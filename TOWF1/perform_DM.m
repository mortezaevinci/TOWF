%not used anywhere

trainNum = size(trains,1);
testNum = size(tests,1);
DistMat = zeros(P,trainNum);
DM = zeros(testNum,trainNum);
for i=1:testNum;
    test = tests(i,:);        
    DM(i,:) = distfit(trains,test)';
end
CP=ClassifyOnNN(DM,trainClassIDs,testClassIDs)