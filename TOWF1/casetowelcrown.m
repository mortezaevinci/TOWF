figure(20+statecur{3});


switch statecur{2}
    case 'manual'
%manual for now

[xx,yy]=ginput(1);


    case 'top'
        
      %[a,b]=towelanalysis{camnumber}.towelarea;
      rstats=regionprops(towelanalysis{statecur{3}}.towelarea,'BoundingBox');
      yy=ceil(rstats.BoundingBox(2))+1;
      [temps,inds]=find(towelanalysis{statecur{3}}.towelarea(yy,:)>0);
      xx=median(inds);
      
    case 'bottom'
      
      rstats=regionprops(towelanalysis{statecur{3}}.towelarea,'BoundingBox');
      yy=floor(rstats.BoundingBox(2))-1+floor(rstats.BoundingBox(4));
      [temps,inds]=find(towelanalysis{statecur{3}}.towelarea(yy,:)>0);
      xx=median(inds);    
    otherwise
        'incorrect case in towelcrown, xx and yy are set to zero';
        xx=0;yy=0;
end

hold on;
plot(xx,yy,'co');

Pc{statecur{3}}=[xx;yy];