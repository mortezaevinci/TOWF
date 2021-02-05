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
   
   
tic
TT=fkine_M26([l1 l2 l3 l4 l5 l6],[th_1 th_2 th_3 th_4 th_5 th_6])
toc

cartesian=T2cartesian(TT);

jacob=[diff(cartesian,th_1) diff(cartesian,th_2) diff(cartesian,th_3) diff(cartesian,th_4) diff(cartesian,th_5) diff(cartesian,th_6)]

