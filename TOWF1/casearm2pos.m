
staterepeat=cell(0);


isrun=1;
switch statecur{2}
    case 'gripper_open'
        if statecur{3}==1
           ammount='7f'; 
        else
           ammount='-7f';  
        end
        mbedparamsarr{statecur{3}}.fullcommandparts= {'7c','10',ammount,0};
            
    case 'gripper_close'
        if statecur{3}==1
           ammount='-7f'; 
        else
           ammount='7f';  
        end
        mbedparamsarr{statecur{3}}.fullcommandparts= {'7c','10',ammount,0};    
    
    case 'cartesian_do'
            TT=cartesian_real2T(askedx)
            for ii=1:6
                curpot(ii)=hex2dec(armparamsarr{statecur{3}}.M2data{ii}.sendata.jointpos);
            end
            curposr=pot2pos(armparamsarr{statecur{3}},[1;2;3;4;5;6],curpot)
            curpos=qreal2qsim(curposr,statecur{3});
            curpost=curpos;%zeros(6,1);
            [estimateqpos isconverged]=ikine_M26(TT,armparamsarr{statecur{3}}.L,curpost) %use d instead of curpos [0;.2;0;-.3;0;-1] for some good results
            estimateqpos=myjointlimits(estimateqpos)
            estimateTT=fkine_M26(armparamsarr{statecur{3}}.L,estimateqpos)
                       
            if isconverged
                estimateqposr=qsim2qreal(estimateqpos,statecur{3})
                estimateqposr=myjointlimits(estimateqposr)
                
                estimateqpot=pos2pot(armparamsarr{statecur{3}},[1;2;3;4;5;6],estimateqposr);
                estimateqpot=[estimateqpot;0] %addition of gripper, not controlled anyways.
                controlparamsarr{statecur{3}}.desiredvalue=floor(double(uint16(estimateqpot)))
                
                %show simulation
                robotsim;
                'Simulation complete! press any key to continue'
                
                nn=input('do control? y=yes, n=no','s');
                
                if nn=='y'
                controlparamsarr{statecur{3}}.finished=[0;0;0;0;0;0;1];
                statem=[{'docontrol','',statecur{3}}; statem];
                end
            else
                'Error: Cartesian control in arm2pos, did not converge'
            end
    case 'cartesian_init' %referrer case
        %%
        %under development
        
        isrun=0;
        
      
            
        askedx=input('6x1 matrix of x? ');
                
        if ~isempty(askedx)
            statem=[{'getJdata','',statecur{3}}; %{'getMdata','13579bd',statecur{3}};
                    {'arm2pos','cartesian_do',statecur{3}};
                    statem];
  
        end
        
         case 'cartesian_inita' %referrer case
        
        askedx=autox;
       if ~isempty(askedx)
            statem=[{'getJdata','',statecur{3}}; %{'getMdata','13579bd',statecur{3}};
                    {'arm2pos','cartesian_do',statecur{3}};
                    statem];
  
        end
        
    case 'zeromtr'
        
        mbedparamsarr{statecur{3}}.fullcommandparts= [{'70','23',armparamsarr{statecur{3}}.zeropos(1,:),0};
            {'72','23',armparamsarr{statecur{3}}.zeropos(2,:),0};
            {'74','23',armparamsarr{statecur{3}}.zeropos(3,:),0};
            {'76','23',armparamsarr{statecur{3}}.zeropos(4,:),0};
            {'78','23',armparamsarr{statecur{3}}.zeropos(5,:),0};
            {'7a','23',armparamsarr{statecur{3}}.zeropos(6,:),0};
            % {'7c','23',armparamsarr{statecur{3}}.zeropos(7,:),0};
            {'0','10','0',8};
            ];
    case 'zerojnt'
        armnumber=statecur{3};
        controlparamsarr{armnumber}.desiredvalue=hex2dec(armparamsarr{armnumber}.zeropos);
        controlparamsarr{armnumber}.finished=[0;0;0;0;0;0;1];
        controlparamsarr{armnumber}.currentcom=1;
        controlparamsarr{armnumber}.lasttime(controlparamsarr{armnumber}.currentcom)=tic;
        
        statem1=[{'pos2mbedparams',controlparamsarr{armnumber}.sensors(controlparamsarr{armnumber}.currentcom,:),armnumber};
            {'arm2pos','mine',armnumber}];
        statem=[statem1;statem];
        
     case 'jntspace'
         isrun=0;
         if strcmp(askedq,'auto')
             askedq=autoq;
         else
             askedq=input('6x1 matrix of q? ');
         end
        if ~isempty(askedq)
        armnumber=statecur{3};
        askedpot=pos2pot(armparamsarr{armnumber},[1 2 3 4 5 6],askedq);
        controlparamsarr{armnumber}.desiredvalue=askedpot;
        controlparamsarr{armnumber}.finished=[0;0;0;0;0;0;1];
        controlparamsarr{armnumber}.currentcom=1;
        controlparamsarr{armnumber}.lasttime(controlparamsarr{armnumber}.currentcom)=tic;
        
        statem1=[{'pos2mbedparams',controlparamsarr{armnumber}.sensors(controlparamsarr{armnumber}.currentcom,:),armnumber};
            {'arm2pos','mine',armnumber}];
        statem=[statem1;statem];
        end
    case 'rand'
        mbedparamsarr{statecur{3}}.fullcommandparts= [{'70','10',num2str(floor(rand(1,1)*128-64)),0};
            {'72','10',num2str(floor(rand(1,1)*128-64)),0};
            {'74','10',num2str(floor(rand(1,1)*128-64)),0};
            {'76','10',num2str(floor(rand(1,1)*128-64)),0};
            {'78','10',num2str(floor(rand(1,1)*128-64)),0};
            {'7a','10',num2str(floor(rand(1,1)*128-64)),0};
            % {'7c','23',armparamsarr{statecur{3}}.zeropos(7,:),0};
            {'0','10','0',.5};
            ];
        
    case 'ask'
        mbedparamsarr{statecur{3}}.fullcommandparts= [{'70','10',input('70 power: ','s'),0};
            {'72','10',input('72 power: ','s'),0};
            {'74','10',input('74 power: ','s'),0};
            {'76','10',input('76 power: ','s'),0};
            {'78','10',input('78 power: ','s'),0};
            {'7a','10',input('7a power: ','s'),0};
            % {'7c','23',armparamsarr{statecur{3}}.zeropos(7,:),0};
            {'0','10','0',1};
            {'0','10','0',0};
            ];
    case 'wing'
        components=['70';'72';'74';'76';'78';'7a'];
        mbedparamsarr{statecur{3}}.fullcommandparts=[];
        for ii=1:size(components,2)
            compos=input('Enter the motor position: ','s');
            if ~isempty(compos)
                mbedparamsarr{statecur{3}}.fullcommandparts= [mbedparamsarr{statecur{3}}.fullcommandparts;
                    
                {components(ii),'23',compos,0}
                ];
            end
            
        end
        mbedparamsarr{statecur{3}}.fullcommandparts= [mbedparamsarr{statecur{3}}.fullcommandparts;
            % {'7c','23',armparamsarr{statecur{3}}.zeropos(7,:),0};
            {'0','10','0',8};
            ];
        
       
    case 'mine'
        %this case for now, will force the control and stop the software.
        %it may need to be changed later.
        currentcom=controlparamsarr{statecur{3}}.currentcom
        
        if controlparamsarr{statecur{3}}.currentcom~=0
            
            
            if controlparamsarr{statecur{3}}.finished(currentcom)==0
                %do position control!
                'do the contrl'
                %update controlparams by armparams
                lasterr=controlparamsarr{statecur{3}}.desiredvalue(currentcom)-controlparamsarr{statecur{3}}.lastvalue(currentcom);
                controlparamsarr{statecur{3}}.lastvalue(currentcom)=hex2dec(mbedparamsarr{statecur{3}}.M2data.sendata.jointpos);
                err0=controlparamsarr{statecur{3}}.desiredvalue(currentcom)-controlparamsarr{statecur{3}}.lastvalue(currentcom);
                delt0=toc(uint64(controlparamsarr{statecur{3}}.lasttime(currentcom)));
                controlparamsarr{statecur{3}}.lasttime(currentcom)=tic;
                
                
                controloutput=controlparamsarr{statecur{3}}.P(currentcom)*err0+controlparamsarr{statecur{3}}.I(currentcom)*(err0+controlparamsarr{statecur{3}}.lastoutput(currentcom))+controlparamsarr{statecur{3}}.D(currentcom)*(err0-lasterr);
                
                if controlparamsarr{statecur{3}}.outputinv(currentcom)==1
                    controloutput=-controloutput
                end
                
                %limit control output
                controloutput=controloutput*2; %speed control, min/max factor
                
                if sign(controloutput)==1
                  %  if controlparamsarr{statecur{3}}.mbedposctrl==0
                        if controloutput>controlparamsarr{statecur{3}}.maxpositive(currentcom)
                            controloutput=controlparamsarr{statecur{3}}.maxpositive(currentcom);
                        end
                  %  end
                    
                    if controloutput<controlparamsarr{statecur{3}}.minpositive(currentcom)
                        controloutput=controlparamsarr{statecur{3}}.minpositive(currentcom);
                    end
                    
                    
                else
                  %  if controlparamsarr{statecur{3}}.mbedposctrl==0
                        if controloutput<controlparamsarr{statecur{3}}.maxnegative(currentcom)
                            controloutput=controlparamsarr{statecur{3}}.maxnegative(currentcom);
                        end
                 %   end
                    
                    if controloutput>controlparamsarr{statecur{3}}.minnegative(currentcom)
                        controloutput=controlparamsarr{statecur{3}}.minnegative(currentcom);
                    end
                    
                    
                end
                
                controloutput=floor(controloutput);
                
                
                controlparamsarr{statecur{3}}.lastoutput(currentcom)=controloutput;
                
                
                
                
                
                %check if current is finshed?
                if abs(err0)<controlparamsarr{statecur{3}}.finethres(currentcom)
                %if sign(err0)~=sign(lasterr)
                    'error satisfied'
                    controlparamsarr{statecur{3}}.finished(currentcom)=1;
                    
                    mbedparamsarr{statecur{3}}.fullcommandparts=[{controlparamsarr{statecur{3}}.components(currentcom,:),'10','0',0}];
                else
                    controlparamsarr{statecur{3}}.finished(currentcom)=0;
                    
                    if controlparamsarr{statecur{3}}.mbedposctrl==0
                        mbedparamsarr{statecur{3}}.fullcommandparts= [{controlparamsarr{statecur{3}}.components(currentcom,:),'10',mydec2hex(controloutput,2),0}];
                    else
                        if currentcom==1
                            tdelay=.1; %seconds
                            %batterysave={'0','10','0',tdelay};
                            batterysave=cell(0);
                        else
                            tdelay=0;
                            batterysave=cell(0);
                        end
                        if controloutput>1000
                        controloutput=floor(controloutput*100); %some experimental conversion factor for speed
                        else
                        controloutput=floor(controloutput*20); %some experimental conversion factor for speed
                        end
                        
                        hexcontroloutput=dec2hex(abs(controloutput),4);
                        if sign(controloutput)==-1
                        hexcontroloutput=['-'  hexcontroloutput];     
                        end
                        
                        if hex2dec(mbedparamsarr{statecur{3}}.M2data.sendata.motorpos)+700>hex2dec(mbedparamsarr{statecur{3}}.M2data.sendata.minmtrps) & hex2dec(mbedparamsarr{statecur{3}}.M2data.sendata.motorpos)-700<hex2dec(mbedparamsarr{statecur{3}}.M2data.sendata.maxmtrps)
                           mbedparamsarr{statecur{3}}.fullcommandparts= [batterysave;{controlparamsarr{statecur{3}}.components(currentcom,:),'80',[mydec2hex(controlparamsarr{statecur{3}}.desiredvalue(currentcom),4) ' ' '0000' ' ' mydec2hex(controlparamsarr{statecur{3}}.lastvalue(currentcom),4) ' ' hexcontroloutput],.05}];
                        else
                           'WARNING: motor soft limits reached. the control is interrupted.'
                           controlparamsarr{statecur{3}}.finished(currentcom)=2;
                        end
                    end
                end
                
            else
                if currentcom>0
                    controlparamsarr{statecur{3}}.finished(currentcom)=1;
                end
                currentcom=0;  %allow for other components to be selected if this is finished
                
                
            end
            
            controlparamsarr{statecur{3}}.finished
            %REPEAT IF ANY UNFINISHED CASE EXISTED
            unfinind=find(controlparamsarr{statecur{3}}.finished==0);
            
            if ~isempty(unfinind)
                unfinindind=find(unfinind~=currentcom);
                if isempty(unfinindind)
                    %the unfinished one remains the same
                else
                    %rotate the unfinished component
                    unfinind=unfinind(unfinindind);
                    
                    latestind=find(unfinind>currentcom);
                    if isempty(latestind)
                        currentcom=unfinind(1); %next unfininshed component is selected
                    else
                        currentcom=unfinind(latestind(1));
                    end
                end
                
                
            end
            
            controlparamsarr{statecur{3}}.currentcom=currentcom;
            
            if currentcom~=0
                staterepeat=[{'pos2mbedparams',controlparamsarr{statecur{3}}.sensors(currentcom,:),statecur{3}};
                    {'arm2pos','mine',statecur{3}}];
            else
                staterepeat={'arm2pos','mine',statecur{3}};
                
            end
            
        else
            
            %stay finished
            %    controlparamsarr{statecur{3}}.currentcom=0;
            
            staterepeat=[];   %incase no repeation was needed (refer to 'mine' case)
            
            'stoping everything in next state'
            mbedparamsarr{statecur{3}}.fullcommandparts= [
                {'0','10','0',0};
                ];
            
            
            
        end
        
        
    case 'dx2dq2'
        
        
     %can be desolved into arm2pos for easy-to-follow code

