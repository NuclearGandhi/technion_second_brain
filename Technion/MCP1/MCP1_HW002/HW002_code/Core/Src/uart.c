#include "main.h"
#include "uart.h"
#include <string.h>
#include <stdio.h>

#define UART &hlpuart1

#define RX_CMD_LEN 8
#define RX_BUF_LEN 16
#define TX_BUF_LEN 64

#define NO_RX_DATA      0
#define NEW_RX_DATA     1

#define TX_READY        0
#define TX_BUSY         1

#define DO_STEP 1
#define DO_IDLE 2
#define DO_SEND 3
#define DO_RECORD 4


extern UART_HandleTypeDef hlpuart1, huart3;

extern uint16_t ind,scan, print,d, ch;
extern uint8_t TestMode, stop;

uint8_t uart_rx_flag;
uint8_t uart_tx_flag;

uint8_t RxByte, RxBufferIndx;
uint8_t RxBuffer[RX_BUF_LEN];
uint8_t TxBuffer[TX_BUF_LEN];

extern       int16_t Pwm[4], Ref[4], mode;
extern float kp,ki,kd, ka;

void apply_command(void);

void init_uart2(void)
{
  uart_rx_flag = NO_RX_DATA;
  uart_tx_flag = TX_READY;

  RxBufferIndx = 0;
  HAL_UART_Receive_IT(UART, &RxByte, 1);
}

void transmit_msg_out(const char *msg)
{
  uint8_t msgLen;

  while (uart_tx_flag != TX_READY) { // wait until prev tx ends
    asm(" nop");
  }

  msgLen = strlen(msg);
  memcpy(TxBuffer, msg, msgLen);

  uart_tx_flag = TX_BUSY;
  HAL_UART_Transmit_IT(UART, TxBuffer, msgLen);

}

void HAL_UART_TxCpltCallback(UART_HandleTypeDef *UartHandle)
{
  /* Set transmission flag: transfer complete */
  uart_tx_flag = TX_READY;
}

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *UartHandle)
{
  if (RxByte == 13) {
    RxBuffer[RxBufferIndx] = 0; //  add terminator
    uart_rx_flag = NEW_RX_DATA;
  } else {
    RxBuffer[RxBufferIndx] =  RxByte; // add new byte to buffer
   // HAL_UART_Transmit_IT(&hlpuart1, &RxByte, 1);
    RxBufferIndx++;
      //  transmit_msg_out("GOT CHAR\r");

    if (RxBufferIndx >= RX_BUF_LEN) { // avoid buffer leak
      RxBufferIndx = 0;
    }
    HAL_GPIO_TogglePin(GPIOB, GPIO_PIN_8);

    HAL_UART_Receive_IT(UART, &RxByte, 1); // listen for the next byte
  }

}

char sCmd[16], out_str[32];
int16_t param, enc;

void handle_comm(void)
{

  if (uart_rx_flag == NEW_RX_DATA) {

    sscanf((char *) RxBuffer, "%s %d", sCmd, &param);

   // sprintf(out_str, "       >> cmd=%s\tparam=%d\r\n", sCmd, param);
   // transmit_msg_out(out_str);
   // transmit_msg_out(sCmd);
    apply_command();

    uart_rx_flag = NO_RX_DATA;
    RxBufferIndx = 0;
    HAL_UART_Receive_IT(UART, &RxByte, 1);
  }

}

void apply_command(void)
{uint16_t x;
  // set LEDS values according to 4 LSB of param
  x=0;
  if (0 == strcmp(sCmd, "ind"))  {ind=param; }  // param is 0 or 1
  if (0 == strcmp(sCmd, "scan"))  {scan=param;}
  if (0 == strcmp(sCmd, "print"))  {print=param;}
  if (0 == strcmp(sCmd, "delay"))  {d=param;}

  if (0 == strcmp(sCmd, "pwm1"))  {Pwm[0]=param;}
  if (0 == strcmp(sCmd, "pwm2"))  {Pwm[1]=param;}
  if (0 == strcmp(sCmd, "pwm3"))  {Pwm[2]=param;}
  if (0 == strcmp(sCmd, "pwm4"))  {Pwm[3]=param;}

  if (0 == strcmp(sCmd, "kp"))  {kp=(float) param/10000;}
  if (0 == strcmp(sCmd, "ki"))  {ki=(float) param/10000;}
  if (0 == strcmp(sCmd, "kd"))  {kd=(float) param/10000;}

    if (0 == strcmp(sCmd, "ref1"))  {Ref[0]=param;}
    if (0 == strcmp(sCmd, "ref2"))  {Ref[1]=param;}
    if (0 == strcmp(sCmd, "ref3"))  {Ref[2]=param;}
    if (0 == strcmp(sCmd, "ref4"))  {Ref[3]=param;}

    if (0 == strcmp(sCmd, "ch"))  {ch=param; }
    if (0 == strcmp(sCmd, "test"))  {TestMode=param; }
    if (0 == strcmp(sCmd, "stop"))  {stop=param;}
    if (0 == strcmp(sCmd, "mode"))  {mode=param;}
    if (0 == strcmp(sCmd, "record"))  {mode=param;
     if (mode==DO_RECORD)  ka=0;}



}
