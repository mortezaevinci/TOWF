controlparamsarr{statecur{3}}.currentcom=1;
controlparamsarr{statecur{3}}.lasttime(controlparamsarr{statecur{3}}.currentcom)=tic;
statecontrol=[{'pos2mbedparams',controlparamsarr{statecur{3}}.sensors(controlparamsarr{statecur{3}}.currentcom,:),statecur{3}};
    {'arm2pos','mine',statecur{3}}];

statem=[statecontrol;statem];