%under development

   
   
%first do getMdata,13579b,armnumber
askeddx=input('6x1 matrix of dx? ');
if ~isempty(askeddx)


dx= askeddx;

qr=pot2pos(armparamsarr{statecur{3}},[1,2,3,4,5,6]);

qs=qreal2qsim(qr,statecur{3});

J=jacob_M26(armparamsarr{statecur{3}}.L,qs);

invJ=pinv(J); %any better approach to calculate inv J?

dqs=invJ*dx

dqr=qsim2qreal(dqs,statecur{3})


   dqrpot=pot2pos(armparamsarr{statecur{3}},[1,2,3,4,5,6],dqr)

mbedparamsarr{statecur{3}}.fullcommandparts=[];
for ii=1:6
    inithex=armparamsarr{statecur{3}}.M2data{ii}.sendata.jointpos;
    initval=hex2dec(inithex);
    finalval=initval+dqrpot(ii);
    finalhex=dec2hex(floor(finalval),4);
    err0=finalval-initval;
    controloutput=sign(err0)*2;
    
    
       if controlparamsarr{statecur{3}}.outputinv(ii)==1
                    controloutput=-controloutput
                end
            if controloutput<controlparamsarr{statecur{3}}.minpositive(ii)
                   controloutput=controlparamsarr{statecur{3}}.minpositive(ii);
            end
 
            if controloutput>controlparamsarr{statecur{3}}.minnegative(ii)
                  controloutput=controlparamsarr{statecur{3}}.minnegative(ii);
            end
            
           controloutput=floor(controloutput*20); %some experimental conversion factor for speed
         hexcontroloutput=dec2hex(abs(controloutput),4);
           if sign(controloutput)==-1
           hexcontroloutput=['-'  hexcontroloutput];     
             end
            mbedparamsarr{statecur{3}}.fullcommandparts= [mbedparamsarr{statecur{3}}.fullcommandparts;
                {controlparamsarr{statecur{3}}.components(ii,:),'80',[finalhex ' ' '0000' ' ' inithex ' ' hexcontroloutput],0};
                {'0','10','0',1}
                ];
              
