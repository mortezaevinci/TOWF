clc

L=[.16 .18 .12 .18 .15 .2];

qdef=[0 -pi/2 0 0 0 pi/2];

q=[0 0 0 0 0 0]+qdef;  %x=q-zero, z= pi/2 for either joint 72, 76, 7a ... y=-pi/2 for 74, and pi/2 for 76

                         
tic
Tt_arm=fkine_M26(L,q)
toc

 tic
 J=jacob_M26(L,q)
 toc



%T=T^-1

%since at position-zero, Xend-effector=Tt_arm*I;

 
 q2=[-pi/10 0 0 0 0 0]+qdef;
 
 tic
 Tt_arm_sim=fkine_M26(L,q2)
 toc
 
 Tt_arm_sim^-1