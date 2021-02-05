function [ map r c ] = SUSAN( I,masksize )
%SUSAN Corner detection

maskSz = [masksize masksize];
mask = getnhood(strel('disk',(masksize+1)/2));
fun = @(I)SF(I,mask);
map = nlfilter(I,maskSz,fun);
[r c] = find(map);

end

function res = SF(I,mask)

threshg1 = (nnz(mask)-1)*.2;
threshg2 = (nnz(mask)-1)*.4;
threshg3 = (nnz(mask)-1)*.4;
thT = .07;
thT1 = .04;

sz = size(I,1);
usan = ones(sz)*I(round(sz/2),round(sz/2));

similar = (abs(usan-I)<thT);
similar = similar.*mask;
res = sum(similar(:));
if res < threshg1
	dark = nnz((I-usan<-thT1).*mask);
	bright = nnz((I-usan>thT1).*mask);
	res = min(dark,bright)<threshg2 && max(dark,bright)>threshg3;

else
	res = 0;
end

end
