clc



Tc1=calibparamsarr{1}.HTc{7}
Tc2=calibparamsarr{2}.HTc{17}

Xc1=[0;0;1;1]; % a position in cam1 reference
X1g=Tc1^-1*Xc1 %the cam1 position to grid reference
Xc12=Tc2*Tc1^-1*Xc1 % a position of cam1 reference converted to cam2 reference


Xc2=[0;0;0;1];

Xc21=Tc1*Tc2^-1*Xc2