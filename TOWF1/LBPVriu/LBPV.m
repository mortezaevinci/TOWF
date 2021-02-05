function result = LBPV(I,R,P,MAP)
%returns the local binary pattern variance histogram 

[ysize xsize] = size(I);
d_image = double(I);

% Get LBP value for each pixel of the input image
LBPMap = lbp(I,R,P,MAP,'x');  

zerop=zeros(P,2);
for i = 1:P
    zerop(i,1) = -R*sin((i-1)*2*pi/P);
    zerop(i,2) = R*cos((i-1)*2*pi/P);
end
miny=min(zerop(:,1));
maxy=max(zerop(:,1));
minx=min(zerop(:,2));
maxx=max(zerop(:,2));
%origin in the block
origy=1-floor(min(miny,0));
origx=1-floor(min(minx,0));
blocksizey=ceil(max(maxy,0))-floor(min(miny,0))+1;
blocksizex=ceil(max(maxx,0))-floor(min(minx,0))+1;

dx = xsize - blocksizex;
dy = ysize - blocksizey;

for i = 1:P
  y = zerop(i,1)+origy;
  x = zerop(i,2)+origx;
  fy = floor(y); cy = ceil(y); ry = round(y);
  fx = floor(x); cx = ceil(x); rx = round(x);

  if (abs(x - rx) < 1e-6) && (abs(y - ry) < 1e-6)
    % use original datatypes
    T = d_image(ry:ry+dy,rx:rx+dx);
 
    convertedarr(:,i) = reshape(T,prod(size(T)),1); 
  else
    % use double type images 
    ty = y - fy;
    tx = x - fx;

  % Compute interpolated pixel values
    w1 = (1-tx)*(1-ty);
    w2 = tx*(1-ty);
    w3 = (1-tx)*ty;
    w4 = tx*ty;
   
    T = w1*d_image(fy:fy+dy,fx:fx+dx)+w2*d_image(fy:fy+dy,cx:cx+dx)+w3*d_image(cy:cy+dy,fx:fx+dx)+w4*d_image(cy:cy+dy,cx:cx+dx);
    
    convertedarr(:,i) = reshape(T,prod(size(T)),1);
  end  
end

%compute variance for the image
VAR = var(convertedarr,1,2);
VAR = reshape(VAR,size(T));

MapNum = max(MAP(:));

% Initialize the result matrix with zeros.
result=zeros(1,MapNum+1);
for k=0:MapNum;
    index = find(LBPMap==k);
    result(k+1) = sum(VAR(index));
end