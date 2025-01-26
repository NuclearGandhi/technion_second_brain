/*
 * encoders_data.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "encoders".
 *
 * Model version              : 1.43
 * Simulink Coder version : 23.2 (R2023b) 01-Aug-2023
 * C source code generated on : Mon Jan 20 13:45:54 2025
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "encoders.h"

/* Block parameters (default storage) */
P_encoders_T encoders_P = {
  /* Mask Parameter: AnalogOutput_FinalValue
   * Referenced by: '<Root>/Analog Output'
   */
  0.0,

  /* Mask Parameter: AnalogOutput_InitialValue
   * Referenced by: '<Root>/Analog Output'
   */
  0.0,

  /* Mask Parameter: EncoderInputChannel1_InputFilter
   * Referenced by: '<Root>/Encoder Input - Channel 1'
   */
  0.0,

  /* Mask Parameter: EncoderInputChannel2_InputFilter
   * Referenced by: '<Root>/Encoder Input - Channel 2'
   */
  0.0,

  /* Mask Parameter: AnalogOutput_MaxMissedTicks
   * Referenced by: '<Root>/Analog Output'
   */
  10.0,

  /* Mask Parameter: EncoderInputChannel1_MaxMissedTicks
   * Referenced by: '<Root>/Encoder Input - Channel 1'
   */
  10.0,

  /* Mask Parameter: EncoderInputChannel2_MaxMissedTicks
   * Referenced by: '<Root>/Encoder Input - Channel 2'
   */
  10.0,

  /* Mask Parameter: AnalogOutput_YieldWhenWaiting
   * Referenced by: '<Root>/Analog Output'
   */
  0.0,

  /* Mask Parameter: EncoderInputChannel1_YieldWhenWaiting
   * Referenced by: '<Root>/Encoder Input - Channel 1'
   */
  0.0,

  /* Mask Parameter: EncoderInputChannel2_YieldWhenWaiting
   * Referenced by: '<Root>/Encoder Input - Channel 2'
   */
  0.0,

  /* Mask Parameter: AnalogOutput_Channels
   * Referenced by: '<Root>/Analog Output'
   */
  1,

  /* Mask Parameter: EncoderInputChannel1_Channels
   * Referenced by: '<Root>/Encoder Input - Channel 1'
   */
  0,

  /* Mask Parameter: EncoderInputChannel2_Channels
   * Referenced by: '<Root>/Encoder Input - Channel 2'
   */
  1,

  /* Mask Parameter: AnalogOutput_RangeMode
   * Referenced by: '<Root>/Analog Output'
   */
  0,

  /* Mask Parameter: AnalogOutput_VoltRange
   * Referenced by: '<Root>/Analog Output'
   */
  0,

  /* Computed Parameter: TransferFcn_A
   * Referenced by: '<Root>/Transfer Fcn'
   */
  { -30.0, -225.0 },

  /* Computed Parameter: TransferFcn_C
   * Referenced by: '<Root>/Transfer Fcn'
   */
  { 15.0, 0.0 }
};
