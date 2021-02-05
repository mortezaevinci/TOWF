clc



Tc1=calibparamsarr{1}.HTc{7}
Tc2=calibparamsarr{2}.HTc{17}

%represents position of camera 2 with respect to camera 1
Tc21=(Tc1*Tc2^-1)^-1
%represents position of camera 1 with respect to camera 2
Tc12=(Tc1*Tc2^-1)

%a point in camera x
pp=[0;0;1]


tt1=[[eye(3,3) pp];[0 0 0 1]]*Tc21

      Rc=[
    [tt1(1:3,1:3) [0;0;0]];
    
   0 0 0 1
   ];

d21=(Rc^-1*tt1)   %the relative distance from camera 2 in the reference of camera 1

tt21=[[Tc21(1:3,1:3) d21(1:3,4)];[0 0 0 1]]
   Rc=[
    [tt21(1:3,1:3) [0;0;0]];
    
   0 0 0 1
   ];

(Rc^-1*tt21) 
(Rc^-1*tt21) ^-1


%a point in camera x
pp=[0;0;1]

tt1=[[eye(3,3) pp];[0 0 0 1]]*Tc12

      Rc=[
    [tt1(1:3,1:3) [0;0;0]];
    
   0 0 0 1
   ];

d12=(Rc^-1*tt1)   %the relative distance from camera 2 in the reference of camera 1


