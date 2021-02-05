function q=kine_sol2(q)
%qold4=q(4);
%qold2=q(2);
q(2)=q(2)+q(4);
q(4)=-q(4);
q([3 5])=-q([3 5]);
%q(6)=-(q(6)-pi/2)+pi/2-pi;

end