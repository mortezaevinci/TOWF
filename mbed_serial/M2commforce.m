function M2data=M2commforce(s1,component,command,ammount,nocheck)
if nargin<5
    nocheck=0;
end

M2data.ack=0;  

for i=1:5
    M2data=M2comm(s1,component,command,ammount,nocheck);
    
    if M2data.ack~=0
        break;
    end
end
  
end