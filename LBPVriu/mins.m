function [dissim index]=mins(DM,num)
for ii=1:num
   [dissim(ii), index(ii)]= min(DM);
   DM=[DM(1:(index(ii)-1)) DM((index(ii)+1):end)]; 
end


end