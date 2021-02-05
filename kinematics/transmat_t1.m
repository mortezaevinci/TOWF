for th1=0:.1:pi/2

th0=0;
%th1=0;
th2=0;pi/2;
th3=0;
th4=0;
th5=0;


% th0=sym('th0','real');th1=sym('th1','real');
% th2=sym('th2','real');th3=sym('th3','real');
% th4=sym('th4','real');th5=sym('th5','real');

l5=.5;
l4=.2;
l3=.4;
l2=.3;
l1=.6;
l0x=.1;
l0z=.1;

% l0z=sym('l0z','real');l0x=sym('l0x','real');l1=sym('l1','real');
% l2=sym('l2','real');l3=sym('l3','real');
% l4=sym('l4','real');l5=sym('l5','real');

t56=transmaty(th5,[0 0 -l5]);
t45=transmatz(th4,[0 0 -l4]);

t34=transmaty(th3,[ 0 0 -l3]);
t23=transmatz(th2,[0 0 -l2]);

t12=transmaty(th1,[ 0 0 -l1]);
t01=transmaty(0,[-l0x 0 -l0z]);

tfull=t01*t12*t23*t34*t45*t56

correct=tfull^-1

pend=[1;1;1;1];
p=[t56*pend t45*t56*pend t34*t45*t56*pend t23*t34*t45*t56*pend t12*t23*t34*t45*t56*pend t01*t12*t23*t34*t45*t56*pend];

x=p(1,:);
y=p(2,:);
z=p(3,:);

figure(1)

plot3(x,y,z,'-o','linewidth',3)
view ([5 -5 5])%([0 -5 0])%
axis([-l1-l2-l3 l1+l2+l3 -l1-l2-l3 l1+l2+l3 -l1-l2-l3 l1+l2+l3]*2)
hold on
plot3(x,y,z,'--','linewidth',1)
grid on
sgrid

hold off
pause
end