function Xg=grid2camreference(Xc,Rc,Tc)
Xg=Rc^-1*(Xc-Tc);
end