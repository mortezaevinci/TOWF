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
   
   
   tic
T=fkine_mine2([.2 .5 .5 .4 .4 .3],[0 0 0 0 0 0])
toc

% tic
% ikine_mine(robot,T)
% toc