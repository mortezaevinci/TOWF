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
wsize=[50 50];
dfocusval=double(5);
focusval=uint8(100);
thresmeas=10000;
fmeas=[];
while(dfocusval~=0) % Stop after 100 frames
    
    set(vid_src1,'Focus',focusval);
    data1 = get(himage1,'CData');
    
    data1w=data1(size(data1,1)/2+(-wsize(1):wsize(1)),size(data1,2)/2+(-wsize(2):wsize(2)),1);
    fmeas=[fmeas fmeasure(data1w,'TENV',[])];
    
    if numel(fmeas)<2
        focusval=focusval+dfocusval;
    elseif numel(fmeas)==2
        if fmeas(1)>=fmeas(2)+thresmeas %it was better before
           focusval=focusval-dfocusval;
           dfocusval=-dfocusval;
        elseif fmeas(1)<fmeas(2)-thresmeas
            focusval=focusval+dfocusval;
        end
        
    else
        fmeas=fmeas(end:end);
    end
    
    %check limits
    if focusval<0
        focusval=0;
        dfocusval=-dfocusval;
    end
    if focusval>255
        focusval=255;
        dfocusval=-dfocusval;
    end
  
   if fmeas(end)>8e9
       dfocusval=0;
      % 'dfh'
   elseif fmeas(end)<5e8
       if dfocusval==0
       dfocusval=5;
       fmeas=[];
       end
   else
       
   end
   fmeas(end)
    %dfocusval
   %dfocusval=dfocusval-3+rand(1)*3
   
    figure(2)
    imshow(data1);
   

end

closepreview(vid1);
stop(vid1);
delete(vid1);