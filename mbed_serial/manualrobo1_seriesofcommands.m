try
fclose(instrfind);
delete(instrfind);
end

s1 = serial('COM7');                            %define serial port
s1.BaudRate=115200;                               %define baud rate
s1.Timeout=1;
fopen(s1); %open serial port


fullcommandparts=[{'70','10','-64',0};
                  {'72','10','-64',0};
                  {'74','10','64',0};
                  {'70','10','64',3};
                  {'72','10','35',0};
                  {'74','10','-64',0};
                  {'70','10','0',3};
                  {'72','10','0',0};
                  {'74','10','0',0}];
              
fullcommandparts=[{'70','24','8000',0};
                  {'72','24','8000',0};
                  {'74','24','8000',0};
                  {'76','24','8000',0};
                  {'78','24','8000',0};
                  {'7a','24','8000',0};
                  {'7b','24','8000',0};
                  {'70','24','ff00',5};
                  {'72','24','ff00',0};
                  {'74','24','ff00',0};
                  {'00','10','0',5};
                ];
              
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