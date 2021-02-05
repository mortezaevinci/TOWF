   focusparams.wsize=[30 30];
   focusparams.dfocusval=double(3);
   focusparams.focusval=double(5);  %initial focusval
   focusparams.fmeas=[];
   focusparams.maxfocus=240;
   focusparams.immdiv=1;
   fs=11;
   focusparams.h1=ones(fs,fs)./fs./fs;
   focusparams.h1((fs-1)/2+1,(fs-1)/2+1)=-1;
   focusparams.h2=-ones(fs,fs)./fs./fs;
   focusparams.h2((fs-1)/2+1,(fs-1)/2+1)=1;   
   
         
   set(vid_src,'Focus',focusparams.focusval);
    
    pause(.04);
   
   nz=floor((focusparams.maxfocus-focusparams.focusval)/focusparams.dfocusval);
   DBFimm=zeros([ny/focusparams.immdiv,nx/focusparams.immdiv,nz]);
   focusparams.focusvalmap=focusparams.focusval:focusparams.dfocusval:focusparams.maxfocus;
   
   cnt=0;
   for ii= focusparams.focusvalmap
       ii
       cnt=cnt+1;
       dbm0=getfocusimm3(himage(statecur{3}),vid_src(statecur{3}),focusparams);
     DBFimm(:,:,cnt)=dbm0;
       
       
       
       
       focusparams.focusval=focusparams.focusval+focusparams.dfocusval;
   end
   
   
   [~,depthimm]=max(DBFimm(:,:,1:end),[],3);
  
     imshow(depthimm./max(max(depthimm)));
   
   'depth image. press any key to continue...'
   pause;
   
   
   
   %%
%    for uu=1:size(DBFimm,3)
%       dm=DBFimm(:,:,uu);
%       imshow(dm./max(max(dm)));
%       pause
%        
%    end