      %to start set state='arduinoIMAG' or 'arduinoDLTA'
        %it will automatically, continue with arduinoBUFF and arduinoISOK
        %use double value 1 or 2 for mouse1 or mouse2



%empty buffer, should be empty usually
if s1.BytesAvailable
          fscanf(s1,'%c',s1.BytesAvailable);
end
          
     


astatem=[statecur{1}(8:11)];
astateprev=statecur{2};


dxdy{statecur{3}}=[0 0];
adata='';

          
          switch astatem
              case 'IMAG'
                  astateERR=0;
                %  tic;
                %send command
                
                  fprintf(s1,'%c',['I' num2str(statecur{3})]); %send command
                
                  astatem='isOK';
                  astateprev='IMAG';
                  
              case 'DLTA'
                  astateERR=0;
                %send command
                
                  fprintf(s1,'%c',['D' num2str(statecur{3})]); %send command
                
                  astatem='isOK';
                  astateprev='DLTA';
                  
               case 'isOK'
                  %wait for acknowledgement
                  cdata=fscanf(s1,'%c',3);
                  if strcmp(cdata,'_OK')
                      if astateprev=='IMAG'
                          astatem='DLTA';
                      elseif astateprev=='DLTA';
                              astatem='BUFF';
                      end
                     
                      astateERR=0;
                  elseif strcmp(cdata,'NOK')
                      astatem=astateprev;
                  else
                      if astateERR<5
                      astatem='isOK';
                      astateERR=astateERR+1;
                      else
                          astatem=[];
                      end
                  end
          
            case 'BUFF'
                 
                  fprintf(s1,'%c',['F' num2str(statecur{3})]); %send command
pause (.02);
                  for i=1:10
                  
                  %s1.BytesAvailable
                 if (s1.BytesAvailable==326 )
                       adata=fscanf(s1,'%c',324);
                       dxdy{statecur{3}}=double((fscanf(s1,'%c',2)));
                       if numel(dxdy{statecur{3}})~=2
                          dxdy{statecur{3}}=[0 0]; 
                       end
                       
                       for j=1:2
                       if bitget(dxdy{statecur{3}}(j),8)==1
                          dxdy{statecur{3}}(j)=-double(bitcmp(uint8(dxdy{statecur{3}}(j)))+1);
                       end
                       end
                       
                       if ~isempty(adata)
                           if numel(adata)==324
                       adata=double(adata);
                       adata=bitand(adata,63); %the rest are control bits
                       imm{statecur{3}}=reshape(adata(1:324),18,18);
                       
                       astateERR=0;
                       
                       astatem='';   %it was 'FIGU' before
                       astateprev='BUFF';
                       break;
                           else
                              astateERR=0;
                              astatem='IMAG';
                              astateprev='';
                           end
                       end
                 end

                  end
          
          case 'FIGU'   %DO NOT USE THIS HERE, DO FIGURE IN MAIN
      
%                curpos=curpos+[dxdy(2) dxdy(1)];
%                for j=1:2
%                   if curpos(j)<1
%                       curpos(j)=1;
%                   end
%                   if curpos(j)>500-18
%                       curpos(j)=500-18;
%                   end
%                    
%                end
               
      %         imm=imm./max(max(imm));
      %         imagefull(curpos(1):(curpos(1)+17),curpos(2):(curpos(2)+17))=imm;
                  
         
      %             figure(1)
      %            hold on
      %             imshow(imm);
      %             hold off
                   
      %             drawnow
                  

      %       astatem='I2';
             
               astateERR=0;
              otherwise
               'Warning: undefined case in arduino stream'   
          end %switch
        
          if astateERR>5
              astatem='IMAG';
              astateERR=0;
          end
          
if ~isempty(astatem)
statem=[{['arduino' astatem],astateprev,statecur{3}}; statem];
end
