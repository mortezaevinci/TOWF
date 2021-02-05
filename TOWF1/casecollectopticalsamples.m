
load '_opticalsamples.mat'

if strcmp(statecur{2},'general')
distance=input('how close sensor is to towel (0-100, farthest=100): ');
blurquality=input('What is your insight about the blurry quality (0-100, 100 the best quality, 50=medium blurry, 0=off the distance limits): ');
type0=0;
else %fixed-window so far
    distance=20;
    blurquality=100;
    type0=1;
end
edge0=input('Is it an edge or the middle of the towel? (0=middle, 1=edge): ');


if exist('opticalsamples')
   ind=numel(opticalsamples.distance);
   newind=ind+1;
   
    
    
else
   newind=1;
end

   opticalsamples.imm{newind}=imm{statecur{3}};
   opticalsamples.distance(newind)=distance;
   opticalsamples.blurquality(newind)=blurquality;
   opticalsamples.edge(newind)=edge0;
   
   opticalsamples.type(newind)=type0;
   
   save('_opticalsamples.mat','opticalsamples')
   
