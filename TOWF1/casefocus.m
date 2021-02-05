switch statecur{2}
    case 'towel'
        focusparams.wsize=[30 30];
        focusparams.dfocusval=double(2);
        focusparams.focusval=double(50);  %initial focusval
        focusparams.fmeas=[];
        focusparams.maxfocus=120;
        focusparams.filterparams.a=1;
        focusparams.filterparams.b=[1/4 1/4 1/4 1/4];
        focusparams.manual=0;
    case 'manual'
        focusparams.manual=1;
        focusparams.focusval=input('Enter focus value (0-255): ');
    otherwise
        'warning: undefined case in focus stream'
        
end

if focusparams.manual==0
    %automatic focus
focusparams=setfocus(himage(statecur{3}),vid_src(statecur{3}),focusparams);
%focusparams now includes final focusval

else
    %manual focus
  set(vid_src(statecur{3}),'Focus',focusparams.focusval);
  
end

