#include "uart.h"

#include <stdio.h>
#include <string.h>

#include "main.h"


#define UART &hlpuart1

#define RX_CMD_LEN 8
#define RX_BUF_LEN 16
#define TX_BUF_LEN 64

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
extern float kp, ki, kd, ka;

void apply_command(void);

void init_uart2(void) {
    uart_rx_flag = NO_RX_DATA;
    uart_tx_flag = TX_READY;

    RxBufferIndx = 0;
    HAL_UART_Receive_IT(UART, &RxByte, 1);
}

void transmit_msg_out(const char *msg) {
    uint8_t msgLen;

    while (uart_tx_flag != TX_READY) {  // wait until prev tx ends
        asm(" nop");
    }

    msgLen = strlen(msg);
    memcpy(TxBuffer, msg, msgLen);

    uart_tx_flag = TX_BUSY;
    HAL_UART_Transmit_IT(UART, TxBuffer, msgLen);
}

void HAL_UART_TxCpltCallback(UART_HandleTypeDef *UartHandle) {
    /* Set transmission flag: transfer complete */
    uart_tx_flag = TX_READY;
}

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *UartHandle) {
    if (RxByte == 13) {
        RxBuffer[RxBufferIndx] = 0;  //  add terminator
        uart_rx_flag = NEW_RX_DATA;
    } else {
        RxBuffer[RxBufferIndx] = RxByte;  // add new byte to buffer
                                          // HAL_UART_Transmit_IT(&hlpuart1, &RxByte, 1);
        RxBufferIndx++;
        //  transmit_msg_out("GOT CHAR\r");

        if (RxBufferIndx >= RX_BUF_LEN) {  // avoid buffer leak
            RxBufferIndx = 0;
        }
        HAL_GPIO_TogglePin(GPIOB, GPIO_PIN_8);

        HAL_UART_Receive_IT(UART, &RxByte, 1);  // listen for the next byte
    }
}

void HAL_UART_ErrorCallback(UART_HandleTypeDef *huart) {
    // Restart reception if error occurs (e.g. Overrun)
    HAL_UART_Receive_IT(UART, &RxByte, 1);
}

char sCmd[16], out_str[64];
int16_t param;
int16_t p1, p2, p3, p4;

void handle_comm(void) {
    if (uart_rx_flag == NEW_RX_DATA) {
        // Try parsing with 4 parameters first (for pwm command)
        int n = sscanf((char *)RxBuffer, "%s %hd %hd %hd %hd", sCmd, &p1, &p2, &p3, &p4);
        
        if (n == 5) {
             sprintf(out_str, ">> cmd=%s %d %d %d %d\r\n", sCmd, p1, p2, p3, p4);
        } else {
             // Fallback to single parameter
             sscanf((char *)RxBuffer, "%s %hd", sCmd, &param);
             sprintf(out_str, ">> cmd=%s param=%d\r\n", sCmd, param);
        }
        
        transmit_msg_out(out_str);
        apply_command();

        uart_rx_flag = NO_RX_DATA;
        RxBufferIndx = 0;
        HAL_UART_Receive_IT(UART, &RxByte, 1);
    }
}

void apply_command(void) {
    if (0 == strcmp(sCmd, "state")) {
        mode = param;
        // Reset recording index if entering square state
        if (mode == STATE_SQUARE) {
            ka = 0;
        }
    }
    
    if (0 == strcmp(sCmd, "pwm")) {
        Pwm[0] = p1;
        Pwm[1] = p2;
        Pwm[2] = p3;
        Pwm[3] = p4;
    }

    if (0 == strcmp(sCmd, "mode")) {
        drive_mode = param;
    }
}
