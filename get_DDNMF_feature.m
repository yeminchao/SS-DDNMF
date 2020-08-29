function get_DDNMF_feature(r,SS_flag)

if ~exist('SS_flag','var')
   SS_flag=0; 
end

if SS_flag
    sample_file='data/sample-SS.mat';
    dict_file='SS-DDNMF-dict-r=%d.mat';
    feat_file='SS-DDNMF-feat-r=%d.mat';
else
    sample_file='data/sample.mat';
    dict_file='DDNMF-dict-r=%d.mat';
    feat_file='DDNMF-feat-r=%d.mat';
end


load(sample_file,'trainData1','trainLabel1','trainPosition1','trainData2','trainLabel2','trainPosition2','testData2','testLabel2','testPosition2');


load(fullfile('data',sprintf(dict_file,r)),'Us','Ut');


trainFeat1=nnls(Us,trainData1')';
trainFeat2=nnls(Ut,trainData2')';
trainFeat1_projted_to_domain2=trainFeat1*Ut';
trainFeat2_projted_to_domain1=trainFeat2*Us';
testFeat2=nnls(Ut,testData2')';
testFeat2_projted_to_domain1=testFeat2*Us';
save(fullfile('data',sprintf(feat_file,r)),'trainFeat1','trainLabel1','trainPosition1',...
    'trainFeat2','trainLabel2','trainPosition2', ...
'testFeat2','testLabel2','testPosition2',...
    'trainFeat1_projted_to_domain2','trainFeat2_projted_to_domain1','testFeat2_projted_to_domain1');




