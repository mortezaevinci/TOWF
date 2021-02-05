 function cl=newfig(src,evnt)
   if strcmp(get(src,'SelectionType'),'alt')
      cl=1;
   else
      cl=0;
   end
end