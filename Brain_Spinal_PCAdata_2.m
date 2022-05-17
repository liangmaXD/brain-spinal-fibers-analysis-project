%%
Names={
'S028'...
'S033'...
'S034'...
'S037'...
'S040'...
'S041'...
'S042'...
'S043'...
'S044'...
'S047'...
'S048'...
'S049'...
'S056'...
'S058'...%'S059'...
'S060'...
'S062'...%'S064'...
'S065'...
'S068'...
'S069'...
'S070'...
'S072'...
'S073'...
'S074'...
'S075'...
'S077'...
'S078'...
'S080'...
'S081'...
'S082'...
'S084'...
'S085'...
'S089'...
'S090'...
'S091'...
'S098'...
'S099'...
'S100'...
'S101'...
'S102'...
'S103'...
'S105'...
'S106'...
'S107'...
'S108'...
};
for i=1:length(Names)
    acc_FA_L(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\tha-acc\L\',Names{i},'_meanFA.mat']);
    acc_FA_R(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\tha-acc\R\',Names{i},'_meanFA.mat']);
    acc_AD_L(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\tha-acc\L\',Names{i},'_meanAD.mat']);
    acc_AD_R(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\tha-acc\R\',Names{i},'_meanAD.mat']);
    acc_MD_L(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\tha-acc\L\',Names{i},'_meanMD.mat']);
    acc_MD_R(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\tha-acc\R\',Names{i},'_meanMD.mat']);
    acc_RD_L(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\tha-acc\L\',Names{i},'_meanRD.mat']);
    acc_RD_R(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\tha-acc\R\',Names{i},'_meanRD.mat']);
    %%
    S1_FA_L(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\S1-tha\L\',Names{i},'_meanFA.mat']);
    S1_FA_R(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\S1-tha\R\',Names{i},'_meanFA.mat']);
    S1_AD_L(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\S1-tha\L\',Names{i},'_meanAD.mat']);
    S1_AD_R(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\S1-tha\R\',Names{i},'_meanAD.mat']);
    S1_MD_L(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\S1-tha\L\',Names{i},'_meanMD.mat']);
    S1_MD_R(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\S1-tha\R\',Names{i},'_meanMD.mat']);
    S1_RD_L(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\S1-tha\L\',Names{i},'_meanRD.mat']);
    S1_RD_R(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\S1-tha\R\',Names{i},'_meanRD.mat']);
    %%
    S2_FA_L(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\S2-tha\L\',Names{i},'_meanFA.mat']);
    S2_FA_R(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\S2-tha\R\',Names{i},'_meanFA.mat']);
    S2_AD_L(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\S2-tha\L\',Names{i},'_meanAD.mat']);
    S2_AD_R(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\S2-tha\R\',Names{i},'_meanAD.mat']);
    S2_MD_L(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\S2-tha\L\',Names{i},'_meanMD.mat']);
    S2_MD_R(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\S2-tha\R\',Names{i},'_meanMD.mat']);
    S2_RD_L(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\S2-tha\L\',Names{i},'_meanRD.mat']);
    S2_RD_R(i)=load(['G:\Cortical_spinalcord\FiberTracts\std2native_tha-x\',Names{i},'\S2-tha\R\',Names{i},'_meanRD.mat']);
end
%% 拼接
acc_mean_data_L=[];
for j=1:size(acc_FA_L(1).meanFA,2)
    for i=1:length(Names)
        tmp_acc(i,1)=acc_FA_L(i).meanFA(1,j);
        tmp_acc(i,2)=acc_AD_L(i).meanAD(1,j);
        tmp_acc(i,3)=acc_MD_L(i).meanMD(1,j);
        tmp_acc(i,4)=acc_RD_L(i).meanRD(1,j);
    end
    acc_mean_data_L=[acc_mean_data_L;tmp_acc];
end
clear tmp_acc;
%
S1_mean_data_L=[];
for j=1:size(S1_FA_L(1).meanFA,2)
    for i=1:length(Names)
        tmp_S1(i,1)=S1_FA_L(i).meanFA(1,j);
        tmp_S1(i,2)=S1_AD_L(i).meanAD(1,j);
        tmp_S1(i,3)=S1_MD_L(i).meanMD(1,j);
        tmp_S1(i,4)=S1_RD_L(i).meanRD(1,j);
    end
    S1_mean_data_L=[S1_mean_data_L;tmp_S1];
end
clear tmp_S1;
%
S2_mean_data_L=[];
for j=1:size(S2_FA_L(1).meanFA,2)
    for i=1:length(Names)
        tmp_S2(i,1)=S2_FA_L(i).meanFA(1,j);
        tmp_S2(i,2)=S2_AD_L(i).meanAD(1,j);
        tmp_S2(i,3)=S2_MD_L(i).meanMD(1,j);
        tmp_S2(i,4)=S2_RD_L(i).meanRD(1,j);
    end
    S2_mean_data_L=[S2_mean_data_L;tmp_S2];
end
clear tmp_S2;

acc_mean_data_R=[];
for j=1:size(acc_FA_R(1).meanFA,2)
    for i=1:length(Names)
        tmp_acc(i,1)=acc_FA_R(i).meanFA(1,j);
        tmp_acc(i,2)=acc_AD_R(i).meanAD(1,j);
        tmp_acc(i,3)=acc_MD_R(i).meanMD(1,j);
        tmp_acc(i,4)=acc_RD_R(i).meanRD(1,j);
    end
    acc_mean_data_R=[acc_mean_data_R;tmp_acc];
end
clear tmp_acc;
%
S1_mean_data_R=[];
for j=1:size(S1_FA_R(1).meanFA,2)
    for i=1:length(Names)
        tmp_S1(i,1)=S1_FA_R(i).meanFA(1,j);
        tmp_S1(i,2)=S1_AD_R(i).meanAD(1,j);
        tmp_S1(i,3)=S1_MD_R(i).meanMD(1,j);
        tmp_S1(i,4)=S1_RD_R(i).meanRD(1,j);
    end
    S1_mean_data_R=[S1_mean_data_R;tmp_S1];
end
clear tmp_S1;
%
S2_mean_data_R=[];
for j=1:size(S2_FA_R(1).meanFA,2)
    for i=1:length(Names)
        tmp_S2(i,1)=S2_FA_R(i).meanFA(1,j);
        tmp_S2(i,2)=S2_AD_R(i).meanAD(1,j);
        tmp_S2(i,3)=S2_MD_R(i).meanMD(1,j);
        tmp_S2(i,4)=S2_RD_R(i).meanRD(1,j);
    end
    S2_mean_data_R=[S2_mean_data_R;tmp_S2];
end
clear tmp_S2;

all_data=[acc_mean_data_L;S1_mean_data_L;S2_mean_data_L;acc_mean_data_R;S1_mean_data_R;S2_mean_data_R];
%% PCA
[coeff,score,latent,tsquared,explained,mu] = pca(zscore(all_data,0,1));
figure(1);
pareto(explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
figure(2);
biplot(coeff(:,1:2),'score',score(:,1:2));
pc1_data=score(:,1);
pc2_data=score(:,2);
%% 拆PCA到纤维束
len_s1_L=length(Names)*length(S1_FA_L(1).meanFA);
len_acc_L=length(Names)*length(acc_FA_L(1).meanFA);
len_s2_L=length(Names)*length(S2_FA_L(1).meanFA);
len_s1_R=length(Names)*length(S1_FA_R(1).meanFA);
len_acc_R=length(Names)*length(acc_FA_R(1).meanFA);
len_s2_R=length(Names)*length(S2_FA_R(1).meanFA);

acc_L_PC1=pc1_data(1:len_acc_L,:);
S1_L_PC1=pc1_data(len_acc_L+1:len_acc_L+len_s1_L,:);
S2_L_PC1=pc1_data(len_acc_L+len_s1_L+1:len_acc_L+len_s1_L+len_s2_L,:);
acc_R_PC1=pc1_data(len_acc_L+len_s1_L+len_s2_L+1:len_acc_L+len_s1_L+len_s2_L+len_acc_R,:);
S1_R_PC1=pc1_data(len_acc_L+len_s1_L+len_s2_L+len_acc_R+1:len_acc_L+len_s1_L+len_s2_L+len_acc_R+len_s1_R,:);
S2_R_PC1=pc1_data(len_acc_L+len_s1_L+len_s2_L+len_acc_R+len_s1_R+1:end,:);
%% 拆解PCA结果到人
acc_L_data=reshape(acc_L_PC1,length(Names),length(acc_FA_L(1).meanFA));
acc_R_data=reshape(acc_R_PC1,length(Names),length(acc_FA_R(1).meanFA));
S1_L_data=reshape(S1_L_PC1,length(Names),length(S1_FA_L(1).meanFA));
S1_R_data=reshape(S1_R_PC1,length(Names),length(S1_FA_R(1).meanFA));
S2_L_data=reshape(S2_L_PC1,length(Names),length(S2_FA_L(1).meanFA));
S2_R_data=reshape(S2_R_PC1,length(Names),length(S2_FA_R(1).meanFA));




