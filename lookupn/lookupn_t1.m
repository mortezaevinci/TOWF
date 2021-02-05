clc

x=[.1 .1 .1 .3 .5 .3];

xi=randn(100,6);

tic
ti=delaunayn(xi);
toc

tic
d=dsearchn(xi,ti,x)
%xi(d,:)
toc


x=[0 0 0 0 0 0];
tic
d=dsearchn(xi,ti,x)
%xi(d,:)
toc