%  clear all;
%  close all;
randn('state',0)
steps=200;

T0=1;
x1=zeros(4,steps);
x1(:,1)=[0,10,0,10]';
for t=1:steps-1
    x1(1,t+1)=x1(1,t)+10;
    x1(2,t+1)=10;
    x1(3,t+1)=10*sin(t/10)+randn(1);
    x1(4,t+1)=10;
end
figure(1);
plot(x1(1,1:steps),x1(3,1:steps),'k*')
h=legend('目标匀速运动',1);
xlabel('目标轨迹的X轴位移（单位：m）');
ylabel('目标轨迹的Y轴位移（单位：m）');
title('目标运动的真实轨迹')
T=1;d=.1;
H=[1,0,0,0
    0,0,1,0];
F=[1,T,0,0
    0,1,0,0
    0,0,1,T
    0,0,0,1];
G=[0.5*T^2,0
    T,0
    0,0.5*T^2
    0,T];
vt1=randn(2,steps);
vt2=randn(2,steps);
vt3=randn(2,steps);
z1=H*x1+d*vt1;
z2=H*x1+1*vt2;
z3=H*x1+2*vt3;
figure(2);
plot(z1(1,1:steps),z1(2,1:steps),'k*',z2(1,1:steps),z2(2,1:steps),'ko',z3(1,1:steps),z3(2,1:steps),'k+');
title('量测')
h=legend('量测1','量测2','量测2',3);
xlabel('X轴位移（单位：m）');
ylabel('Y轴位移（单位：m）');

Xn=zeros(4,steps);
Xp=zeros(4,steps);
z4=zeros(2,steps);
z5=zeros(2,steps);
t=zeros(2,steps)
P=zeros(4,4,steps);
Pp=zeros(4,4,steps);
P(:,:,1)=[10,0,0,0
        0,1,0,0
        0,0,10,0
        0,0,0,1];
 Q=zeros(2,2,steps);
 R=zeros(2,2,steps);
 K=zeros(4,2,steps);
 I=eye(4);
 Xn(:,1)=x1(:,1);
   for k=1:(steps-1)
 			Q(:,:,k+1)=.1*eye(2);
            R(:,:,k+1)=5*eye(2);
            Xp(:,k+1)=F*x1(:,k);
            z4(:,k+1)=H*Xp(:,k+1);
           
               z5(:,k+1)=z4(:,k+1);
                   
            Pp(:,:,k+1)=F*P(:,:,k)*F'+G*Q(:,:,k+1)*G';
            K(:,:,k+1)=Pp(:,:,k+1)*H'*inv(H*Pp(:,:,k+1)*H'+R(:,:,k+1));
            Xn(:,k+1)=Xp(:,k+1)+K(:,:,k+1)*(z5(:,k+1)-H*Xp(:,k+1)); 
            P(:,:,k+1)=(I-K(:,:,k+1)*H)*Pp(:,:,k+1);
            
    end
    figure(3);
plot(x1(1,1:steps),x1(3,1:steps),z5(1,2:steps),z5(2,2:steps),'k*',Xn(1,1:steps),Xn(3,1:steps),'ko');
title('目标的测量及卡尔曼滤波')
h=legend('目标量测','目标量测的卡尔曼滤波',2);
xlabel('X轴位移（单位：m）');
ylabel('Y轴位移（单位：m）');
    zzkfx=abs(Xn(1,1:steps)-x1(1,1:steps));
    zzkfy=abs(Xn(3,1:(steps-1))-x1(3,1:(steps-1)));
    zzax=abs(z5(1,1:steps)-x1(1,1:steps));
    zzay=abs(z5(2,1:steps)-x1(3,1:steps));
figure(4);
 plot(zzkfy,'k');
h=legend('kf估计误差',1); 
title('y误差分布')
xlabel('时间（单位：s）');
ylabel('误差（单位：m）');
figure(5);
   plot(zzkfx,'k');
h=legend('kf估计误差',1); 
title('x误差分布')
xlabel('时间（单位：s）');
ylabel('误差（单位：m）');
figure(6);
   plot(zzax,'k');
h=legend('目标量测的误差',1); 
title('x误差分布')
xlabel('时间（单位：s）');
ylabel('误差（单位：m）');
figure(7);
   plot(zzay,'k');
h=legend('目标量测的误差',1); 
title('y误差分布')
xlabel('时间（单位：s）');
ylabel('误差（单位：m）');
   