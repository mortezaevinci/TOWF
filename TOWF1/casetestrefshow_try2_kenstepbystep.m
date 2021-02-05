clc

%the lengths of the different parts of the robot
L=[.16 .18 .12 .18 .15 .2];
%the initial joint position that gives the far-stretched arm pose
qdef=[0 -pi/2 0 0 0 pi/2];

%calculating the kinematics and Jacobean
q=[0 0 0 0 0 0]+qdef;
Tt_arm=fkine_M26(L,q)   %this Tt_arm represents the end-effector at the "zero" far-stretched arm position, we will calculate other positions based on this
   
%%
%in this section, the chessboard is moved on the floor, and the effect on
%the extrinsic parameters can be observed.

%examples of Tc and Rc


%
%
%
%
%in correlation with the images on may17

%Tc1 let's say the very origin
Tc{1} = [ -0.109933 	 0.064082 	 0.837166 ];
%Rotation vector:   omc_ext = [ 3.010120 	 -0.154941 	 0.048194 ]
Rc{1} = [ 0.994229 	 -0.104261 	 0.025285
                               -0.100208 	 -0.986671 	 -0.128213
                               0.038315 	 0.124939 	 -0.991424 ];



%Tc2
%moved in X-direction for about -2 blocks (about -6cm)
Tc{2} = [ -0.172355 	 0.065348 	 0.835699 ];
%Rotation vector:   omc_ext = [ 3.009190 	 -0.131827 	 0.039329 ]
Rc{2} = [ 0.995846 	 -0.088752 	 0.020335
                               -0.085386 	 -0.987843 	 -0.129903
                               0.031617 	 0.127627 	 -0.991318 ];
%Pixel error:           err = [ 0.13665 	 0.16835 ]


%Tc3
%moved in Y-direction for about 2 blocks (about 6cm)

Tc{3} = [ -0.178364 	 -0.004692 	 0.843892 ];
%Rotation vector:   omc_ext = [ 3.006560 	 -0.150918 	 0.048665 ]
Rc{3} = [ 0.994476 	 -0.101795 	 0.025604
                               -0.097577 	 -0.986447 	 -0.131914
                               0.038685 	 0.128686 	 -0.990930 ];
%Pixel error:           err = [ 0.13722 	 0.14513 ]


%Tc4
%moved in Z-direction for about 12cm

Tc{4} = [ -0.177940 	 -0.023661 	 0.724354 ];
%Rotation vector:   omc_ext = [ 3.023951 	 -0.153324 	 0.033470 ]
Rc{4} = [ 0.994645 	 -0.102061 	 0.016267
                               -0.099555 	 -0.988446 	 -0.114292
                               0.027744 	 0.112060 	 -0.993314 ];
%Pixel error:           err = [ 0.16232 	 0.14232 ]



%Tc5
%rotated around X-axis toward the camera

Tc{5} = [ -0.175588 	 -0.021745 	 0.726340 ];
%Rotation vector:   omc_ext = [ -2.900899 	 0.152438 	 -0.046066 ]
Rc{5} = [ 0.994075 	 -0.099612 	 0.043509
                               -0.107037 	 -0.966775 	 0.232139
                               0.018939 	 -0.235421 	 -0.971709 ];
%Pixel error:           err = [ 0.14739 	 0.18994 ]



%Tc6
%rotated back to Tc4, and then rotated around Z-axis clockwise for about 45 degrees


Tc{6} = [ -0.190788 	 -0.044391 	 0.726339 ];
%Rotation vector:   omc_ext = [ 2.923145 	 0.863391 	 -0.020069 ]
Rc{6} = [ 0.839792 	 0.542731 	 0.013856
                               0.541501 	 -0.835507 	 -0.093298
                               -0.039059 	 0.085854 	 -0.995542 ];
%Pixel error:           err = [ 0.11536 	 0.10027 ]



%Tc7
%rotated back to Tc4, and then rotated around Z-axis clockwise for about 90 degrees


Tc{7} = [ -0.189365 	 -0.038473 	 0.723811 ];
%Rotation vector:   omc_ext = [ 2.212605 	 2.129305 	 -0.110908 ]
Rc{7} = [ 0.038143 	 0.999263 	 -0.004259
                               0.994298 	 -0.038378 	 -0.099489
                               -0.099579 	 -0.000440 	 -0.995030 ];
%Pixel error:           err = [ 0.17054 	 0.19824 ]

% looping to find the change in position based on the chessboard
for ii=1:6


Tc_ext = Tc{ii}';
Rc_ext = Rc{ii};
Tt_ext1=[[Rc_ext Tc_ext];[ 0 0 0 1]];

    

Tc_ext = Tc{ii+1}';
Rc_ext = Rc{ii+1};
Tt_ext2=[[Rc_ext Tc_ext];[ 0 0 0 1]];

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


 %examples of Rc Tc, and the approximate joint positions
 q2=[pi/50 0 0 0 0 0]+qdef;
 
 
 for ii=1:1
 
Tc_ext = Tc0';
Rc_ext = Rc0;
Tt_ext1=[[Rc_ext Tc_ext];[ 0 0 0 1]]
   

Tc_ext = Tc1(ii)';
Rc_ext = Rc1(ii);
Tt_ext2=[[Rc_ext Tc_ext];[ 0 0 0 1]];
     
     
 Tt_arm_sim=fkine_M26(L,q2(ii))

 
%my best guess: for referencechcnage Xc=Tc*Xg, for point change in the same
%ref Xc*Tc=Xg

%these are a few candidates that might be correct. Since, none worked in
%all cases, I couldn't assume that my math was right anyways
 
alpharef=Tt_arm*Tt_ext1^-1;

temp= alpharef*Tt_ext2;

cammovepos=Tt_ext1^-1*Tt_ext2
cammoveref=Tt_ext2*Tt_ext1^-1




Xend_can1=Tt_arm*(Tt_ext2^-1*Tt_ext1)

Xend_can3=cammovepos^-1*Tt_arm

Xend_can2=temp

Xend_can4=cammovepos*Tt_arm 

Xend_can5=temp;
Xend_can5(:,4)=Tt_arm(:,4)-cammovepos(:,4)

Xend=Xend_can1; %this should provide the new location of the end-effector



Xendinv=Xend^-1
 
 xx1=[0;0;0;1];
 xx2=[.5;.4;.3;1];
 
 [Xend*xx1 Xend*xx2]
 
 [ Tt_arm_sim*xx1  Tt_arm_sim*xx2]
 
 end