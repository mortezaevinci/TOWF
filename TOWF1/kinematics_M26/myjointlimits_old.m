function  q=myjointlimits(q)
   if q(3)<0
      q(3)=q(3)+pi;
      q(4)=-q(4);
      if q(5)<0
       q(5)=q(5)+pi;
      else
          q(5)=q(5)-pi;
      end
   end

   if q(4)<0   %what the fuck!
      q(6)=-q(6); 
       
   end
end