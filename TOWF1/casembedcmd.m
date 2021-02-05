%%
%examples of commands

% fullcommandparts=[{'70','10','-64',0};
%                   {'72','10','-64',0};
%                   {'74','10','64',0};
%                   {'70','10','64',3};
%                   {'72','10','35',0};
%                   {'74','10','-64',0};
%                   {'70','10','0',3};
%                   {'72','10','0',0};
%                   {'74','10','0',0}];
%               
% fullcommandparts=[{'70','24','8000',0};
%                   {'72','24','8000',0};
%                   {'74','24','8000',0};
%                   {'76','24','8000',0};
%                   {'78','24','8000',0};
%                   {'7a','24','8000',0};
%                   {'7b','24','8000',0};
%                   {'70','24','ff00',5};
%                   {'72','24','ff00',0};
%                   {'74','24','ff00',0};
%                   {'00','10','0',5};
%                 ];

%%
  if m2s(statecur{3}).BytesAvailable>0
            
            dump=fscanf(m2s(statecur{3}),'%s');
  end

fullcommandparts=mbedparamsarr{statecur{3}}.fullcommandparts


while(~isempty(fullcommandparts))
    
       component=fullcommandparts{1,1};
       command=fullcommandparts{1,2};
       ammount=fullcommandparts{1,3};
       pausetime=fullcommandparts{1,4};
       fullcommandparts=fullcommandparts(2:end,:);
   
      pause(pausetime);
       %pause
       
       M2data1=M2commforce(m2s(statecur{3}),component,command,ammount);
      
       if M2data1.ack~=0
           
        if ~isempty(M2data1.sendata.raw) 
         M2data1=generatesendetail(M2data1);
        
          M2data1.sendata   
          mbedparamsarr{statecur{3}}.M2data=M2data1;
        end
       
     
           if numel(M2data1.jointdata.raw)==28
           M2data1.jointdata.raw
            for ii=(0:6)*4+1
              if M2data1.jointdata.raw(ii)~='-'
              armparamsarr{statecur{3}}.M2data{ii}.sendata.jointpos=M2data1.jointdata.raw(ii:(ii+3));
              end
            end
           elseif numel(M2data1.jointdata.raw)>0
               'warning: full Jdata not received'
               'press any key to ocntinue...'
               pause;
           end   
        
       end
end