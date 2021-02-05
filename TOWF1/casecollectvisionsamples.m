
load '_visionsamples.mat'

if exist('visionsamples')
   ind=numel(visionsamples.focusparams);
   newind=ind+1;
else
   newind=1;
end
   visionsamples.towelanalysis{newind}.capgray=imcap{statecur{3}}.capgray;
   visionsamples.towelanalysis{newind}.caprgb=imcap{statecur{3}}.caprgb;
   visionsamples.towelanalysis{newind}.caphsv=imcap{statecur{3}}.caphsv;
   visionsamples.towelanalysis{newind}=towelanalysis{statecur{3}};
   visionsamples.focusparams{newind}=focusparams;
   visionsamples.camindex{newind}=statecur{3};
   
      
save('_visionsamples.mat','visionsamples')
   
