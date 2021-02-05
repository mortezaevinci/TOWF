%statecur{2} example ='13579bd' to represet 7"1" 7"3" 75 77 79 7b 7d

components=['71';'73';'75';'77';'79';'7b';'7d'];

stateget1MD=cell(0);

if ~isempty(statecur{2})
    
    %previous value remains still
  
   currentcomponent=statecur{2}(1);
   statecur{2}=statecur{2}(2:end);
   cind=find(components(:,2)'==currentcomponent);
   if ~isempty(cind)
       stateget1MD=[{'pos2mbedparams',components(cind,:),statecur{3}};
                {'savemdata',cind,statecur{3}}];
               
       
   end
    stateGETMDATA={'getMdata',statecur{2},statecur{3}};
          
else
    stateGETMDATA=cell(0);
    

    if codeparams.stable==0; save('_armcalib.mat','armparamsarr');end
     
end


  


statem=[stateget1MD;stateGETMDATA;statem];
