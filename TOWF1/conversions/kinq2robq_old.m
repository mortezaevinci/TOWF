%this is probably based on old kinematics,
%for the new kinematics use, qsim2qreal

%this functions is renamed, so if used, an error pops up for the revision.


function qout=kinq2robq(q)
q(1)=-q(1);
%not known about q3 and q5!!!
q(3)=-q(3);
q(5)=-q(5);


qout=q;
end