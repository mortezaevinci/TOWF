%statecur={nextstate, sensor for control, mbed ID}

%so far only 8 is needed

mbedparamsarr{statecur{3}}.fullcommandparts= [{statecur{2},'14','',0}];
               
stateCMD={'mbedCMD','',statecur{3}};
 
statem=[stateCMD; statem];