/*
 * ikine_M26_cc.c
 *
 * Code generation for function 'ikine_M26_cc'
 *
 * C source code generated on: Tue Aug 23 13:45:39 2011
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "ikine_M26_cc.h"
#include "norm.h"
#include "inv.h"
#include "det.h"
#include "jacob_M26.h"
#include "ikine_M26_cc_mexutil.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 33, "ikine_M26_cc", "J:/My files/Project TOWF/MATLAB/TOWF1/kinematics_M26/ikine_M26_cc.m" };
static emlrtRSInfo b_emlrtRSI = { 43, "ikine_M26_cc", "J:/My files/Project TOWF/MATLAB/TOWF1/kinematics_M26/ikine_M26_cc.m" };
static emlrtRSInfo c_emlrtRSI = { 46, "ikine_M26_cc", "J:/My files/Project TOWF/MATLAB/TOWF1/kinematics_M26/ikine_M26_cc.m" };
static emlrtRSInfo d_emlrtRSI = { 47, "ikine_M26_cc", "J:/My files/Project TOWF/MATLAB/TOWF1/kinematics_M26/ikine_M26_cc.m" };
static emlrtRSInfo e_emlrtRSI = { 48, "ikine_M26_cc", "J:/My files/Project TOWF/MATLAB/TOWF1/kinematics_M26/ikine_M26_cc.m" };
static emlrtRSInfo f_emlrtRSI = { 58, "ikine_M26_cc", "J:/My files/Project TOWF/MATLAB/TOWF1/kinematics_M26/ikine_M26_cc.m" };
static emlrtRSInfo g_emlrtRSI = { 75, "ikine_M26_cc", "J:/My files/Project TOWF/MATLAB/TOWF1/kinematics_M26/ikine_M26_cc.m" };
static emlrtRSInfo h_emlrtRSI = { 93, "ikine_M26_cc", "J:/My files/Project TOWF/MATLAB/TOWF1/kinematics_M26/ikine_M26_cc.m" };
static emlrtRSInfo i_emlrtRSI = { 4, "T2cartesian_real", "J:/My files/Project TOWF/MATLAB/TOWF1/kinematics_M26/T2cartesian_real.m" };
static emlrtRSInfo j_emlrtRSI = { 2, "Rc2euler", "J:/My files/Project TOWF/MATLAB/TOWF1/conversions/Rc2euler.m" };
static emlrtRSInfo k_emlrtRSI = { 3, "Rc2euler", "J:/My files/Project TOWF/MATLAB/TOWF1/conversions/Rc2euler.m" };
static emlrtRSInfo l_emlrtRSI = { 4, "Rc2euler", "J:/My files/Project TOWF/MATLAB/TOWF1/conversions/Rc2euler.m" };
static emlrtRSInfo m_emlrtRSI = { 14, "asin", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/elfun/asin.m" };
static emlrtRSInfo n_emlrtRSI = { 15, "eml_error", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_error.m" };
static emlrtRSInfo o_emlrtRSI = { 14, "acos", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/elfun/acos.m" };
static emlrtRSInfo p_emlrtRSI = { 15, "eml_error", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_error.m" };
static emlrtRSInfo w_emlrtRSI = { 55, "mtimes", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/ops/mtimes.m" };
static emlrtRSInfo x_emlrtRSI = { 53, "eml_xgemm", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/eml_xgemm.m" };
static emlrtRSInfo y_emlrtRSI = { 26, "eml_blas_xgemm", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xgemm.m" };
static emlrtRSInfo ab_emlrtRSI = { 76, "eml_blas_xgemm", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xgemm.m" };
static emlrtRSInfo vb_emlrtRSI = { 41, "mpower", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/ops/mpower.m" };
static emlrtRSInfo yb_emlrtRSI = { 74, "mpower", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/ops/mpower.m" };
static emlrtRSInfo ac_emlrtRSI = { 17, "inv", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/matfun/inv.m" };
static emlrtRSInfo bc_emlrtRSI = { 18, "inv", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/matfun/inv.m" };
static emlrtRSInfo jc_emlrtRSI = { 39, "inv", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/matfun/inv.m" };
static emlrtRSInfo kc_emlrtRSI = { 41, "inv", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/matfun/inv.m" };
static emlrtRSInfo mc_emlrtRSI = { 16, "eml_warning", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_warning.m" };
static emlrtRSInfo nc_emlrtRSI = { 27, "eml_flt2str", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_flt2str.m" };
static emlrtRSInfo oc_emlrtRSI = { 16, "eml_warning", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_warning.m" };
static emlrtRSInfo pc_emlrtRSI = { 38, "norm", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/matfun/norm.m" };
static emlrtRSInfo qc_emlrtRSI = { 171, "norm", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/matfun/norm.m" };
static emlrtRSInfo rc_emlrtRSI = { 18, "eml_xnrm2", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/eml_xnrm2.m" };
static emlrtRSInfo tc_emlrtRSI = { 23, "eml_blas_xnrm2", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xnrm2.m" };
static emlrtMCInfo emlrtMCI = { 15, 19, "eml_error", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_error.m" };
static emlrtMCInfo b_emlrtMCI = { 15, 5, "eml_error", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_error.m" };
static emlrtMCInfo c_emlrtMCI = { 15, 19, "eml_error", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_error.m" };
static emlrtMCInfo d_emlrtMCI = { 15, 5, "eml_error", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_error.m" };
static emlrtMCInfo g_emlrtMCI = { 16, 21, "eml_warning", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_warning.m" };
static emlrtMCInfo h_emlrtMCI = { 16, 5, "eml_warning", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_warning.m" };
static emlrtMCInfo i_emlrtMCI = { 27, 23, "eml_flt2str", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_flt2str.m" };
static emlrtMCInfo j_emlrtMCI = { 27, 15, "eml_flt2str", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_flt2str.m" };
static emlrtMCInfo k_emlrtMCI = { 16, 21, "eml_warning", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_warning.m" };
static emlrtMCInfo l_emlrtMCI = { 16, 5, "eml_warning", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/eml_warning.m" };
static emlrtBCInfo f_emlrtBCI = { 1, 6, 48, 35, "", "eml_blas_xnrm2", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xnrm2.m", 0 };
static emlrtBCInfo g_emlrtBCI = { 1, 36, 78, 24, "", "eml_blas_xgemm", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xgemm.m", 0 };
static emlrtBCInfo h_emlrtBCI = { 1, 36, 79, 5, "", "eml_blas_xgemm", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xgemm.m", 0 };
static emlrtBCInfo i_emlrtBCI = { 1, 36, 80, 23, "", "eml_blas_xgemm", "C:/Program Files/MATLAB/R2011a/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xgemm.m", 0 };

/* Function Declarations */
static void b_eml_error(void);
static void b_eml_warning(const char_T varargin_2[14]);
static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier *parentId, char_T y[14]);
static const mxArray *b_message(const mxArray *b, const mxArray *c, emlrtMCInfo *location);
static const mxArray *b_sprintf(const mxArray *b, const mxArray *c, const mxArray *d, emlrtMCInfo *location);
static const mxArray *c_sprintf(const mxArray *b, const mxArray *c, emlrtMCInfo *location);
static void ceval_xgemm(int32_T m, int32_T n, int32_T k, real_T alpha1, const real_T A[36], int32_T ia0, int32_T lda, const real_T B[36], int32_T ib0, int32_T ldb, real_T beta1, real_T C[36], int32_T ic0, int32_T ldc);
static real_T ceval_xnrm2(int32_T n, const real_T x[6], int32_T ix0, int32_T incx);
static void eml_error(void);
static void eml_warning(void);
static void emlrt_marshallIn(const mxArray *d_sprintf, const char_T *identifier, char_T y[14]);
static void i_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *msgId, char_T ret[14]);
static void warning(const mxArray *b, emlrtMCInfo *location);

