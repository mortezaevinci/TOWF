

%statecur{2} represents the position for all joints for example put 'a000'

%%some random position
%controlparamsarr{statecur{3}}.desiredvalue=[hex2dec('a000');hex2dec('7000');hex2dec('9000');hex2dec('7000');hex2dec('4000');hex2dec('7000');0];

%%close to zero position
%john's
controlparamsarr{statecur{3}}.desiredvalue=[hex2dec('8a00');hex2dec('8800');hex2dec('8200');hex2dec('9d00');hex2dec('3b00');hex2dec('7600');0];
%dales'
controlparamsarr{statecur{3}}.desiredvalue=[hex2dec('7a70');hex2dec('5f00');hex2dec('8913');hex2dec('7ee8');hex2dec('a77c');hex2dec('9d26');0];


controlparamsarr{statecur{3}}.finished=[0;0;0;0;0;0;1];
controlparamsarr{statecur{3}}.currentcom=1;
controlparamsarr{statecur{3}}.lasttime(controlparamsarr{statecur{3}}.currentcom)=tic;


%run arm2pos

statecontrolpos=[{'pos2mbedparams',controlparamsarr{statecur{3}}.sensors(controlparamsarr{statecur{3}}.currentcom,:),statecur{3}};
    {'arm2pos','mine',statecur{3}}];

statem=[statecontrolpos;statem];