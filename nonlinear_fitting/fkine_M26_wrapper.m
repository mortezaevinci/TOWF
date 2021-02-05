function X=fkine_wrapper_M26(x,xdata)
 for ii=1:size(xdata,2)
     xparams=fkine_fun_M26(xdata(1:6,ii),xdata(7:12,ii),x(:,1),x(:,2));
     xparams=xparams(1:3,:);
  X(:,ii)=reshape(xparams,12,1);
 end

end