end

              

               
staterepeat=[{'getJdata','',statecur{3}}; %{'getMdata','13579bd',statecur{3}};
{'arm2pos','dx2dq',statecur{3}};];


%note that first command requires getting Mdata, in this case... IT IS NOT
%THERE.

%statem=[stateCMD; stategetmdata; staterepeat; statem];


else
    
end

%staterepeat=cell(0);
        
    case 'dx2dq'
        
        
     %can be desolved into arm2pos for easy-to-follow code

%under development

   
   
%first do getMdata,13579b,armnumber
askeddx=input('6x1 matrix of dx? ');
if ~isempty(askeddx)


dx= askeddx;

qr=pot2pos(armparamsarr{statecur{3}},[1,2,3,4,5,6]);

qs=qreal2qsim(qr,statecur{3});

J=jacob_M26(armparamsarr{statecur{3}}.L,qs);

invJ=pinv(J); %any better approach to calculate inv J?

dqs=invJ*dx

dqr=qsim2qreal(dqs,statecur{3})

ctrlout=dqr/max(dqr)*127;

for ii=1:6
    
   
    %convert the sign from pos 2 pot
    if armparamsarr{statecur{3}}.linearpot2pos.mm<0
        ctrlout=-ctrlout;
    end
    
    %convert the sign from pot 2 control command
    if controlparamsarr{statecur{3}}.outputinv(ii)==1
        ctrlout=-ctrlout;
    end
    
    if ctrlout(ii)>127
        ctrlout(ii)=127;
    end
    if abs(ctrlout(ii))<50
       ctrlout(ii)=32*sign(ctrlout(ii)); 
    end
    if ctrlout(ii)<-127
        ctrlout(ii)=-127;
    end

    
