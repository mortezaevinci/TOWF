/*
 * ikine_M26_cc.h
 *
 * Code generation for function 'ikine_M26_cc'
 *
 * C source code generated on: Tue Aug 23 13:45:40 2011
 *
 */

#ifndef __IKINE_M26_CC_H__
#define __IKINE_M26_CC_H__
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
extern void ikine_M26_cc(const real_T TT[16], const real_T L[6], const real_T q0[6], real_T qout[6], real_T *isconverged);
#endif
/* End of code generation (ikine_M26_cc.h) */
