imaqreset;


% Create video input object. 
vid1 = videoinput('winvideo',1,'I420_640x480')

%vid1.Logging='on';
vid_src1 = getselectedsource(vid1);
set(vid_src1,'FocusMode','manual');

himage1=preview(vid1);
set(himage1,'Visible','off');
set(himage1,'HitTest','off')

%figure(1)
wsize=[30 30];
dfocusval=double(2);
focusval=double(50);
fmeas=[];
maxfocus=120;
while(focusval<maxfocus) % Stop after 100 frames
    
    set(vid_src1,'Focus',focusval);
    
     pause(.001);
    data1 = get(himage1,'CData');
    
    data1w=data1(size(data1,1)/2+(-wsize(1):wsize(1)),size(data1,2)/2+(-wsize(2):wsize(2)),1);
    fmeas=[fmeas [focusval;fmeasure(data1w,'TENV',[])]];
  
 focusval=focusval+dfocusval;
  %figure(2)
  %  imshow(data1);

end
   a=1; b=[1/4 1/4 1/4 1/4]; %moving average filter
   fmeas(2,:)=filter(b,a,fmeas(2,:));

   [temp ind]=max(fmeas(2,:));
   focusval=fmeas(1,ind);
   
    set(vid_src1,'Focus',focusval);
    
    pause(.007*(maxfocus-focusval));
    data1 = get(himage1,'CData');
     
    figure(2)
    imshow(data1);

    focusval
    
    figure(3)
    plot(fmeas(1,:),fmeas(2,:));
    
stoppreview(vid1);
closepreview(vid1);
stop(vid1);
delete(vid1);