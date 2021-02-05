/*
 * ikine_M26_cc_mexutil.c
 *
 * Code generation for function 'ikine_M26_cc_mexutil'
 *
 * C source code generated on: Tue Aug 23 13:45:39 2011
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "ikine_M26_cc.h"
#include "ikine_M26_cc_mexutil.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */

/* Function Definitions */

const mxArray *emlrt_marshallOut(real_T u)
{
    const mxArray *y;
    const mxArray *m6;
    y = NULL;
    m6 = mxCreateDoubleScalar(u);
    emlrtAssign(&y, m6);
    return y;
}

void error(const mxArray *b, emlrtMCInfo *location)
{
    const mxArray *pArray;
    pArray = b;
    emlrtCallMATLAB(0, NULL, 1, &pArray, "error", TRUE, location);
}

const mxArray *message(const mxArray *b, emlrtMCInfo *location)
{
    const mxArray *pArray;
    const mxArray *m8;
    pArray = b;
    return emlrtCallMATLAB(1, &m8, 1, &pArray, "message", TRUE, location);
}
/* End of code generation (ikine_M26_cc_mexutil.c) */
