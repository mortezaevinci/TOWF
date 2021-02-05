%%code revision notes
%camnumber=2 always, used for armcalibration purposes



%%
%general initialization

'Initialization'

clc;
clear all;
format short g;
format compact;

%reset camera devices
try
    imaqreset;
end

%reset all serial
try
    fclose(instrfind);
    delete(instrfind);
end

%%
%constants
askedx='';
askedq='';
%code stabality vs performance
codeparams.stable=0;

%skipping constants
skip.video=1;
skip.arduino=1;
skip.stereo=1;
skip.mbed=0;


load '_towelanalysis.mat';
load '_armanalysis.mat';
%initial states
SMmanual={'manual','',double(0)};
SMinit={'init','',double(0)};
SMcalibparams={'calibratecamera','matfromfile',double(0)};
SMarmparams={'calibratearm','matfromfile',double(0)};
SMcontrolparams={'setcontrol','matfromfile',double(0)};
SMmbedq=[{'mbedquiet','',1};{'mbedquiet','',2}];
SMgetcurMdata=[{'getMdata','13579bd',1};{'getMdata','13579bd',2}];
SMinitsimbot=[{'initsimbot','',1};{'initsimbot','',2}];

if skip.mbed==1
statem=[SMinit; SMcalibparams; SMarmparams; SMcontrolparams; SMinitsimbot; SMmanual]; %columns of states, with [currentstate;datastring;datadouble]
else
statem=[SMinit; SMcalibparams; SMarmparams; SMcontrolparams; SMmbedq; SMgetcurMdata; SMinitsimbot; SMmanual]; %columns of states, with [currentstate;datastring;datadouble]
end

exit=0;
waitidle=.05;

imm{1}=zeros(18,18);
imm{2}=zeros(18,18);
dxdy{1}=[0 0];
dxdy{2}=[0 0];

nx=640;
ny=480;

%initial calibparams
%mycalibparams;
%calibparams0=calibparams; %note calibparams is used as a temporary buffer
%calibparamsarr{1}=calibparams0;
%calibparamsarr{2}=calibparams0;



%%
%object initialization


%serial communication

if skip.arduino==0
    
    %arduino
    s1 = serial('COM5');                            %define serial port
    s1.BaudRate=115200;                               %define baud rate
    s1.Timeout=.5;
    s1.InputBufferSize=2048;
    pause(.1)
    fopen(s1); %open serial port
    
end

if skip.mbed==0
    %mbed
    %mymbedparams;
    %mbedparamsarr{1}=mbedparams;
    %mbedparamsarr{2}=mbedparams;
    
    %%now loaded from the file
    %mycontrolparams;
    %controlparamsarr{1}=controlparams;
    %controlparamsarr{2}=controlparams;
    
    for i=1:2
        try
        m2s(i) = serial(['COM' num2str(5+i)]);                            %define serial port
        m2s(i).BaudRate=115200;                               %define baud rate
        m2s(i).Timeout=.2;
        fopen(m2s(i)); %open serial port
        catch err
            err.message
            pause
        end
    end
    
end

%video objects
if skip.video==0
    vid(1) = videoinput('winvideo',1,['I420_' num2str(nx) 'x' num2str(ny)]);
    vid(2) = videoinput('winvideo',2,['I420_' num2str(nx) 'x' num2str(ny)]);
    
    for i=1:size(vid,2)
        vid_src(i)=getselectedsource(vid(i));
        set(vid_src(i),'FocusMode','manual');
        himage(i)=preview(vid(i));
        set(himage(i),'Visible','off');
        set(himage(i),'HitTest','off')
        
    end
    %figures 1 and 2 are reserved for preview
end




pause(.5);
%%


%state machine
statemachinecnt=0;

while (exit==0)
    statemachinecnt=statemachinecnt+1;
    
    try
        [statecur, statem]=extractstate(statem);
        statecur
        
        %instable code, user interaction
        if codeparams.stable==0
            if statemachinecnt>100
                cutit=' ';
                statemachinecnt=0;
                while(cutit~='n')
                    cutit=input('cut the current state? (y or n or a=all, r=reset mbed)','s');
                    if cutit=='y'
                        [statecur, statem]=extractstate(statem);
                        statecur
                    elseif cutit=='a'
                        statem=[];
                        break;
                    elseif cutit=='r'
                        %reset mbed
                       if skip.mbed==0
    %mbed
    for i=1:2
        fclose(m2s(i));
        delete(m2s(i));
    end
    
    
    
