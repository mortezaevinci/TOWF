%statecur{2} defines the type of procedure

statemc={'cycle','isempty(input(''cycle? empty=true, other=false: ''));',0};

statem1={'arduinoIMAG','',statecur{3}};
statem2={'imshow','mouse',statecur{3}};
statem3={'collectopticalsamples',statecur{2},statecur{3}};

statecycle=[statem1;statem2;statem3];

statem=[statemc;statem];

