
%%
% GOOD RESULTS IN casetestrefshow_try2_kenstepbystep2

%filter this out, and use that one.
%%


clc

L=[.16 .18 .12 .18 .15 .2];

qdef=[0 -pi/2 0 0 0 pi/2];

q=[0 0 0 0 0 0]+qdef;  %x=q-zero, z= pi/2 for either joint 72, 76, 7a ... y=-pi/2 for 74, and pi/2 for 76

                         
Tt_ext1=calibparamsarr{camnumber}.HTc{1};

Rc_ext=Tt_ext1(1:3,1:3);

                           
[phi,theta,psai]=Rc2euler(Rc_ext)

tic
Tt_arm=fkine_M26(L,q)
toc

 tic
 J=jacob_M26(L,q);
 toc



%T=T^-1

%since at position-zero, Xend-effector=Tt_arm*I;

lastind=numel(calibparams.HTc);
Tt_ext2=calibparamsarr{camnumber}.HTc{lastind};

R_extc=Tt_ext1(1:3,1:3);


[phi,theta,psai]=Rc2euler(Rc_ext)

% temp=Tt_ext1^-1*Tt_ext2;
% temp2=Tt_ext1^-1*Tt_ext2;
% Tc_temp=Tt_ext1(1:3,1:3)^-1*Tt_ext1(1:3,1:3)*temp2(1:3,4);
% Tt_end=Tt_arm(1:3,4)+Tc_temp;
% Rt_end=Tt_arm(1:3,1:3)^-1*temp(1:3,1:3)^-1;
% Xend=[[Rt_end^-1 Tt_end];[0 0 0 1]]


%Xend=[[Tt_arm(1:3,1:3) [0;0;0]];[0 0 0 1]]*Xend^-1

%q2_3=[0 0 0 -pi/15 0 0]+qdef;
 %q2_4=[0 0 -pi/3.8 -pi/14.2 0 0]+qdef;
 %q2_5=[0 -pi/10 0 0 0 0]+qdef;
 %q2_6=[0 0 -pi/2.2 pi/12 0 -pi/4]+qdef;
 %q2_7=[0 pi/10 0 -pi/10 -pi/3.4 -pi/5]+qdef;
 
 q2=[pi/50 0 0 0 0 0]+qdef;
 
 tic
 Tt_arm_sim=fkine_M26(L,q2)
 toc
 
 
%this was tested before, but based on new math stuff, might be worng 
%second thought!! it is most probably correct!
%check reference change, against point change of coordinates, by the Rc, Tc
%my best guess: for referencechcnage Xc=Tc*Xg, for point change in the same
%ref Xc*Tc=Xg
 
% alpharef=Tt_arm*Tt_ext1^-1;
% 
% temp= alpharef*Tt_ext2;

cammovepos=Tt_ext1^-1*Tt_ext2
cammoveref=Tt_ext2*Tt_ext1^-1


%%removed when the original cam external calculations are reverted
%     temp=temp([1 3 2 4],:);
%     temp(:,2)=-temp(:,2);
%     temp(:,3)=-temp(:,3);
%     temp=temp(:,[1 3 2 4]);

%


% %for the robot: Xend=Xbase*TT
% %for the camera: maybe xc=Tc*xg or xc=xg*Tc
% 
% %this is probably the correct one, but not tested
% alpharef=Tt_arm*Tt_ext1;
% 
% temp= alpharef*Tt_ext2^-1;
% % temp=temp(:,[1 3 2 4]);
% % 
% % temp(2,:)=-temp(2,:);
% % temp(3,:)=-temp(3,:);
% % temp=temp([1 3 2 4],:);


%%%fuuuck!

Xend_can1=Tt_arm*(Tt_ext2^-1*Tt_ext1)

% Xend_can3=cammovepos^-1*Tt_arm
% % Xend(:,4)=Tt_arm(:,4)+cammovepos(:,4);
% % Xend
% 
% Xend_can2=temp
% 
% Xend_can4=cammovepos*Tt_arm %this provides the new location
% 
% Xend_can5=temp;
% Xend_can5(:,4)=Tt_arm(:,4)-cammovepos(:,4)

Xend=Xend_can1



Xendinv=Xend^-1
 
 xx1=[0;0;0;1];
 xx2=[.5;.4;.3;1];
 
 [Xend*xx1 Xend*xx2]
 
 [ Tt_arm_sim*xx1  Tt_arm_sim*xx2]
 
 try
 estimateq=ikine_M26(Tt_arm,L)
 
 estimateq2=ikine_M26(Tt_arm_sim,L,q)
 
 estimateq_xend=ikine_M26(Xend,L,q);
 
 %standardize it
 estimateq_xend=myjointlimits(estimateq_xend)
 
 %not working good at all
 % estimateq_xend_random=ikine_M26_random(Xend,L,q)
 
 estimateXend=fkine_M26(L,estimateq_xend)
 
delT=T2cartesian_real(Xend)-T2cartesian_real(Tt_arm)
 end
 
 
delTest=J*(q2'-q')

det(J)

try
invJ=pinv(J);
estimatedq=invJ*delT
estimateddx=(J*estimatedq) %should be equal to delT... error is caused by pinv(J)
end

