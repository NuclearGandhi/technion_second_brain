#include "uart.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "main.h"

#define UART &huart3

#define RX_CMD_LEN 8
#define RX_BUF_LEN 64  // Increased for longer commands
#define TX_BUF_LEN 128

#define NO_RX_DATA 0
#define NEW_RX_DATA 1

#define TX_READY 0
#define TX_BUSY 1

extern UART_HandleTypeDef hlpuart1, huart3;

extern uint16_t ind, scan, print, d, ch;
extern uint8_t TestMode, stop;

volatile uint8_t uart_rx_flag;
volatile uint8_t uart_tx_flag;

uint8_t RxByte, RxBufferIndx;
uint8_t RxBuffer[RX_BUF_LEN];
uint8_t TxBuffer[TX_BUF_LEN];

extern int16_t Pwm[4], Ref[4];
extern uint16_t mode;
extern uint16_t drive_mode;
extern float kp, ki, kd;
extern int16_t ka;
extern int16_t REC[1000][5];

// Kinematics variables
extern float vx_ref, vy_ref, wz_ref;
extern volatile uint8_t obstacle_stop_enabled;
extern volatile uint8_t traj_running;

// Encoder variables for debugging
extern int16_t Enc[4];    // Current encoder counts
extern int16_t We[4];     // Wheel velocities (counts/sample)
extern int32_t Enc32[4];  // Extended encoder counts

void apply_command(void);

void init_uart2(void) {
    uart_rx_flag = NO_RX_DATA;
    uart_tx_flag = TX_READY;

    RxBufferIndx = 0;
    HAL_UART_Receive_IT(UART, &RxByte, 1);
}

void transmit_msg_out(const char* msg) {
    uint8_t msgLen;

    while (uart_tx_flag != TX_READY) {
        asm(" nop");
    }

    msgLen = strlen(msg);
    if (msgLen > TX_BUF_LEN) msgLen = TX_BUF_LEN;
    memcpy(TxBuffer, msg, msgLen);

    uart_tx_flag = TX_BUSY;
    HAL_UART_Transmit_IT(UART, TxBuffer, msgLen);
}

void HAL_UART_TxCpltCallback(UART_HandleTypeDef* UartHandle) { uart_tx_flag = TX_READY; }

void HAL_UART_RxCpltCallback(UART_HandleTypeDef* UartHandle) {
    if (RxByte == 13 || RxByte == 10) {  // CR or LF
        if (RxBufferIndx > 0) {
            // Only process if we have data (ignore empty lines)
            RxBuffer[RxBufferIndx] = 0;  // Null terminate
            uart_rx_flag = NEW_RX_DATA;
        }
        // Always restart receive for next byte
        HAL_UART_Receive_IT(UART, &RxByte, 1);
    } else {
        RxBuffer[RxBufferIndx] = RxByte;
        RxBufferIndx++;

        if (RxBufferIndx >= RX_BUF_LEN) {
            RxBufferIndx = 0;
        }
        HAL_GPIO_TogglePin(GPIOB, GPIO_PIN_8);
        HAL_UART_Receive_IT(UART, &RxByte, 1);
    }
}

void HAL_UART_ErrorCallback(UART_HandleTypeDef* huart) { HAL_UART_Receive_IT(UART, &RxByte, 1); }

char sCmd[16], out_str[128];
int16_t param;
int16_t p1, p2, p3, p4;
float f1, f2, f3;

void handle_comm(void) {
    if (uart_rx_flag == NEW_RX_DATA) {
        // Parse command
        int n = sscanf((char*)RxBuffer, "%s", sCmd);

        if (n >= 1) {
            sprintf(out_str, ">> cmd=%s\r\n", sCmd);
            transmit_msg_out(out_str);
            apply_command();
        }

        uart_rx_flag = NO_RX_DATA;
        RxBufferIndx = 0;
        HAL_UART_Receive_IT(UART, &RxByte, 1);
    }
}

