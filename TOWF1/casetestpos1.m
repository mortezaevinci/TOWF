

%statecur{2} represents the position for joint ... for example put 'a000'

controlparamsarr{statecur{3}}.desiredvalue=[hex2dec(statecur{2});-1;-1;-1;-1;-1;-1];
controlparamsarr{statecur{3}}.finished=[0;1;1;1;1;1;1];
controlparamsarr{statecur{3}}.currentcom=1;
controlparamsarr{statecur{3}}.lasttime(controlparamsarr{statecur{3}}.currentcom)=tic;


%run arm2pos

statecontrolpos=[{'pos2armparams',controlparamsarr{statecur{3}}.sensors(controlparamsarr{statecur{3}}.currentcom,:),statecur{3}};
    {'arm2pos','mine',statecur{3}}];

statem=[statecontrolpos;statem];