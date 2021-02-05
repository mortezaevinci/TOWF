% Author :Sreeram Mohan
%   Tested with arduino Duemilanove 
%   Open source software for the arduino duemilanove !
%   Feel free to use and suggest updates !!!!
clear all;
%reset all serial
try
fclose(instrfind);
delete(instrfind);
catch
    
end

s1 = serial('COM5');                            %define serial port
s1.BaudRate=115200;                               %define baud rate
s1.Timeout=.2;
%open serial port
fopen(s1);
          
pause(1);
stop=false;

cnt=0;
imagedata=zeros(18*18);

scrsz = get(0,'ScreenSize');
h=figure(1);
while(stop==false)                                %acquisition of 100 points
      try
          hexdata='';
          cnt=0;
          
          fprintf(s1,'%s','I2'); %send command
          
pause(.5);
            while (~strcmp(hexdata,'END_'))
              
              if (numel(hexdata)==4)
                   cnt=cnt+1;
                   imagedata(cnt)=hex2dec(hexdata(3:4));
              else
                 %break
              end
                  
         
          %decvect=hex2dec_ptbypt(hexdata);
          %imagedata(1,:)=decvect(1:18);   %%%later one shuld control the decvect to ALWAYS give 18 numbers out
          %%% the "starting" bit is probably there for now (WRONG DATA)
               if cnt==324  
                         
              imm=reshape(imagedata(1:324),18,18);
        
             hold on
              imshow(imm./max(max(imm)));
              hold off
              cnt=0;
              drawnow
              break;
               end
              
              %s1
              if s1.BytesAvailable>0 
                
                  hexdata=fscanf(s1,'%s',4)
              end
                  
            end
         
              if cnt~=324
                  'invalid data'
              end
 
      catch ERR1
        if strcmp(ERR1.identifier,'MATLAB:hex2dec:IllegalHexadecimal')
            
        else
        stop=true;
        end
    end
end
ERR1.message

% close the serial port!
fclose(s1);  
delete(s1);