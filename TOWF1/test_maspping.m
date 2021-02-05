askedx=[.7;0.05;.3;0;0;0;]  

TT=cartesian_real2T(askedx)
           
            [estimateqpos isconverged]=ikine_M26(TT,armparamsarr{1}.L,[0;.2;0;-.3;0;-1])%curpos)
            estimateqpos=myjointlimits(estimateqpos)
            estimateTT=fkine_M26(armparamsarr{1}.L,estimateqpos)
                       
            if isconverged
                estimateqposr=qsim2qreal(estimateqpos,1)
                estimateqposr=myjointlimits(estimateqposr)
                
                estimateqpot=pos2pot(armparamsarr{1},[1;2;3;4;5;6],estimateqposr);
                estimateqpot=[estimateqpot;0] %addition of gripper, not controlled anyways.
            end