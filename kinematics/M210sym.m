%PUMA560 Load kinematic and dynamic data for a Puma 560 manipulator
%
%	PUMA560
%
% Defines the object 'p560' in the current workspace which describes the 
% kinematic and dynamic characterstics of a Unimation Puma 560 manipulator
% using standard DH conventions.
% The model includes armature inertia and gear ratios.
%
% Also define the vector qz which corresponds to the zero joint
% angle configuration, qr which is the vertical 'READY' configuration,
% and qstretch in which the arm is stretched out in the X direction.
%
% See also: ROBOT, PUMA560AKB, STANFORD, TWOLINK.

%
% Notes:
%    - the value of m1 is given as 0 here.  Armstrong found no value for it
% and it does not appear in the equation for tau1 after the substituion
% is made to inertia about link frame rather than COG frame.
% updated:
% 2/8/95  changed D3 to 150.05mm which is closer to data from Lee, AKB86 and Tarn
%  fixed errors in COG for links 2 and 3
% 29/1/91 to agree with data from Armstrong etal.  Due to their use
%  of modified D&H params, some of the offsets Ai, Di are
%  offset, and for links 3-5 swap Y and Z axes.
% 14/2/91 to use Paul's value of link twist (alpha) to be consistant
%  with ARCL.  This is the -ve of Lee's values, which means the
%  zero angle position is a righty for Paul, and lefty for Lee.
%  Note that gravity load torque is the motor torque necessary
%  to keep the joint static, and is thus -ve of the gravity
%  caused torque.
%
% 8/95 fix bugs in COG data for Puma 560. This led to signficant errors in
%  inertia of joint 1. 
% $Log: not supported by cvs2svn $
% Revision 1.4  2008/04/27 11:36:54  cor134
% Add nominal (non singular) pose qn

% Copyright (C) 1993-2008, by Peter I. Corke
%
% This file is part of The Robotics Toolbox for Matlab (RTB).
% 
% RTB is free software: you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% RTB is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU Lesser General Public License for more details.
% 
% You should have received a copy of the GNU Leser General Public License
% along with RTB.  If not, see <http://www.gnu.org/licenses/>.

clear L

 for ii=1:6
eval(['l' num2str(ii) '=sym(''l' num2str(ii) ''',''real'');']);
eval(['th_' num2str(ii) '=sym(''th_' num2str(ii) ''',''real'');']);
 end

 


L{1} = link([ pi/2 l1	0	0	0], 'standard');
L{2} = link([0 	l2	0	0	0], 'standard');
L{3} = link([pi/2 .0 0 0  0],'standard');
L{4} = link([-pi/2 0 0 0  0],'standard');
L{5} = link([-pi/2 l3 0 0  0],'standard');
L{6} = link([0 l4 0 0  0],'standard');
L{7} = link([pi/2 .0 0 0  0],'standard');
L{8} = link([-pi/2 0 0 0  0],'standard');
L{9} = link([-pi/2 l5 0 0  0],'standard');
L{10} = link([0 l6 0 0  0],'standard');



for ii=1:10
L{ii}.m =10;


L{ii}.r =[.1 .1 .1];

L{ii}.I = [  0	 0.35	 0	 0	 0	 0];

L{ii}.Jm =  200e-6;

L{ii}.G =  107.815;



L{ii}.B=1e-03;


L{ii}.Tc=[.1 -.1];
end



M26 = robot(L, 'Puma 560', 'Unimation', 'params of 8/95');
clear L
M26.name = 'Puma 560';
M26.manuf = 'Unimation';
