'Start-up...'

clear LBPu2 LBPriu LBPVu2 LBPVriu LBPV2riu DM;


%function DemoCodesOutex
% This demo codes shows the basic operations of LBPV_GM

% images and labels folder
% please download Outex Database from http://www.outex.oulu.fi, then
% extract Outex_TC_00010 to the "rootpic" folder
%rootpic = 'Outex_TC_00010\';
% picture number of the database
%picNum = 4320;

% Radius and Neighborhood
R=1;
P=8;
% genearte LBP and LBPV features
patternMappingu2 = Getmapping(P,'u2');
patternMappingriu2 = Getmapping(P,'riu');


% Radius and Neighborhood
R2=2;
P2=8;
% genearte LBP and LBPV features
patternMappingu2_16 = Getmapping(P2,'u2');
patternMappingriu2_16 = Getmapping(P2,'riu2');

cnt1=0;
trainIDs=[];
testIDs=[];
trainClassIDs=[];
testClassIDs=[];

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
    LBPu2(cnt1,:) = [lbp_new(Gray,R,P,patternMappingu2)];% lbp_new(Gray,R2,P2,patternMappingu2_16)];
    LBPriu(cnt1,:) = [lbp_new(Gray,R,P,patternMappingriu2)];% lbp_new(Gray,R2,P2,patternMappingriu2_16)];
    LBPVu2(cnt1,:) = [LBPV(Gray,R,P,patternMappingu2)];% LBPV(Gray,R2,P2,patternMappingu2_16)];
    LBPVriu(cnt1,:) = [LBPV(Gray,R,P,patternMappingriu2)];% LBPV(Gray,R2,P2,patternMappingriu2_16)]; 
    
    if nnz(ii==[1 3 5 7 9 11 12 13 15 17]) %train
        trainIDs=[trainIDs cnt1];
        trainClassIDs=[trainClassIDs visionsamples.towelanalysis{ii}.areasample_edge(jj)];
        
    else 
       testIDs=[testIDs cnt1];
        testClassIDs=[testClassIDs visionsamples.towelanalysis{ii}.areasample_edge(jj)];
          
    end
    
    end
end

% classification test using LBPVriu
trains = LBPVriu(trainIDs,:);
tests = LBPVriu(testIDs,:);
trainNum = size(trains,1);
testNum = size(tests,1);
DM = zeros(testNum,trainNum);
for i=1:testNum;
    test = tests(i,:);        
    DM(i,:) = distMATChiSquare(trains,test)';
end
%CP=ClassifyOnNN(DM,trainClassIDs,testClassIDs)

rightCount=0;
distNewmax=0;
for i=1:length(testClassIDs);
    

    [dissim, index]=mins(DM(i,:),5);
    %[distNew, index]= min(DM(i,:));   % find Nearest Neighborhood
    [winner,mindex]=votes(trainClassIDs, index,dissim);
    

    if winner == testClassIDs(i) && winner==0  % judge whether the nearest one is correctly classified
        rightCount = rightCount+1;
        distNewmax=max(distNewmax,dissim(mindex));
    end
end
rightCount/length(testClassIDs) %not neccasarily the good percentage (winner==1)
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
    
     LBPV2riu(cnt2,:) = [LBPV(Gray,R,P,patternMappingriu2)];% LBPV(Gray,R2,P2,patternMappingriu2_16)]; 
     
     pos2(cnt2,:)=[iir iic];
     
    end
end

tests2 = LBPV2riu(:,:);%LBPV2riu(testIDs,:);
testNum2 = size(tests2,1);
DM2 = zeros(testNum,trainNum);
for i=1:testNum2;
    
    test = tests2(i,:);        
    DM2(i,:) = distMATChiSquare(trains,test)';
end

imshow(I)
hold on
for i=1:size(LBPV2riu,1);
    

    [dissim, index]=mins(DM2(i,:),5);
    %trainClassIDs(index(1))
    [winner,mindex]=votes(trainClassIDs, index,dissim);
    
    if winner==0
    if dissim(mindex)<distNewmax
        
        plot(pos2(i,2),pos2(i,1),'r*');
    end
    end
end