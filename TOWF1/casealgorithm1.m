evalstate={'eval','autox=[0.8;0;.2;0;0;0];',0};
algs01=[evalstate;{'arm2pos','cartesian_inita',1}];

evalstate={'eval','autox=[0.8;0;.2;0;0;0];',0};
algs02=[evalstate;{'arm2pos','cartesian_inita',2}];

algs1={'capture','',1};
algs3={'capture','',2};

algs5={'towelarea','',1};
algs7={'towelarea','',2};

algs9={'towelcrown','top',1};
algs11={'towelcrown','top',2};

algs13={'posbycams','',2}; %armnumber=2 (dale)   
%***DALE/CAM CALIBRATION IS NOT DONE YET!***

algs15={'arm2pos','gripper_open',2};

%what is Xb exactly?! we need a cartesian space there! double check
evalstate={'eval','autox=[Xb(1:3);0;pi/2;0];',0};
algs17=[evalstate;{'arm2pos','cartesian_inita',2}];

algs19={'arm2pos','gripper_close',2};

algs21={'armcheck','towelgrabbed',2};
%what to do if not...

evalstate={'eval','autox=[.4;.5;.3;pi/5;pi/2;0];',0};   % [0.5;.4;.4;0;pi/2;0] good but not converging
algs23=[evalstate;{'arm2pos','cartesian_inita',2}];

algs241={'capture','',1};
algs242={'capture','',2};

algs25={'towelarea','istop',1};
algs27={'towelarea','istop',2};

algs29={'towelcrown','bottom',1};
algs31={'towelcrown','bottom',2};

algs33={'posbycams','',1}; %armnumber=1 (john)

algs35={'arm2pos','gripper_open',1};

%what is Xb exactly?! we need a cartesian space there! double check
evalstate={'eval','autox=[Xb(1:3);0;0;-pi/2];',0};   %autox=[Xb(1:3);0;0;pi/2];   (it was pi/2 before, but it seems -pi/2 is correct)
algs37=[evalstate;{'arm2pos','cartesian_inita',1}];

algs39={'arm2pos','gripper_close',1};

algs41={'armcheck','towelgrabbed',1};
%what to do if not...

algs43={'arm2pos','gripper_open',2};

evalstate={'eval','autox=[.4;-.4;.1;pi/2;pi/2;0];',0};  %(itself, and [.6;-.4;.2;pi/2;0;0] covernge... these seem wrong...)
algs45=[evalstate;{'arm2pos','cartesian_inita',1}];


%the other way around= [.4;.52;.18;0;0;pi/2]
%possiblw [.5;-.52;.18;0;0;-pi/1.9]
evalstate={'eval','autox=[.4;.5;.1;0;0;pi/2];',0}; %this converges [.4;.6;-.2;0;0;pi/2];,  this is original, but non-converging [.6;.52;.18;0;0;-pi/2]     (old .5;-.52;.18;0;0;pi/2.1)
algs47=[evalstate;{'arm2pos','cartesian_inita',2}];

%algs49, close the gripper into half...

%can go continuous if motion-rate control was possible.
evalstate={'eval','autox=[.5;.52;.1;0;0;pi/2.1];',0};
algs51=[evalstate;{'arm2pos','cartesian_inita',2}];

evalstate={'eval','autox=[.5;.52;0;0;0;pi/2];',0};
algs53=[evalstate;{'arm2pos','cartesian_inita',2}];

evalstate={'eval','autox=[.5;.52;-.05;0;0;pi/2];',0};
algs55=[evalstate;{'arm2pos','cartesian_inita',2}];

evalstate={'eval','autox=[.5;.52;-.1;0;0;pi/2];',0};
algs57=[evalstate;{'arm2pos','cartesian_inita',2}];

evalstate={'eval','autox=[.5;.52;-0.2;0;0;pi/2];',0};
algs59=[evalstate;{'arm2pos','cartesian_inita',2}];

%algs61, assuming that the towel is on the correct side...

algs63={'arm2pos','gripper_close',2};

algs65={'armcheck','towelgrabbed',2};
%what to do if not

%fold position
evalstate={'eval','autox=[.5;0.2;0.1;0;pi/3;pi/1.5];',0};
algs69=[evalstate;{'arm2pos','cartesian_inita',2}];

evalstate={'eval','autox=[.5;-.2;.1;0;pi/3;-pi/1.5];',0};
algs67=[evalstate;{'arm2pos','cartesian_inita',1}];


mbedman1={'mbedMAN','',1};
mbedman2={'mbedMAN','',2};

algorithm1=[algs01;algs02;mbedman1;mbedman2;algs1;algs3;algs5;algs7;algs9;algs11;algs13;algs15;algs17;mbedman2;algs19;algs21;algs23;mbedman2;algs241;algs242;algs25;algs27;algs29;algs31;algs33;algs35;algs37;mbedman1;algs39;algs41;algs43;algs45;mbedman1;algs47;mbedman2;algs51;mbedman2;algs53;mbedman2;algs55;mbedman2;algs57;mbedman2;algs59;mbedman2;algs63;algs65;algs67;mbedman1;algs69;mbedman2;];

statem=[algorithm1;statem];
