function focusparams=setfocus(himage,vid_src,focusparams)

while(focusparams.focusval<focusparams.maxfocus) % Stop after 100 frames
    
    set(vid_src,'Focus',focusparams.focusval);
    
    pause(.02);
    data1 = get(himage,'CData');
    
    data1w=data1(size(data1,1)/2+(-focusparams.wsize(1):focusparams.wsize(1)),size(data1,2)/2+(-focusparams.wsize(2):focusparams.wsize(2)),1);
    focusparams.fmeas=[focusparams.fmeas [focusparams.focusval;focusmeasure(data1w,'TENV',[])]];
  
    focusparams.focusval=focusparams.focusval+focusparams.dfocusval;

end
  
   focusparams.fmeas(2,:)=filter(focusparams.filterparams.b,focusparams.filterparams.a,focusparams.fmeas(2,:));

   [temp ind]=max(focusparams.fmeas(2,:));
   focusparams.focusval=focusparams.fmeas(1,ind);
   
    set(vid_src,'Focus',focusparams.focusval);
    
    %should be bigger than mechanical delay for the camera to focus
    pause(.007*(focusparams.maxfocus-focusparams.focusval)); %if overal system became slow, remove this part.
    %data1 = get(himage1,'CData');
end