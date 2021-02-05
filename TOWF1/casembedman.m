if isempty(statecur{2})

component='76' %default component
while(~isempty(component))
    
    component=input('component: ','s');
    
    if ~isempty(component)
    command=input('command: ','s');
    ammount=input('ammount: ','s');
    ack=0;
    
    M2data1=M2commforce(m2s(statecur{3}),component,command,ammount);
    
    
    if ~isempty(M2data1.sendata.raw) 
         M2data1=generatesendetail(M2data1);
        
         M2data1.sendata     
    end
    
           if numel(M2data1.jointdata.raw)==28
           M2data1.jointdata.raw
            for ii=(0:6)*4+1
              if M2data1.jointdata.raw(ii)~='-'
              armparamsarr{statecur{3}}.M2data{ii}.sendata.jointpos=M2data1.jointdata.raw(ii:(ii+3));
              end
            end
        end   
    
    end
end


else
    
      ack=0;
    
      remain=statecur{2};
      [ccomponent,remain]=strtok(remain,' ');
      remain=strtrim(remain);
      [command,remain]=strtok(remain,' ');
      remain=strtrim(remain);
      [ammount,remain]=strtok(remain,' ');
      remain=strtrim(remain);
      
      
    M2data1=M2commforce(m2s(statecur{3}),component,command,ammount);
    
    
    if ~isempty(M2data1.sendata.raw) 
         M2data1=generatesendetail(M2data1);
        
         M2data1.sendata     
    end
    
       if numel(M2data1.jointdata.raw)==28
           M2data1.jointdata.raw
            for ii=(0:6)*4+1
              if M2data1.jointdata.raw(ii)~='-'
              armparamsarr{statecur{3}}.M2data{ii}.sendata.jointpos=M2data1.jointdata.raw(ii:(ii+4));
              end
            end
        end
    
end
    