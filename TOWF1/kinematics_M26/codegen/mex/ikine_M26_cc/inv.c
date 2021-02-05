/*
 * inv.c
 *
 * Code generation for function 'inv'
 *
 * C source code generated on: Tue Aug 23 13:45:40 2011
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "ikine_M26_cc.h"
#include "inv.h"
#include "ikine_M26_cc_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo pb_emlrtRSI = { 42, "eml_blas_xswap", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xswap.m" };
static emlrtRSInfo ub_emlrtRSI = { 41, "eml_blas_xger", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xger.m" };
static emlrtRSInfo cc_emlrtRSI = { 148, "inv", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/matfun/inv.m" };
static emlrtRSInfo dc_emlrtRSI = { 149, "inv", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/matfun/inv.m" };
static emlrtRSInfo ec_emlrtRSI = { 165, "inv", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/matfun/inv.m" };
static emlrtRSInfo fc_emlrtRSI = { 53, "eml_xtrsm", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/eml_xtrsm.m" };
static emlrtRSInfo hc_emlrtRSI = { 23, "eml_blas_xtrsm", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xtrsm.m" };
static emlrtRSInfo ic_emlrtRSI = { 84, "eml_blas_xtrsm", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xtrsm.m" };
static emlrtBCInfo b_emlrtBCI = { 1, 36, 44, 40, "", "eml_blas_ixamax", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_ixamax.m", 0 };
static emlrtBCInfo c_emlrtBCI = { 1, 6, 25, 16, "", "eml_ipiv2perm", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_ipiv2perm.m", 0 };
static emlrtBCInfo d_emlrtBCI = { 1, 6, 26, 9, "", "eml_ipiv2perm", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_ipiv2perm.m", 0 };
static emlrtBCInfo e_emlrtBCI = { 1, 36, 35, 9, "", "eml_matlab_zgetrf", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgetrf.m", 0 };
static emlrtBCInfo j_emlrtBCI = { 1, 36, 42, 35, "", "eml_blas_xswap", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xswap.m", 0 };
static emlrtBCInfo k_emlrtBCI = { 1, 36, 43, 9, "", "eml_blas_xswap", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xswap.m", 0 };
static emlrtBCInfo l_emlrtBCI = { 1, 36, 42, 28, "", "eml_blas_xger", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xger.m", 0 };
static emlrtBCInfo m_emlrtBCI = { 1, 36, 43, 9, "", "eml_blas_xger", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xger.m", 0 };
static emlrtBCInfo n_emlrtBCI = { 1, 36, 44, 9, "", "eml_blas_xger", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xger.m", 0 };
static emlrtBCInfo o_emlrtBCI = { 1, 36, 86, 5, "", "eml_blas_xtrsm", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xtrsm.m", 0 };
static emlrtBCInfo p_emlrtBCI = { 1, 36, 86, 40, "", "eml_blas_xtrsm", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xtrsm.m", 0 };

/* Function Declarations */
static void ceval_xtrsm(int32_T m, int32_T n, real_T alpha1, const real_T A[36], int32_T ia0, int32_T lda, real_T B[36], int32_T ib0, int32_T ldb);

/* Function Definitions */

static void ceval_xtrsm(int32_T m, int32_T n, real_T alpha1, const real_T A[36], int32_T ia0, int32_T lda, real_T B[36], int32_T ib0, int32_T ldb)
{
    char_T SIDE;
    char_T UPLO;
    char_T TRANSA;
    char_T DIAGA;
    SIDE = 'L';
    UPLO = 'U';
    TRANSA = 'N';
    DIAGA = 'N';
    EMLRTPUSHRTSTACK(&ic_emlrtRSI);
    dtrsm32(&SIDE, &UPLO, &TRANSA, &DIAGA, &m, &n, &alpha1, &A[emlrtBoundsCheckR2011a(ia0, &o_emlrtBCI, &emlrtContextGlobal) - 1], &lda, &B[emlrtBoundsCheckR2011a(ib0, &p_emlrtBCI, &emlrtContextGlobal) - 1], &ldb);
    EMLRTPOPRTSTACK(&ic_emlrtRSI);
}

int32_T ceval_ixamax(int32_T n, const real_T x[36], int32_T ix0, int32_T incx)
{
    return idamax32(&n, &x[emlrtBoundsCheckR2011a(ix0, &b_emlrtBCI, &emlrtContextGlobal) - 1], &incx);
}

void ceval_xger(int32_T m, int32_T n, real_T alpha1, int32_T ix0, int32_T incx, int32_T iy0, int32_T incy, real_T A[36], int32_T ia0, int32_T lda)
{
    EMLRTPUSHRTSTACK(&ub_emlrtRSI);
    dger32(&m, &n, &alpha1, &A[emlrtBoundsCheckR2011a(ix0, &l_emlrtBCI, &emlrtContextGlobal) - 1], &incx, &A[emlrtBoundsCheckR2011a(iy0, &m_emlrtBCI, &emlrtContextGlobal) - 1], &incy, &A[emlrtBoundsCheckR2011a(ia0, &n_emlrtBCI, &emlrtContextGlobal) - 1], &lda);
    EMLRTPOPRTSTACK(&ub_emlrtRSI);
}

