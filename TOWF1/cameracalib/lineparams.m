function linep=lineparams(point0,point1)
%point=[x;y]
%linep includes a,b,c where ax+by+c=0
linep.a=1;
linep.b=(point0(1)-point1(1))/(point1(2)-point0(2));
linep.c=(point1(1)-point0(1))/(point1(2)-point0(2))*point0(2)-point0(1);

end