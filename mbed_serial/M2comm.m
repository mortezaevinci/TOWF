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
   % hex2dec(ammount);
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
            
            cnt=cnt+1;
            switch cnt
                case 1
                    if isempty(strfind(response,M2order))
                        ack=0; %failed
                        
                        'Command not sent properly'
                        %break;
                    end
                case 2
                    if M2order(1)=='S' %Sending
                    if ~strcmp(response,[command ammount])
                        ack=0; %failed
                        ['Warning: Send command not the same as received ' response '~=' command ' ' ammount]
                        %break;
                    end
                    else %receiving
                        M2data.sendata.raw=response;
                        
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