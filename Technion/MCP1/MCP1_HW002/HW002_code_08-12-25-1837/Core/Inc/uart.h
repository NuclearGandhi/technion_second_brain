/*
 * uart.h
 *
 *  Created on: May 9, 2020
 *      Author: izhak
 */

#ifndef INC_UART_H_
#define INC_UART_H_


void init_uart2(void);
void handle_comm(void);
void transmit_msg_out(const char *msg);




#endif /* INC_UART_H_ */
