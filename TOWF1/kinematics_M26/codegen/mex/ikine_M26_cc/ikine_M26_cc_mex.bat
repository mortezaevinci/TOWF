@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2011a
set MATLAB_ARCH=win32
set MATLAB_BIN="C:\Program Files\MATLAB\R2011a\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=J:\My files\Project TOWF\MATLAB\TOWF1\kinematics_M26\codegen\mex\ikine_M26_cc\
set LIB_NAME=ikine_M26_cc_mex
set MEX_NAME=ikine_M26_cc_mex
set MEX_EXT=.mexw32
call mexopts.bat
echo # Make settings for ikine_M26_cc > ikine_M26_cc_mex.mki
echo COMPILER=%COMPILER%>> ikine_M26_cc_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> ikine_M26_cc_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> ikine_M26_cc_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> ikine_M26_cc_mex.mki
echo LINKER=%LINKER%>> ikine_M26_cc_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> ikine_M26_cc_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> ikine_M26_cc_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> ikine_M26_cc_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> ikine_M26_cc_mex.mki
echo BORLAND=%BORLAND%>> ikine_M26_cc_mex.mki
echo OMPFLAGS= >> ikine_M26_cc_mex.mki
echo EMC_COMPILER=msvc100>> ikine_M26_cc_mex.mki
echo EMC_CONFIG=optim>> ikine_M26_cc_mex.mki
"C:\Program Files\MATLAB\R2011a\bin\win32\gmake" -B -f ikine_M26_cc_mex.mk
