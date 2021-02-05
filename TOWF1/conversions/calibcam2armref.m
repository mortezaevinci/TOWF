function [Xgridarm,Rgridarm,Tgridarm]=calibcam2armref(gridpoint,Rc,Tc,Rarm,Tarm)

Rc=Rc;
Tc=Tc;
gridpoint=gridpoint;

[x2,Rgridarm,Tgridarm]=ref2ref(gridpoint,Rc,Rarm,Tc,Tarm);

Xgridarm=[x2;Rgridarm(1,1:3)'];
end