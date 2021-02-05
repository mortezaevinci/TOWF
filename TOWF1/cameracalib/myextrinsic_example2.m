%calibration should be already done
%refer to mycalib_example

imaqreset;


vid(1) = videoinput('winvideo',1,'I420_640x480');

for i=1
    vid_src(i)=getselectedsource(vid(i));
    set(vid_src(i),'FocusMode','manual');
    himage(i)=preview(vid(i));
    set(himage(i),'Visible','off');
    set(himage(i),'HitTest','off')

end

trypic=[];

while(isempty(trypic))
        I = get(himage(1),'CData');
        figure(2);
        imshow(I);
        trypic=input('try this image? ([]=no');
end

myextrinsic_computation;


for i=1
stoppreview(vid(i));
closepreview(vid(i));
stop(vid(i));
delete(vid(i));
end