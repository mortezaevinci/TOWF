function dxdq=Jacob_wrapper(x,xdata,noq)
 for ii=1:size(xdata,2)
  dxdq(:,ii)=Jacob_fun(xdata(1,ii),xdata(2:end,ii),x(:,1),x(:,2));
 end

end