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
    meas(24,ii)=nnz(rftm>meas(22,ii));
    
    
       meas(25,ii)=mean(mean(rfta));
    meas(26,ii)=max(max(rfta))-min(min(rfta));   
end


results=[opticalsamples.edge;
       opticalsamples.distance;
       opticalsamples.blurquality;
       meas];
   
   rmax=max(results')';
   rmaxrep=repmat(rmax,1,nn);
   results=results./rmaxrep;
   
   imshow(results)
   
   
   %make population
   popn=30000;  %make sure popn is a muliply of 4
   
   pop=[];
   
   'creating population...'
   for jj=1:popn
       
     pop=[pop;
         (rand(1,size(meas,1))*2-1)];
   end
   
   fitness0=[];
   
   'GA processing...'
   %GA
   for loopn=1:100
  loopn
  
       for jj=1:popn
           
           
           %evaluate
           output0=[];
             for ii=1:nn
      
      output0=[output0;exp(((pop(jj,:)*meas(:,ii)))*(-opticalsamples.edge(ii)*2+1))];
      
   
   
             end
             
             %calculate fitness
       fitness0(jj)=mean(output0);
       end
       
       [~,ffind]=sort(fitness0,'ascend');
       
       %selected population
       goodpop=pop(ffind(1:(popn/2)),:);
       
       
       %children
       chromsize=size(meas,1);
       chromhalf=floor(chromsize/2);
       
       childpop=[];
       for kk=1:popn/4
       childpop=[childpop;[goodpop(kk,1:chromhalf) goodpop(kk+popn/4,(chromhalf+1):chromsize)]];
       childpop=[childpop;[goodpop(kk+popn/4,1:chromhalf) goodpop(kk,(chromhalf+1):chromsize)]];
       end
       
       %next generation
       pop=[goodpop;childpop];
       
           fitness0(ffind(1)  )
       
   end 
   output0=[];
   
   fitout=[];
          for ii=1:nn
      
      output0=[output0;((pop(ffind(1),:)*meas(:,ii)))];
      fitout=[fitout;exp(((pop(ffind(1),:)*meas(:,ii)))*(-opticalsamples.edge(ii)*2+1))];
          end
             
   
   gaoutcome=[opticalsamples.edge;output0';fitout']   %positive output should be edge, and negative output should be non-edge
   
 'wrong ones='
 nnz(fitout>1)
   
   load '_opticalsamples.mat';