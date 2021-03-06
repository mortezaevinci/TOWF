function M2data=M2comm(serialobj,component,command,ammount,nocheck)

if nargin<5
    nocheck=0;
end




M2data.ack=0;
M2data.sendata.raw='';
if isempty(ammount)

        M2order='Receiving';
        ammount='0000'; %just for lazy coding!
        fullcommand=[component ' ' command];
else
            M2order='Sending'; 
            
            if ammount(1)=='-'
                ammount=dec2hex(bitcmp(str2num(ammount(2:end)),8)+1);
            end
            
            fullcommand=[component ' ' command ' ' ammount];
end

ack=1;


try
    hex2dec(component);
    hex2dec(command);
   % hex2dec(ammount);   %this can be multiples space-separated bytes...
   % fix this later for safety
catch
   'incorrect command'
   ack=0;
   
end


if ack==1
    
     
    try
        fprintf(serialobj,'%s\n',fullcommand);
    end
    
    ack=1;
    
    cnt=0;
    for i=1:10
        pause(.03);
        if serialobj.BytesAvailable>0
            response=fscanf(serialobj,'%s');
            
            if nocheck
                response
            end
            response
            
            cnt=cnt+1
            switch cnt
                case 1
                    if isempty(strfind(response,M2order))
                        if ~isempty(strfind(response,'Enter'))
                        ['ignoring modified mbed communication protocol: ' response]
                        cnt=cnt-1;
                        
                        else
                        ack=0; %failed
                        
                        'Command not sent properly'
                        end
                        %break;
                    end
                case 2
                    if isempty(strcmp(response,'Enter'))
                    if M2order(1)=='S' %Sending
                    if ~strcmp(response,[command ammount])
                        ack=0; %failed
                        ['Warning: Send command not the same as received: ' response '~=' command ' ' ammount]
                        %break;
                    end
                    elseif M2order(1)=='R' %receiving
                        M2data.sendata.raw=response;
                                                          
                    end
                    
                    elseif ~isempty(strcmp(response,'ack'))
                        cnt=cnt+1;
                         if ~strcmp(response,'ack')
                        ack=0;
                        'ack not received'
                    else
                        'ack received'
                        ack=1;
                        
                        
                        
                          %for now if ack is receive, it is assumed the
                          %command is sent properly.
                        
                    end
                        
                    else
                    
                      ['ignoring modified mbed communication protocol: ' response]
                        cnt=cnt-1;
                        
                    end
                    
                case 3
                    if ~strcmp(response,'ack')
                        ack=0;
                        'ack not received'
                    else
                        'ack received'
                        ack=1;
                          %for now if ack is receive, it is assumed the
                          %command is sent properly.
                        
                    end
                otherwise
                       'received unrecognized data'
                    break;
            end
            
        end
        
    end
    
end 
  
    M2data.ack=ack;
    
end