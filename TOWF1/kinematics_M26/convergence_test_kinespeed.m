load '_armcalib.mat';
load '_curpos.mat';

asx=[.6;-.1;-.5;pi/2;pi/2;0];
TT=cartesian_real2T(asx);


tic
[estimateqpos isconverged]=ikine_M26(TT,armparamsarr{1}.L,curpos(:,1))
toc


tic
fkine_M26(armparamsarr{1}.L,[0,1,2,1,.5,.3]);
toc

TT1=fkine_M26(armparamsarr{1}.L,[0.125,-.95,-1.44,-1.82,1,.62])

T2cartesian_real(TT1)