clc

load '_armcalib.mat';
load '_curpos.mat';

%curpos=zeros(6,2);

asx= [.4;-.4;.2;pi/2;0;0];

TT=cartesian_real2T(asx);
tic
[estimateqpos isconverged]=ikine_M26(TT,armparamsarr{1}.L,curpos(:,1))
toc


tt0=fkine_M26(armparamsarr{1}.L,estimateqpos);

T2cartesian_real(tt0)

