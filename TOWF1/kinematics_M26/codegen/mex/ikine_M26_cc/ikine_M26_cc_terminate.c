/*
 * ikine_M26_cc_terminate.c
 *
 * Code generation for function 'ikine_M26_cc_terminate'
 *
 * C source code generated on: Tue Aug 23 13:45:40 2011
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "ikine_M26_cc.h"
#include "ikine_M26_cc_terminate.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */

/* Function Definitions */

void ikine_M26_cc_atexit(void)
{
    emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void ikine_M26_cc_terminate(void)
{
    emlrtLeaveRtStack(&emlrtContextGlobal);
}
/* End of code generation (ikine_M26_cc_terminate.c) */