end

ctrlout=floor(ctrlout)

%%design based on integration over speed.

%apply a norm to dq, and then limit the maximum to a desired value
dqrnorm=dqr/max(dqr);
maxdqr=.1;
dqr=dqrnorm*maxdqr;

dqrpot=pot2pos(armparamsarr{statecur{3}},[1,2,3,4,5,6],dqr)

mbedparamsarr{statecur{3}}.fullcommandparts=[];
for ii=1:6
    inithex=armparamsarr{statecur{3}}.M2data{ii}.sendata.jointpos;
    initval=hex2dec(inithex);
    finalval=initval+dqrpot(ii);
    finalhex=dec2hex(floor(finalval),4);
    err0=finalval-initval;
    controloutput=sign(err0);
    
       if controlparamsarr{statecur{3}}.outputinv(ii)==1
                    controloutput=-controloutput
                end
            if controloutput<controlparamsarr{statecur{3}}.minpositive(ii)
                   controloutput=controlparamsarr{statecur{3}}.minpositive(ii);
            end
 
            if controloutput>controlparamsarr{statecur{3}}.minnegative(ii)
                  controloutput=controlparamsarr{statecur{3}}.minnegative(ii);
            end
            
           controloutput=floor(controloutput*250); %some experimental conversion factor for speed
         hexcontroloutput=dec2hex(abs(controloutput),4);
           if sign(controloutput)==-1
           hexcontroloutput=['-'  hexcontroloutput];     
             end
            mbedparamsarr{statecur{3}}.fullcommandparts= [mbedparamsarr{statecur{3}}.fullcommandparts;
                {controlparamsarr{statecur{3}}.components(ii,:),'80',[finalhex ' ' '0000' ' ' inithex ' ' hexcontroloutput],0};
                {'0','10','0',1}
                ];
              
