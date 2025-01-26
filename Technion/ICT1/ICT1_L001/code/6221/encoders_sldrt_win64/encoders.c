/*
 * encoders.c
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
#include "rtwtypes.h"
#include "encoders_private.h"
#include <string.h>
#include "rt_nonfinite.h"
#include "encoders_dt.h"

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

const real_T encoders_RGND = 0.0;      /* real_T ground */

/* Block signals (default storage) */
B_encoders_T encoders_B;

/* Continuous states */
X_encoders_T encoders_X;

/* Disabled State Vector */
XDis_encoders_T encoders_XDis;

/* Block states (default storage) */
DW_encoders_T encoders_DW;

/* Real-time model */
static RT_MODEL_encoders_T encoders_M_;
RT_MODEL_encoders_T *const encoders_M = &encoders_M_;

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
  int_T nXc = 2;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);

  /* Save the state values at time t in y, we'll use x as ynew. */
  (void) memcpy(y, x,
                (uint_T)nXc*sizeof(real_T));

  /* Assumes that rtsiSetT and ModelOutputs are up-to-date */
  /* f0 = f(t,y) */
  rtsiSetdX(si, f0);
  encoders_derivatives();

  /* f1 = f(t + (h/2), y + (h/2)*f0) */
  temp = 0.5 * h;
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (temp*f0[i]);
  }

  rtsiSetT(si, t + temp);
  rtsiSetdX(si, f1);
  encoders_output();
  encoders_derivatives();

  /* f2 = f(t + (h/2), y + (h/2)*f1) */
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (temp*f1[i]);
  }

  rtsiSetdX(si, f2);
  encoders_output();
  encoders_derivatives();

  /* f3 = f(t + h, y + h*f2) */
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (h*f2[i]);
  }

  rtsiSetT(si, tnew);
  rtsiSetdX(si, f3);
  encoders_output();
  encoders_derivatives();

  /* tnew = t + h
     ynew = y + (h/6)*(f0 + 2*f1 + 2*f2 + 2*f3) */
  temp = h / 6.0;
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + temp*(f0[i] + 2.0*f1[i] + 2.0*f2[i] + f3[i]);
  }

  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