/* Function Definitions */

static void b_eml_error(void)
{
    const mxArray *y;
    static const int32_T iv3[2] = { 1, 30 };
    const mxArray *m2;
    static const char_T cv2[30] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o', 'l', 'b', 'o', 'x', ':', 'a', 'c', 'o', 's', '_', 'd', 'o', 'm', 'a', 'i', 'n', 'E', 'r', 'r', 'o', 'r' };
    EMLRTPUSHRTSTACK(&p_emlrtRSI);
    y = NULL;
    m2 = mxCreateCharArray(2, iv3);
    emlrtInitCharArray(30, m2, cv2);
    emlrtAssign(&y, m2);
    error(message(y, &c_emlrtMCI), &d_emlrtMCI);
    EMLRTPOPRTSTACK(&p_emlrtRSI);
}

static void b_eml_warning(const char_T varargin_2[14])
{
    const mxArray *y;
    static const int32_T iv6[2] = { 1, 33 };
    const mxArray *m5;
    static const char_T cv5[33] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T', 'L', 'A', 'B', ':', 'i', 'l', 'l', 'C', 'o', 'n', 'd', 'i', 't', 'i', 'o', 'n', 'e', 'd', 'M', 'a', 't', 'r', 'i', 'x' };
    const mxArray *b_y;
    static const int32_T iv7[2] = { 1, 14 };
    EMLRTPUSHRTSTACK(&oc_emlrtRSI);
    y = NULL;
    m5 = mxCreateCharArray(2, iv6);
    emlrtInitCharArray(33, m5, cv5);
    emlrtAssign(&y, m5);
    b_y = NULL;
    m5 = mxCreateCharArray(2, iv7);
    emlrtInitCharArray(14, m5, varargin_2);
    emlrtAssign(&b_y, m5);
    warning(b_message(y, b_y, &k_emlrtMCI), &l_emlrtMCI);
    EMLRTPOPRTSTACK(&oc_emlrtRSI);
}

