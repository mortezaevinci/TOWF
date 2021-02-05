
armanalysis{2}.pinky=(imcap{1,2}.caprgb(:,:,1)>imcap{1,2}.caprgb(:,:,2)*1.4)&(imcap{1,2}.caprgb(:,:,1)>imcap{1,2}.caprgb(:,:,3)*1.1);

armanalysis{2}.pinky=medfilt2(armanalysis{1,2}.pinky,[7 7]);

%imshow(armanalysis{1,2}.pinky)

imshow(imcap{2}.caprgb)

rstats=regionprops(armanalysis{1,2}.pinky,'centroid');
pcentroid=mean(cat(1,rstats.Centroid));   %estimated center

hold on
plot(pcentroid(1),pcentroid(2),'r+'); 

