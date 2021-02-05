clc
clear all

%%
%formulation



%%
%actual data

%a.*q+b=realq
B=.1;
A=.09;

%generate stochastic data in
for ii=1:100
Q{ii}=.5;
q{ii}=(Q{ii}-B)./A+rand(1,1).*.8;
DXDQ{ii}=Jacob_fun(1,q{ii},A,B);
end


%%
%estimation

x0=[.5 .5];
[x,resnorm,~,exitflag,output]=lsqcurvefit(@(x,xdata)Jacob_wrapper(x,xdata),x0,[ones(numel(cell2mat(q)),1) cell2mat(q)'],cell2mat(DXDQ)')
