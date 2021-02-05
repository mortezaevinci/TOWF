tic

camnumber=2;%replace with statecur{3}

towelanalysis{camnumber}.canny1=edge(imcap{camnumber}.capgray,'canny',.1,2);   %best works, .2, 1 for green, works .05,1 for blue
towelanalysis{camnumber}.cannytowel1=towelanalysis{camnumber}.canny1 & towelanalysis{camnumber}.towelarea;


[d,l]=bwdist(towelanalysis{camnumber}.cannytowel1);
se = strel('square',3);
d2 = imdilate(d,se);
d_localmax=(d2==d).*d;
towelanalysis{camnumber}.betweentwoedge=d_localmax<8 & d_localmax>2; %this 8, value, should get correlated with focus, or general distance to towel

hh{1}=[0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 1 1 0;
       0 0 0 0 1 1 1;
       0 0 0 0 0 1 1];
   
hg{1}=[1 1 0 0 0 0 0;
       1 1 1 0 0 0 0;
       0 1 1 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0];
 
hh{2}=[0 0 0 0 0 1 1;
       0 0 0 0 1 1 1;
       0 0 0 0 1 1 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0];
   
hg{2}=hh{2}';
   
hh{3}=[0 0 1 1 1 0 0;
       0 0 0 1 0 0 0;
       0 0 0 1 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0];
   
hg{3}=[0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 1 0 0 0;
       0 0 0 1 0 0 0;
       0 0 1 1 1 0 0]; 
   
hh{4}=hh{3}';
hg{4}=hg{3}';

  for iii=1:4
  imh=imfilter(towelanalysis{camnumber}.betweentwoedge,hh{iii});
  img=imfilter(towelanalysis{camnumber}.betweentwoedge,hg{iii});
  towelanalysis{camnumber}.betweentwoedge=towelanalysis{camnumber}.betweentwoedge | (imh &img);
  end
 towelanalysis{camnumber}.betweentwoedge=bwmorph(towelanalysis{camnumber}.betweentwoedge,'thin');


[H,T,R] = hough(towelanalysis{camnumber}.betweentwoedge);
P  = houghpeaks(H,5,'threshold',ceil(0.1*max(H(:))));

lines=[];

length0=100;
while ~isfield(lines,'point1') && length0>0 
  lines = houghlines(towelanalysis{camnumber}.betweentwoedge,T,R,P,'FillGap',20,'MinLength',length0);  
  length0=floor(length0*.8);
end

figure, imshow(imcap{camnumber}.caprgb), hold on

if length0>0
%plotting...


max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');


end

%finding corner around the selected edges
dilatesize=8;
se = strel('disk',openclosesize);
towelanalysis{camnumber}.betweentwoedge_dilate = imdilate(towelanalysis{camnumber}.betweentwoedge,se);
 
% vv=fspecial('gaussian',[21 1],10);
% cc0=corner(towelanalysis{camnumber}.capgray,'harris','FilterCoefficients',vv,'QualityLevel',.01,'SensitivityFactor',.245);

% [cim crow ccol]=harris(towelanalysis{camnumber}.capgray,5,20,5);
% cc0=[ccol crow];

cc0=corner_curve(imcap{camnumber}.capgray,towelanalysis{camnumber}.cannytowel1,1,120,10,[],[],1,40);
cc0=[cc0(:,2) cc0(:,1)];

cc1=[];
for ci=1:size(cc0,1)
   if towelanalysis{camnumber}.betweentwoedge_dilate(cc0(ci,2),cc0(ci,1))>0
    cc1=[cc1;cc0(ci,:)];
   end
end

if ~isempty(cc1)
plot(cc1(:,1),cc1(:,2),'c+')
end


toc