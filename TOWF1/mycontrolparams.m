controlparams.finished=[1;1;1;1;1;1;1];  %when a set of control ends
controlparams.currentcom=0;   %tunr based control of all params ... 0 means all are finished, or no control is needed
controlparams.components=['70';'72';'74';'76';'78';'7a';'7c'];
controlparams.sensors=['71';'73';'75';'77';'79';'7b';'7d'];
controlparams.P=[.001;.001;.001;.0002;.0005;.0002;.001]*2;
controlparams.I=[.001;.001;.001;.001;.001;.001;.001]*0;
controlparams.D=[.001;.001;.001;.001;.001;.001;.001]*0;

controlparams.maxpositive=[127;127;127;127;127;127;127];
controlparams.maxnegative=-[127;127;127;127;127;127;127];
controlparams.minpositive=[32;32;24;32;24;24;24];
controlparams.minnegative=-[24;50;24;50;24;24;24];
controlparams.outputinv=[0;0;0;0;1;0;0];


controlparams.lastoutput=[0;0;0;0;0;0;0];
controlparams.lastvalue=[0;0;0;0;0;0;0];
controlparams.lasttime=[0;0;0;0;0;0;0];
controlparams.desiredvalue=[-1;-1;-1;-1;-1;-1;-1]; %0-65535  (doesn't matter what value... the user should provide the non-used ones with finished=1)
controlparams.finethres=[255;255;255;255;100;255;255]*2;

controlparams.mbedposctrl=1;