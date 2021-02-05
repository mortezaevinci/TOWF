


if (exist('map')~=1), map = gray(256); end;

enoughpic=0;





enoughpic=[];
while(isempty(enoughpic))
    %take imagein stead
    trypic=[];
    
    while(isempty(trypic))
        I = get(himage(statecur{3}),'CData');
        figure(3);
        imshow(I);
        trypic=input('try this image? ([]=no');
    end
    
    calibparams.n_img=calibparams.n_img+1;
    calibparams.I{calibparams.n_img}=I;
    
    myclick_ima_calib;
    
    
    keeppic=input('keep pic? ([]=keep)');
    if ~isempty(keeppic)
        calibparams.n_img=calibparams.n_img-1;
    end
    
    enoughpic=input('enough pic? ([]=continue)');
    
end%while

mygo_calib_optim;

