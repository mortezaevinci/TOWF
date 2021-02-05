dv=5;        
d=[dv dv]';
        Ts=1;
        
        offtime=1800;
        
        [x,y]=trajectory(Ts,offtime);
Pv=d*d';
N=ceil(offtime/Ts);
sigma=1;% ���ٶȷ���ĵ��Ŷ�
randn('state',sum(100*clock)); % ���������������


for i=1:N
   vx(i)=dv*randn(1); % �۲����������߶���
   vy(i)=dv*randn(1);
   zx(i)=x(i)+vx(i); % ʵ�ʹ۲�ֵ
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

randn('state',sum(100*clock)); % ���������������
for n=0:Ts:offtime-1
    W(:,n/Ts+1)=a(n+1)+sigma*randn(2,1);
end

XE=zeros(2,2);


 Xfli=[zx(2) (zx(2)-zx(1))/Ts zy(2) (zy(2)-zy(1))/Ts]'; %����ǰ�����۲�ֵ���Գ�ʼ�������й���
  Xef=[-vx(2) Ts*W(1)/2+(vx(1)-vx(2))/Ts -vy(2) Ts*W(1)/2+(vy(1)-vy(2))/Ts]';
        Px=[Pv,Pv/Ts;Pv/Ts,2*Pv/Ts+Ts*Ts*Q/4];

        XE(1,1)=zx(1);XE(1,2)=zx(2);XE(2,1)=zy(1);XE(2,2)=zy(2);
        
        
          for k=3:N
        
        Xest=Phi*Xfli; % ���¸�ʱ�̵�Ԥ��ֵ
        Xes=Phi*Xef+Gamma*W(:,k-1); % Ԥ��������
        Pxe=Phi*Px*Phi'+Gamma*Q*Gamma'; % Ԥ������Э������
        K=Pxe*C'*inv(C*Pxe*C'+R); % Kalman�˲�����
    
        Xfli=Xest+K*([zx(k);zy(k)]-C*Xest); 
        Xef=(eye(4)-K*C)*Xes-K*[vx(k);vy(k)];
        Px=(eye(4)-K*C)*Pxe;
        
        XE(:,k)=Xfli([1 3]);
        end
      


%��ͼ
figure
plot(x,y,'r');hold on;
plot(zx,zy,'g');hold on;
plot(XE(1,:),XE(2,:),'b');hold off;
axis([1500 5000 1000 10000]),grid on;
legend('true path','noisy path','kalman');