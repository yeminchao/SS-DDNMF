function generate_data

load('DataCube.mat');

DataCube1=double(DataCube1);
DataCube2=double(DataCube2);
gt1=double(gt1);
gt2=double(gt2);

data1=reshape(DataCube1,[size(DataCube1,1)*size(DataCube1,2),size(DataCube1,3)]);
Label1=reshape(gt1,[size(DataCube1,1)*size(DataCube1,2),1]);
position1=zeros(size(DataCube1,2),size(DataCube1,1),2);
[position1(:,:,1),position1(:,:,2)]=meshgrid(1:1:size(DataCube1,1),1:1:size(DataCube1,2));
position1=permute(position1,[2,1,3]);
position1=reshape(position1,[size(DataCube1,1)*size(DataCube1,2),2]);



data2=reshape(DataCube2,[size(DataCube2,1)*size(DataCube2,2),size(DataCube2,3)]);
Label2=reshape(gt2,[size(DataCube2,1)*size(DataCube2,2),1]);
position2=zeros(size(DataCube2,2),size(DataCube2,1),2);
[position2(:,:,1),position2(:,:,2)]=meshgrid(1:1:size(DataCube2,1),1:1:size(DataCube2,2));
position2=permute(position2,[2,1,3]);
position2=reshape(position2,[size(DataCube2,1)*size(DataCube2,2),2]);


save('data/data.mat','data1','Label1','position1','data2','Label2','position2');









