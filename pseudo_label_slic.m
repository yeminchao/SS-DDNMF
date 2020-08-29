clear;
clc;

load('DataCube.mat');
DataCube2=double(DataCube2);
k=round(sqrt(size(DataCube2,1)*size(DataCube2,2)));
% k=0.1*(size(DataCube2,1)*size(DataCube2,2));
m=50;
seRadius=1;
colopt= 'mean';

tau=1;

% if ~exist('seg_label.mat','file')
[seg_label, Am, Sp, d] = slic(DataCube2, k, m, seRadius, colopt);
%     save('seg_label.mat','seg_label');
% else
%     load('seg_label.mat','seg_label');
% end

load('data/sample.mat','trainPosition2','trainLabel2');

t_label=zeros(size(DataCube2,1),size(DataCube2,2));
for i=1:length(trainLabel2)
    t_label(trainPosition2(i,1),trainPosition2(i,2))=trainLabel2(i);
end

segs=unique(seg_label);
classes=unique(trainLabel2);

pseudo_label=zeros(size(DataCube2,1),size(DataCube2,2));

for i=1:length(segs)
    region_mask=seg_label==segs(i);
    occr=sum(bsxfun(@eq,t_label(region_mask)',classes),2);
%     [occr,label0]=hist(t_label(region_mask),classes);
    [max_occr,idx]=max(occr);
    label0=classes(idx);
    if max_occr>0 && max_occr>=tau*sum(occr)
        pseudo_label(region_mask)=label0;
    end
end

pseudo_label(t_label~=0)=t_label(t_label~=0);

save('data/pseudo_label.mat','pseudo_label');

clear;

load('DataCube.mat');
load('data/pseudo_label.mat','pseudo_label');
load('data/sample.mat');
DataCube2=double(DataCube2);
data2=reshape(DataCube2,[size(DataCube2,1)*size(DataCube2,2),size(DataCube2,3)]);
Label2=pseudo_label;
position2=zeros(size(DataCube2,2),size(DataCube2,1),2);
[position2(:,:,1),position2(:,:,2)]=meshgrid(1:1:size(DataCube2,1),1:1:size(DataCube2,2));
position2=permute(position2,[2,1,3]);
position2=reshape(position2,[size(DataCube2,1)*size(DataCube2,2),2]);

idx2=Label2>0;
trainLabel2=Label2(idx2);
trainData2=data2(idx2,:);
trainPosition2=position2(idx2,:);


save('data/sample-SS.mat','trainData1','trainLabel1','trainPosition1','trainData2','trainLabel2','trainPosition2',   ...
    'testData2','testLabel2','testPosition2');


















