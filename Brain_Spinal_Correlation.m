% Names={
% 'S028'...
% 'S033'...
% 'S034'...
% 'S037'...
% 'S040'...
% 'S041'...
% 'S042'...
% 'S043'...
% 'S044'...
% 'S047'...
% 'S048'...
% 'S049'...
% 'S056'...
% 'S058'...
% 'S059'...
% 'S060'...
% 'S062'...
% 'S064'...
% 'S065'...
% 'S068'...
% 'S069'...
% 'S070'...
% 'S072'...
% 'S073'...
% 'S074'...
% 'S075'...
% 'S077'...
% 'S078'...
% 'S080'...
% 'S081'...
% 'S082'...
% 'S084'...
% 'S085'...
% 'S089'...
% 'S090'...
% 'S091'...
% 'S098'...
% 'S099'...
% 'S200'...
% 'S201'...
% 'S202'...
% 'S203'...
% 'S205'...
% 'S206'...
% 'S207'...
% 'S208'... 
% };
% 
% 
% MD_L=zeros([length(Names),70]);
% MD_R=zeros([length(Names),70]);
% 
% vonfreyshort=xlsread('G:\Cortical_spinalcord\DTI_感觉敏感性_整理.xlsx',2);
% electricshort=xlsread('G:\Cortical_spinalcord\DTI_感觉敏感性.xlsx',3);
% ATSshort=xlsread('G:\Cortical_spinalcord\DTI_感觉敏感性.xlsx',4);
% for i=1:length(Names)
%     file=['G:\Cortical_spinalcord\FiberTracts\Cortex_SpinalcordFiberTracts\',Names{i},'\meanfiber\'];
%     load([file,Names{i},'_MD_meancorfibers_70_L.mat']);
%     MD_L(i,:)=meancorfiber;
%     load([file,Names{i},'_MD_meancorfibers_70_L.mat']);
%     MD_R(i,:)=meancorfiber;
%     load([file,Names{i},'_MD_meancorfibers_70_L.mat']);
%     MD_L(i,:)=meancorfiber;
%     load([file,Names{i},'_MD_meancorfibers_70_L.mat']);
%     MD_L(i,:)=meancorfiber;
%     load([file,Names{i},'_MD_meancorfibers_70_R.mat']);
%     MD_R(i,:)=meancorfiber;
%     load([file,Names{i},'_MD_meancorfibers_70_R.mat']);
%     MD_R(i,:)=meancorfiber;
%     load([file,Names{i},'_MD_meancorfibers_70_R.mat']);
%     MD_R(i,:)=meancorfiber;
%     load([file,Names{i},'_MD_meancorfibers_70_L.mat']);
%     MD_R(i,:)=meancorfiber;
% end
% tmp=isnan(electriclong);
% for i=size(electriclong,1):-1:1
%     if (tmp(i,:)==1)
%         electriclong(i,:)=[];
%     end
% end
tmp=[];
spinal_RD=ones(44,size(S2_MD_L(1).meanMD,2));
spinal_RD=ones(44,size(S2_MD_L(1).meanMD,2));
spinal_RD=ones(44,size(S2_MD_L(1).meanMD,2));
spinal_RD=ones(44,size(S2_MD_L(1).meanMD,2));
S2_MDR=ones(44,size(S2_MD_R(1).meanMD,2));
S2_MDR=ones(44,size(S2_MD_R(1).meanMD,2));
S2_MDR=ones(44,size(S2_MD_R(1).meanMD,2));
S2_MDR=ones(44,size(S2_MD_R(1).meanMD,2));
for i=1:size(S2_MD_L,2)
    spinal_RD(i,:)=S2_MD_L(i).meanMD;
    spinal_RD(i,:)=S2_MD_L(i).meanMD;
    spinal_RD(i,:)=S2_MD_L(i).meanMD;
    spinal_RD(i,:)=S2_MD_L(i).meanMD;
end
for i=1:size(S2_MD_R,2)
    S2_MDR(i,:)=S2_MD_R(i).meanMD;
    S2_MDR(i,:)=S2_MD_R(i).meanMD;
    S2_MDR(i,:)=S2_MD_R(i).meanMD;
    S2_MDR(i,:)=S2_MD_R(i).meanMD;
end
V_RC6P_R_P=[];
for i=1:size(spinal_RD,2)
    [R1,P1]=corrcoef(spinal_RD(:,i),ATS_LC40);
    V_RC6P_R_P(1,i)=R1(1,2);
    V_RC6P_R_P(2,i)=P1(1,2);
end
for i=1:size(spinal_RD,2)
    [R2,P2]=corrcoef(spinal_RD(:,i),ATS_RC40);
    V_RC6P_R_P(3,i)=R2(1,2);
    V_RC6P_R_P(4,i)=P2(1,2);
end
for i=1:size(S2_MDR,2)
    [R1,P1]=corrcoef(S2_MDR(:,i),ATS_LC40);
    V_RC6P_R_P(5,i)=R1(1,2);
    V_RC6P_R_P(6,i)=P1(1,2);
end
for i=1:size(S2_MDR,2)
    [R2,P2]=corrcoef(S2_MDR(:,i),ATS_RC40);
    V_RC6P_R_P(7,i)=R2(1,2);
    V_RC6P_R_P(8,i)=P2(1,2);
end
for i=1:size(spinal_RD,2)
    [R1,P1]=corrcoef(spinal_RD(:,i),Touchsensity_L);
    V_RC6P_R_P(9,i)=R1(1,2);
    V_RC6P_R_P(10,i)=P1(1,2);
end
for i=1:size(spinal_RD,2)
    [R2,P2]=corrcoef(spinal_RD(:,i),Touchsensity_R);
    V_RC6P_R_P(11,i)=R2(1,2);
    V_RC6P_R_P(12,i)=P2(1,2);
end

for i=1:size(S2_MDR,2)
    [R1,P1]=corrcoef(S2_MDR(:,i),ATS_LC40);
    V_RC6P_R_P(13,i)=R1(1,2);
    V_RC6P_R_P(14,i)=P1(1,2);
end
for i=1:size(S2_MDR,2)
    [R2,P2]=corrcoef(S2_MDR(:,i),HPS_R);
    V_RC6P_R_P(15,i)=R2(1,2);
    V_RC6P_R_P(16,i)=P2(1,2);
end
for i=1:size(S2_MDR,2)
    [R1,P1]=corrcoef(S2_MDR(:,i),paintolerance_L);
    V_RC6P_R_P(17,i)=R1(1,2);
    V_RC6P_R_P(18,i)=P1(1,2);
end
for i=1:size(S2_MDR,2)
    [R2,P2]=corrcoef(S2_MDR(:,i),paintolerance_R);
    V_RC6P_R_P(19,i)=R2(1,2);
    V_RC6P_R_P(20,i)=P2(1,2);
end
for i=1:size(S2_MDR,2)
    [R1,P1]=corrcoef(S2_MDR(:,i),Touchsensity_L);
    V_RC6P_R_P(21,i)=R1(1,2);
    V_RC6P_R_P(22,i)=P1(1,2);
end
for i=1:size(S2_MDR,2)
    [R2,P2]=corrcoef(S2_MDR(:,i),Touchsensity_R);
    V_RC6P_R_P(23,i)=R2(1,2);
    V_RC6P_R_P(24,i)=P2(1,2);
end
