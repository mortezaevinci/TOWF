function M2data=M2comm(serialobj,component,command,ammount,nocheck,quiet)


if nargin<5
    nocheck=0;
end

if nargin<6
    quiet=1;
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
    %hex2dec(component); %might be q
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
   
    %pause(.005);
   
    for i=1:10
     
        %pause(.001);
      
        if serialobj.BytesAvailable>0
            
            response=fscanf(serialobj,'%s');
            
            
            if nocheck
                response
            end
                response       
            cnt=cnt+1;
            if quiet==1
                if M2order(1)=='S'
                cnt=3;
                elseif M2order(1)=='R' %receiving
                    if cnt==1
                        cnt=2;
                    end
                end
            end
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
                    
                    if M2order(1)=='S' %Sending
                    if ~strcmp(response,[command ammount])
                        ack=0; %failed
                        ['Warning: Send command not the same as received: ' response '~=' command ' ' ammount]
                        %break;
                    end
                    elseif M2order(1)=='R' %receiving
                        M2data.sendata.raw=response;
                       ack=0;                                  
                    end
                    
                                  
                                        
                   
                    
                case 3
                    if strcmp(response,'ack') || strcmp(response,'Quietmode')
                        ack=1;
                      %  'ack received'
                    else
                       % 'ack not received'
                        ack=0;
                          %for now if ack is receive, it is assumed the
                          %command is sent properly.
                        
                    end
                otherwise
                       'received unrecognized data'
                   
            end
            
        end
        if ack==1; break;end
    end
        
end 
  
    M2data.ack=ack;
   

    
end