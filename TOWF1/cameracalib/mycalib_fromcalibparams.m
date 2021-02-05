


if (exist('map')~=1), map = gray(256); end;


for ii=1:numel(calibparams.I)


I = calibparams.I{ii};
     
calibparams.n_img=calibparams.n_img+1;
calibparams.I{calibparams.n_img}=I;


myclick_ima_calib;
if rotator==4
    'Warning: bad calibration results, code needs improvements here.'
    
end

end%while

mygo_calib_optim;

