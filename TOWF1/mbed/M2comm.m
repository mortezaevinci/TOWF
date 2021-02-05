function M2data=M2comm(serialobj,component,command,ammount,nocheck)

%WARNING: should be always in quiet mode
%very compact version to reduce the time of the overhead

if nargin<5
    nocheck=0;
end

M2data.ack=0;
M2data.sendata.raw='';
M2data.jointdata.raw='';

if isempty(ammount)
    
    if  isempty(command)
        fullcommand=component;
    else
        fullcommand=[component ' ' command];
    end
else
    %   if ammount(1)=='-'
    %       ammount=dec2hex(bitcmp(str2num(ammount(2:end)),8)+1);
    %   end
    
    fullcommand=[component ' ' command ' ' ammount];
end



backsignal=0;


try
    %hex2dec(component); %might be q
    hex2dec(command);
    % hex2dec(ammount);   %this can be multiples space-separated bytes...
    % fix this later for safety
catch
    'incorrect command'
    return;
    
end


try
    fprintf(serialobj,'%s\n',fullcommand);
end


%pause(.005);
tic
tt=0;

while (serialobj.BytesAvailable<2 && tt<.025)
        
        response=fscanf(serialobj,'%s');
        
        
        if nocheck
            response
        end
        
        
        if strcmp(response,'ack') || strcmp(response,'Quietmode') || strcmp(response,'done')
            backsignal=1;
            %  'ack received'
            
            
        elseif strcmp(response,'nack')
            % 'ack not received'
            backsignal=-1;
            %for now if ack is receive, it is assumed the
            %command is sent properly.
        else
            if component(1)=='v'
            M2data.jointdata.raw=response; 
            backsignal=1;
            else
            %data
            M2data.sendata.raw=response;
            backsignal=1;
            end
        end
        
        tt=toc;
        if backsignal~=0; break;end
end
    


if backsignal==1
    M2data.ack=1;
end


end