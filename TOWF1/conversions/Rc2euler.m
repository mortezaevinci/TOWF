function [phi,theta,psai]=Rc2euler(Rc)
   theta=asin(-Rc(3,1));
   psai=asin(Rc(2,1)/cos(theta));
   phi=acos(Rc(3,3)/cos(theta));
end