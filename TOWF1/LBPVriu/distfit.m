function DM = distfit(train, test)
% dissimilarity function

[trainrow, traincol] = size(train);
[testrow, testcol] = size(test);
testExtend = repmat(test, trainrow, 1);
subMatrix = train-testExtend;
subMatrix2 = subMatrix.^2;
addMatrix = train+testExtend;
idxZero = find(addMatrix==0);
addMatrix(idxZero)=1;
DistMat = subMatrix2./addMatrix;
DM = sum(DistMat,2);
end