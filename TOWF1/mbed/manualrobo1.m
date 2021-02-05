try
fclose(instrfind);
delete(instrfind);
end

s1 = serial('COM7');                            %define serial port
s1.BaudRate=115200;                               %define baud rate
s1.Timeout=1;
fopen(s1); %open serial port

component='76' %default component
while(~isempty(component))
    
    component=input('component: ','s');
    
    if ~isempty(component)
    command=input('command: ','s');
    ammount=input('ammount: ','s');
    ack=0;
    
    
    
    M2data1=M2commforce(s1,component,command,ammount,0);
    
    
    if ~isempty(M2data1.sendata.raw) 
         M2data1=generatesendetail(M2data1);
        
         M2data1.sendata     
    end
    
       
    end
end


fclose(s1);
delete(s1);