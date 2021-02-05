/*
 * norm.c
 *
 * Code generation for function 'norm'
 *
 * C source code generated on: Tue Aug 23 13:45:40 2011
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "ikine_M26_cc.h"
#include "norm.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo lc_emlrtRSI = { 44, "norm", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/matfun/norm.m" };

/* Function Declarations */

/* Function Definitions */

real_T norm(const real_T x[36])
{
    real_T y;
    int32_T j;
    boolean_T exitg1;
    real_T s;
    int32_T i;
    EMLRTPUSHRTSTACK(&lc_emlrtRSI);
    y = 0.0;
    j = 1;
    exitg1 = 0U;
    while ((exitg1 == 0U) && (j <= 6)) {
        s = 0.0;
        for (i = 0; i < 6; i++) {
            s += muDoubleScalarAbs(x[i + 6 * (j - 1)]);
        }
        if (muDoubleScalarIsNaN(s)) {
            y = rtNaN;
            exitg1 = 1U;
        } else {
            if (s > y) {
                y = s;
            }
            j++;
        }
    }
    EMLRTPOPRTSTACK(&lc_emlrtRSI);
    return y;
}
/* End of code generation (norm.c) */
