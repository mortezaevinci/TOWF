function dxdq=Jacob_fun_M26(l,q0,a,b)
qreal=a.*q0+b;
dxdq=jacob_M26(l,qreal);
end