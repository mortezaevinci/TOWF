


%%
%general initialization

clc;
clear all;

%reset camera devices


%reset all serial
try
fclose(instrfind);
delete(instrfind);
   
end

%%
%constants
SMmanual={'manual','',double(0)};
SMinit={'init','',double(0)};
SMcalibparams={'calibratecamera','matfromfile',double(0)};
statem=[SMinit; SMcalibparams; SMmanual]; %columns of states, with [currentstate;datastring;datadouble]

exit=0;
waitidle=.05;

imm{1}=zeros(18,18);
imm{2}=zeros(18,18);
dxdy{1}=[0 0];
dxdy{2}=[0 0];

nx=640;
ny=480;

%initial calibparams
mycalibparams;
calibparams0=calibparams; %note calibparams is used as a temporary buffer
calibparamsarr{1}=calibparams0;
calibparamsarr{2}=calibparams0;

%skipping constants
skip.video=1;
skip.serial=1;
%%
%object initialization

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

%serial communication

%arduino
if skip.serial==0
s1 = serial('COM5');                            %define serial port
s1.BaudRate=115200;                               %define baud rate
s1.Timeout=.5;
s1.InputBufferSize=2048;
fopen(s1); %open serial port
end

pause(.1);
%%


%state machine

while (exit==0)
    try
        [statecur, statem]=extractstate(statem);
       statecur
switch statecur{1}
    case 'init'
        
    case '' %idle, user events
         pause(waitidle);
    case 'manual'  %asks for the next state
        casemanual;
    case 'calibratecamera' %stringdata='imagefromfile' 'matfromfile' or 'camera'
        casecalibratecamera;
    case 'calculateextrinsic'
        casecalculateextrinsic;
    case 'focus'
        %statecur([1,2,3])=state, focustype, cameraindex
        casefocus;
    case 'imshow' %use camera to show camera image, and mouse to show mouse sensor image... double value 1 or 2 for index
        caseimshow;
    case 'dtshow' %show data to the user
        casedtshow;
    case 'modifyparameter'
        casemodifyparameter;
    case 'dtsave'
        casesavecalibration;
    case {'arduinoIMAG','arduinoDLTA','arduinoBUFF','arduinoisOK'}  
        %to start set state='arduinoIMAG' or 'arduinoDLTA'
        %it will automatically, continue with arduinoBUFF
        %use double value 1 or 2 for mouse1 or mouse2
        casearduino;
    case 'exit'
        exit=1;
    otherwise
        'Warning: undefined state in main stream'
end %switch
    catch ERR1
           ERR1.message
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

if skip.serial==0
%shutdown serial
fclose(s1);
delete(s1);

end




