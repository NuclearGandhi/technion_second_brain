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
#include "stm32g4xx_hal.h"

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
#define B1_Pin GPIO_PIN_13
#define B1_GPIO_Port GPIOC
#define B1_EXTI_IRQn EXTI15_10_IRQn
#define LPUART1_TX_Pin GPIO_PIN_2
#define LPUART1_TX_GPIO_Port GPIOA
#define LPUART1_RX_Pin GPIO_PIN_3
#define LPUART1_RX_GPIO_Port GPIOA
#define LD2_Pin GPIO_PIN_5
#define LD2_GPIO_Port GPIOA
#define T_SWDIO_Pin GPIO_PIN_13
#define T_SWDIO_GPIO_Port GPIOA
#define T_SWCLK_Pin GPIO_PIN_14
#define T_SWCLK_GPIO_Port GPIOA
#define T_SWO_Pin GPIO_PIN_3
#define T_SWO_GPIO_Port GPIOB

/* USER CODE BEGIN Private defines */
// Operating states
#define STATE_IDLE 1
#define STATE_PWM 2
#define STATE_SQUARE 3
#define STATE_DRIVE 4
#define STATE_VELOCITY 5      // Closed-loop velocity control
#define STATE_KINEMATICS 6    // vx/vy/wz kinematics control
#define STATE_TRAJECTORY 7    // Trajectory following

// Drive modes (for open-loop STATE_DRIVE)
#define MODE_F 1      // Forward
#define MODE_B 2      // Backward
#define MODE_CW 3     // Clockwise rotation
#define MODE_CCW 4    // Counter-clockwise rotation
#define MODE_NW 5     // Diagonal NW
#define MODE_SW 6     // Diagonal SW
#define MODE_NE 7     // Diagonal NE
#define MODE_SE 8     // Diagonal SE

// External function declarations for UART commands
void start_trajectory(void);
void stop_trajectory(void);
void reset_pid(void);
void kinematics_to_wheel_vel(float vx, float vy, float wz);

// External variables for UART commands
extern float kp, ki, kd;
extern int16_t Ref[4];
extern float vx_ref, vy_ref, wz_ref;
extern volatile uint8_t obstacle_stop_enabled;
/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */
