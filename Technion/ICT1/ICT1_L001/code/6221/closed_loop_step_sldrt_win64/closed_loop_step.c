/*
 * closed_loop_step.c
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
#include "rtwtypes.h"
#include <math.h>
#include "closed_loop_step_private.h"
#include <string.h>
#include "rt_nonfinite.h"
#include "closed_loop_step_dt.h"

/* options for Simulink Desktop Real-Time board 0 */
static double SLDRTBoardOptions0[] = {
  0.0,
  0.0,
  0.0,
  2.0,
  2.0,
};

/* list of Simulink Desktop Real-Time timers */
const int SLDRTTimerCount = 1;
const double SLDRTTimers[2] = {
  0.001, 0.0,
};

/* list of Simulink Desktop Real-Time boards */
const int SLDRTBoardCount = 1;
SLDRTBOARD SLDRTBoards[1] = {
  { "National_Instruments/PCI-6221", 4294967295U, 5, SLDRTBoardOptions0 },
};

/* Block signals (default storage) */
B_closed_loop_step_T closed_loop_step_B;

/* Continuous states */
X_closed_loop_step_T closed_loop_step_X;

/* Disabled State Vector */
XDis_closed_loop_step_T closed_loop_step_XDis;

/* Block states (default storage) */
DW_closed_loop_step_T closed_loop_step_DW;

/* Real-time model */
static RT_MODEL_closed_loop_step_T closed_loop_step_M_;
RT_MODEL_closed_loop_step_T *const closed_loop_step_M = &closed_loop_step_M_;

/*
 * This function updates continuous states using the ODE4 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  time_T t = rtsiGetT(si);
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE4_IntgData *id = (ODE4_IntgData *)rtsiGetSolverData(si);
  real_T *y = id->y;
  real_T *f0 = id->f[0];
  real_T *f1 = id->f[1];
  real_T *f2 = id->f[2];
  real_T *f3 = id->f[3];
  real_T temp;
  int_T i;
  int_T nXc = 3;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);

  /* Save the state values at time t in y, we'll use x as ynew. */
  (void) memcpy(y, x,
                (uint_T)nXc*sizeof(real_T));

  /* Assumes that rtsiSetT and ModelOutputs are up-to-date */
  /* f0 = f(t,y) */
  rtsiSetdX(si, f0);
  closed_loop_step_derivatives();

  /* f1 = f(t + (h/2), y + (h/2)*f0) */
  temp = 0.5 * h;
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (temp*f0[i]);
  }

  rtsiSetT(si, t + temp);
  rtsiSetdX(si, f1);
  closed_loop_step_output();
  closed_loop_step_derivatives();

  /* f2 = f(t + (h/2), y + (h/2)*f1) */
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (temp*f1[i]);
  }

  rtsiSetdX(si, f2);
  closed_loop_step_output();
  closed_loop_step_derivatives();

  /* f3 = f(t + h, y + h*f2) */
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (h*f2[i]);
  }

  rtsiSetT(si, tnew);
  rtsiSetdX(si, f3);
  closed_loop_step_output();
  closed_loop_step_derivatives();

  /* tnew = t + h
     ynew = y + (h/6)*(f0 + 2*f1 + 2*f2 + 2*f3) */
  temp = h / 6.0;
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + temp*(f0[i] + 2.0*f1[i] + 2.0*f2[i] + f3[i]);
  }

  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

