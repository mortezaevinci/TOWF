clc

L=[0.160000000000000,0.180000000000000,0.150000000000000,0.180000000000000,0.120000000000000,0.200000000000000];
    q=[pi/3;pi/4;pi/5;pi/3;0;0]'
TT=fkine_M26(L,q)

cart=T2cartesian_real(TT)'    %this is [x;y;z;phi;theta;psai]

q0=[0;0;0;0;0;0];

[qestimated,isconverged]=ikine_M26(TT,L,q0)  %note that the answer is not unique

TTe=fkine_M26(L,qestimated);
carte=T2cartesian_real(TTe)' %this is converged correctly...




%it is possible to start from a "cart" directly instead of "q"


%in ikine_M@6, you can see, method=0, 1... in method1, you can see lambda,
%and zarib... usually the convergence is sensitive to these...
%find a solution! for example, if you find a better method, or an adaptive
%way of changing the parameters to improve ocnvergence...
%prove ocnvergence is improved!!