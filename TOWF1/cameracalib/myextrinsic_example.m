%calibration should be already done
%refer to mycalib_example

path0=input('image path?','s');   %'capture.2011.03.22.1.bmp'
I=imread(path0);

myextrinsic_computation;