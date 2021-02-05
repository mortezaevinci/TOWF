function dxdq=Jacob_fun(l,q0,a,b)

qreal=a.*q0+b;
dxdq=[l*cos(qreal(1)).*sin(qreal(3))+sin(qreal(3))-cos(qreal(1)).^2;
       cos(qreal(2));
       sin(qreal(4));
   sin(qreal(3));
   cos(qreal(5))*sin(qreal(6)+qreal(4));
   cos(qreal(6))*sin(qreal(5)+qreal(4))+1;];
end