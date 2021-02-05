camnum=2;


armanalysis{camnum}.pinky=(imcap{camnum}.caphsv(:,:,1)>0.95)&(imcap{camnum}.caphsv(:,:,2)>.3)&(imcap{camnum}.caphsv(:,:,3)<.8);

armanalysis{camnum}.pinky=medfilt2(armanalysis{camnum}.pinky,[5 5]);

imshow(armanalysis{1,2}.pinky)

%imshow(imcap{camnum}.caprgb)

rstats=regionprops(armanalysis{camnum}.pinky,'centroid');
pcentroid=mean(cat(1,rstats.Centroid));   %estimated center

hold on
plot(pcentroid(1),pcentroid(2),'r+'); 

