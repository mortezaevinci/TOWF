function [statecur,statem]=extractstate(statem)
if isempty(statem)
statecur={'','',0};    
else
statecur=statem(1,:);
end

if numel(statem)>1
statem=statem(2:end,:);
else
statem=[];
end

end