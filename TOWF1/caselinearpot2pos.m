%DO NOT MODIFY OR USE, MOVED TO CALIBRATEARM CASE



%calculate linear equation of pot 2 pos and saving it into armparams

armnumber=statecur{3};

for ii=1:6
    jntpos=armparamsarr{armnumber}.absjntpos(ii,:);
    jntpot=armparamsarr{armnumber}.absjntpos(ii+6,:);
    
    [sjntpos ind1]=sort(jntpos);
    sjntpot=jntpot(ind1);
    
    dsjntpos=diff(sjntpos);
    dsjntpot=diff(sjntpot);
    
       
    
    %pos =mm*pot+bb
        
    m=dsjntpos./dsjntpot;
     mm=median(sort(m));
    
    b=sjntpos-mm*sjntpot;
    bb=median(sort(b));
    
    armparamsarr{armnumber}.linearpot2pos.mm(ii)=mm;
    armparamsarr{armnumber}.linearpot2pos.bb(ii)=bb;
end

if codeparams.stable==0; save('_armcalib.mat','armparamsarr');end


%
%
%use function pot2pos for conversion later on