load '_armcalib.mat';
load '_curpos.mat';

asx=[.5;-.2;.1;0;pi/3;-pi/1.5];%[.4;.5;.2;0;0;pi/2];
TT=cartesian_real2T(asx);


tic
[estimateqpos isconverged]=ikine_M26(TT,armparamsarr{1}.L,curpos(:,2))
toc

 t = [0:.05:2]; 	% generate a time vector
 fignumber=8;
 hh=figure(fignumber);
 hold on     

qt=jtraj(curpos(:,1)',estimateqpos',t); % compute the joint coordinate trajectory
drivebot_simplified(M2darr{1},qt,lengths,fignumber);