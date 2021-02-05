load '_opticalsamples.mat';


%filter out general smaples and keep fixed-window samples
opind=find(opticalsamples.type==1);
opticalsamples2.distance=opticalsamples.distance(opind);
opticalsamples2.blurquality=opticalsamples.blurquality(opind);
opticalsamples2.edge=opticalsamples.edge(opind);
kk0=0;
for kk=1:numel(opind)
    kk0=kk0+1;
opticalsamples2.imm{kk0}=opticalsamples.imm{kk};
end
opticalsamples2.type(opind)=opticalsamples.type(opind);
opticalsamples=opticalsamples2;


nn=numel(opticalsamples.distance);
meas=zeros(23,nn);

for ii=1:nn
    imm0=opticalsamples.imm{ii};
    imm0=imm0./max(max(imm0));
    
    %focus measures
  meas(1,ii)=focusmeasure(imm0,'TENV',[])*100;
  meas(2,ii)=focusmeasure(imm0,'HELM',[]);
  meas(3,ii)=focusmeasure(imm0,'LAPD',[]);
  meas(4,ii)=focusmeasure(imm0,'SFIL',[])./10^15;
  meas(5,ii)=focusmeasure(imm0,'TENG',[]);
   
    %general data
    meas(6,ii)=mean(mean(imm0));
    meas(7,ii)=max(max(imm0))-min(min(imm0));
    [c x]=imhist(imm0);
    
    meas(8,ii)=nnz(c); %number of different existing brightnesses
    
    bwb=bwboundaries(imm0);
    meas(9,ii)=size(bwb,2); %number of matlab-found boundaries
    
    filter1=fspecial('gaussian',[5 1],1);
    c1=corner(imm0,'Harris','FilterCoefficients',filter1);
    c2=corner(imm0,'MinimumEigenvalue','FilterCoefficients',filter1);
    
    meas(10,ii)=size(c1,1); %number of harris corners found
    meas(11,ii)=size(c2,1); %number of minmum eigenvalues corners found
    
    meas(12,ii)=mean(mean(cornermetric(imm0)))*10^5; %mean value of the corner metric based on canny
    meas(13,ii)=mean(mean(cornermetric(imm0,'MinimumEigenvalue')))*10^3; %mean value of the corner metric based on canny  
    
    meas(14,ii)=sum(sum(edge(imm0,'sobel'))); %number of sobel edges
    meas(15,ii)=sum(sum(edge(imm0,'prewitt'))); %number of prewitt edges
    meas(16,ii)=sum(sum(edge(imm0,'roberts'))); %number of roberts edges
    meas(17,ii)=sum(sum(edge(imm0,'log'))); %number of log edges
    meas(18,ii)=sum(sum(edge(imm0,'canny'))); %number of canny edges
    meas(19,ii)=mean([meas(14,ii) meas(15,ii) meas(16,ii) meas(17,ii) meas(18,ii) ]);   %number of edges, averaged methods
    
    meas(20,ii)=entropy(imm0);
    
    rf=rangefilt(imm0);
    meas(21,ii)=max(max(rf)); %max of brightness disparity
    meas(22,ii)=mean(mean(rf)); % mean brightness disparity
    
    
    %the bandpass filter fft may be able to distinguish between edge and
    %middle towel... to be tested as second phase: advanced measures
    rft=fft2(imm0);
    rftm=abs(rft(3:(end),3:(end-2)));
    rfta=angle(rft(3:(end),3:(end-2)));
    
    meas(22,ii)=mean(mean(rftm));
    meas(23,ii)=max(max(rftm))-min(min(rftm));
    
       meas(24,ii)=mean(mean(rfta));
    meas(25,ii)=max(max(rfta))-min(min(rfta));   
    
    opticalsamples.edge(ii)
    subplot(1,3,1)
    imshow(imm0);
    subplot(1,3,2)
    imshow(rftm);
    subplot(1,3,3)
    imshow(rfta)
    pause
end

