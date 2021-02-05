/*
 * ikine_M26_cc_api.c
 *
 * Code generation for function 'ikine_M26_cc_api'
 *
 * C source code generated on: Tue Aug 23 13:45:40 2011
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "ikine_M26_cc.h"
#include "ikine_M26_cc_api.h"
#include "ikine_M26_cc_mexutil.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
static const mxArray *b_emlrt_marshallOut(const real_T u[6]);
static void c_emlrt_marshallIn(const mxArray *TT, const char_T *identifier, real_T y[16]);
static void d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier *parentId, real_T y[16]);
static void e_emlrt_marshallIn(const mxArray *L, const char_T *identifier, real_T y[6]);
static void f_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier *parentId, real_T y[6]);
static void g_emlrt_marshallIn(const mxArray *q0, const char_T *identifier, real_T y[6]);
static void h_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier *parentId, real_T y[6]);
static void j_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *msgId, real_T ret[16]);
static void k_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *msgId, real_T ret[6]);
static void l_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *msgId, real_T ret[6]);

/* Function Definitions */

static const mxArray *b_emlrt_marshallOut(const real_T u[6])
{
    const mxArray *y;
    static const int32_T iv8[1] = { 6 };
    const mxArray *m7;
    real_T (*pData)[];
    int32_T i;
    y = NULL;
    m7 = mxCreateNumericArray(1, (int32_T *)&iv8, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T (*)[])mxGetPr(m7);
    for (i = 0; i < 6; i++) {
        (*pData)[i] = u[i];
    }
    emlrtAssign(&y, m7);
    return y;
}

static void c_emlrt_marshallIn(const mxArray *TT, const char_T *identifier, real_T y[16])
{
    emlrtMsgIdentifier thisId;
    thisId.fIdentifier = identifier;
    thisId.fParent = NULL;
    d_emlrt_marshallIn(emlrtAlias(TT), &thisId, y);
    emlrtDestroyArray(&TT);
}

static void d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier *parentId, real_T y[16])
{
    j_emlrt_marshallIn(emlrtAlias(u), parentId, y);
    emlrtDestroyArray(&u);
}

static void e_emlrt_marshallIn(const mxArray *L, const char_T *identifier, real_T y[6])
{
    emlrtMsgIdentifier thisId;
    thisId.fIdentifier = identifier;
    thisId.fParent = NULL;
    f_emlrt_marshallIn(emlrtAlias(L), &thisId, y);
    emlrtDestroyArray(&L);
}

static void f_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier *parentId, real_T y[6])
{
    k_emlrt_marshallIn(emlrtAlias(u), parentId, y);
    emlrtDestroyArray(&u);
}

static void g_emlrt_marshallIn(const mxArray *q0, const char_T *identifier, real_T y[6])
{
    emlrtMsgIdentifier thisId;
    thisId.fIdentifier = identifier;
    thisId.fParent = NULL;
    h_emlrt_marshallIn(emlrtAlias(q0), &thisId, y);
    emlrtDestroyArray(&q0);
}

static void h_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier *parentId, real_T y[6])
{
    l_emlrt_marshallIn(emlrtAlias(u), parentId, y);
    emlrtDestroyArray(&u);
}

static void j_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *msgId, real_T ret[16])
{
    int32_T i;
    int32_T iv10[2];
    int32_T i2;
    for (i = 0; i < 2; i++) {
        iv10[i] = 4;
    }
    emlrtCheckBuiltInR2011a(msgId, src, "double", FALSE, 2U, iv10);
    for (i = 0; i < 4; i++) {
        for (i2 = 0; i2 < 4; i2++) {
            ret[i2 + (i << 2)] = (*(real_T (*)[16])mxGetData(src))[i2 + (i << 2)];
        }
    }
    emlrtDestroyArray(&src);
}

static void k_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *msgId, real_T ret[6])
{
    int32_T i3;
    int32_T iv11[2];
    for (i3 = 0; i3 < 2; i3++) {
        iv11[i3] = 1 + 5 * i3;
    }
    emlrtCheckBuiltInR2011a(msgId, src, "double", FALSE, 2U, iv11);
    for (i3 = 0; i3 < 6; i3++) {
        ret[i3] = (*(real_T (*)[6])mxGetData(src))[i3];
    }
    emlrtDestroyArray(&src);
}

static void l_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *msgId, real_T ret[6])
{
    int32_T iv12[1];
    int32_T i4;
    iv12[0] = 6;
    emlrtCheckBuiltInR2011a(msgId, src, "double", FALSE, 1U, iv12);
    for (i4 = 0; i4 < 6; i4++) {
        ret[i4] = (*(real_T (*)[6])mxGetData(src))[i4];
    }
    emlrtDestroyArray(&src);
}

void ikine_M26_cc_api(const mxArray * const prhs[3], const mxArray *plhs[2])
{
    real_T TT[16];
    real_T L[6];
    real_T q0[6];
    int32_T i;
    real_T b_q0[6];
    real_T isconverged;
    /* Marshall function inputs */
    c_emlrt_marshallIn(emlrtAliasP(prhs[0]), "TT", TT);
    e_emlrt_marshallIn(emlrtAliasP(prhs[1]), "L", L);
    g_emlrt_marshallIn(emlrtAliasP(prhs[2]), "q0", q0);
    /* Invoke the target function */
    for (i = 0; i < 6; i++) {
        b_q0[i] = q0[i];
    }
    ikine_M26_cc(TT, L, b_q0, q0, &isconverged);
    /* Marshall function outputs */
    plhs[0] = b_emlrt_marshallOut(q0);
    plhs[1] = emlrt_marshallOut(isconverged);
}
/* End of code generation (ikine_M26_cc_api.c) */
