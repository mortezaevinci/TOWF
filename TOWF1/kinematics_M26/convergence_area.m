load _curpos;
convergingx=[];
for x1=[.5:.2:.9]
    x1
    for x2=[-.5:.2:.5]
        x2
        for x3=[-0.8:0.2:.5]
            x3
            for x4=[-pi/2:pi/6:pi/2]
                for x5=[-pi/2:pi/6:pi/2]
                    for x6=[-pi/2:pi/6:pi/2]
TT=cartesian_real2T([x1;x2;x3;x4;x5;x6]);

[estimateqpos isconverged]=ikine_M26(TT,armparamsarr{1}.L,curpos(:,1));

if isconverged
    convergingx=[convergingx [x1;x2;x3;x4;x5;x6]];
  
end

                    end
                end
            end
        end
    end
end