%since camera2 (calibration camera) is always the last one, Tc_ext always
%equals calibparams{2}.Tc

Tc=Tc_ext;
Rc=Rc_ext;

[phi,theta,psai]=Rc2euler(Rc)

tic
T=fkine_M26(L,q)
toc
[phi,theta,psai]=Rc2euler(T)

tic
J=jacob_M26(L,q);
toc

%T=T^-1

Rarm=T(1:3,1:3);
Tarm=T(1:3,4);

[Xgridarm,Rgridarm,Tgridarm]=calibcam2armref(Tc0,Rc,Tc,Rarm,Tarm)

