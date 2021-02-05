clc

%AUTOMATE LATER ON
camnumber=2;
if exist('statecur')
armnumber=statecur{3};
else
    %default
    armnumber=2;
end




%the lengths of the different parts of the robot
L=[.16 .18 .12 .18 .15 .2];
%the initial joint position that gives the far-stretched arm pose

%calculating the kinematics and Jacobean
q=[0 0 0 0 0 0]';
q=qreal2qsim(q,armnumber);
Tt_arm=fkine_M26(L,q)   %this Tt_arm represents the end-effector at the "zero" far-stretched arm position, we will calculate other positions based on this
   
%%
%in this section, the chessboard is moved on the floor, and the effect on
%the extrinsic parameters can be observed.

%examples of Tc and Rc


%
%
%
%


% looping to find the change in position based on the chessboard
for ii=2:9
ii

Tt_ext1=calibparamsarr{camnumber}.HTc{1};
   

Tt_ext2=calibparamsarr{camnumber}.HTc{ii};

cammovepos=Tt_ext1^-1*Tt_ext2 %represents the relocation of the chessboard

end

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
 
  %this was tested before, but based on new math stuff, might be worng 
%second thought!! it is most probably correct!
%check reference change, against point change of coordinates, by the Rc, Tc
%my best guess: for referencechcnage Xc=Tc*Xg, for point change in the same
%ref Xc*Tc=Xg


% alpharef=Tt_arm*Tt_ext1^-1;
% 
% temp= alpharef*Tt_ext2;
% 
% cammovepos=Tt_ext1^-1*Tt_ext2
% cammoveref=Tt_ext2*Tt_ext1^-1
%  
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
 
%%
%in this section, the chessboard is moved by the arm. The effect on the
%camera extrinsic parameters remains the same as before. Now, we need to
%calculate the change in the position of the end effector.


 %corresponding approximate joint positions to the transformation by
 %cameras (refer to documented extrinsic parameters HTc's in data folder)
 %\\Q:\My files\Project TOWF\data\samples arm pos with camera extrinsic
 %parameters, may18.txt
  q2{1}=[0 0 0 0 0 0]'*pi/180;
 q2{2}=[-17 0 0 0 0 0]'*pi/180;
  q2{3}=[0 0 0 0 0 0]'*pi/180;
   q2{4}=[0 -21.6 0 0 0 0]'*pi/180;
    q2{5}=[0 0 0 0 0 0]'*pi/180;
     q2{6}=[0 0 38 0 0 0]'*pi/180;
      q2{7}=[0 0 0 -24 0 0]'*pi/180;
       q2{8}=[0 0 0 0 -38 0]'*pi/180;
        q2{9}=[0 0 0 0 0 -30]'*pi/180;
        
        
        %%%%%THE SIGN OF THE Q2 VALUES MIGHT BE WRONG!
 
 for ii=2:9
     ii
 
Tt_ext1=calibparamsarr{camnumber}.HTc{1};
   

Tt_ext2=calibparamsarr{camnumber}.HTc{ii};
     
     
q2{ii}=qreal2qsim(q2{ii},armnumber);


 Tt_arm_sim=fkine_M26(L,q2{ii})

 
%my best guess: for referencechcnage Xc=Tc*Xg, for point change in the same
%ref Xc*Tc=Xg

%these are a few candidates that might be correct. Since, none worked in
%all cases, I couldn't assume that my math was right anyways
 
%  alpharef=Tt_arm*Tt_ext1^-1;
%  
%  temp= alpharef*Tt_ext2;

cammovepos=Tt_ext1^-1*Tt_ext2
cammoveref=Tt_ext2*Tt_ext1^-1




Xend_can1=Tt_arm*(Tt_ext2^-1*Tt_ext1)

% Xend_can3=cammovepos^-1*Tt_arm
% 
% Xend_can2=temp
% 
% Xend_can4=cammovepos*Tt_arm 
% 
% Xend_can5=temp;
% Xend_can5(:,4)=Tt_arm(:,4)-cammovepos(:,4)

Xend=Xend_can1; %this should provide the new location of the end-effector



%Xendinv=Xend^-1
 
%  xx1=[0;0;0;1];
%  xx2=[.5;.4;.3;1];
%  
%  [Xend*xx1 Xend*xx2]
%  
%  [ Tt_arm_sim*xx1  Tt_arm_sim*xx2]
 

 % try
      'estimateq2'
 [estimateq2 isconverged]=ikine_M26(Tt_arm_sim,L,q)
   %end;try
       'estimateq2 by xend'
 [estimateq2_xend isconverged]=ikine_M26(Xend,L,q);
 
 %standardize it
 estimateq2_xend=myjointlimits(estimateq2_xend)
  % end
 %not working good at all
 % estimateq_xend_random=ikine_M26_random(Xend,L,q)
 try
 estimateXend=fkine_M26(L,estimateq2_xend)
 
delT=T2cartesian_real(Xend)-T2cartesian_real(Tt_arm)
      

 end
 try
 J=jacob_M26(L,q2{ii})
 
delTest=J*(q2{ii}'-q')

det(J)
 end

try
invJ=pinv(J);
estimatedq=invJ*delT
estimateddx=(J*estimatedq) %should be equal to delT... error is caused by pinv(J)
end

 
 end