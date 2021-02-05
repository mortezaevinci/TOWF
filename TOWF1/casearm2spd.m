%can be desolved into arm2pos for easy-to-follow code

%under development

%moved to arm2pos, dx2dq
   
   
%first do getMdata,13579b,armnumber
askeddx=input('6x1 matrix of dx? ');
if ~isempty(askeddx)


dx= askeddx;

q=[];
for ii=1:6
    q=[q;pot2pos(armparamsarr{statecur{3}},ii)];
end

q=qreal2qsim(q,statecur{3});

J=jacob_M26(armparamsarr{statecur{3}}.L,q);

invJ=pinv(J); %any better approach to calculate inv J?

dq=invJ*dx

dq=qsim2qreal(dq,statecur{3})

ctrlout=dq;
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

ctrlout=floor(ctrlout);

%works: based on magnitude
     mbedparamsarr{statecur{3}}.fullcommandparts= [{'70','10',mydec2hex(ctrlout(1),2),0};
                   {'72','10',mydec2hex(ctrlout(2),2),0};
                   {'74','10',mydec2hex(ctrlout(3),2),0};
                   {'76','10',mydec2hex(ctrlout(4),2),0};
                   {'78','10',mydec2hex(ctrlout(5),2),0};
                   {'7a','10',mydec2hex(ctrlout(6),2),0};
                   {'00','10','0',.25};
                    {'00','10','0',0};
                     {'00','10','0',0};
                   ];

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
%                    {'00','10','0',.25};
%                    ];

               
stateCMD={'mbedCMD','',statecur{3}};
stategetmdata={'getMdata','13579b',statecur{3}};%'getJdata','',statecur{3}};
staterepeat={'arm2pos','dx2dq',statecur{3}};


%note that first command requires getting Mdata, in this case... IT IS NOT
%THERE.

statem=[stateCMD; stategetmdata; staterepeat; statem];


else
    
end