/* Model output function */
void encoders_output(void)
{
  /* local block i/o variables */
  real_T rtb_EncoderInputChannel2;
  if (rtmIsMajorTimeStep(encoders_M)) {
    /* set solver stop time */
    if (!(encoders_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&encoders_M->solverInfo,
                            ((encoders_M->Timing.clockTickH0 + 1) *
        encoders_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&encoders_M->solverInfo,
                            ((encoders_M->Timing.clockTick0 + 1) *
        encoders_M->Timing.stepSize0 + encoders_M->Timing.clockTickH0 *
        encoders_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(encoders_M)) {
    encoders_M->Timing.t[0] = rtsiGetT(&encoders_M->solverInfo);
  }

  if (rtmIsMajorTimeStep(encoders_M)) {
    /* S-Function (sldrtao): '<Root>/Analog Output' */
    /* S-Function Block: <Root>/Analog Output */
    {
      {
        ANALOGIOPARM parm;
        parm.mode = (RANGEMODE) encoders_P.AnalogOutput_RangeMode;
        parm.rangeidx = encoders_P.AnalogOutput_VoltRange;
        RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                       &encoders_P.AnalogOutput_Channels, ((real_T*) (((const
          real_T*) &encoders_RGND))), &parm);
      }
    }

    /* S-Function (sldrtei): '<Root>/Encoder Input - Channel 1' */
    /* S-Function Block: <Root>/Encoder Input - Channel 1 */
    {
      ENCODERINPARM parm;
      parm.quad = (QUADMODE) 2;
      parm.index = (INDEXPULSE) 0;
      parm.infilter = encoders_P.EncoderInputChannel1_InputFilter;
      RTBIO_DriverIO(0, ENCODERINPUT, IOREAD, 1,
                     &encoders_P.EncoderInputChannel1_Channels,
                     &encoders_B.EncoderInputChannel1, &parm);
    }

    /* S-Function (sldrtei): '<Root>/Encoder Input - Channel 2' */
    /* S-Function Block: <Root>/Encoder Input - Channel 2 */
    {
      ENCODERINPARM parm;
      parm.quad = (QUADMODE) 2;
      parm.index = (INDEXPULSE) 0;
      parm.infilter = encoders_P.EncoderInputChannel2_InputFilter;
      RTBIO_DriverIO(0, ENCODERINPUT, IOREAD, 1,
                     &encoders_P.EncoderInputChannel2_Channels,
                     &rtb_EncoderInputChannel2, &parm);
    }
  }
}

/* Model update function */
void encoders_update(void)
{
  if (rtmIsMajorTimeStep(encoders_M)) {
    rt_ertODEUpdateContinuousStates(&encoders_M->solverInfo);
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
  if (!(++encoders_M->Timing.clockTick0)) {
    ++encoders_M->Timing.clockTickH0;
  }

  encoders_M->Timing.t[0] = rtsiGetSolverStopTime(&encoders_M->solverInfo);

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
    if (!(++encoders_M->Timing.clockTick1)) {
      ++encoders_M->Timing.clockTickH1;
    }

    encoders_M->Timing.t[1] = encoders_M->Timing.clockTick1 *
      encoders_M->Timing.stepSize1 + encoders_M->Timing.clockTickH1 *
      encoders_M->Timing.stepSize1 * 4294967296.0;
  }
}

/* Derivatives for root system: '<Root>' */
void encoders_derivatives(void)
{
  XDot_encoders_T *_rtXdot;
  _rtXdot = ((XDot_encoders_T *) encoders_M->derivs);

  /* Derivatives for TransferFcn: '<Root>/Transfer Fcn' */
  _rtXdot->TransferFcn_CSTATE[0] = encoders_P.TransferFcn_A[0] *
    encoders_X.TransferFcn_CSTATE[0];
  _rtXdot->TransferFcn_CSTATE[0] += encoders_P.TransferFcn_A[1] *
    encoders_X.TransferFcn_CSTATE[1];
  _rtXdot->TransferFcn_CSTATE[1] = encoders_X.TransferFcn_CSTATE[0];
}

/* Model initialize function */
void encoders_initialize(void)
{
  /* Start for S-Function (sldrtao): '<Root>/Analog Output' */

  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) encoders_P.AnalogOutput_RangeMode;
      parm.rangeidx = encoders_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &encoders_P.AnalogOutput_Channels,
                     &encoders_P.AnalogOutput_InitialValue, &parm);
    }
  }

  /* InitializeConditions for S-Function (sldrtei): '<Root>/Encoder Input - Channel 1' */

  /* S-Function Block: <Root>/Encoder Input - Channel 1 */
  {
    ENCODERINPARM parm;
    parm.quad = (QUADMODE) 2;
    parm.index = (INDEXPULSE) 0;
    parm.infilter = encoders_P.EncoderInputChannel1_InputFilter;
    RTBIO_DriverIO(0, ENCODERINPUT, IORESET, 1,
                   &encoders_P.EncoderInputChannel1_Channels, NULL, &parm);
  }

  /* InitializeConditions for S-Function (sldrtei): '<Root>/Encoder Input - Channel 2' */

  /* S-Function Block: <Root>/Encoder Input - Channel 2 */
  {
    ENCODERINPARM parm;
    parm.quad = (QUADMODE) 2;
    parm.index = (INDEXPULSE) 0;
    parm.infilter = encoders_P.EncoderInputChannel2_InputFilter;
    RTBIO_DriverIO(0, ENCODERINPUT, IORESET, 1,
                   &encoders_P.EncoderInputChannel2_Channels, NULL, &parm);
  }

  /* InitializeConditions for TransferFcn: '<Root>/Transfer Fcn' */
  encoders_X.TransferFcn_CSTATE[0] = 0.0;
  encoders_X.TransferFcn_CSTATE[1] = 0.0;
}

/* Model terminate function */
void encoders_terminate(void)
{
  /* Terminate for S-Function (sldrtao): '<Root>/Analog Output' */

  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) encoders_P.AnalogOutput_RangeMode;
      parm.rangeidx = encoders_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &encoders_P.AnalogOutput_Channels,
                     &encoders_P.AnalogOutput_FinalValue, &parm);
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
  encoders_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  encoders_update();
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
  encoders_initialize();
}

void MdlTerminate(void)
{
  encoders_terminate();
}

