%robot toolbox
load '_robotsim.mat';

lengths=armparamsarr{1}.L;

qz=[0 -pi/2 0 0 0 pi/2];
  t = [0:.05:2]; 	% generate a time vector
 fignumber=8;
 hh=figure(fignumber);
      

try
    
  
for ii=1:6
     curpot(ii,statecur{3})=hex2dec(armparamsarr{statecur{3}}.M2data{ii}.sendata.jointpos);
end
   
catch
  curpot=zeros(6,2);    
end
  if skip.mbed==0
curposr(:,statecur{3})=pot2pos(armparamsarr{statecur{3}},[1;2;3;4;5;6],curpot(:,statecur{3}))
curpos(:,statecur{3})=qreal2qsim(curposr(:,statecur{3}),statecur{3});
  else
     curpos(:,statecur{3})=[0 -pi/2 0 0 0 pi/2]'; 
  end
qt{statecur{3}}=jtraj(qz,curpos(:,statecur{3})',t); % compute the joint coordinate trajectory
drivebot_simplified(M2darr{statecur{3}},qt{statecur{3}},lengths,fignumber);
hold on

