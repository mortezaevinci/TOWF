clear robot;

robot.n=6;
robot.Tag='M26';
robot.name='M26';

for ii=1:robot.n
    
    robot.qlim(ii,:)=[-pi/2 pi/2];
     eval(['th_' num2str(ii) '=sym(''th_' num2str(ii) ''',''real'');']);
     eval(['l' num2str(ii) '=sym(''l' num2str(ii) ''',''real'');']);
end



robot.base=eye(4,4);
robot.tool=eye(4,4);

%drivebot_mine(robot,[.1 .2 0.5 1 -.5 .75])
   %drivebot(R)
   
   
   
   
   
   tic
T=fkine_mine2([l1 l2 l3 l4 l5 l6],[th_1 th_2 th_3 th_4 th_5 th_6])
toc

% tic
% ikine_mine(robot,T)
% toc