%  states0=[.1 .1 0 .4 0 .6]';


th0=states0(1);
th1=states0(2);
th2=states0(3);
th3=states0(4);
th4=states0(5);
th5=states0(6);
%inertia
%Ie=diag([I4 I1 I2 I3]);
%Me=diag([m4 m1 m2 m3]);

l0=.5;l1=1;l2=2;l3=1;

%positions
p1=[0;0;l0];
p2=[l1*cos(th1);0;l1*sin(th1)];
p3=p2+l2*[cos(th3)*sin(th1)*cos(th2)+sin(th3)*cos(th1); cos(th3)*sin(th2); -cos(th3)*sin(th1)*cos(th2)+sin(th3)*sin(th1)];
p4=p3+l3*[cos(th5)*sin(th1+th3)*cos(th2+th4)+sin(th3)*cos(th1+th3); cos(th5)*sin(th2+th4);-cos(th5)*sin(th1+th3)*cos(th2+th4)+sin(th5)*sin(th1+th3)];


Pe=[[cos(th0) -sin(th0) 0];
    [sin(th0) cos(th0) 0];
    [0 0 1]]*[p1';p2';p3';p4'].';

%velocities
%temp=diff(Pe,t);
%Ve=(temp(:,1).^2+temp(:,2).^2+temp(:,3).^2).^0.5

%Ve=subs2t((subs2c(Ve)));

%omege=[sqrt(diff(th1,t)^2+diff(th4,t)^2) sqrt((diff(th1,t)+diff(th2,t))^2+diff(th4,t)^2) sqrt((diff(th1,t)+diff(th2,t)+diff(th3,t))^2+diff(th4,t)^2) diff(th4,t)].'

%forward kinematics


x=Pe(:,1);
y=Pe(:,2);
z=Pe(:,3);

hold on
plot3(x,y,z,'-o','linewidth',3)
hold on
plot3(x,y,zeros(size(z)),'--','linewidth',1)
grid on
sgrid
axis([-l1-l2-l3 l1+l2+l3 -l1-l2-l3 l1+l2+l3 -l1-l2-l3 l1+l2+l3])
%axis equal
view ([5 -5 5])%([0 -5 0])%
%hold off