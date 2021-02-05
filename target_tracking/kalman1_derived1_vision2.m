clc

camnum=2;
nx=640; ny=480;

   vid(1) = videoinput('winvideo',1,['I420_' num2str(nx) 'x' num2str(ny)]);
    vid(2) = videoinput('winvideo',2,['I420_' num2str(nx) 'x' num2str(ny)]);
    
    for i=1:size(vid,2)
        vid_src(i)=getselectedsource(vid(i));
        set(vid_src(i),'FocusMode','manual');
        himage(i)=preview(vid(i));
        set(himage(i),'Visible','off');
        set(himage(i),'HitTest','off')
        
    end
pause(1);
    
    
dv=5;        
d=[dv dv]';
        Ts=1;
        
    w=30;
        
   %     [x,y]=trajectory(Ts,offtime);
Pv=d*d';
sigma=.2;% 加速度方向的的扰动


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
R=Pv*.1;
Q=sigma^2;W=[];

% randn('state',sum(100*clock)); % 设置随机数发生器
% for n=0:Ts:offtime-1
%     W(:,n/Ts+1)=a(n+1)+sigma*randn(2,1);
% end

XE=zeros(2,2);
Xfli=zeros(4,1);

cl=0;
figh = figure('name','press some keys') ;
set(figh,'windowkeypressfcn','set(gcbf,''Userdata'',get(gcbf,''CurrentCharacter''))') ;
set(figh,'windowkeyreleasefcn','set(gcbf,''Userdata'','''')') ;

hold on;

 Px=[Pv,Pv/Ts;Pv/Ts,2*Pv/Ts+Ts*Ts*Q/4];

k=0;

curkey='';
while (isempty(curkey))   
   % pause(.2);
   curkey = get(figh,'userdata');
      
    %get pos (zx, zy)
    
    imcap{camnum}.caprgb=get(himage(camnum),'CData');
    imcap{camnum}.caphsv=rgb2hsv(imcap{camnum}.caprgb);
  armanalysis{camnum}.pinky=(imcap{camnum}.caphsv(:,:,1)>0.95)&(imcap{camnum}.caphsv(:,:,2)>.3)&(imcap{camnum}.caphsv(:,:,3)<.8);

armanalysis{camnum}.pinky=medfilt2(armanalysis{camnum}.pinky,[5 5]);

    rstats=regionprops(armanalysis{camnum}.pinky,'centroid');
    pcentroid=cat(1,rstats.Centroid);
    if numel(pcentroid)>2
    pcentroid=mean(pcentroid);   %estimated center
  
    end
    
    if ~isnan(pcentroid)
    k=k+1;
     zx=pcentroid(1);
    zy=pcentroid(2);
 switch k
     
     
     case 1
         XE(1,1)=zx;XE(2,1)=zy;
         Xfli(2)=-zx/Ts;
         Xfli(4)=-zy/Ts;
     case 2
         
       Xfli=[zx zx/Ts zy zy/Ts]'+Xfli; %利用前两个观测值来对初始条件进行估计
      % Xef=[-vx(2) (vx(1)-vx(2))/Ts -vy(2) (vy(1)-vy(2))/Ts]';
       

        XE(1,2)=zx;XE(2,2)=zy;
     otherwise
        
        
        Xest=Phi*Xfli; % 更新该时刻的预测值
        %Xes=Phi*Xef;%+Gamma*W(:,k-1); % 预测输出误差
        Pxe=Phi*Px*Phi'+Gamma*Q*Gamma'; % 预测误差的协方差阵
        K=Pxe*C'*inv(C*Pxe*C'+R); % Kalman滤波增益
    
        Xfli=Xest+K*([zx;zy]-C*Xest); 
        %Xef=(eye(4)-K*C)*Xes-K*[vx(k);vy(k)];
        Px=(eye(4)-K*C)*Pxe;
        
%         if k>11
%             k0=k-10;
%             xemean=mean(XE(:,k0:k-1)');
%             if (Xfli(1)-xemean(1))^2+(Xfli(2)-xemean(2))^2>w^2
%                 XE(:,k)=xemean;
%             else
%                 XE(:,k)=Xfli([1 3]); 
%             end
%         else
%             XE(:,k)=Xfli([1 3]); 
%         end
        
       XE(:,k)=Xfli([1 3]); 
 end
 
 imshow(armanalysis{camnum}.pinky);
 hold on;
 plot(XE(1,k),XE(2,k),'ro',zx,zy,'r+');
 drawnow;
 
    end
 
% plot(x,y,'r');hold on;
% plot(zx,zy,'g');hold on;
% plot(XE(1,:),XE(2,:),'b');hold off;
% axis([1500 5000 1000 10000]),grid on;
% legend('true path','noisy path','kalman');


end


  for i=size(vid,2):-1:1
        stoppreview(vid(i));
        closepreview(vid(i));
        stop(vid(i));
        delete(vid(i));
  end
    
  
  
 