try
fclose(instrfind);
delete(instrfind);
end

s1 = serial('COM7');                            %define serial port
s1.BaudRate=115200;                               %define baud rate
s1.Timeout=1;
fopen(s1); %open serial port



              
while(~isempty(fullcommandparts))
    
       component=fullcommandparts{1,1};
       command=fullcommandparts{1,2};
       ammount=fullcommandparts{1,3};
       pausetime=fullcommandparts{1,4};
       fullcommandparts=fullcommandparts(2:end,:);
   
       pause(pausetime);
       
       M2data1=M2commforce(s1,component,command,ammount);
      
    
end


fclose(s1);
delete(s1);