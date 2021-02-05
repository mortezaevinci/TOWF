/*
 * det.c
 *
 * Code generation for function 'det'
 *
 * C source code generated on: Tue Aug 23 13:45:40 2011
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "ikine_M26_cc.h"
#include "det.h"
#include "inv.h"
#include "ikine_M26_cc_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo cb_emlrtRSI = { 20, "det", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/matfun/det.m" };
static emlrtBCInfo emlrtBCI = { 1, 36, 35, 9, "", "eml_matlab_zgetrf", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgetrf.m", 0 };

/* Function Declarations */

/* Function Definitions */

real_T det(const real_T x[36])
{
    real_T y;
    real_T A[36];
    int32_T k;
    int32_T ipiv[6];
    int32_T j;
    int32_T mmj;
    int32_T jj;
    int32_T i;
    boolean_T isodd;
    EMLRTPUSHRTSTACK(&cb_emlrtRSI);
    EMLRTPUSHRTSTACK(&eb_emlrtRSI);
    EMLRTPUSHRTSTACK(&fb_emlrtRSI);
    memcpy((void *)&A[0], (void *)&x[0], 36U * sizeof(real_T));
    for (k = 0; k < 6; k++) {
        ipiv[k] = 1 + k;
    }
    for (j = 0; j < 5; j++) {
        mmj = -j;
        jj = j * 7;
        EMLRTPUSHRTSTACK(&gb_emlrtRSI);
        EMLRTPUSHRTSTACK(&jb_emlrtRSI);
        EMLRTPUSHRTSTACK(&lb_emlrtRSI);
        k = ceval_ixamax(mmj + 6, A, jj + 1, 1);
        EMLRTPOPRTSTACK(&lb_emlrtRSI);
        EMLRTPOPRTSTACK(&jb_emlrtRSI);
        EMLRTPOPRTSTACK(&gb_emlrtRSI);
        if (A[emlrtBoundsCheckR2011a(jj + k, &emlrtBCI, &emlrtContextGlobal) - 1] != 0.0) {
            if (k - 1 != 0) {
                ipiv[j] = j + k;
                EMLRTPUSHRTSTACK(&hb_emlrtRSI);
                EMLRTPUSHRTSTACK(&mb_emlrtRSI);
                EMLRTPUSHRTSTACK(&ob_emlrtRSI);
                ceval_xswap(6, A, j + 1, 6, j + k, 6);
                EMLRTPOPRTSTACK(&ob_emlrtRSI);
                EMLRTPOPRTSTACK(&mb_emlrtRSI);
                EMLRTPOPRTSTACK(&hb_emlrtRSI);
            }
            k = (jj + mmj) + 6;
            for (i = jj + 1; i + 1 <= k; i++) {
                A[i] /= A[jj];
            }
        }
        EMLRTPUSHRTSTACK(&ib_emlrtRSI);
        EMLRTPUSHRTSTACK(&qb_emlrtRSI);
        EMLRTPUSHRTSTACK(&rb_emlrtRSI);
        EMLRTPUSHRTSTACK(&sb_emlrtRSI);
        ceval_xger(mmj + 5, 5 - j, -1.0, jj + 2, 1, jj + 7, 6, A, jj + 8, 6);
        EMLRTPOPRTSTACK(&sb_emlrtRSI);
        EMLRTPOPRTSTACK(&rb_emlrtRSI);
        EMLRTPOPRTSTACK(&qb_emlrtRSI);
        EMLRTPOPRTSTACK(&ib_emlrtRSI);
    }
    EMLRTPOPRTSTACK(&fb_emlrtRSI);
    EMLRTPOPRTSTACK(&eb_emlrtRSI);
    EMLRTPOPRTSTACK(&cb_emlrtRSI);
    y = A[0];
    for (k = 0; k < 5; k++) {
        y *= A[(k + 6 * (k + 1)) + 1];
    }
    isodd = FALSE;
    for (k = 0; k < 5; k++) {
        if (ipiv[k] > k + 1) {
            isodd = !isodd;
        }
    }
    if (isodd) {
        y = -y;
    }
    return y;
}
/* End of code generation (det.c) */
