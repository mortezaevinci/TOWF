try
fclose(instrfind);
delete(instrfind);
end

for i=1:2
m2s(i) = serial(['COM' num2str(5+i)]);                            %define serial port
m2s(i).BaudRate=115200;                               %define baud rate
m2s(i).Timeout=.2;
fopen(m2s(i)); %open serial port
end

component='76' %default component
while(~isempty(component))
    
    component=input('component: ','s');
    
    if ~isempty(component)
    command=input('command: ','s');
    ammount=input('ammount: ','s');
    ack=0;
    
    
    for i=1:2
    M2data(i)=M2commforce(m2s(i),component,command,ammount)
    end
    
    end
end

for i=1:2
fclose(m2s(i));
delete(m2s(i));
end