load '_visionsamples.mat';


nn=numel(visionsamples.camindex);

v=fspecial('gaussian',[35 1],3) ;


thresh0=[.1 .1 .1 .03 .1 .03 .1 .02 .1];

area0=[21 81 568 469
12 103 612 461
13 177 490 464
11 237 563 475
10 234 391 469
3 114 284 469
74 247 368 468
40 247 350 468
147 243 438 470];

for ii=1:nn
    ii
    I=visionsamples.towelanalysis{ii}.capgray(area0(ii,2):area0(ii,4),area0(ii,1):area0(ii,3));
   Ic=cornermetric(I,'FilterCoefficients',v);
   
   imshow(I)
   pause
   
   
%   Ic=Ic.* double(visionsamples.towelanalysis{ii}.towelarea);
   
   maxic=max(max(Ic));
size(Ic)
Ic=Ic./maxic;
   meanic=mean(mean(Ic));
   
%    It=double(Ic<thresh0(ii)).*Ic ;
%    maxit=max(max(It));
%    It=It./maxit;
%    It=It;
%   
    imshow(I);
    pause;
   imshow(Ic*500);
 pause
   
   
   Ie=edge(I,'canny',.5,2);
   
   imshow(Ie)
   pause
end