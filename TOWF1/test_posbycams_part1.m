clc

armnumber=1;

TTarm=extrinsicparamsarr{armnumber}.TTarm;
Tc1=extrinsicparamsarr{armnumber}.TTcamref{1};
Tc2=extrinsicparamsarr{armnumber}.TTcamref{2};


Xc1=[0;0;1;1]; % a position in cam1 reference
X1g=Tc1^-1*Xc1 %the cam1 position to grid reference
Xc12=Tc2*Tc1^-1*Xc1 % a position of cam1 reference converted to cam2 reference


Xc2=[0;0;0;1];

Xc21=Tc1*Tc2^-1*Xc2


Xend_can1=TTarm*(Tt_ext2^-1*Tc1)