static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier *parentId, char_T y[14])
{
    i_emlrt_marshallIn(emlrtAlias(u), parentId, y);
    emlrtDestroyArray(&u);
}

static const mxArray *b_message(const mxArray *b, const mxArray *c, emlrtMCInfo *location)
{
    const mxArray *pArrays[2];
    const mxArray *m11;
    pArrays[0] = b;
    pArrays[1] = c;
    return emlrtCallMATLAB(1, &m11, 2, pArrays, "message", TRUE, location);
}

static const mxArray *b_sprintf(const mxArray *b, const mxArray *c, const mxArray *d, emlrtMCInfo *location)
{
    const mxArray *pArrays[3];
    const mxArray *m9;
    pArrays[0] = b;
    pArrays[1] = c;
    pArrays[2] = d;
    return emlrtCallMATLAB(1, &m9, 3, pArrays, "sprintf", TRUE, location);
}

static const mxArray *c_sprintf(const mxArray *b, const mxArray *c, emlrtMCInfo *location)
{
    const mxArray *pArrays[2];
    const mxArray *m10;
    pArrays[0] = b;
    pArrays[1] = c;
    return emlrtCallMATLAB(1, &m10, 2, pArrays, "sprintf", TRUE, location);
}

static void ceval_xgemm(int32_T m, int32_T n, int32_T k, real_T alpha1, const real_T A[36], int32_T ia0, int32_T lda, const real_T B[36], int32_T ib0, int32_T ldb, real_T beta1, real_T C[36], int32_T ic0, int32_T ldc)
{
    char_T TRANSA;
    char_T TRANSB;
    TRANSA = 'N';
    TRANSB = 'N';
    EMLRTPUSHRTSTACK(&ab_emlrtRSI);
    dgemm32(&TRANSA, &TRANSB, &m, &n, &k, &alpha1, &A[emlrtBoundsCheckR2011a(ia0, &g_emlrtBCI, &emlrtContextGlobal) - 1], &lda, &B[emlrtBoundsCheckR2011a(ib0, &h_emlrtBCI, &emlrtContextGlobal) - 1], &ldb, &beta1, &C[emlrtBoundsCheckR2011a(ic0, &i_emlrtBCI, &emlrtContextGlobal) - 1], &ldc);
    EMLRTPOPRTSTACK(&ab_emlrtRSI);
}

static real_T ceval_xnrm2(int32_T n, const real_T x[6], int32_T ix0, int32_T incx)
{
    return dnrm232(&n, &x[emlrtBoundsCheckR2011a(ix0, &f_emlrtBCI, &emlrtContextGlobal) - 1], &incx);
}

static void eml_error(void)
{
    const mxArray *y;
    static const int32_T iv2[2] = { 1, 30 };
    const mxArray *m1;
    static const char_T cv1[30] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o', 'l', 'b', 'o', 'x', ':', 'a', 's', 'i', 'n', '_', 'd', 'o', 'm', 'a', 'i', 'n', 'E', 'r', 'r', 'o', 'r' };
    EMLRTPUSHRTSTACK(&n_emlrtRSI);
    y = NULL;
    m1 = mxCreateCharArray(2, iv2);
    emlrtInitCharArray(30, m1, cv1);
    emlrtAssign(&y, m1);
    error(message(y, &emlrtMCI), &b_emlrtMCI);
    EMLRTPOPRTSTACK(&n_emlrtRSI);
}

static void eml_warning(void)
{
    const mxArray *y;
    static const int32_T iv5[2] = { 1, 27 };
    const mxArray *m4;
    static const char_T cv4[27] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'i', 'n', 'g', 'u', 'l', 'a', 'r', 'M', 'a', 't', 'r', 'i', 'x' };
    EMLRTPUSHRTSTACK(&mc_emlrtRSI);
    y = NULL;
    m4 = mxCreateCharArray(2, iv5);
    emlrtInitCharArray(27, m4, cv4);
    emlrtAssign(&y, m4);
    warning(message(y, &g_emlrtMCI), &h_emlrtMCI);
    EMLRTPOPRTSTACK(&mc_emlrtRSI);
}

static void emlrt_marshallIn(const mxArray *d_sprintf, const char_T *identifier, char_T y[14])
{
    emlrtMsgIdentifier thisId;
    thisId.fIdentifier = identifier;
    thisId.fParent = NULL;
    b_emlrt_marshallIn(emlrtAlias(d_sprintf), &thisId, y);
    emlrtDestroyArray(&d_sprintf);
}

static void i_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *msgId, char_T ret[14])
{
    int32_T i1;
    int32_T iv9[2];
    for (i1 = 0; i1 < 2; i1++) {
        iv9[i1] = 1 + 13 * i1;
    }
    emlrtCheckBuiltInR2011a(msgId, src, "char", FALSE, 2U, iv9);
    emlrtImportCharArray(src, ret, 14);
    emlrtDestroyArray(&src);
}

