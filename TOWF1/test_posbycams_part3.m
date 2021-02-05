

armnumber=1;

TTarm=extrinsicparamsarr{armnumber}.TTarm;
Tc1=extrinsicparamsarr{armnumber}.TTcamref{1};
Tc2=extrinsicparamsarr{armnumber}.TTcamref{2};
TTgrid=extrinsicparamsarr{armnumber}.chess2endeffector;

Xc1=[0.046;-0.1282;.8844;1]; % a position in cam1 reference
X1g=Tc1^-1*Xc1 %the cam1 position to grid reference

%Xend_can1=TTarm*(Tt_ext2^-1*Tc1)

X1e=TTgrid^-1*X1g

X1b=TTarm*X1e

