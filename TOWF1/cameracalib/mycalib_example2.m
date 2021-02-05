imaqreset;


if (exist('map')~=1), map = gray(256); end;

enoughpic=0;


vid(1) = videoinput('winvideo',1,'I420_640x480');

for i=1
    vid_src(i)=getselectedsource(vid(i));
    set(vid_src(i),'FocusMode','manual');
    himage(i)=preview(vid(i));
    set(himage(i),'Visible','off');
    set(himage(i),'HitTest','off')

end



enoughpic=[];
while(isempty(enoughpic))
%take imagein stead
trypic=[];

while(isempty(trypic))
        I = get(himage(1),'CData');
        figure(2);
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


for i=1
stoppreview(vid(i));
closepreview(vid(i));
stop(vid(i));
delete(vid(i));
end