
clear all;

%reset all serial
try
fclose(instrfind);
delete(instrfind);
catch
    
end

s1 = serial('COM5');                            %define serial port
s1.BaudRate=115200;                               %define baud rate
s1.Timeout=.5;
s1.InputBufferSize=2048;
%open serial port
fopen(s1);
          
pause(1);  %won't be needed in the final code, as this is initialization
stop=false;

statem='I2';
stateprev='';
stateERR=0;

dxdy=[0 0];
adata='';
imm=zeros(18,18);

imagefull=zeros(500,500);
curpos=[250 250];

scrsz = get(0,'ScreenSize');
h1=figure(1);
h2=figure(2);
while(stop==false)                                %acquisition of 100 points
      try
          %statem
          %numel(imagedata)
          %s1
          %clear buffer (better way?)
          %dxdy
          if s1.BytesAvailable
          fscanf(s1,'%c',s1.BytesAvailable);
          end
          
          switch statem
              case 'I2'
                  
                %  tic;
                %send command
                  fprintf(s1,'%c','I2'); %send command
                  statem='isOK';
                  stateprev='I2';
                  
              case 'D2'
                %send command
                  fprintf(s1,'%c','D2'); %send command
                  statem='isOK';
                  stateprev='D2';
                  
               case 'isOK'
                  %wait for acknowledgement
                  cdata=fscanf(s1,'%c',3);
                  if strcmp(cdata,'_OK')
                      if stateprev=='I2'
                          statem='D2';
                      elseif stateprev=='D2';
                              statem='F2';
                      end
                     
                      stateERR=0;
                  elseif strcmp(cdata,'NOK')
                      statem=stateprev;
                  else
                      statem='isOK';
                      stateERR=stateERR+1;
                  end
          
            case 'F2'
                 
                  fprintf(s1,'%c','F2'); %send command

                  for i=1:10
                  pause (.02);
                  %s1.BytesAvailable
                 if (s1.BytesAvailable==326 )
                       adata=fscanf(s1,'%c',324);
                       dxdy=double((fscanf(s1,'%c',2)));
                       if numel(dxdy)~=2
                          dxdy=[0 0]; 
                       end
                       
                       for j=1:2
                       if bitget(dxdy(j),8)==1
                          dxdy(j)=-double(bitcmp(uint8(dxdy(j)))+1);
                       end
                       end
                       
                       if ~isempty(adata)
                       adata=double(adata);
                       adata=bitand(adata,63); %the rest are control bits
                       imm=reshape(adata(1:324),18,18);
                       statem='Figure';
                       stateprev='F2';
                       break;
                       end
                 end

                  end
                              
           case 'Figure'
              %if numel(imagedata)==324 

                  %imm=reshape(imagedata(1:324),18,18);
               curpos=curpos+[dxdy(2) dxdy(1)];
               for j=1:2
                  if curpos(j)<1
                      curpos(j)=1;
                  end
                  if curpos(j)>500-18
                      curpos(j)=500-18;
                  end
                   
               end
               
               imm=imm./max(max(imm));
               imagefull(curpos(1):(curpos(1)+17),curpos(2):(curpos(2)+17))=imm;
                  
            %  toc
                   figure(1)
                  hold on
                   imshow(imm);
                   hold off
                   
                   drawnow
                  
%                    figure(2)
%                    hold on
%                    imshow(imagefull);
%                    hold off
%                    drawnow
                  %break;
             % else
             %    'invalid imagedata'
             %    numel(imagedata)
             % end
             statem='I2';
             
               stateERR=0;
              otherwise
                  
          end
        
          if stateERR>10
              statem='I2';
              stateERR=0;
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