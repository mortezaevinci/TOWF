'Start-up...'

clear LBPu2 LBPriu LBPVu2 LBPVriu DM;


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

% read picture ID of training and test samples, and read class ID of
% training and test samples
%trainTxt = sprintf('%s000\\train.txt', rootpic);
%testTxt = sprintf('%s000\\test.txt', rootpic);
%[trainIDs, trainClassIDs] = ReadOutexTxt(trainTxt);
%[testIDs, testClassIDs] = ReadOutexTxt(testTxt);

% classification test using LBPriu
trains = LBPriu(trainIDs,:);
tests = LBPriu(testIDs,:);
trainNum = size(trains,1);
testNum = size(tests,1);
DM = zeros(testNum,trainNum);
for i=1:testNum;
    test = tests(i,:);        
    DM(i,:) = distMATChiSquare(trains,test)';
end
CP=ClassifyOnNN(DM,trainClassIDs,testClassIDs)

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
CP=ClassifyOnNN(DM,trainClassIDs,testClassIDs)

% classification test using LBPu2, exhaustive searching
trains = LBPu2(trainIDs,:);
tests = LBPu2(testIDs,:);
trains = ConvertU2LBP(trains,P); % convert LBP histogram to meet the requirement for global matching
tests = ConvertU2LBP(tests,P);
DM = distGMES(trains,tests,P);
CP=ClassifyOnNN(DM,trainClassIDs,testClassIDs)

% classification test using LBPVu2, exhaustive searching
trains = LBPVu2(trainIDs,:);
tests = LBPVu2(testIDs,:);
trains = ConvertU2LBP(trains,P); % convert LBP histogram to meet the requirement for global matching
tests = ConvertU2LBP(tests,P);
DM = distGMES(trains,tests,P);
CP=ClassifyOnNN(DM,trainClassIDs,testClassIDs)

% classification test using LBPu2, 1 principal direction for each image
trains = LBPu2(trainIDs,:);
tests = LBPu2(testIDs,:);
trains = ConvertU2LBP(trains,P); % convert LBP histogram to meet the requirement for global matching
tests = ConvertU2LBP(tests,P);
DM = distGMPD(trains,tests,P,1);
CP=ClassifyOnNN(DM,trainClassIDs,testClassIDs)

% classification test using LBPu2, 2 principal directions for each image
trains = LBPu2(trainIDs,:);
tests = LBPu2(testIDs,:);
trains = ConvertU2LBP(trains,P); % convert LBP histogram to meet the requirement for global matching
tests = ConvertU2LBP(tests,P);
DM = distGMPD(trains,tests,P,2);
CP=ClassifyOnNN(DM,trainClassIDs,testClassIDs)

% classification test using LBPVu2, 1 principal direction for each image
trains = LBPVu2(trainIDs,:);
tests = LBPVu2(testIDs,:);
trains = ConvertU2LBP(trains,P); % convert LBP histogram to meet the requirement for global matching
tests = ConvertU2LBP(tests,P);
DM = distGMPD(trains,tests,P,1);
CP=ClassifyOnNN(DM,trainClassIDs,testClassIDs)

% classification test using LBPVu2, 2 principal directions for each image
trains = LBPVu2(trainIDs,:);
tests = LBPVu2(testIDs,:);
trains = ConvertU2LBP(trains,P); % convert LBP histogram to meet the requirement for global matching
tests = ConvertU2LBP(tests,P);
DM = distGMPD(trains,tests,P,2);
CP=ClassifyOnNN(DM,trainClassIDs,testClassIDs)

% classification test using LBPu2, 2 principal direction for each image,
% cluster some less important patterns to their rotation invariant
trains = LBPu2(trainIDs,:);
tests = LBPu2(testIDs,:);
trains = ConvertU2LBP(trains,P); % convert LBP histogram to meet the requirement for global matching
tests = ConvertU2LBP(tests,P);
DM = distGMPDRN(trains,tests,P,2,P/2-1); % RN=P/2-1
CP=ClassifyOnNN(DM,trainClassIDs,testClassIDs)

% classification test using LBPVu2, 2 principal directions for each image,
% cluster some less important patterns to their rotation invariant
trains = LBPVu2(trainIDs,:);
tests = LBPVu2(testIDs,:);
trains = ConvertU2LBP(trains,P); % convert LBP histogram to meet the requirement for global matching
tests = ConvertU2LBP(tests,P);
DM = distGMPDRN(trains,tests,P,2,P/2-1); % % RN=P/2-1
CP=ClassifyOnNN(DM,trainClassIDs,testClassIDs)