end

%%works: based on magnitude
% delayt=.2;
% 
%      mbedparamsarr{statecur{3}}.fullcommandparts= [{'70','10',mydec2hex(ctrlout(1),2),0};
%                    
%                    {'72','10',mydec2hex(ctrlout(2),2),0};
%                    {'0','10','0',delayt};
%                    {'74','10',mydec2hex(ctrlout(3),2),0};
%                    
%                    {'76','10',mydec2hex(ctrlout(4),2),0};
%                    {'0','10','0',delayt};
%                    {'78','10',mydec2hex(ctrlout(5),2),0};
%                    
%                    {'7a','10',mydec2hex(ctrlout(6),2),0};
%                    {'0','10','0',delayt};
%                     {'0','10','0',0};
%                      
%                    ];

% %design based on time outputed
%      mbedparamsarr{statecur{3}}.fullcommandparts= [{'70','10',num2str(sign(ctrlout(1))*7f),0};
%                    {'70','10','0',dq(1)*10};
%                    {'72','10',num2str(sign(ctrlout(1))*7f),0};
%                    {'72','10','0',dq(2)*10};
%                    {'74','10',num2str(sign(ctrlout(1))*7f),0};
%                    {'74','10','0',dq(3)*10};
%                    {'76','10',num2str(sign(ctrlout(1))*7f),0};
%                    {'76','10','0',dq(4)*10};
%                    {'78','10',num2str(sign(ctrlout(1))*7f),0};
%                    {'78','10','0',dq(5)*10};
%                    {'7a','10',num2str(sign(ctrlout(1))*7f),0};
%                    {'7a','10','0',dq(6)*10};
%                    {'0','10','0',.25};
%                    ];

               
staterepeat=[{'getJdata','',statecur{3}}; %{'getMdata','13579bd',statecur{3}};
{'arm2pos','dx2dq',statecur{3}};];


%note that first command requires getting Mdata, in this case... IT IS NOT
%THERE.

%statem=[stateCMD; stategetmdata; staterepeat; statem];


else
    
end


    otherwise
        'Warning: case not recognized in arm2pos'
        isrun=0;
end

if isrun==1
    stateCMD={'mbedCMD','',statecur{3}};
    statem=[stateCMD;staterepeat; statem];
end