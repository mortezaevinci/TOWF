function  q=myjointlimits(q)
if q(3)>pi/2
    q(3)=q(3)-pi/2;
    q(4)=-q(4);
elseif q(3)<-pi/2
    q(3)=q(3)+pi/2;
    q(4)=-q(4);
end
if q(5)>pi/2
    q(5)=q(5)-pi/2;
    q(6)=-q(6);
elseif q(5)<-pi/2
    q(5)=q(5)+pi/2;
    q(6)=-q(6);
end

if q(6)>3*pi/2
    q(6)=q(6)-2*pi;
end

if q(6)<-3*pi/2
    q(6)=q(6)+2*pi;
end
%avoid, the second ikine convergence
%


end