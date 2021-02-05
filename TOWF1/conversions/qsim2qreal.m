function q=qreal2qsim(q,armnumber);


if armnumber==2  %dale
q(1)=-q(1);
q(5)=-q(5);
else %1 john
    'warning: john'' arm is still not tested for qsim2qreal!'
 %   'press any key to continue'
 %   pause
    
    q(1)=-q(1);
q(5)=-q(5);
end


qdef=[0 -pi/2 0 0 0 pi/2]';
q=q-qdef;
end