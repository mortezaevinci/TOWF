/*
 * ikine_M26_cc_mexutil.h
 *
 * Code generation for function 'ikine_M26_cc_mexutil'
 *
 * C source code generated on: Tue Aug 23 13:45:39 2011
 *
 */

#ifndef __IKINE_M26_CC_MEXUTIL_H__
#define __IKINE_M26_CC_MEXUTIL_H__
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
extern const mxArray *emlrt_marshallOut(real_T u);
extern void error(const mxArray *b, emlrtMCInfo *location);
extern const mxArray *message(const mxArray *b, emlrtMCInfo *location);
#endif
/* End of code generation (ikine_M26_cc_mexutil.h) */
