armnumber=statecur{3};


'the system will pause after each move'
'random moves will be provided, then the absolute values are asked from the operator'

controlparamsarr{armnumber}.desiredvalue=hex2dec(armparamsarr{armnumber}.zeropos);


controlparamsarr{armnumber}.finished=[0;0;0;0;0;0;1];
controlparamsarr{armnumber}.currentcom=1;
controlparamsarr{armnumber}.lasttime(controlparamsarr{armnumber}.currentcom)=tic;



statem1=[{'pos2mbedparams',controlparamsarr{armnumber}.sensors(controlparamsarr{armnumber}.currentcom,:),armnumber};
    {'arm2pos','mine',armnumber}];

statem2={'eval','pause;',0};
% statem4={'modifyparameter',['mbedparamsarr{1}.fullcommandparts=[{''' component ''',''10'',''64'',0}; {''00'',''10'',''0'',1}];',0};
% statem42={'mbedCMD','',1};
statemc={'cycle','input(''cycle? 1=true, other=false: '');',0};

statem3={'arm2pos','ask',armnumber};
statem4={'getMdata','13579bd',armnumber};
statem5={'calibratearm','saveabspos',armnumber};

statecycle=[statem3;statem4;statem5];

statem=[statem1;statem2;statemc;statem];