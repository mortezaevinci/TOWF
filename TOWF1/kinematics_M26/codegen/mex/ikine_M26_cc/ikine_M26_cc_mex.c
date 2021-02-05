/*
 * ikine_M26_cc_mex.c
 *
 * Code generation for function 'ikine_M26_cc'
 *
 * C source code generated on: Tue Aug 23 13:45:40 2011
 *
 */

/* Include files */
#include "mex.h"
#include "ikine_M26_cc_api.h"
#include "ikine_M26_cc_initialize.h"
#include "ikine_M26_cc_terminate.h"

/* Type Definitions */

/* Function Declarations */
static void ikine_M26_cc_mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]);

/* Variable Definitions */
emlrtContext emlrtContextGlobal = { true, false, EMLRT_VERSION_INFO, NULL, "ikine_M26_cc", NULL, false, NULL };

/* Function Definitions */
static void ikine_M26_cc_mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  /* Temporary copy for mex outputs. */
  mxArray *outputs[2];
  int n = 0;
  int nOutputs = (nlhs < 1 ? 1 : nlhs);
  /* Check for proper number of arguments. */
  if(nrhs != 3) {
    mexErrMsgIdAndTxt("emlcoder:emlmex:WrongNumberOfInputs","3 inputs required for entry-point 'ikine_M26_cc'.");
  } else if(nlhs > 2) {
    mexErrMsgIdAndTxt("emlcoder:emlmex:TooManyOutputArguments","Too many output arguments for entry-point 'ikine_M26_cc'.");
  }
  /* Module initialization. */
  ikine_M26_cc_initialize(&emlrtContextGlobal);
  /* Call the function. */
  ikine_M26_cc_api(prhs,(const mxArray**)outputs);
  /* Copy over outputs to the caller. */
  for (n = 0; n < nOutputs; ++n) {
    plhs[n] = emlrtReturnArrayR2009a(outputs[n]);
  }
  /* Module finalization. */
  ikine_M26_cc_terminate();
}
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  /* Initialize the memory manager. */
  mexAtExit(ikine_M26_cc_atexit);
  emlrtClearAllocCount(&emlrtContextGlobal, 0, 0, NULL);
  /* Dispatch the entry-point. */
  ikine_M26_cc_mexFunction(nlhs, plhs, nrhs, prhs);
}
/* End of code generation (ikine_M26_cc_mex.c) */
