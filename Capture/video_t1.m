imaqreset;


% Create video input object. 
vid1 = videoinput('winvideo',1,'I420_640x480')
vid2 = videoinput('winvideo',2,'I420_640x480')

set(vid1,'framespertrigger',1);
set(vid2,'framespertrigger',1);
%vid1.framespertrigger=5;
%vid2.framespertrigger=5;
% Set video input object properties for this application.
% Note that example uses both SET method and dot notation method.
set(vid1,'TriggerRepeat',Inf);
vid1.FrameGrabInterval = 10;
set(vid2,'TriggerRepeat',Inf);
vid2.FrameGrabInterval = 10;
% Set value of a video source object property.
vid_src1 = getselectedsource(vid1);
%set(vid_src1,'Tag','motion detection setup');
vid_src2 = getselectedsource(vid2);
%set(vid_src2,'Tag','motion detection setup');
% Create a figure window.
figure(1); figure(2) 

% Start acquiring frames.
start(vid1)
start(vid2)
% Calculate difference image and display it.

lastframe1=vid1.FramesAcquired;
lastframe2=vid2.FramesAcquired;
while(vid1.FramesAcquired<=100) % Stop after 100 frames
    if lastframe1<vid1.FramesAcquired
    data1 = peekdata(vid1,1); 
      figure(1)
    imshow(ycbcr2rgb(data1));
    flushdata(vid1);
    lastframe1=vid1.FramesAcquired;
    end
    
     if lastframe2<vid2.FramesAcquired
    data2 = peekdata(vid2,1);
   figure(2)
    imshow(ycbcr2rgb(data2));
     flushdata(vid2);
     lastframe2=vid2.FramesAcquired;
    end 
    
  vid1.FramesAcquired
  pause
end

stop(vid1);
delete(vid1);

stop(vid2);
delete(vid2);