/* Registration function */
RT_MODEL_encoders_T *encoders(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* non-finite (run-time) assignments */
  encoders_P.EncoderInputChannel1_InputFilter = rtInf;
  encoders_P.EncoderInputChannel2_InputFilter = rtInf;

  /* initialize real-time model */
  (void) memset((void *)encoders_M, 0,
                sizeof(RT_MODEL_encoders_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&encoders_M->solverInfo,
                          &encoders_M->Timing.simTimeStep);
    rtsiSetTPtr(&encoders_M->solverInfo, &rtmGetTPtr(encoders_M));
    rtsiSetStepSizePtr(&encoders_M->solverInfo, &encoders_M->Timing.stepSize0);
    rtsiSetdXPtr(&encoders_M->solverInfo, &encoders_M->derivs);
    rtsiSetContStatesPtr(&encoders_M->solverInfo, (real_T **)
                         &encoders_M->contStates);
    rtsiSetNumContStatesPtr(&encoders_M->solverInfo,
      &encoders_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&encoders_M->solverInfo,
      &encoders_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&encoders_M->solverInfo,
      &encoders_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&encoders_M->solverInfo,
      &encoders_M->periodicContStateRanges);
    rtsiSetContStateDisabledPtr(&encoders_M->solverInfo, (boolean_T**)
      &encoders_M->contStateDisabled);
    rtsiSetErrorStatusPtr(&encoders_M->solverInfo, (&rtmGetErrorStatus
      (encoders_M)));
    rtsiSetRTModelPtr(&encoders_M->solverInfo, encoders_M);
  }

  rtsiSetSimTimeStep(&encoders_M->solverInfo, MAJOR_TIME_STEP);
  encoders_M->intgData.y = encoders_M->odeY;
  encoders_M->intgData.f[0] = encoders_M->odeF[0];
  encoders_M->intgData.f[1] = encoders_M->odeF[1];
  encoders_M->intgData.f[2] = encoders_M->odeF[2];
  encoders_M->intgData.f[3] = encoders_M->odeF[3];
  encoders_M->contStates = ((real_T *) &encoders_X);
  encoders_M->contStateDisabled = ((boolean_T *) &encoders_XDis);
  encoders_M->Timing.tStart = (0.0);
  rtsiSetSolverData(&encoders_M->solverInfo, (void *)&encoders_M->intgData);
  rtsiSetIsMinorTimeStepWithModeChange(&encoders_M->solverInfo, false);
  rtsiSetSolverName(&encoders_M->solverInfo,"ode4");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = encoders_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "encoders_M points to
       static memory which is guaranteed to be non-NULL" */
    encoders_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    encoders_M->Timing.sampleTimes = (&encoders_M->Timing.sampleTimesArray[0]);
    encoders_M->Timing.offsetTimes = (&encoders_M->Timing.offsetTimesArray[0]);

    /* task periods */
    encoders_M->Timing.sampleTimes[0] = (0.0);
    encoders_M->Timing.sampleTimes[1] = (0.001);

    /* task offsets */
    encoders_M->Timing.offsetTimes[0] = (0.0);
    encoders_M->Timing.offsetTimes[1] = (0.0);
  }

  rtmSetTPtr(encoders_M, &encoders_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = encoders_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    encoders_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(encoders_M, -1);
  encoders_M->Timing.stepSize0 = 0.001;
  encoders_M->Timing.stepSize1 = 0.001;

  /* External mode info */
  encoders_M->Sizes.checksums[0] = (2630211031U);
  encoders_M->Sizes.checksums[1] = (450992799U);
  encoders_M->Sizes.checksums[2] = (987326625U);
  encoders_M->Sizes.checksums[3] = (3008410663U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[1];
    encoders_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(encoders_M->extModeInfo,
      &encoders_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(encoders_M->extModeInfo, encoders_M->Sizes.checksums);
    rteiSetTPtr(encoders_M->extModeInfo, rtmGetTPtr(encoders_M));
  }

  encoders_M->solverInfoPtr = (&encoders_M->solverInfo);
  encoders_M->Timing.stepSize = (0.001);
  rtsiSetFixedStepSize(&encoders_M->solverInfo, 0.001);
  rtsiSetSolverMode(&encoders_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  encoders_M->blockIO = ((void *) &encoders_B);
  (void) memset(((void *) &encoders_B), 0,
                sizeof(B_encoders_T));

  /* parameters */
  encoders_M->defaultParam = ((real_T *)&encoders_P);

  /* states (continuous) */
  {
    real_T *x = (real_T *) &encoders_X;
    encoders_M->contStates = (x);
    (void) memset((void *)&encoders_X, 0,
                  sizeof(X_encoders_T));
  }

  /* disabled states */
  {
    boolean_T *xdis = (boolean_T *) &encoders_XDis;
    encoders_M->contStateDisabled = (xdis);
    (void) memset((void *)&encoders_XDis, 0,
                  sizeof(XDis_encoders_T));
  }

  /* states (dwork) */
  encoders_M->dwork = ((void *) &encoders_DW);
  (void) memset((void *)&encoders_DW, 0,
                sizeof(DW_encoders_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    encoders_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 23;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  encoders_M->Sizes.numContStates = (2);/* Number of continuous states */
  encoders_M->Sizes.numPeriodicContStates = (0);
                                      /* Number of periodic continuous states */
  encoders_M->Sizes.numY = (0);        /* Number of model outputs */
  encoders_M->Sizes.numU = (0);        /* Number of model inputs */
  encoders_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  encoders_M->Sizes.numSampTimes = (2);/* Number of sample times */
  encoders_M->Sizes.numBlocks = (10);  /* Number of blocks */
  encoders_M->Sizes.numBlockIO = (1);  /* Number of block outputs */
  encoders_M->Sizes.numBlockPrms = (19);/* Sum of parameter "widths" */
  return encoders_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
