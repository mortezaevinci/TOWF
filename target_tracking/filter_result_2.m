function [XER,YER]=filter_result(Ts,d)
% filter_result         �Թ۲����ݽ��п������˲����õ�Ԥ��ĺ����Լ��������ľ�ֵ�ͱ�׼��
% Ts                    ����ʱ�䣬���״�Ĺ�������
% mon                   ����Monte-Carlo����Ĵ���
% d                     ���������,��λm
%����ֵ�����˲�Ԥ���Ĺ��ƺ���,�Լ���ֵ�����Э����
switch nargin
    case 0
        d=5;
        Ts=1;
    case 1
        d=5;
end

offtime=800;

% �������۵ĺ���
[x,y]=trajectory(Ts,offtime);
Pv=d*d;
N=ceil(offtime/Ts);

randn('state',sum(100*clock)); % ���������������
for i=1:N
   vx(i)=d*randn(1); % �۲����������߶���
   vy(i)=d*randn(1);
   zx(i)=x(i)+vx(i); % ʵ�ʹ۲�ֵ
   zy(i)=y(i)+vy(i);
end

% �����۲�����
    % �ÿ������˲��õ����Ƶĺ���
    XE=Kalman_filter(Ts,offtime,d,0); 
    YE=Kalman_filter(Ts,offtime,d,1);
    %������



%��ͼ
figure
plot(x,y,'r');hold on;
plot(zx,zy,'g');hold on;
plot(XE,YE,'b');hold off;
axis([1500 5000 1000 10000]),grid on;
legend('��ʵ�켣','�۲�����','�˲�����');