void ceval_xswap(int32_T n, real_T x[36], int32_T ix0, int32_T incx, int32_T iy0, int32_T incy)
{
    EMLRTPUSHRTSTACK(&pb_emlrtRSI);
    dswap32(&n, &x[emlrtBoundsCheckR2011a(ix0, &j_emlrtBCI, &emlrtContextGlobal) - 1], &incx, &x[emlrtBoundsCheckR2011a(iy0, &k_emlrtBCI, &emlrtContextGlobal) - 1], &incy);
    EMLRTPOPRTSTACK(&pb_emlrtRSI);
}

void invNxN(const real_T x[36], real_T y[36])
{
    real_T A[36];
    int32_T pipk;
    int32_T ipiv[6];
    int32_T j;
    int32_T mmj;
    int32_T jj;
    int32_T i;
    int8_T p[6];
    memset((void *)&y[0], 0, 36U * sizeof(real_T));
    EMLRTPUSHRTSTACK(&cc_emlrtRSI);
    EMLRTPUSHRTSTACK(&eb_emlrtRSI);
    EMLRTPUSHRTSTACK(&fb_emlrtRSI);
    memcpy((void *)&A[0], (void *)&x[0], 36U * sizeof(real_T));
    for (pipk = 0; pipk < 6; pipk++) {
        ipiv[pipk] = 1 + pipk;
    }
    for (j = 0; j < 5; j++) {
        mmj = -j;
        jj = j * 7;
        EMLRTPUSHRTSTACK(&gb_emlrtRSI);
        EMLRTPUSHRTSTACK(&jb_emlrtRSI);
        EMLRTPUSHRTSTACK(&lb_emlrtRSI);
        pipk = ceval_ixamax(mmj + 6, A, jj + 1, 1);
        EMLRTPOPRTSTACK(&lb_emlrtRSI);
        EMLRTPOPRTSTACK(&jb_emlrtRSI);
        EMLRTPOPRTSTACK(&gb_emlrtRSI);
        if (A[emlrtBoundsCheckR2011a(jj + pipk, &e_emlrtBCI, &emlrtContextGlobal) - 1] != 0.0) {
            if (pipk - 1 != 0) {
                ipiv[j] = j + pipk;
                EMLRTPUSHRTSTACK(&hb_emlrtRSI);
                EMLRTPUSHRTSTACK(&mb_emlrtRSI);
                EMLRTPUSHRTSTACK(&ob_emlrtRSI);
                ceval_xswap(6, A, j + 1, 6, j + pipk, 6);
                EMLRTPOPRTSTACK(&ob_emlrtRSI);
                EMLRTPOPRTSTACK(&mb_emlrtRSI);
                EMLRTPOPRTSTACK(&hb_emlrtRSI);
            }
            pipk = (jj + mmj) + 6;
            for (i = jj + 1; i + 1 <= pipk; i++) {
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
    EMLRTPOPRTSTACK(&cc_emlrtRSI);
    EMLRTPUSHRTSTACK(&dc_emlrtRSI);
    for (pipk = 0; pipk < 6; pipk++) {
        p[pipk] = (int8_T)(1 + pipk);
    }
    for (mmj = 0; mmj < 5; mmj++) {
        if (ipiv[mmj] > mmj + 1) {
            pipk = (int32_T)p[emlrtBoundsCheckR2011a(ipiv[mmj], &c_emlrtBCI, &emlrtContextGlobal) - 1];
            p[emlrtBoundsCheckR2011a(ipiv[mmj], &d_emlrtBCI, &emlrtContextGlobal) - 1] = p[mmj];
            p[mmj] = (int8_T)pipk;
        }
    }
    EMLRTPOPRTSTACK(&dc_emlrtRSI);
    for (mmj = 0; mmj < 6; mmj++) {
        y[mmj + 6 * (p[mmj] - 1)] = 1.0;
        for (j = mmj; j + 1 < 7; j++) {
            if (y[j + 6 * (p[mmj] - 1)] != 0.0) {
                for (i = j + 1; i + 1 < 7; i++) {
                    y[i + 6 * (p[mmj] - 1)] -= y[j + 6 * (p[mmj] - 1)] * A[i + 6 * j];
                }
            }
        }
    }
    EMLRTPUSHRTSTACK(&ec_emlrtRSI);
    EMLRTPUSHRTSTACK(&fc_emlrtRSI);
    EMLRTPUSHRTSTACK(&hc_emlrtRSI);
    ceval_xtrsm(6, 6, 1.0, A, 1, 6, y, 1, 6);
    EMLRTPOPRTSTACK(&hc_emlrtRSI);
    EMLRTPOPRTSTACK(&fc_emlrtRSI);
    EMLRTPOPRTSTACK(&ec_emlrtRSI);
}
/* End of code generation (inv.c) */
