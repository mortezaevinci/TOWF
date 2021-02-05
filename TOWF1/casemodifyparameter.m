if isempty(statecur{2})
    
while(1)
    try
paramname=input('Parameter name: ([]=finished)','s');
if isempty(paramname)
    break;
end
paramvalue=input('Parameter value: ','s');
eval([paramname '=' paramvalue ';']);
    catch ERRlocal
        ERRlocal.message
    end
end


else
    
    eval(statecur{2});
    
end