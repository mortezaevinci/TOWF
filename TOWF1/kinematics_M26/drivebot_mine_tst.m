clc

M2dm;
M2d2=M2d;
M2d2.name='M2 john';
M2d2.base=[1 0 0 0;
           0 1 0 1;
           0 0 1 0;
           0 0 0 1];

lengths=armparamsarr{1}.L;

qz=[0;0;0;0;0;0];
qr=[0;-pi/2;0;0;0;pi/2];

  t = [0:.05:2]; 	% generate a time vector
    q1 = jtraj(qz', qr', t); % compute the joint coordinate trajectory
q2 = jtraj(qr', qz', t); % compute the joint coordinate trajectory
q3 = jtraj(qr', qz', t); % compute the joint coordinate trajectory

    fignumber=8;
    hh=figure(fignumber);
  
    
drivebot_simplified(M2d,q1,lengths,fignumber);



hold on
drivebot_simplified(M2d2,q2,lengths,fignumber);

% figure(3)
% figure(8)


drivebot_simplified(M2d,q3,lengths,fignumber);



