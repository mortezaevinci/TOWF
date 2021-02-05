

switch  statecur{2}
    case 'imagefromfile'
        calibparams=calibparamsarr{statecur{3}};
        calibparams.n_img=0;
        mycalib_fromfile;
        calibparamsarr{statecur{3}}=calibparams;
        
        if codeparams.stable==0; save('_calibration.mat','calibparamsarr');end
        
    case 'camera'
        calibparams=calibparamsarr{statecur{3}};
        calibparams.n_img=0;
        mycalib_fromcam;
        calibparamsarr{statecur{3}}=calibparams;
        if codeparams.stable==0; save('_calibration.mat','calibparamsarr');end
        
    case 'imagefromcalibparams'
        calibparams=calibparamsarr{statecur{3}};
        calibparams.n_img=0;
        mycalib_fromcalibparams;
        calibparamsarr{statecur{3}}=calibparams;
        if codeparams.stable==0; save('_calibration.mat','calibparamsarr');end
        
        
    case 'matfromfile'
        load '_calibration.mat';
        
        
   
        
    otherwise
        'Warning: unknown case in calibratecamera stream'
        
end