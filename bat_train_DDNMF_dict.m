function bat_train_DDNMF_dict(SS_flag)

if ~exist('SS_flag','var')
   SS_flag=0; 
end

m=5:25;

for i=1:length(m)
  train_DDNMF_dict(m(i),SS_flag);
end



