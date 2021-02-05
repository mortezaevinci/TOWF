repeat=[];
cnt=0;

while(isempty(repeat))
goodresults=0;
    
mycalculateextrinsic;
      
if (goodresults==1)|(cnt>3)
    cnt=0;
repeat=input('both origins on the bottom-left? (other=yes, []=no)');
else
    repeat=[];
    cnt=cnt+1;
end


end