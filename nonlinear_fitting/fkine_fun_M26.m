function X=fkine_fun_M26(l,q0,a,b)
qreal=a.*q0+b;
X=fkine_M26(l,qreal);
end