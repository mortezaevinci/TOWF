function [XER,YER]=filter_result(Ts,d)
% filter_result         对观测数据进行卡尔曼滤波，得到预测的航迹以及估计误差的均值和标准差
% Ts                    采样时间，即雷达的工作周期
% mon                   进行Monte-Carlo仿真的次数
% d                     测量的误差,单位m
%返回值包括滤波预测后的估计航迹,以及均值和误差协方差
switch nargin
    case 0
        d=5;
        Ts=1;
    case 1
        d=5;
end

offtime=800;

% 产生理论的航迹
[x,y]=trajectory(Ts,offtime);
Pv=d*d;
N=ceil(offtime/Ts);

randn('state',sum(100*clock)); % 设置随机数发生器
for i=1:N
   vx(i)=d*randn(1); % 观测噪声，两者独立
   vy(i)=d*randn(1);
   zx(i)=x(i)+vx(i); % 实际观测值
   zy(i)=y(i)+vy(i);
end

% 产生观测数据
    % 用卡尔曼滤波得到估计的航迹
    XE=Kalman_filter(Ts,offtime,d,0); 
    YE=Kalman_filter(Ts,offtime,d,1);
    %误差矩阵



%作图
figure
plot(x,y,'r');hold on;
plot(zx,zy,'g');hold on;
plot(XE,YE,'b');hold off;
axis([1500 5000 1000 10000]),grid on;
legend('真实轨迹','观测数据','滤波估计');