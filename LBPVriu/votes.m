function [winner, mindex]=votes(trainClassIDs, index,dissim)
  tempmat=[]; %[candidate vote;]
  remainvote=1;
  rate=numel(index)-1;
  for ii=1:numel(index)
      vote=remainvote/rate/dissim(ii);
      remainvote=remainvote*(rate-1)/rate;
      if isempty(tempmat)
          findex=[];
      else
      findex=find(tempmat(:,1)==trainClassIDs(index(ii)));
      end
      
      if isempty(findex)
         tempmat=[tempmat; [trainClassIDs(index(ii)) vote]];
      else 
         tempmat(findex,2)=tempmat(findex,2)+vote;
      end
  end
  
  [maxt,mindex]=max(tempmat(:,2));
  winner=tempmat(mindex,1);
end