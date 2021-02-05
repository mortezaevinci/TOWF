clc
clear robot;

robot.n=6;
robot.Tag='M26';
robot.name='M26';

for ii=1:robot.n
    
    robot.qlim(ii,:)=[-pi/2 pi/2];
end

robot.base=eye(4,4);
robot.tool=eye(4,4);

%drivebot_mine(robot,[.1 .2 0.5 1 -.5 .75])
   %drivebot(R)
   
   
for ii=1:6
eval(['l' num2str(ii) '=sym(''l' num2str(ii) ''',''real'');']);
eval(['th_' num2str(ii) '=sym(''th_' num2str(ii) ''',''real'');']);
end
   

L=[.16 .19 .12 .19 .14 .165];
q=[0 0 0 0 0 0]+[0 0 pi/2 0 pi/2 0]  %x=q-zero, z= pi/2 for either joint 72, 76, 7a ... y=-pi/2 for 74, and pi/2 for 76
   
   tic
T=fkine_M26(L,q)
toc


[phi,theta,psai]=Rc2euler(T(1:3,1:3));

J=jacob_M26(L,q)


basepos=[1 0 0 1;
         0 1 0 2;
         0 0 1 3;
         0 0 0 1];
     



endefpos= basepos*T


%from real th ... add [0 0 -pi/2 0 -pi/2 0] to john's