end 
             pause(.5)           
           for i=1:2
        m2s(i) = serial(['COM' num2str(5+i)]);                %define serial port
        m2s(i).BaudRate=115200;                               %define baud rate
        m2s(i).Timeout=.2;
        fopen(m2s(i)); %open serial port
    end               
             pause(.5)           
                    end
                end
            end
        end
        
        %states
        switch statecur{1}
            case '' %idle case, or user events can come here.
                'Warning: exiting on no state exists'
                exit=1;
            case 'init'
                caseinit;
            case 'initsimbot'
                caseinitsimbot;
            case 'reinitsim'
                casereinitsim;
            case {'modifyparameter','eval'}
                casemodifyparameter;
            case 'dtsave'
                casesavecalibration;                
            case 'manual'  %asks for the next state
                casemanual;
            case 'dtshow' %show data to the usertest
                casedtshow;
            case 'cycle'
                casecycle;   %cycles the statecycle
            case 'exit'
                exit=1;   %exits
            case 'calibratecamera' %stringdata='imagefromfile' 'matfromfile' or 'camera'
                casecalibratecamera;
            case 'calculateextrinsic'
                casecalculateextrinsic;
            case 'posbycams'
                caseposbycams;
            case 'focus'
                %statecur([1,2,3])=state, focustype, cameraindex
                casefocus;
            case 'DBF' %Depth by Focus
                casedbf;
            case 'imshow' %use camera to show camera image, and mouse to show mouse sensor image... double value 1 or 2 for index
                caseimshow;
            case 'toweledge'
                casetoweledge;
            case 'capture'
                casecapture;
            case 'towelarea'
                casetowelarea;
            case 'towelcrown'
                casetowelcrown;
            case 'testtowel1'
                casetesttowel1;
            case 'testtowel2'
                casetesttowel2;
            case 'collectvisionsamples'
                casecollectvisionsamples;
            case 'mbedquiet'
                casembedquiet;
            case {'mbedCMD'} %runs mbed commands
                casembedcmd;
            case 'mbedMAN' %performs manual mbed commands by mbedCMD
                casembedman;
            case 'calibratearm'
                casecalibratearm;
            case 'setcontrol'
                casesetcontrol;
            case 'docontrol'
                casedocontrol;          
            case 'arm2pos' %moves the arm to the targeted position
                casearm2pos;
            case 'armcheck'
                casearmcheck;
            case 'arm2spd' %(is supposed to) move arm by specific speed
                casearm2spd;
            case 'testpos1' %testing
                casetestpos1;
            case 'testpos2' %testing
                casetestpos2;
            case 'pos2mbedparams' %receives the arm positions and saves into mbedparams
                casepos2mbedparams;
            case 'getMdata'  %gets Mdata from mbed
                casegetmdata;
            case 'getJdata'  %gets Mdata from mbed
                casegetjdata;
            case 'savemdata'  %saves each mdata
                casesavemdata; %do not use this manually
            case 'savedata'   %REPEATED FROM CALIBRATEARM case,
                casesavedata; %DO NOT USE THIS!
            case 'collectarmsamples'  %collects arm samples
                casecollectarmsamples;
            case 'collectarmabsolute'  %collect joint absolute and potentiometer values and saves
                casecollectarmabsolute;
            case 'testrefshow'   %mapping problem testing
                casetestrefshow_try2;
            case 'test_mytriangulation'
                casetest_mytriangulation;
            case 'algorithm1'
                casealgorithm1;
            %case 'getabsolutepos' obsolete: now in, calibratearm
            %    casegetabsolutepos;   %gets absolute position of joints
            case {'arduinoIMAG','arduinoDLTA','arduinoBUFF','arduinoisOK'}
                casearduino;     
            case 'arduinoIMAGcon'
                casearduinoimagcon;
            case 'collectopticalsamples'
                casecollectopticalsamples;

            otherwise
                'Warning: undefined state in main stream'
        end %switch
    catch ERR1
        ERR1.message
        ERR1.stack.line
        ERR1.stack.file
        exit=1;
    end
end %while

%%
%shutdown

%shutdown all video objects
if skip.video==0
    for i=size(vid,2):-1:1
        stoppreview(vid(i));
        closepreview(vid(i));
        stop(vid(i));
        delete(vid(i));
    end
end

%shutdown serial
if skip.arduino==0
    
    %arduino
    fclose(s1);
    delete(s1);
end

if skip.mbed==0
    %mbed
    for i=1:2
        try
        fclose(m2s(i));
        delete(m2s(i));
        end
    end
    
end


%save params only here if stable code, otherwise they are saved at each
%main change, slowing down the code
if codeparams.stable==1;
    save('_calibration.mat','calibparamsarr');
    save('_armcalib.mat','armparamsarr');
    save('_opticalsamples','opticalsamples');
    save('_visionsamples.mat','visionsamples');
    save('_extrinsicparams.mat','extrinsicparamsarr');
end


close all