static void warning(const mxArray *b, emlrtMCInfo *location)
{
    const mxArray *pArray;
    pArray = b;
    emlrtCallMATLAB(0, NULL, 1, &pArray, "warning", TRUE, location);
}

void ikine_M26_cc(const real_T TT[16], const real_T L[6], const real_T q0[6], real_T qout[6], real_T *isconverged)
{
    int32_T i;
    real_T nm;
    int32_T count;
    boolean_T exitg1;
    real_T b_TT[16];
    static const int8_T iv0[4] = { 0, 0, 0, 1 };
    real_T theta;
    real_T y;
    real_T b_y;
    real_T c_y;
    real_T d_y;
    real_T J[36];
    real_T qq[36];
    int32_T i0;
    real_T b_J[36];
    static const real_T dv0[36] = { 0.005, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.005, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.005, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.005, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.005, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.005 };
    boolean_T b0;
    real_T c[36];
    real_T dv1[36];
    real_T n1x;
    real_T n1xinv;
    real_T rc;
    const mxArray *e_y;
    static const int32_T iv1[2] = { 1, 8 };
    const mxArray *m0;
    static const char_T cv0[8] = { '%', '%', '%', 'd', '.', '%', 'd', 'e' };
    char_T str[14];
    real_T dq[6];
    real_T c_TT[6];
    real_T d_TT[6];
    real_T f_y[6];
    /* 0 for ordinary jacobean, 1 for DLS */
    /*  */
    /*   solution control parameters */
    /*  */
    *isconverged = 1.0;
    for (i = 0; i < 6; i++) {
        qout[i] = q0[i];
    }
    /*  	if ishomog(tr),		% single xform case */
    nm = 5.0;
    count = 0;
    exitg1 = 0U;
    while ((exitg1 == 0U) && (nm > 0.01)) {
        EMLRTPUSHRTSTACK(&emlrtRSI);
        /* created by M2d .... it is the new M26 */
        b_TT[0] = muDoubleScalarSin(qout[5]) * (muDoubleScalarSin(qout[3]) * (muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[2]) - muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[2])) - muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[3]) * muDoubleScalarSin(qout[1])) - muDoubleScalarCos(qout[5]) * (muDoubleScalarCos(qout[4]) * (muDoubleScalarCos(qout[3]) * (muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[2]) - muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[2])) + muDoubleScalarCos(qout[0]) * muDoubleScalarSin(qout[1]) * muDoubleScalarSin(qout[3])) + muDoubleScalarSin(qout[4]) * (muDoubleScalarCos(qout[2]) * muDoubleScalarSin(qout[0]) + muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[1]) * muDoubleScalarSin(qout[2])));
        b_TT[4] = muDoubleScalarSin(qout[4]) * (muDoubleScalarCos(qout[3]) * (muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[2]) - muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[2])) + muDoubleScalarCos(qout[0]) * muDoubleScalarSin(qout[1]) * muDoubleScalarSin(qout[3])) - muDoubleScalarCos(qout[4]) * (muDoubleScalarCos(qout[2]) * muDoubleScalarSin(qout[0]) + muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[1]) * muDoubleScalarSin(qout[2]));
        b_TT[8] = muDoubleScalarCos(qout[5]) * (muDoubleScalarSin(qout[3]) * (muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[2]) - muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[2])) - muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[3]) * muDoubleScalarSin(qout[1])) + muDoubleScalarSin(qout[5]) * (muDoubleScalarCos(qout[4]) * (muDoubleScalarCos(qout[3]) * (muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[2]) - muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[2])) + muDoubleScalarCos(qout[0]) * muDoubleScalarSin(qout[1]) * muDoubleScalarSin(qout[3])) + muDoubleScalarSin(qout[4]) * (muDoubleScalarCos(qout[2]) * muDoubleScalarSin(qout[0]) + muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[1]) * muDoubleScalarSin(qout[2])));
        b_TT[12] = (((L[0] * muDoubleScalarCos(qout[0]) + (muDoubleScalarSin(qout[3]) * (muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[2]) - muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[2])) - muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[3]) * muDoubleScalarSin(qout[1])) * (L[3] + L[4])) - L[5] * muDoubleScalarCos(qout[5]) * (muDoubleScalarCos(qout[4]) * (muDoubleScalarCos(qout[3]) * (muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[2]) - muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[2])) + muDoubleScalarCos(qout[0]) * muDoubleScalarSin(qout[1]) * muDoubleScalarSin(qout[3])) + muDoubleScalarSin(qout[4]) * (muDoubleScalarCos(qout[2]) * muDoubleScalarSin(qout[0]) + muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[1]) * muDoubleScalarSin(qout[2])))) - muDoubleScalarCos(qout[0]) * muDoubleScalarSin(qout[1]) * (L[1] + L[2])) + L[5] * muDoubleScalarSin(qout[5]) * (muDoubleScalarSin(qout[3]) * (muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[2]) - muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[2])) - muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[3]) * muDoubleScalarSin(qout[1]));
        b_TT[1] = muDoubleScalarCos(qout[5]) * (muDoubleScalarCos(qout[4]) * (muDoubleScalarCos(qout[3]) * (muDoubleScalarCos(qout[0]) * muDoubleScalarSin(qout[2]) + muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[2]) * muDoubleScalarSin(qout[0])) - muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[1]) * muDoubleScalarSin(qout[3])) + muDoubleScalarSin(qout[4]) * (muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[2]) - muDoubleScalarCos(qout[1]) * muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[2]))) - muDoubleScalarSin(qout[5]) * (muDoubleScalarSin(qout[3]) * (muDoubleScalarCos(qout[0]) * muDoubleScalarSin(qout[2]) + muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[2]) * muDoubleScalarSin(qout[0])) + muDoubleScalarCos(qout[3]) * muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[1]));
        b_TT[5] = muDoubleScalarCos(qout[4]) * (muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[2]) - muDoubleScalarCos(qout[1]) * muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[2])) - muDoubleScalarSin(qout[4]) * (muDoubleScalarCos(qout[3]) * (muDoubleScalarCos(qout[0]) * muDoubleScalarSin(qout[2]) + muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[2]) * muDoubleScalarSin(qout[0])) - muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[1]) * muDoubleScalarSin(qout[3]));
        b_TT[9] = -muDoubleScalarCos(qout[5]) * (muDoubleScalarSin(qout[3]) * (muDoubleScalarCos(qout[0]) * muDoubleScalarSin(qout[2]) + muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[2]) * muDoubleScalarSin(qout[0])) + muDoubleScalarCos(qout[3]) * muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[1])) - muDoubleScalarSin(qout[5]) * (muDoubleScalarCos(qout[4]) * (muDoubleScalarCos(qout[3]) * (muDoubleScalarCos(qout[0]) * muDoubleScalarSin(qout[2]) + muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[2]) * muDoubleScalarSin(qout[0])) - muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[1]) * muDoubleScalarSin(qout[3])) + muDoubleScalarSin(qout[4]) * (muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[2]) - muDoubleScalarCos(qout[1]) * muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[2])));
        b_TT[13] = (((L[0] * muDoubleScalarSin(qout[0]) - (muDoubleScalarSin(qout[3]) * (muDoubleScalarCos(qout[0]) * muDoubleScalarSin(qout[2]) + muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[2]) * muDoubleScalarSin(qout[0])) + muDoubleScalarCos(qout[3]) * muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[1])) * (L[3] + L[4])) + L[5] * muDoubleScalarCos(qout[5]) * (muDoubleScalarCos(qout[4]) * (muDoubleScalarCos(qout[3]) * (muDoubleScalarCos(qout[0]) * muDoubleScalarSin(qout[2]) + muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[2]) * muDoubleScalarSin(qout[0])) - muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[1]) * muDoubleScalarSin(qout[3])) + muDoubleScalarSin(qout[4]) * (muDoubleScalarCos(qout[0]) * muDoubleScalarCos(qout[2]) - muDoubleScalarCos(qout[1]) * muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[2])))) - muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[1]) * (L[1] + L[2])) - L[5] * muDoubleScalarSin(qout[5]) * (muDoubleScalarSin(qout[3]) * (muDoubleScalarCos(qout[0]) * muDoubleScalarSin(qout[2]) + muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[2]) * muDoubleScalarSin(qout[0])) + muDoubleScalarCos(qout[3]) * muDoubleScalarSin(qout[0]) * muDoubleScalarSin(qout[1]));
        b_TT[2] = muDoubleScalarCos(qout[5]) * (muDoubleScalarCos(qout[4]) * (muDoubleScalarCos(qout[1]) * muDoubleScalarSin(qout[3]) + muDoubleScalarCos(qout[2]) * muDoubleScalarCos(qout[3]) * muDoubleScalarSin(qout[1])) - muDoubleScalarSin(qout[1]) * muDoubleScalarSin(qout[2]) * muDoubleScalarSin(qout[4])) + muDoubleScalarSin(qout[5]) * (muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[3]) - muDoubleScalarCos(qout[2]) * muDoubleScalarSin(qout[1]) * muDoubleScalarSin(qout[3]));
        b_TT[6] = -muDoubleScalarSin(qout[4]) * (muDoubleScalarCos(qout[1]) * muDoubleScalarSin(qout[3]) + muDoubleScalarCos(qout[2]) * muDoubleScalarCos(qout[3]) * muDoubleScalarSin(qout[1])) - muDoubleScalarCos(qout[4]) * muDoubleScalarSin(qout[1]) * muDoubleScalarSin(qout[2]);
        b_TT[10] = muDoubleScalarCos(qout[5]) * (muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[3]) - muDoubleScalarCos(qout[2]) * muDoubleScalarSin(qout[1]) * muDoubleScalarSin(qout[3])) - muDoubleScalarSin(qout[5]) * (muDoubleScalarCos(qout[4]) * (muDoubleScalarCos(qout[1]) * muDoubleScalarSin(qout[3]) + muDoubleScalarCos(qout[2]) * muDoubleScalarCos(qout[3]) * muDoubleScalarSin(qout[1])) - muDoubleScalarSin(qout[1]) * muDoubleScalarSin(qout[2]) * muDoubleScalarSin(qout[4]));
        b_TT[14] = (((L[3] + L[4]) * (muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[3]) - muDoubleScalarCos(qout[2]) * muDoubleScalarSin(qout[1]) * muDoubleScalarSin(qout[3])) + muDoubleScalarCos(qout[1]) * (L[1] + L[2])) + L[5] * muDoubleScalarSin(qout[5]) * (muDoubleScalarCos(qout[1]) * muDoubleScalarCos(qout[3]) - muDoubleScalarCos(qout[2]) * muDoubleScalarSin(qout[1]) * muDoubleScalarSin(qout[3]))) + L[5] * muDoubleScalarCos(qout[5]) * (muDoubleScalarCos(qout[4]) * (muDoubleScalarCos(qout[1]) * muDoubleScalarSin(qout[3]) + muDoubleScalarCos(qout[2]) * muDoubleScalarCos(qout[3]) * muDoubleScalarSin(qout[1])) - muDoubleScalarSin(qout[1]) * muDoubleScalarSin(qout[2]) * muDoubleScalarSin(qout[4]));
        for (i = 0; i < 4; i++) {
            b_TT[3 + (i << 2)] = (real_T)iv0[i];
        }
        EMLRTPUSHRTSTACK(&i_emlrtRSI);
        EMLRTPUSHRTSTACK(&j_emlrtRSI);
        nm = -b_TT[2];
        if ((nm < -1.0) || (1.0 < nm)) {
            EMLRTPUSHRTSTACK(&m_emlrtRSI);
            eml_error();
            EMLRTPOPRTSTACK(&m_emlrtRSI);
        }
        theta = muDoubleScalarAsin(nm);
        EMLRTPOPRTSTACK(&j_emlrtRSI);
        EMLRTPUSHRTSTACK(&k_emlrtRSI);
        y = b_TT[1] / muDoubleScalarCos(theta);
        if ((y < -1.0) || (1.0 < y)) {
            EMLRTPUSHRTSTACK(&m_emlrtRSI);
            eml_error();
            EMLRTPOPRTSTACK(&m_emlrtRSI);
        }
        EMLRTPOPRTSTACK(&k_emlrtRSI);
        EMLRTPUSHRTSTACK(&l_emlrtRSI);
        b_y = b_TT[10] / muDoubleScalarCos(theta);
        if ((b_y < -1.0) || (1.0 < b_y)) {
            EMLRTPUSHRTSTACK(&o_emlrtRSI);
            b_eml_error();
            EMLRTPOPRTSTACK(&o_emlrtRSI);
        }
        EMLRTPOPRTSTACK(&l_emlrtRSI);
        EMLRTPOPRTSTACK(&i_emlrtRSI);
        EMLRTPUSHRTSTACK(&i_emlrtRSI);
        EMLRTPUSHRTSTACK(&j_emlrtRSI);
        nm = -TT[2];
        if ((nm < -1.0) || (1.0 < nm)) {
            EMLRTPUSHRTSTACK(&m_emlrtRSI);
            eml_error();
            EMLRTPOPRTSTACK(&m_emlrtRSI);
        }
        nm = muDoubleScalarAsin(nm);
        EMLRTPOPRTSTACK(&j_emlrtRSI);
        EMLRTPUSHRTSTACK(&k_emlrtRSI);
        c_y = TT[1] / muDoubleScalarCos(nm);
        if ((c_y < -1.0) || (1.0 < c_y)) {
            EMLRTPUSHRTSTACK(&m_emlrtRSI);
            eml_error();
            EMLRTPOPRTSTACK(&m_emlrtRSI);
        }
        EMLRTPOPRTSTACK(&k_emlrtRSI);
        EMLRTPUSHRTSTACK(&l_emlrtRSI);
        d_y = TT[10] / muDoubleScalarCos(nm);
        if ((d_y < -1.0) || (1.0 < d_y)) {
            EMLRTPUSHRTSTACK(&o_emlrtRSI);
            b_eml_error();
            EMLRTPOPRTSTACK(&o_emlrtRSI);
        }
        EMLRTPOPRTSTACK(&l_emlrtRSI);
        EMLRTPOPRTSTACK(&i_emlrtRSI);
        EMLRTPOPRTSTACK(&emlrtRSI);
        EMLRTPUSHRTSTACK(&b_emlrtRSI);
        jacob_M26(L, qout, J);
        EMLRTPOPRTSTACK(&b_emlrtRSI);
        EMLRTPUSHRTSTACK(&c_emlrtRSI);
        EMLRTPUSHRTSTACK(&w_emlrtRSI);
        EMLRTPUSHRTSTACK(&x_emlrtRSI);
        EMLRTPUSHRTSTACK(&y_emlrtRSI);
        memset((void *)&qq[0], 0, 36U * sizeof(real_T));
        for (i = 0; i < 6; i++) {
            for (i0 = 0; i0 < 6; i0++) {
                b_J[i0 + 6 * i] = J[i + 6 * i0];
            }
        }
        ceval_xgemm(6, 6, 6, 1.0, J, 1, 6, b_J, 1, 6, 0.0, qq, 1, 6);
        EMLRTPOPRTSTACK(&y_emlrtRSI);
        EMLRTPOPRTSTACK(&x_emlrtRSI);
        EMLRTPOPRTSTACK(&w_emlrtRSI);
        for (i = 0; i < 36; i++) {
            qq[i] += dv0[i];
        }
        EMLRTPOPRTSTACK(&c_emlrtRSI);
        EMLRTPUSHRTSTACK(&d_emlrtRSI);
        b0 = (det(qq) != 0.0);
        EMLRTPOPRTSTACK(&d_emlrtRSI);
        if (b0) {
            EMLRTPUSHRTSTACK(&e_emlrtRSI);
            EMLRTPUSHRTSTACK(&vb_emlrtRSI);
            memcpy((void *)&c[0], (void *)&qq[0], 36U * sizeof(real_T));
            EMLRTPUSHRTSTACK(&yb_emlrtRSI);
            memcpy((void *)&qq[0], (void *)&c[0], 36U * sizeof(real_T));
            EMLRTPUSHRTSTACK(&ac_emlrtRSI);
            invNxN(c, dv1);
            memcpy((void *)&c[0], (void *)&dv1[0], 36U * sizeof(real_T));
            EMLRTPOPRTSTACK(&ac_emlrtRSI);
            EMLRTPUSHRTSTACK(&bc_emlrtRSI);
            n1x = norm(qq);
            n1xinv = norm(c);
            rc = 1.0 / (n1x * n1xinv);
            if ((n1x == 0.0) || (n1xinv == 0.0) || (rc == 0.0)) {
                EMLRTPUSHRTSTACK(&jc_emlrtRSI);
                eml_warning();
                EMLRTPOPRTSTACK(&jc_emlrtRSI);
            } else {
                if (muDoubleScalarIsNaN(rc) || (rc < 2.2204460492503131E-16)) {
                    EMLRTPUSHRTSTACK(&kc_emlrtRSI);
                    EMLRTPUSHRTSTACK(&nc_emlrtRSI);
                    e_y = NULL;
                    m0 = mxCreateCharArray(2, iv1);
                    emlrtInitCharArray(8, m0, cv0);
                    emlrtAssign(&e_y, m0);
                    emlrt_marshallIn(c_sprintf(b_sprintf(e_y, emlrt_marshallOut(14.0), emlrt_marshallOut(6.0), &i_emlrtMCI), emlrt_marshallOut(rc), &j_emlrtMCI), "sprintf", str);
                    EMLRTPOPRTSTACK(&nc_emlrtRSI);
                    b_eml_warning(str);
                    EMLRTPOPRTSTACK(&kc_emlrtRSI);
                }
            }
            EMLRTPOPRTSTACK(&bc_emlrtRSI);
            EMLRTPOPRTSTACK(&yb_emlrtRSI);
            EMLRTPOPRTSTACK(&vb_emlrtRSI);
            EMLRTPUSHRTSTACK(&w_emlrtRSI);
            EMLRTPUSHRTSTACK(&x_emlrtRSI);
            EMLRTPUSHRTSTACK(&y_emlrtRSI);
            memset((void *)&qq[0], 0, 36U * sizeof(real_T));
            for (i = 0; i < 6; i++) {
                for (i0 = 0; i0 < 6; i0++) {
                    b_J[i0 + 6 * i] = J[i + 6 * i0];
                }
            }
            ceval_xgemm(6, 6, 6, 1.0, b_J, 1, 6, c, 1, 6, 0.0, qq, 1, 6);
            EMLRTPOPRTSTACK(&y_emlrtRSI);
            EMLRTPOPRTSTACK(&x_emlrtRSI);
            EMLRTPOPRTSTACK(&w_emlrtRSI);
            for (i = 0; i < 3; i++) {
                dq[i] = b_TT[12 + i];
                c_TT[i] = TT[12 + i];
            }
            dq[3] = muDoubleScalarAcos(b_y);
            dq[4] = theta;
            dq[5] = muDoubleScalarAsin(y);
            c_TT[3] = muDoubleScalarAcos(d_y);
            c_TT[4] = nm;
            c_TT[5] = muDoubleScalarAsin(c_y);
            for (i = 0; i < 6; i++) {
                d_TT[i] = -dq[i] + c_TT[i];
            }
            for (i = 0; i < 6; i++) {
                f_y[i] = 0.0;
                for (i0 = 0; i0 < 6; i0++) {
                    y = f_y[i] + qq[i + 6 * i0] * d_TT[i0];
                    f_y[i] = y;
                }
            }
            for (i = 0; i < 6; i++) {
                dq[i] = muDoubleScalarRem(f_y[i], 6.2831853071795862) / 10.0;
            }
            EMLRTPOPRTSTACK(&e_emlrtRSI);
        } else {
            for (i = 0; i < 6; i++) {
                dq[i] = qout[i];
            }
            count += 500;
            /* finish */
        }
        EMLRTPUSHRTSTACK(&f_emlrtRSI);
        for (i = 0; i < 6; i++) {
            y = qout[i] + dq[i];
            qout[i] = muDoubleScalarRem(y, 6.2831853071795862);
            f_y[i] = y;
        }
        EMLRTPOPRTSTACK(&f_emlrtRSI);
        /* +rand(6,1).*.0001; */
        for (i = 0; i < 6; i++) {
            nm = qout[i];
            if (qout[i] > 3.1415926535897931) {
                nm = qout[i] - 6.2831853071795862;
            }
            if (nm < -3.1415926535897931) {
                nm += 6.2831853071795862;
            }
            emlrtBreakCheck();
            qout[i] = nm;
        }
        /* a non-mathematical enforcement of solution constraints */
        if (qout[3] > 0.0) {
            /*                  %possibility1 */
            /*                 q(1)=-q(1); */
            /*                 q(3)=-q(3); */
            /*                 q(5)=-q(5); */
            EMLRTPUSHRTSTACK(&g_emlrtRSI);
            /* qold4=q(4); */
            /* qold2=q(2); */
            qout[1] += qout[3];
            qout[3] = -qout[3];
            for (i = 0; i < 2; i++) {
                qout[2 + (i << 1)] = -qout[2 + (i << 1)];
            }
            /* q(6)=-(q(6)-pi/2)+pi/2-pi; */
            EMLRTPOPRTSTACK(&g_emlrtRSI);
        }
        if (qout[2] > 1.5707963267948966) {
            qout[2] -= 1.5707963267948966;
            qout[3] = -qout[3];
        } else {
            if (qout[2] < -1.5707963267948966) {
                qout[2] += 1.5707963267948966;
                qout[3] = -qout[3];
            }
        }
        if (qout[4] > 1.5707963267948966) {
            qout[4] -= 1.5707963267948966;
            qout[5] = -qout[5];
        } else {
            if (qout[4] < -1.5707963267948966) {
                qout[4] += 1.5707963267948966;
                qout[5] = -qout[5];
            }
        }
        if (qout[5] > 4.71238898038469) {
            qout[5] -= 6.2831853071795862;
        }
        if (qout[5] < -4.71238898038469) {
            qout[5] += 6.2831853071795862;
        }
        /* avoid, the second ikine convergence */
        /*  */
        /*              %specific to M26 */
        /*              if q(3)<0 */
        /*                 q(3)=q(3)+pi; */
        /*                 q(4)=-q(4); */
        /*                 if q(5)<0 */
        /*                 q(5)=q(5)+pi; */
        /*                 else */
        /*                     q(5)=q(5)-pi; */
        /*                 end */
        /*                   */
        /*              end */
        EMLRTPUSHRTSTACK(&h_emlrtRSI);
        EMLRTPUSHRTSTACK(&pc_emlrtRSI);
        EMLRTPUSHRTSTACK(&qc_emlrtRSI);
        EMLRTPUSHRTSTACK(&rc_emlrtRSI);
        EMLRTPUSHRTSTACK(&tc_emlrtRSI);
        nm = ceval_xnrm2(6, dq, 1, 1);
        EMLRTPOPRTSTACK(&tc_emlrtRSI);
        EMLRTPOPRTSTACK(&rc_emlrtRSI);
        EMLRTPOPRTSTACK(&qc_emlrtRSI);
        EMLRTPOPRTSTACK(&pc_emlrtRSI);
        EMLRTPOPRTSTACK(&h_emlrtRSI);
        if (muDoubleScalarIsNaN(nm)) {
            nm = 5.0;
        }
        count++;
        emlrtBreakCheck();
        if (count > 250) {
            *isconverged = 0.0;
            exitg1 = 1U;
        }
    }
}
/* End of code generation (ikine_M26_cc.c) */
