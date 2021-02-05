


if (exist('map')~=1), map = gray(256); end;

enoughpic=0;

while(enoughpic==0)
%take imagein stead
path0=input('image path?','s');   %'capture.2011.03.22.1.bmp'
I=imread(path0);
calibparams.n_img=calibparams.n_img+1;
calibparams.I{calibparams.n_img}=I;

myclick_ima_calib;


keeppic=input('keep pic? (0=keep');
if 0~=keeppic
    calibparams.n_img=calibparams.n_img-1;
end

enoughpic=input('enough pic? (0=continue)');

end%while

mygo_calib_optim;

