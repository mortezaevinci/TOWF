load '_visionsamples.mat';


nn=numel(visionsamples.camindex);

for ii=1:nn
    ii
    I=visionsamples.towelanalysis{ii}.capgray;
    imshow(I)
    
    [x,y,but1]=ginput(1);
    while but1~=3
    'select the center of a window to be sampled...'
    
    
if isfield(visionsamples.towelanalysis{ii},'areasample_edge')
   ind=numel(visionsamples.towelanalysis{ii}.areasample_edge);
   newind=ind+1;
else
   newind=1;
end
    
if y<21 || y>460 || x<21 || x>620
    
    
else

    visionsamples.towelanalysis{ii}.areasample31{newind}=I((y-15):(y+15),(x-15):(x+15));
    visionsamples.towelanalysis{ii}.areasample41{newind}=I((y-20):(y+20),(x-20):(x+20));    
    
    edge0=input('is it an edge? (1=edge, 0=middle) ');
    visionsamples.towelanalysis{ii}.areasample_edge(newind)=edge0;
end
    
    [x,y,but1]=ginput(1);
    end
    
end


save('_visionsamples.mat','visionsamples');