function Rc=euler2Rc(phi,theta,psai)
 Rc=[cos(theta)*cos(psai) -cos(phi)*sin(psai)+sin(phi)*sin(theta)*cos(psai) sin(phi)*sin(psai)+cos(phi)*sin(theta)*cos(psai);
     cos(theta)*sin(psai) cos(phi)*cos(psai)+sin(phi)*sin(theta)*sin(psai) -sin(phi)*cos(psai)+cos(phi)*sin(theta)*sin(psai);
     -sin(theta) sin(phi)*cos(theta) cos(phi)*cos(theta)];
end