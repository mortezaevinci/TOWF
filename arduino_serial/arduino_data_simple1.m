s1 = serial('COM5');                            %define serial port
s1.BaudRate=57600;                               %define baud rate
s1.Timeout=.5;
%open serial port
fopen(s1);
          
pause(1);  %won't be needed in the final code, as this is initialization
stop=false;


while(stop==false)                                %acquisition of 100 points
      try
          
          
          fprintf(s1,'%s','I2'); %send command
          
          data=fscanf(s1,'%c',2)
          data2=fscanf(s1,'%c',1)
          
          
          catch ERR1
        if strcmp(ERR1.identifier,'MATLAB:hex2dec:IllegalHexadecimal')
            
        else
        stop=true;
        end
   end 
end
ERR1.message

% close the serial port!
fclose(s1);  
delete(s1);