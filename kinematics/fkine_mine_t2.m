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
   

L=[.16 .19 .12 .19 .14 .165]
   
   tic
T=fkine_mine3(L,[0 0 0 0 0 0])
toc


J=jacob_mine(L,[0 0 0 0 0 0])

