function [winner, mindex]=calcwinner(trainClassIDs, index,dissim)
  temp=[]; %[candidate decision;]
  remaineddecision=1;
  rate=numel(index)-1;
  for ii=1:numel(index)
      decision=remaineddecision/rate/dissim(ii);
      remaineddecision=remaineddecision*(rate-1)/rate;
      if isempty(temp)
          findex=[];
      else
      findex=find(temp(:,1)==trainClassIDs(index(ii)));
      end
      
      if isempty(findex)
         temp=[temp; [trainClassIDs(index(ii)) decision]];
      else 
         temp(findex,2)=temp(findex,2)+decision;
      end
  end
  
  [maxt,mindex]=max(temp(:,2));
  winner=temp(mindex,1);
end