dv=5;        
d=[dv dv]';
        Ts=1;
        
        offtime=1800;
        
        [x,y]=trajectory(Ts,offtime);
Pv=d*d';
N=ceil(offtime/Ts);
sigma=1;% 加速度方向的的扰动
randn('state',sum(100*clock)); % 设置随机数发生器


for i=1:N
   vx(i)=dv*randn(1); % 观测噪声，两者独立
   vy(i)=dv*randn(1);
   zx(i)=x(i)+vx(i); % 实际观测值
   zy(i)=y(i)+vy(i);
end

a=[zeros(1,400) 0.075*ones(1,200) zeros(1,10) -0.3*ones(1,50) zeros(1,offtime-660)]; 


Phi=[1,Ts 0 0;
     0,1 0 0;
     0 0 1 Ts;
     0 0 0 1];
Gamma=[Ts*Ts/2 0;
           Ts 0;
          0 Ts*Ts/2;
          0 Ts];
C=[1 0 0 0;
   0 0 1 0];
R=Pv*10000;
Q=sigma^2;W=[];

randn('state',sum(100*clock)); % 设置随机数发生器
for n=0:Ts:offtime-1
    W(:,n/Ts+1)=a(n+1)+sigma*randn(2,1);
end

XE=zeros(2,2);


 Xfli=[zx(2) (zx(2)-zx(1))/Ts zy(2) (zy(2)-zy(1))/Ts]'; %利用前两个观测值来对初始条件进行估计
  Xef=[-vx(2) Ts*W(1)/2+(vx(1)-vx(2))/Ts -vy(2) Ts*W(1)/2+(vy(1)-vy(2))/Ts]';
        Px=[Pv,Pv/Ts;Pv/Ts,2*Pv/Ts+Ts*Ts*Q/4];

        XE(1,1)=zx(1);XE(1,2)=zx(2);XE(2,1)=zy(1);XE(2,2)=zy(2);
        
        
          for k=3:N
        
        Xest=Phi*Xfli; % 更新该时刻的预测值
        Xes=Phi*Xef+Gamma*W(:,k-1); % 预测输出误差
        Pxe=Phi*Px*Phi'+Gamma*Q*Gamma'; % 预测误差的协方差阵
        K=Pxe*C'*inv(C*Pxe*C'+R); % Kalman滤波增益
    
        Xfli=Xest+K*([zx(k);zy(k)]-C*Xest); 
        Xef=(eye(4)-K*C)*Xes-K*[vx(k);vy(k)];
        Px=(eye(4)-K*C)*Pxe;
        
        XE(:,k)=Xfli([1 3]);
        end
      


%作图
figure
plot(x,y,'r');hold on;
plot(zx,zy,'g');hold on;
plot(XE(1,:),XE(2,:),'b');hold off;
axis([1500 5000 1000 10000]),grid on;
legend('true path','noisy path','kalman');