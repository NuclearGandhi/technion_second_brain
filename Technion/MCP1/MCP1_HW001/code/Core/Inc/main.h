/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2025 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f4xx_hal.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

void HAL_TIM_MspPostInit(TIM_HandleTypeDef *htim);

/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define USER_Btn_Pin GPIO_PIN_13
#define USER_Btn_GPIO_Port GPIOC
#define USER_Btn_EXTI_IRQn EXTI15_10_IRQn
#define MCO_Pin GPIO_PIN_0
#define MCO_GPIO_Port GPIOH
#define LD3_Pin GPIO_PIN_14
#define LD3_GPIO_Port GPIOB
#define STLK_RX_Pin GPIO_PIN_8
#define STLK_RX_GPIO_Port GPIOD
#define STLK_TX_Pin GPIO_PIN_9
#define STLK_TX_GPIO_Port GPIOD
#define USB_PowerSwitchOn_Pin GPIO_PIN_6
#define USB_PowerSwitchOn_GPIO_Port GPIOG
#define USB_OverCurrent_Pin GPIO_PIN_7
#define USB_OverCurrent_GPIO_Port GPIOG
#define USB_SOF_Pin GPIO_PIN_8
#define USB_SOF_GPIO_Port GPIOA
#define USB_VBUS_Pin GPIO_PIN_9
#define USB_VBUS_GPIO_Port GPIOA
#define USB_ID_Pin GPIO_PIN_10
#define USB_ID_GPIO_Port GPIOA
#define USB_DM_Pin GPIO_PIN_11
#define USB_DM_GPIO_Port GPIOA
#define USB_DP_Pin GPIO_PIN_12
#define USB_DP_GPIO_Port GPIOA
#define TMS_Pin GPIO_PIN_13
#define TMS_GPIO_Port GPIOA
#define TCK_Pin GPIO_PIN_14
#define TCK_GPIO_Port GPIOA
#define LED_1_Pin GPIO_PIN_0
#define LED_1_GPIO_Port GPIOD
#define LED_2_Pin GPIO_PIN_1
#define LED_2_GPIO_Port GPIOD
#define LED_3_Pin GPIO_PIN_2
#define LED_3_GPIO_Port GPIOD
#define LED_4_Pin GPIO_PIN_3
#define LED_4_GPIO_Port GPIOD
#define LED_5_Pin GPIO_PIN_4
#define LED_5_GPIO_Port GPIOD
#define LED_6_Pin GPIO_PIN_5
#define LED_6_GPIO_Port GPIOD
#define LED_7_Pin GPIO_PIN_6
#define LED_7_GPIO_Port GPIOD
#define LED_8_Pin GPIO_PIN_7
#define LED_8_GPIO_Port GPIOD
#define LD2_Pin GPIO_PIN_7
#define LD2_GPIO_Port GPIOB

/* USER CODE BEGIN Private defines */

#define MOTOR_ENABLE 0
#define MOTOR_DISABLE 1

#define MOTOR_1_PORT GPIOE
#define MOTOR_1_ENABLE_PIN GPIO_PIN_12
#define MOTOR_1_DIRECTION_PIN GPIO_PIN_13
#define MOTOR_1_STEP_PIN GPIO_PIN_14
#define MOTOR_1_RES_PIN GPIO_PIN_15

#define MOTOR_2_PORT GPIOG
#define MOTOR_2_ENABLE_PIN GPIO_PIN_0
#define MOTOR_2_DIRECTION_PIN GPIO_PIN_1
#define MOTOR_2_STEP_PIN GPIO_PIN_2
#define MOTOR_2_RES_PIN GPIO_PIN_3

#define MOTOR_3_PORT GPIOF
#define MOTOR_3_ENABLE_PIN GPIO_PIN_2
#define MOTOR_3_DIRECTION_PIN GPIO_PIN_3
#define MOTOR_3_STEP_PIN GPIO_PIN_5
#define MOTOR_3_RES_PIN GPIO_PIN_7


/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */
