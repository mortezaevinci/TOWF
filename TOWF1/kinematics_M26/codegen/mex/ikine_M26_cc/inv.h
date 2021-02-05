/*
 * inv.h
 *
 * Code generation for function 'inv'
 *
 * C source code generated on: Tue Aug 23 13:45:40 2011
 *
 */

#ifndef __INV_H__
#define __INV_H__
/* Include files */
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"

#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "blascompat32.h"
#include "rtwtypes.h"
#include "ikine_M26_cc_types.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern int32_T ceval_ixamax(int32_T n, const real_T x[36], int32_T ix0, int32_T incx);
extern void ceval_xger(int32_T m, int32_T n, real_T alpha1, int32_T ix0, int32_T incx, int32_T iy0, int32_T incy, real_T A[36], int32_T ia0, int32_T lda);
extern void ceval_xswap(int32_T n, real_T x[36], int32_T ix0, int32_T incx, int32_T iy0, int32_T incy);
extern void invNxN(const real_T x[36], real_T y[36]);
#endif
/* End of code generation (inv.h) */
