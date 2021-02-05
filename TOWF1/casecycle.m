%statecur{3} is not used
%statecur{2} is the condition

if eval(statecur{2})==1


statem=[statecycle;
        {'cycle',statecur{2},statecur{3}};
        statem
        ];
  


end