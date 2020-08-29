function bat_get_DDNMF_feature(SS_flag)

if ~exist('SS_flag','var')
   SS_flag=0; 
end

m=5:25;

for i=1:length(m)
  get_DDNMF_feature(m(i),SS_flag);
end



