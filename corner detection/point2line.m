function distance=point2line(point,linep)
%line is in the form of line.a, b,c where ax+by+c=0;
%point=[x;y];
distance=abs(linep.a*point(1)+linep.b*point(2)+linep.c)/sqrt(linep.a^2+linep.b^2);


end