/* Model output function */
void closed_loop_step_output(void)
{
  real_T rtb_EncoderInput;
  if (rtmIsMajorTimeStep(closed_loop_step_M)) {
    /* set solver stop time */
    if (!(closed_loop_step_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&closed_loop_step_M->solverInfo,
                            ((closed_loop_step_M->Timing.clockTickH0 + 1) *
        closed_loop_step_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&closed_loop_step_M->solverInfo,
                            ((closed_loop_step_M->Timing.clockTick0 + 1) *
        closed_loop_step_M->Timing.stepSize0 +
        closed_loop_step_M->Timing.clockTickH0 *
        closed_loop_step_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(closed_loop_step_M)) {
    closed_loop_step_M->Timing.t[0] = rtsiGetT(&closed_loop_step_M->solverInfo);
  }

  if (rtmIsMajorTimeStep(closed_loop_step_M)) {
    /* S-Function (sldrtei): '<S1>/Encoder Input' */
    /* S-Function Block: <S1>/Encoder Input */
    {
      ENCODERINPARM parm;
      parm.quad = (QUADMODE) 2;
      parm.index = (INDEXPULSE) 0;
      parm.infilter = closed_loop_step_P.EncoderInput_InputFilter;
      RTBIO_DriverIO(0, ENCODERINPUT, IOREAD, 1,
                     &closed_loop_step_P.EncoderInput_Channels,
                     &rtb_EncoderInput, &parm);
    }

    /* Gain: '<S1>/Pulse_to_Deg' */
    closed_loop_step_B.Pulse_to_Deg = closed_loop_step_P.Pulse_to_Deg_Gain *
      rtb_EncoderInput;
  }

  /* Gain: '<Root>/P' incorporates:
   *  Sum: '<Root>/Sum'
   *  TransferFcn: '<Root>/Transfer Fcn'
   */
  closed_loop_step_B.P = ((closed_loop_step_P.TransferFcn_C[0] *
    closed_loop_step_X.TransferFcn_CSTATE[0] + closed_loop_step_P.TransferFcn_C
    [1] * closed_loop_step_X.TransferFcn_CSTATE[1]) -
    closed_loop_step_B.Pulse_to_Deg) * closed_loop_step_P.k_p;

  /* TransferFcn: '<Root>/I' */
  closed_loop_step_B.I = 0.0;
  closed_loop_step_B.I += closed_loop_step_P.I_C * closed_loop_step_X.I_CSTATE;
  closed_loop_step_B.I += closed_loop_step_P.I_D * closed_loop_step_B.P;
  if (rtmIsMajorTimeStep(closed_loop_step_M)) {
    /* Constant: '<Root>/Constant' */
    closed_loop_step_B.Constant = closed_loop_step_P.Constant_Value;
  }

  /* Gain: '<S2>/Gain' */
  closed_loop_step_B.Gain = closed_loop_step_P.Gain_Gain * closed_loop_step_B.I;
  if (rtmIsMajorTimeStep(closed_loop_step_M)) {
    /* S-Function (sldrtao): '<S1>/Analog Output' */
    /* S-Function Block: <S1>/Analog Output */
    {
      {
        ANALOGIOPARM parm;
        parm.mode = (RANGEMODE) closed_loop_step_P.AnalogOutput_RangeMode;
        parm.rangeidx = closed_loop_step_P.AnalogOutput_VoltRange;
        RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                       &closed_loop_step_P.AnalogOutput_Channels, ((real_T*)
          (&closed_loop_step_B.Gain)), &parm);
      }
    }
  }

  /* RelationalOperator: '<S2>/Relational Operator' incorporates:
   *  Abs: '<S2>/Abs'
   *  Constant: '<S2>/Constant'
   */
  closed_loop_step_B.RelationalOperator = (fabs(closed_loop_step_B.I) >=
    closed_loop_step_P.Constant_Value_m);
  if (rtmIsMajorTimeStep(closed_loop_step_M)) {
    /* Stop: '<S2>/Stop Simulation' */
    if (closed_loop_step_B.RelationalOperator) {
      rtmSetStopRequested(closed_loop_step_M, 1);
    }

    /* End of Stop: '<S2>/Stop Simulation' */
  }
}

/* Model update function */
void closed_loop_step_update(void)
{
  if (rtmIsMajorTimeStep(closed_loop_step_M)) {
    rt_ertODEUpdateContinuousStates(&closed_loop_step_M->solverInfo);
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++closed_loop_step_M->Timing.clockTick0)) {
    ++closed_loop_step_M->Timing.clockTickH0;
  }

  closed_loop_step_M->Timing.t[0] = rtsiGetSolverStopTime
    (&closed_loop_step_M->solverInfo);

  {
    /* Update absolute timer for sample time: [0.001s, 0.0s] */
    /* The "clockTick1" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick1"
     * and "Timing.stepSize1". Size of "clockTick1" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick1 and the high bits
     * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++closed_loop_step_M->Timing.clockTick1)) {
      ++closed_loop_step_M->Timing.clockTickH1;
    }

    closed_loop_step_M->Timing.t[1] = closed_loop_step_M->Timing.clockTick1 *
      closed_loop_step_M->Timing.stepSize1 +
      closed_loop_step_M->Timing.clockTickH1 *
      closed_loop_step_M->Timing.stepSize1 * 4294967296.0;
  }
}

/* Derivatives for root system: '<Root>' */
void closed_loop_step_derivatives(void)
{
  XDot_closed_loop_step_T *_rtXdot;
  _rtXdot = ((XDot_closed_loop_step_T *) closed_loop_step_M->derivs);

  /* Derivatives for TransferFcn: '<Root>/Transfer Fcn' */
  _rtXdot->TransferFcn_CSTATE[0] = closed_loop_step_P.TransferFcn_A[0] *
    closed_loop_step_X.TransferFcn_CSTATE[0];
  _rtXdot->TransferFcn_CSTATE[0] += closed_loop_step_P.TransferFcn_A[1] *
    closed_loop_step_X.TransferFcn_CSTATE[1];
  _rtXdot->TransferFcn_CSTATE[1] = closed_loop_step_X.TransferFcn_CSTATE[0];
  _rtXdot->TransferFcn_CSTATE[0] += closed_loop_step_B.Constant;

  /* Derivatives for TransferFcn: '<Root>/I' */
  _rtXdot->I_CSTATE = closed_loop_step_P.I_A * closed_loop_step_X.I_CSTATE;
  _rtXdot->I_CSTATE += closed_loop_step_B.P;
}

/* Model initialize function */
void closed_loop_step_initialize(void)
{
  /* Start for S-Function (sldrtao): '<S1>/Analog Output' */

  /* S-Function Block: <S1>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) closed_loop_step_P.AnalogOutput_RangeMode;
      parm.rangeidx = closed_loop_step_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &closed_loop_step_P.AnalogOutput_Channels,
                     &closed_loop_step_P.AnalogOutput_InitialValue, &parm);
    }
  }

  /* InitializeConditions for S-Function (sldrtei): '<S1>/Encoder Input' */

  /* S-Function Block: <S1>/Encoder Input */
  {
    ENCODERINPARM parm;
    parm.quad = (QUADMODE) 2;
    parm.index = (INDEXPULSE) 0;
    parm.infilter = closed_loop_step_P.EncoderInput_InputFilter;
    RTBIO_DriverIO(0, ENCODERINPUT, IORESET, 1,
                   &closed_loop_step_P.EncoderInput_Channels, NULL, &parm);
  }

  /* InitializeConditions for TransferFcn: '<Root>/Transfer Fcn' */
  closed_loop_step_X.TransferFcn_CSTATE[0] = 0.0;
  closed_loop_step_X.TransferFcn_CSTATE[1] = 0.0;

  /* InitializeConditions for TransferFcn: '<Root>/I' */
  closed_loop_step_X.I_CSTATE = 0.0;
}

/* Model terminate function */
void closed_loop_step_terminate(void)
{
  /* Terminate for S-Function (sldrtao): '<S1>/Analog Output' */

  /* S-Function Block: <S1>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) closed_loop_step_P.AnalogOutput_RangeMode;
      parm.rangeidx = closed_loop_step_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &closed_loop_step_P.AnalogOutput_Channels,
                     &closed_loop_step_P.AnalogOutput_FinalValue, &parm);
    }
  }
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/

/* Solver interface called by GRT_Main */
#ifndef USE_GENERATED_SOLVER

void rt_ODECreateIntegrationData(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

void rt_ODEDestroyIntegrationData(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

void rt_ODEUpdateContinuousStates(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

#endif

void MdlOutputs(int_T tid)
{
  closed_loop_step_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  closed_loop_step_update();
  UNUSED_PARAMETER(tid);
}

void MdlInitializeSizes(void)
{
}

void MdlInitializeSampleTimes(void)
{
}

void MdlInitialize(void)
{
}

void MdlStart(void)
{
  closed_loop_step_initialize();
}

void MdlTerminate(void)
{
  closed_loop_step_terminate();
}

/* Registration function */
RT_MODEL_closed_loop_step_T *closed_loop_step(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* non-finite (run-time) assignments */
  closed_loop_step_P.EncoderInput_InputFilter = rtInf;

  /* initialize real-time model */
  (void) memset((void *)closed_loop_step_M, 0,
                sizeof(RT_MODEL_closed_loop_step_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&closed_loop_step_M->solverInfo,
                          &closed_loop_step_M->Timing.simTimeStep);
    rtsiSetTPtr(&closed_loop_step_M->solverInfo, &rtmGetTPtr(closed_loop_step_M));
    rtsiSetStepSizePtr(&closed_loop_step_M->solverInfo,
                       &closed_loop_step_M->Timing.stepSize0);
    rtsiSetdXPtr(&closed_loop_step_M->solverInfo, &closed_loop_step_M->derivs);
    rtsiSetContStatesPtr(&closed_loop_step_M->solverInfo, (real_T **)
                         &closed_loop_step_M->contStates);
    rtsiSetNumContStatesPtr(&closed_loop_step_M->solverInfo,
      &closed_loop_step_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&closed_loop_step_M->solverInfo,
      &closed_loop_step_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&closed_loop_step_M->solverInfo,
      &closed_loop_step_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&closed_loop_step_M->solverInfo,
      &closed_loop_step_M->periodicContStateRanges);
    rtsiSetContStateDisabledPtr(&closed_loop_step_M->solverInfo, (boolean_T**)
      &closed_loop_step_M->contStateDisabled);
    rtsiSetErrorStatusPtr(&closed_loop_step_M->solverInfo, (&rtmGetErrorStatus
      (closed_loop_step_M)));
    rtsiSetRTModelPtr(&closed_loop_step_M->solverInfo, closed_loop_step_M);
  }

  rtsiSetSimTimeStep(&closed_loop_step_M->solverInfo, MAJOR_TIME_STEP);
  closed_loop_step_M->intgData.y = closed_loop_step_M->odeY;
  closed_loop_step_M->intgData.f[0] = closed_loop_step_M->odeF[0];
  closed_loop_step_M->intgData.f[1] = closed_loop_step_M->odeF[1];
  closed_loop_step_M->intgData.f[2] = closed_loop_step_M->odeF[2];
  closed_loop_step_M->intgData.f[3] = closed_loop_step_M->odeF[3];
  closed_loop_step_M->contStates = ((real_T *) &closed_loop_step_X);
  closed_loop_step_M->contStateDisabled = ((boolean_T *) &closed_loop_step_XDis);
  closed_loop_step_M->Timing.tStart = (0.0);
  rtsiSetSolverData(&closed_loop_step_M->solverInfo, (void *)
                    &closed_loop_step_M->intgData);
  rtsiSetIsMinorTimeStepWithModeChange(&closed_loop_step_M->solverInfo, false);
  rtsiSetSolverName(&closed_loop_step_M->solverInfo,"ode4");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = closed_loop_step_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "closed_loop_step_M points to
       static memory which is guaranteed to be non-NULL" */
    closed_loop_step_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    closed_loop_step_M->Timing.sampleTimes =
      (&closed_loop_step_M->Timing.sampleTimesArray[0]);
    closed_loop_step_M->Timing.offsetTimes =
      (&closed_loop_step_M->Timing.offsetTimesArray[0]);

    /* task periods */
    closed_loop_step_M->Timing.sampleTimes[0] = (0.0);
    closed_loop_step_M->Timing.sampleTimes[1] = (0.001);

    /* task offsets */
    closed_loop_step_M->Timing.offsetTimes[0] = (0.0);
    closed_loop_step_M->Timing.offsetTimes[1] = (0.0);
  }

  rtmSetTPtr(closed_loop_step_M, &closed_loop_step_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = closed_loop_step_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    closed_loop_step_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(closed_loop_step_M, -1);
  closed_loop_step_M->Timing.stepSize0 = 0.001;
  closed_loop_step_M->Timing.stepSize1 = 0.001;

  /* External mode info */
  closed_loop_step_M->Sizes.checksums[0] = (552510093U);
  closed_loop_step_M->Sizes.checksums[1] = (2551542036U);
  closed_loop_step_M->Sizes.checksums[2] = (955012436U);
  closed_loop_step_M->Sizes.checksums[3] = (3919720787U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[1];
    closed_loop_step_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(closed_loop_step_M->extModeInfo,
      &closed_loop_step_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(closed_loop_step_M->extModeInfo,
                        closed_loop_step_M->Sizes.checksums);
    rteiSetTPtr(closed_loop_step_M->extModeInfo, rtmGetTPtr(closed_loop_step_M));
  }

  closed_loop_step_M->solverInfoPtr = (&closed_loop_step_M->solverInfo);
  closed_loop_step_M->Timing.stepSize = (0.001);
  rtsiSetFixedStepSize(&closed_loop_step_M->solverInfo, 0.001);
  rtsiSetSolverMode(&closed_loop_step_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  closed_loop_step_M->blockIO = ((void *) &closed_loop_step_B);
  (void) memset(((void *) &closed_loop_step_B), 0,
                sizeof(B_closed_loop_step_T));

  /* parameters */
  closed_loop_step_M->defaultParam = ((real_T *)&closed_loop_step_P);

  /* states (continuous) */
  {
    real_T *x = (real_T *) &closed_loop_step_X;
    closed_loop_step_M->contStates = (x);
    (void) memset((void *)&closed_loop_step_X, 0,
                  sizeof(X_closed_loop_step_T));
  }

  /* disabled states */
  {
    boolean_T *xdis = (boolean_T *) &closed_loop_step_XDis;
    closed_loop_step_M->contStateDisabled = (xdis);
    (void) memset((void *)&closed_loop_step_XDis, 0,
                  sizeof(XDis_closed_loop_step_T));
  }

  /* states (dwork) */
  closed_loop_step_M->dwork = ((void *) &closed_loop_step_DW);
  (void) memset((void *)&closed_loop_step_DW, 0,
                sizeof(DW_closed_loop_step_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    closed_loop_step_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 23;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  closed_loop_step_M->Sizes.numContStates = (3);/* Number of continuous states */
  closed_loop_step_M->Sizes.numPeriodicContStates = (0);
                                      /* Number of periodic continuous states */
  closed_loop_step_M->Sizes.numY = (0);/* Number of model outputs */
  closed_loop_step_M->Sizes.numU = (0);/* Number of model inputs */
  closed_loop_step_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  closed_loop_step_M->Sizes.numSampTimes = (2);/* Number of sample times */
  closed_loop_step_M->Sizes.numBlocks = (21);/* Number of blocks */
  closed_loop_step_M->Sizes.numBlockIO = (6);/* Number of block outputs */
  closed_loop_step_M->Sizes.numBlockPrms = (23);/* Sum of parameter "widths" */
  return closed_loop_step_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
