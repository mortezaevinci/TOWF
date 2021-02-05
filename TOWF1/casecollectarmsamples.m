armnumber=statecur{3};
camnumber=2;




%statem1={'arm2pos','zero',armnumber};
statem2={'calculateextrinsic','1cam',camnumber};
statem3={'modifyparameter','Rc0=Rc_ext;Tc0=Tc_ext;',0};
% statem4={'modifyparameter',['mbedparamsarr{1}.fullcommandparts=[{''' component ''',''10'',''64'',0}; {''00'',''10'',''0'',1}];',0};
% statem42={'mbedCMD','',1};
statemc={'cycle','input(''cycle? 1=true, other=false: '');',0};


statem4={'mbedMAN','',armnumber};
statem5={'calculateextrinsic','1cam',camnumber};
statem6={'modifyparameter','Rc1=Rc_ext;Tc1=Tc_ext;',0};
statem7={'testrefshow','',0};
statem8={'getMdata','13579bd',armnumber};
statem9={'calibratearm','savesample',armnumber};
statecycle=[statem4;statem5;statem6;statem7;statem8;statem9];


controlparamsarr{statecur{3}}.desiredvalue=hex2dec(armparamsarr{statecur{3}}.zeropos);
controlparamsarr{statecur{3}}.finished=[0;0;0;0;0;0;1];

statem1={'docontrol','',statecur{3}};

statem=[statem1;statem2;statem3;statemc;statem];