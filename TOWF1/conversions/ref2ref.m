function [Xcc2,Rc,Tc]=ref2ref(Xcc1,Rc1,Rc2,Tc1,Tc2)
Rc=Rc1*(Rc2)^-1;
Tc=-Rc1*(Rc2)^-1*Tc1+Tc2;
Xcc2=Rc*Xcc1+Tc;
end