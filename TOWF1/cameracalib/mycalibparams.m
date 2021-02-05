calibparams.dX=30;   %millimeters
calibparams.dY=30;   %millimeters

calibparams.n_sq_x=8; %number of inner corners in x
calibparams.n_sq_y=5; %no of inner corners in y

%if exist('dX'),
    dX_default = calibparams.dX;
%end;

%if exist('dY'),
    dY_default = calibparams.dY;
%end;

%if exist('n_sq_x'),
    n_sq_x_default = calibparams.n_sq_x;
%end;

%if exist('n_sq_y'),
    n_sq_y_default = calibparams.n_sq_y;
%end;

calibparams.nx=nx; %get this from another variable, and alos use it for camera properties
calibparams.ny=ny;%get this from another variable, and alos use it for camera properties

 calibparams.wintx_default = max(round(calibparams.nx/128),round(calibparams.ny/96));
    calibparams.winty_default = calibparams.wintx_default;
    
    calibparams.wintx=calibparams.wintx_default;
    calibparams.winty=calibparams.winty_default;
    calibparams.wintxkk=calibparams.wintx_default;
    calibparams.wintykk=calibparams.winty_default;
    
    calibparams.manual_squares = 0;
    
    calibparams.figurenumber=5;
    calibparams.n_img=0;
    calibparams.check_cond=0;  %if nonzero, then ill-conditioned cases are filtered out (but, the filtering-out process is erased!!) (refer to activeimages in original code)