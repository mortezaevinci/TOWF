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
d=[dv dv .01 .01 .01]';
        Ts=1;
        Ts2=1;
        
    w=30;
        
   %     [x,y]=trajectory(Ts,offtime);
Pv=d*d';
sigma=.2;% 加速度方向的的扰动


Phi=[1 Ts 0 0 0 0 0 0 0 0;
     0 1 0 0 0 0 0 0 0 0;
     0 0 1 Ts 0 0 0 0 0 0;
     0 0 0 1 0 0 0 0 0 0;
     0 0 0 0 1 Ts2 0 0 0 0;
     0 0 0 0 0 1 0 0 0 0;
     0 0 0 0 0 0 1 Ts2 0 0;
     0 0 0 0 0 0 0 1 0 0;
     0 0 0 0 0 0 0 0 1 Ts2;
     0 0 0 0 0 0 0 0 0 1];
Gamma=[Ts*Ts/2 0 0 0 0;
           Ts 0 0 0 0;
          0 Ts*Ts/2 0 0 0;
          0 Ts 0 0 0
          0 0 Ts2*Ts2/2 0 0;
          0 0 Ts2 0 0;
          0 0 0 Ts2*Ts2/2 0
          0 0 0 Ts2 0;
          0 0 0 0 Ts2*Ts2/2;
          0 0 0 0 Ts2];
 C=[1 0 0 0 0 0 0 0 0 0;
   0 0 1 0 0 0 0 0 0 0;
   0 0 0 0 1 0 0 0 0 0;
   0 0 0 0 0 0 1 0 0 0;
   0 0 0 0 0 0 0 0 1 0];
R=Pv*.1;
Q=sigma^2;W=[];

% randn('state',sum(100*clock)); % 设置随机数发生器
% for n=0:Ts:offtime-1
%     W(:,n/Ts+1)=a(n+1)+sigma*randn(2,1);
% end

XE=zeros(5,2);
Xfli=zeros(10,1);

hs=[.97;.5;.7];

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
    hsr=hs+[-.03;-.3;+.2];

   
  armanalysis{camnum}.pinky=(imcap{camnum}.caphsv(:,:,1)>hsr(1))&(imcap{camnum}.caphsv(:,:,2)>hsr(2))&(imcap{camnum}.caphsv(:,:,3)<hsr(3));

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
         XE(3:5,1)=hs;
         Xfli(2)=-zx/Ts;
         Xfli(4)=-zy/Ts;
         Xfli(6)=hs(1);
         Xfli(8)=hs(2);
         Xfli(10)=hs(3);
     case 2
         
       Xfli=[zx zx/Ts zy zy/Ts hs(1) hs(1)/Ts hs(2) hs(2)/Ts hs(3) hs(3)/Ts]'+Xfli; %利用前两个观测值来对初始条件进行估计
      % Xef=[-vx(2) (vx(1)-vx(2))/Ts -vy(2) (vy(1)-vy(2))/Ts]';
       

        XE(1,2)=zx;XE(2,2)=zy;
        XE(3:5,2)=hs;
     otherwise
        
         pn=(sum(sum(double(armanalysis{camnum}.pinky))));
         for jjj=1:3
         hs(jjj)=sum(sum(double(armanalysis{camnum}.pinky.*imcap{camnum}.caphsv(:,:,jjj))))/pn;
         end
        hs;
       if hs(1)<.93; hs(1)=.93; end
       if hs(2)<.2; hs(2)=.2; end
       if hs(3)>.85; hs(3)=.85; end
       if hs(1)>1; hs(1)=1; end
       if hs(2)>.9; hs(2)=.9; end
       if hs(3)<.2; hs(3)=.2; end
         
        Xest=Phi*Xfli; % 更新该时刻的预测值
        %Xes=Phi*Xef;%+Gamma*W(:,k-1); % 预测输出误差
        Pxe=Phi*Px*Phi'+Gamma*Q*Gamma'; % 预测误差的协方差阵
        K=Pxe*C'*inv(C*Pxe*C'+R); % Kalman滤波增益
    
        Xfli=Xest+K*([zx;zy;hs]-C*Xest); 
        %Xef=(eye(4)-K*C)*Xes-K*[vx(k);vy(k)];
        Px=(eye(10)-K*C)*Pxe;
        
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
        
       XE(:,k)=Xfli([1 3 5 7 9]); 
       
 clc
 XE(:,k)
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
    
  
  
 