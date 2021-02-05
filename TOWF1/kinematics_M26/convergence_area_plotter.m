clc

%load '_armcalib.mat';
%load '_curpos.mat';

curpos=zeros(6,2);

orientation=[0;0;-pi/2];


convergingx=[];


for x1=[.3:.1:.9]
    
    for x2=[-.5:.1:.5]
        
        for x3=[-0.8:0.1:.5]
           
     
TT=cartesian_real2T([x1;x2;x3;orientation]);


[estimateqpos isconverged]=ikine_M26(TT,armparamsarr{1}.L,curpos(:,1));
isconverged

if isconverged
    convergingx=[convergingx [x1;x2;x3]];
  
end

 
        end
    end
end

plot3(convergingx(1,:),convergingx(2,:),convergingx(3,:),'.')