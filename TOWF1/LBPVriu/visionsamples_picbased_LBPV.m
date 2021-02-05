'Initialization...'

load '_visionsamples.mat';

clear LBPV1 LBPV2 DM;

'Generate maps...'
% Radius and Neighborhood
R=1;
P=8;
% genearte LBP and LBPV features
pattern1 = getmap(P);


% Radius and Neighborhood
R2=2;
P2=8;
% genearte LBP and LBPV features
pattern1_16 = getmap(P2);

cnt1=0;
trained=[];
tested=[];
classtrained=[];
classtested=[];

'running...'

iin=numel(visionsamples.towelanalysis);
for ii=1:iin
    jjn=numel(visionsamples.towelanalysis{ii}.areasample_edge);
    for jj=1:jjn
    cnt1=cnt1+1;
    Gray = visionsamples.towelanalysis{ii}.areasample41{jj};
    Gray = double(Gray);
    
    %%effect of zoom
     %   Gray=imresize(Gray,1+rand(1,1));
     %   Gray=Gray(1:41,1:41);
    
    
    Gray = (Gray-mean(Gray(:))+128)/std(Gray(:))*20; % image normalization, to remove global intensity
    LBPV1(cnt1,:) = [LBPV(Gray,R,P,pattern1)];% LBPV(Gray,R2,P2,pattern1_16)]; 
    
    if nnz(ii==[1 3 5 7 9 11 12 13 15 17]) %train
        trained=[trained cnt1];
        classtrained=[classtrained visionsamples.towelanalysis{ii}.areasample_edge(jj)];
        
    else 
       tested=[tested cnt1];
        classtested=[classtested visionsamples.towelanalysis{ii}.areasample_edge(jj)];
          
    end
    
    end
end

'classification test using LBPV...'

trains = LBPV1(trained,:);
tests = LBPV1(tested,:);
trainNum = size(trains,1);
testNum = size(tests,1);
DM = zeros(testNum,trainNum);
for i=1:testNum;
    test = tests(i,:);        
    DM(i,:) = distfit(trains,test)';
end

rightCount=0;
distNewmax=0;
for i=1:length(classtested);
    

    [dissim, index]=mins(DM(i,:),5);
    %[distNew, index]= min(DM(i,:));   % find the nearest Neighborhood
    [winner,mindex]=calcwinner(classtrained, index,dissim);
    

    if winner == classtested(i) && winner==0  % judge if the nearest is correctly classified
        rightCount = rightCount+1;
        distNewmax=max(distNewmax,dissim(mindex));
    end
end
rightCount/length(classtested) %not neccasarily the good percentage (winner==1)
distNewmax

ii=10;

I=visionsamples.towelanalysis{ii}.capgray;

[ir,ic]=size(I);
wsize=20;  %samples41

cnt2=0;

clear LBPV2riu;

for iir=(1+wsize):5:(ir-wsize)
    
    for iic=(1+wsize):5:(ic-wsize)
        cnt2=cnt2+1;
        Gray=I((iir-wsize):(iir+wsize),(iic-wsize):(iic+wsize));
            Gray = double(Gray);
    
    %%effect of zoom
     %   Gray=imresize(Gray,1+rand(1,1));
     %   Gray=Gray(1:41,1:41);
    
    
    Gray = (Gray-mean(Gray(:))+128)/std(Gray(:))*20; % image normalization, to remove global intensity
    
     LBPV2(cnt2,:) = [LBPV(Gray,R,P,pattern1)];% LBPV(Gray,R2,P2,pattern1_16)]; 
     
     pos2(cnt2,:)=[iir iic];
     
    end
end

tests2 = LBPV2(:,:);%LBPV2(tested,:);
testNum2 = size(tests2,1);
DM2 = zeros(testNum,trainNum);
for i=1:testNum2;
    
    test = tests2(i,:);        
    DM2(i,:) = distfit(trains,test)';
end

imshow(I)
hold on
for i=1:size(LBPV2,1);
    

    [dissim, index]=mins(DM2(i,:),5);
    %classtrained(index(1))
    [winner,mindex]=calcwinner(classtrained, index,dissim);
    
    if winner==0
    if dissim(mindex)<distNewmax
        
        plot(pos2(i,2),pos2(i,1),'r*');
    end
    end
end