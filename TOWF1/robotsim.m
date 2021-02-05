%robot toolbox
lengths=armparamsarr{statecur{3}}.L;

 t = [0:.05:2]; 	% generate a time vector
 fignumber=8;
 hh=figure(fignumber);
 hold on     

qt{statecur{3}}=jtraj(curpos',estimateqpos',t); % compute the joint coordinate trajectory
drivebot_simplified(M2darr{statecur{3}},qt{statecur{3}},lengths,fignumber);