void apply_command(void) {
    // State change command: "state N"
    if (0 == strcmp(sCmd, "state")) {
        sscanf((char*)RxBuffer, "%*s %hd", &param);
        mode = param;

        // Reset controller when changing states
        if (mode == STATE_SQUARE) {
            ka = 0;
        }
        if (mode == STATE_VELOCITY || mode == STATE_KINEMATICS || mode == STATE_TRAJECTORY) {
            reset_pid();
        }
        if (mode == STATE_IDLE) {
            stop_trajectory();
        }

        sprintf(out_str, "State -> %d\r\n", mode);
        transmit_msg_out(out_str);
    }

    // PWM direct control: "pwm d1 d2 d3 d4"
    if (0 == strcmp(sCmd, "pwm")) {
        sscanf((char*)RxBuffer, "%*s %hd %hd %hd %hd", &p1, &p2, &p3, &p4);
        Pwm[0] = p1;
        Pwm[1] = p2;
        Pwm[2] = p3;
        Pwm[3] = p4;

        sprintf(out_str, "PWM -> [%d %d %d %d]\r\n", Pwm[0], Pwm[1], Pwm[2], Pwm[3]);
        transmit_msg_out(out_str);
    }

    // Drive mode: "mode N"
    if (0 == strcmp(sCmd, "mode")) {
        sscanf((char*)RxBuffer, "%*s %hd", &param);
        drive_mode = param;

        sprintf(out_str, "DriveMode -> %d\r\n", drive_mode);
        transmit_msg_out(out_str);
    }

    // Velocity reference: "ref r0 r1 r2 r3" (encoder counts per sample)
    if (0 == strcmp(sCmd, "ref")) {
        sscanf((char*)RxBuffer, "%*s %hd %hd %hd %hd", &p1, &p2, &p3, &p4);
        Ref[0] = p1;
        Ref[1] = p2;
        Ref[2] = p3;
        Ref[3] = p4;

        sprintf(out_str, "Ref -> [%d %d %d %d]\r\n", Ref[0], Ref[1], Ref[2], Ref[3]);
        transmit_msg_out(out_str);
    }

    // Kinematics velocity: "vel vx vy wz" (floats: m/s, m/s, rad/s)
    if (0 == strcmp(sCmd, "vel")) {
        // Debug: print received buffer
        sprintf(out_str, "RxBuf: [%s]\r\n", (char*)RxBuffer);
        transmit_msg_out(out_str);

        // Parse using strtof for more reliable float parsing
        char* ptr = (char*)RxBuffer;
        // Skip "vel" command
        while (*ptr && *ptr != ' ') ptr++;
        while (*ptr == ' ') ptr++;

        // Parse vx
        char* end;
        f1 = strtof(ptr, &end);
        ptr = end;
        while (*ptr == ' ') ptr++;

        // Parse vy
        f2 = strtof(ptr, &end);
        ptr = end;
        while (*ptr == ' ') ptr++;

        // Parse wz
        f3 = strtof(ptr, &end);

        vx_ref = f1;
        vy_ref = f2;
        wz_ref = f3;

        // Auto-switch to kinematics mode
        if (mode != STATE_KINEMATICS) {
            mode = STATE_KINEMATICS;
            reset_pid();
        }

        sprintf(out_str, "Vel -> [%.3f %.3f %.3f]\r\n", vx_ref, vy_ref, wz_ref);
        transmit_msg_out(out_str);
    }

    // PI gains: "gains kp ki"
    if (0 == strcmp(sCmd, "gains")) {
        sscanf((char*)RxBuffer, "%*s %f %f", &f1, &f2);
        kp = f1;
        ki = f2;

        sprintf(out_str, "Gains -> kp=%.2f ki=%.3f\r\n", kp, ki);
        transmit_msg_out(out_str);
    }

    // Trajectory control: "traj start" or "traj stop"
    if (0 == strcmp(sCmd, "traj")) {
        char subcmd[16] = {0};
        sscanf((char*)RxBuffer, "%*s %s", subcmd);

        if (0 == strcmp(subcmd, "start")) {
            mode = STATE_TRAJECTORY;
            start_trajectory();
            transmit_msg_out("Trajectory started\r\n");
        } else if (0 == strcmp(subcmd, "stop")) {
            stop_trajectory();
            mode = STATE_IDLE;
            transmit_msg_out("Trajectory stopped\r\n");
        } else {
            sprintf(out_str, "Traj running=%d index=%d\r\n", traj_running, (int)ka);
            transmit_msg_out(out_str);
        }
    }

    // Obstacle detection enable/disable: "obstacle on" or "obstacle off"
    if (0 == strcmp(sCmd, "obstacle")) {
        char subcmd[16] = {0};
        sscanf((char*)RxBuffer, "%*s %s", subcmd);

        if (0 == strcmp(subcmd, "on")) {
            obstacle_stop_enabled = 1;
            transmit_msg_out("Obstacle stop enabled\r\n");
        } else if (0 == strcmp(subcmd, "off")) {
            obstacle_stop_enabled = 0;
            transmit_msg_out("Obstacle stop disabled\r\n");
        }
    }

    // Send recorded data: "send"
    if (0 == strcmp(sCmd, "send")) {
        while (uart_tx_flag != TX_READY) {
            asm(" nop");
        }

        uart_tx_flag = TX_BUSY;
        HAL_UART_Transmit(UART, (uint8_t*)REC, 10000, 5000);
        uart_tx_flag = TX_READY;
        transmit_msg_out("DONE\r\n");
    }

    // Status query: "status"
    if (0 == strcmp(sCmd, "status")) {
        sprintf(out_str, "Mode=%d Ref=[%d,%d,%d,%d] kp=%.1f ki=%.2f\r\n", mode, Ref[0], Ref[1],
                Ref[2], Ref[3], kp, ki);
        transmit_msg_out(out_str);
    }

    // Encoder debug: "enc"
    if (0 == strcmp(sCmd, "enc")) {
        sprintf(out_str, "Enc=[%d,%d,%d,%d]\r\n", Enc[0], Enc[1], Enc[2], Enc[3]);
        transmit_msg_out(out_str);
        sprintf(out_str, "Vel=[%d,%d,%d,%d]\r\n", We[0], We[1], We[2], We[3]);
        transmit_msg_out(out_str);
        sprintf(out_str, "Pos=[%ld,%ld,%ld,%ld]\r\n", (long)Enc32[0], (long)Enc32[1],
                (long)Enc32[2], (long)Enc32[3]);
        transmit_msg_out(out_str);
    }

    // Help command: "help"
    if (0 == strcmp(sCmd, "help")) {
        transmit_msg_out("Commands:\r\n");
        transmit_msg_out("  state N - Set mode (1-7)\r\n");
        transmit_msg_out("  pwm d1 d2 d3 d4 - Direct PWM\r\n");
        transmit_msg_out("  ref r1 r2 r3 r4 - Vel refs\r\n");
        transmit_msg_out("  vel vx vy wz - Kinematics\r\n");
        transmit_msg_out("  gains kp ki - PI gains\r\n");
        transmit_msg_out("  traj start|stop - Trajectory\r\n");
        transmit_msg_out("  send - Get recorded data\r\n");
        transmit_msg_out("  enc - Show encoder values\r\n");
        transmit_msg_out("  status - Show status\r\n");
    }
}
