clc

L=[.16 .19 .12 .19 .14 .165];

qdef=[0 0 pi/2 0 pi/2 0];

q=[0 0 0 0 0 0]+qdef  %x=q-zero, z= pi/2 for either joint 72, 76, 7a ... y=-pi/2 for 74, and pi/2 for 76

Tc_ext = Tc0'
Rc_ext = Rc0
       
                           
[phi,theta,psai]=Rc2euler(Rc_ext)

tic
T=fkine_M26(L,q)
toc
[phi,theta,psai]=Rc2euler(Rc_ext)

tic
J=jacob_M26(L,q);
toc

%T=T^-1

Rarm=T(1:3,1:3);
Tarm=T(1:3,4);

[Xgridarm,Rgridarm,Tgridarm]=calibcam2armref([.965;0;0],Rc_ext,Tc_ext,Rarm,Tarm)




q=[0 0 0 0 0 0]+qdef  %x=q-zero, z= pi/2 for either joint 72, 76, 7a ... y=-pi/2 for 74, and pi/2 for 76

Tc_ext = Tc1';
Rc_ext = Rc1;
                           
                           
[phi,theta,psai]=Rc2euler(Rc_ext)

tic
T=fkine_M26(L,q)
toc
[phi,theta,psai]=Rc2euler(Rc_ext)

tic
J=jacob_M26(L,q);
toc

%T=T^-1

Rarm=T(1:3,1:3);
Tarm=T(1:3,4);

[Xgridarm,Rgridarm,Tgridarm]=calibcam2armref([0;0;0],Rc_ext,Tc_ext,Rgridarm,Tgridarm)

