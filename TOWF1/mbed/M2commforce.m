function M2data=M2commforce(s1,component,command,ammount,nocheck)
if nargin<5
    nocheck=0;
end

M2data.ack=0;

while s1.bytesavailable>0
    fscanf(s1,'%s');
end

for i=1:1
    
    M2data=M2comm(s1,component,command,ammount,nocheck);
    
    if M2data.ack~=0
        
        break;
    end
end

if M2data.ack==0
    disp( 'WARNING: command sent unsuccessfully')
end

end