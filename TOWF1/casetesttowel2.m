s0={'focus','towel',statecur{3}};
s1={'capture','',statecur{3}};
s2={'towelarea','',statecur{3}};
s3={'toweledge','',statecur{3}};
statemc={'cycle','isempty(input(''good picture? empty=bad, other=good: ''));',0};
s4={'collectvisionsamples','',statecur{3}};

statecycle=[s0;s1;s2;s3];

statem=[statecycle;statemc;s4;statem];