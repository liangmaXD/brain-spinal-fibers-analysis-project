p = spm_select('FPList','G:\Cortical_spinalcord\MRIdata','ICBM_Mori_DTI_2mm_FA.nii');%选取ICBM模板
v = spm_vol(p);
w = spm_read_vols(v);
[m,n,p]=size(w);
R=zeros(size(w));
tmp1=load('G:\Cortical_spinalcord\纤维束相关结果图\结果图汇总\多个体纤维束底板\PLSR\新结果\brain\第二项工作\tha-acc_L_LCPS.mat');
tmp2=load('G:\Cortical_spinalcord\纤维束相关结果图\结果图汇总\多个体纤维束底板\PLSR\新结果\brain\第二项工作\tha-acc_R_LCPS.mat');
% tmp3=load('G:\Cortical_spinalcord\纤维束相关结果图\结果图汇总\多个体纤维束底板\PLSR\新结果\S2_R_HPSR_FA.mat');
% tmp4=load('G:\Cortical_spinalcord\纤维束相关结果图\结果图汇总\多个体纤维束底板\PLSR\新结果\S2-tha_R_PT.mat');
Tracts1={};Tracts2={};Tracts3={};Tracts4={};
for i=1:length(tmp1.TractFE)
    for j=1:length(tmp1.TractFE{1,i})
        if(tmp1.TractFE{1,i}(j,:)==[0,1,0])
            Tracts1{1,i}(j,:)=tmp1.Tracts{1,i}(j,:);
        end
    end
end
for i=1:length(Tracts1)
    for j=length(Tracts1{1,i}):-1:1
        if(Tracts1{1,i}(j,:)==[0,0,0])
            Tracts1{1,i}(j,:)=[];
        end
    end
end
for i=1:length(tmp2.TractFE)
    for j=1:length(tmp2.TractFE{1,i})
        if(tmp2.TractFE{1,i}(j,:)==[0,1,0])
            Tracts2{1,i}(j,:)=tmp2.Tracts{1,i}(j,:);
        end
    end
end
for i=1:length(Tracts2)
    for j=length(Tracts2{1,i}):-1:1
        if(Tracts2{1,i}(j,:)==[0,0,0])
            Tracts2{1,i}(j,:)=[];
        end
    end
end
% for i=1:length(tmp3.TractFE)
%     for j=1:length(tmp3.TractFE{1,i})
%         if(tmp3.TractFE{1,i}(j,:)==[0,1,0])
%             Tracts3{1,i}(j,:)=tmp3.Tracts{1,i}(j,:);
%         end
%     end
% end
% for i=1:length(Tracts3)
%     for j=length(Tracts3{1,i}):-1:1
%         if(Tracts3{1,i}(j,:)==[0,0,0])
%             Tracts3{1,i}(j,:)=[];
%         end
%     end
% end
% for i=1:length(tmp4.TractFE)
%     for j=1:length(tmp4.TractFE{1,i})
%         if(tmp4.TractFE{1,i}(j,:)==[0,1,0])
%             Tracts4{1,i}(j,:)=tmp4.Tracts{1,i}(j,:);
%         end
%     end
% end
% for i=1:length(Tracts4)
%     for j=length(Tracts4{1,i}):-1:1
%         if(Tracts4{1,i}(j,:)==[0,0,0])
%             Tracts4{1,i}(j,:)=[];
%         end
%     end
% end
% Tracts=[Tracts1,Tracts2];

Tracts=[Tracts1,Tracts2,Tracts3,Tracts4];
for j=1:length(Tracts)
    if(isempty(Tracts{1,j}))
        continue;
    end
Tracts{1,j}(:,1)=Tracts{1,j}(:,1)./2;
Tracts{1,j}(:,2)=Tracts{1,j}(:,2)./2;
Tracts{1,j}(:,3)=Tracts{1,j}(:,3)./2;
Tracts{1,j}=[m-Tracts{1,j}(:,2)+1,n-Tracts{1,j}(:,1)+1,Tracts{1,j}(:,3)];%exploreDTI坐标转换成只有个体大脑的体素坐标；70-size(w,3)是个体的脊髓的长度
Tracts{1,j} = round(Tracts{1,j});
Tracts{1,j}(find(Tracts{1,j}==0))=1;
L_ind = sub2ind(size(w),Tracts{1,j}(:,1),Tracts{1,j}(:,2),Tracts{1,j}(:,3));
R(L_ind)=1;
end
tmp_v=v;
tmp_v.fname='G:\Cortical_spinalcord\corrpoints2ICBM\frequencyImage\job2\brain\tha-acc_L&R_LCPS.nii';
spm_write_vol(tmp_v,R);