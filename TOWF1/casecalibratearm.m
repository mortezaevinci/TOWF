switch statecur{2}
    
    case '+cam-motion'  %just for debugging
        
                
        %1-go to desired position (can be done manually, or use arm2pos-jntspace)
        %2-getMdata, convert pot2pos
        %3-find TTarm based on pos
        %4-find cam1 and cam2 extrinsic parameters
        %5-save all parameters on extrinsicparamsarr
        
        %for auto joint space, set askedq='auto', and set
        %autoq=[q1;q2;q3;q4;q5;q6]
        %otherwise, it will be asked
        
        state2={'getMdata','13579b',statecur{3}};
        state3={'calibratearm','calcTTarm',statecur{3}};
        state4={'calculateextrinsic','1cam',1};
        state42={'calculateextrinsic','1cam',2};
        state43={'calibratearm','calcTTcamref',statecur{3}};
        state5={'calibratearm','saveextrinsicparams',statecur{3}};
        
        statem=[state2;state3;state4;state42;state43;state5;statem];
    
    
    case '+cam'   %CANNOT BE CYCLED (no need to, anyways)
         
        %1-go to desired position (can be done manually, or use arm2pos-jntspace)
        %2-getMdata, convert pot2pos
        %3-find TTarm based on pos
        %4-find cam1 and cam2 extrinsic parameters
        %5-save all parameters on extrinsicparamsarr
        
        %for auto joint space, set askedq='auto', and set
        %autoq=[q1;q2;q3;q4;q5;q6]
        %otherwise, it will be asked
        
        askedq='auto'; %will be used only once
        autoq=[pi/6;0;0;0;0;-pi/2];
        
        state1={'arm2pos','jntspace',statecur{3}};
        state2={'getMdata','13579b',statecur{3}};
        state3={'calibratearm','calcTTarm',statecur{3}};
        state4={'calculateextrinsic','1cam',1};
        state42={'calculateextrinsic','1cam',2};
        state43={'calibratearm','calcTTcamref',statecur{3}};
        state5={'calibratearm','saveextrinsicparams',statecur{3}};
        
        statem=[state1;state2;state3;state4;state42;state43;state5;statem];
  
    case 'saveextrinsicparams'
        save('_extrinsicparams.mat','extrinsicparamsarr');
        
    case 'calcTTarm'
        q=pot2pos(armparamsarr{statecur{3}},[1;2;3;4;5;6]);
        q=qreal2qsim(q,statecur{3});
        extrinsicparamsarr{statecur{3}}.TTarm=fkine_M26(armparamsarr{statecur{3}}.L,q) ;
        
    case 'calcTTcamref' %will use the last existing extrinsic parameters in calibparamsarr
        for ii=1:2
        extrinsicparamsarr{statecur{3}}.TTcamref{ii}=[[calibparamsarr{ii}.Rc0 calibparamsarr{ii}.Tc0];[0 0 0 1]];
        end
        
    case 'matfromfile'
         load '_armcalib.mat';
         try %remove try when both arms are calibrated.
             load '_extrinsicparams.mat';
         end
         
    case 'savesample'
        dosave=input('data reliable? yes=1 no=0: ');
        
        if dosave==1
        newind=numel(armparamsarr{statecur{3}}.calibdata)+1;
        armparamsarr{statecur{3}}.calibdata{newind}.estq=estimateq_xend;
        armparamsarr{statecur{3}}.calibdata{newind}.Xend=Xend;
        armparamsarr{statecur{3}}.calibdata{newind}.cartesiandata=T2cartesian_real(Xend);
        
        %M2data should already exist at this moment
        for ii=1:6
         armparamsarr{statecur{3}}.calibdata{newind}.q(ii,1)=hex2dec(armparamsarr{statecur{3}}.M2data{ii}.sendata.jointpos);
            
        end
        
        if codeparams.stable==0; save('_armcalib.mat','armparamsarr'); end
        
        end
 
    case 'save2zeropos'
        armparamsarr{statecur{3}}.zeropos=[];
        
        for ii=2:7
            armparamsarr{statecur{3}}.zeropos=[armparamsarr{statecur{3}}.zeropos; armparamsarr{statecur{3}}.M2data{ii}.sendata.jointpos];
       
        end
        
         if codeparams.stable==0; save('_armcalib.mat','armparamsarr'); end
        
         case 'saveabspos'
        dosave=input('mdata reliable? yes=1 no=0: ');
        
        if dosave==1
            
            if isfield(armparamsarr{statecur{3}},'absjntpos')   %absolute joint position
        
            else
                armparamsarr{statecur{3}}.absjntpos=[];
            end
            
        %M2data should already exist at this moment
        
        %in an array of 6xN
        jntpos=[];
        jntpot=[];
        for ii=1:6
           
           jntpot=[jntpot; hex2dec(armparamsarr{statecur{3}}.M2data{ii}.sendata.jointpos)];
           jntpos=[jntpos; input(['joint position in absolute degrees of ' num2str(ii) '= '])];
        end
        
         armparamsarr{statecur{3}}.absjntpos=[ armparamsarr{statecur{3}}.absjntpos [jntpos;jntpot]];
         
         if codeparams.stable==0; save('_armcalib.mat','armparamsarr'); end
        
        end
        
    case 'linearpot2pos'
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
     mm=median(m);
    
    b=sjntpos-mm*sjntpot;
    bb=median(b);
    
    armparamsarr{armnumber}.linearpot2pos.mm(ii)=mm;
    armparamsarr{armnumber}.linearpot2pos.bb(ii)=bb;
end

if codeparams.stable==0; save('_armcalib.mat','armparamsarr');end


%
%
%use function pot2pos for conversion later on
        
    otherwise
        'warning: case in calibratearm doesn''t exist.'
        
end

