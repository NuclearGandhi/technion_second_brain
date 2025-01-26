/*
 * closed_loop_step_data.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "closed_loop_step".
 *
 * Model version              : 14.0
 * Simulink Coder version : 23.2 (R2023b) 01-Aug-2023
 * C source code generated on : Mon Jan 20 15:31:40 2025
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "closed_loop_step.h"

/* Block parameters (default storage) */
P_closed_loop_step_T closed_loop_step_P = {
  /* Variable: k_p
   * Referenced by: '<Root>/P'
   */
  0.36,

  /* Mask Parameter: AnalogOutput_FinalValue
   * Referenced by: '<S1>/Analog Output'
   */
  0.0,

  /* Mask Parameter: AnalogOutput_InitialValue
   * Referenced by: '<S1>/Analog Output'
   */
  0.0,

  /* Mask Parameter: EncoderInput_InputFilter
   * Referenced by: '<S1>/Encoder Input'
   */
  0.0,

  /* Mask Parameter: EncoderInput_MaxMissedTicks
   * Referenced by: '<S1>/Encoder Input'
   */
  10.0,

  /* Mask Parameter: AnalogOutput_MaxMissedTicks
   * Referenced by: '<S1>/Analog Output'
   */
  10.0,

  /* Mask Parameter: EncoderInput_YieldWhenWaiting
   * Referenced by: '<S1>/Encoder Input'
   */
  0.0,

  /* Mask Parameter: AnalogOutput_YieldWhenWaiting
   * Referenced by: '<S1>/Analog Output'
   */
  0.0,

  /* Mask Parameter: EncoderInput_Channels
   * Referenced by: '<S1>/Encoder Input'
   */
  0,

  /* Mask Parameter: AnalogOutput_Channels
   * Referenced by: '<S1>/Analog Output'
   */
  1,

  /* Mask Parameter: AnalogOutput_RangeMode
   * Referenced by: '<S1>/Analog Output'
   */
  0,

  /* Mask Parameter: AnalogOutput_VoltRange
   * Referenced by: '<S1>/Analog Output'
   */
  0,

  /* Expression: 1/25
   * Referenced by: '<S1>/Pulse_to_Deg'
   */
  0.04,

  /* Computed Parameter: TransferFcn_A
   * Referenced by: '<Root>/Transfer Fcn'
   */
  { -48.0, -900.0 },

  /* Computed Parameter: TransferFcn_C
   * Referenced by: '<Root>/Transfer Fcn'
   */
  { 0.0, 900.0 },

  /* Computed Parameter: I_A
   * Referenced by: '<Root>/I'
   */
  -0.0,

  /* Computed Parameter: I_C
   * Referenced by: '<Root>/I'
   */
  2.35,

  /* Computed Parameter: I_D
   * Referenced by: '<Root>/I'
   */
  1.0,

  /* Expression: 15
   * Referenced by: '<Root>/Constant'
   */
  15.0,

  /* Expression: 1/1.2
   * Referenced by: '<S2>/Gain'
   */
  0.83333333333333337,

  /* Expression: 10
   * Referenced by: '<S2>/Constant'
   */
  10.0
};
