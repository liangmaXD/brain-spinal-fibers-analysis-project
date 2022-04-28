%% ʹ��AFQ�ĺ�����ȡ�����������
FG.name = 'Cortex_Spinal';
FG.Abb = [];
Cortex_SpinalFibersPath = 'G:\Cortical_spinalcord\S028\test.mat';
Cortex_SpinalFibers = load(Cortex_SpinalFibersPath);
fibers = Cortex_SpinalFibers.Tracts;
num_of_fibers = length(fibers);

p = spm_select('FPList','G:\Cortical_spinalcord\Tracted_result','S028_FA.nii'); %ѡȡģ���FAͼ��
v = spm_vol(p);
w = spm_read_vols(v);
[m,n,~]=size(w);
for i = 1:num_of_fibers
    Cord_tmp0 = fibers{1,i};
    Cord_tmp1(:,1) = Cord_tmp0(:,1)./abs(v.mat(1,1));%ת������������(ʵ���ϻ����ǳ߶ȴ�С)
    Cord_tmp1(:,2) = Cord_tmp0(:,2)./abs(v.mat(2,2));%�����е�����������������ά�ϵĵ㲻һ�����������ģ����Ի���С��
    Cord_tmp1(:,3) = Cord_tmp0(:,3)./abs(v.mat(3,3));
    Cord_tmp1=[m-Cord_tmp1(:,2)+1,n-Cord_tmp1(:,1)+1,Cord_tmp1(:,3)];%����ķ�ת-ת��-��ת��������
    FG.fibers{1,i} = double(Cord_tmp1'); % nearpoint������Ҫ����ͬ���͵�3xN��3xM����
    Cord_tmp1 = [];
end
clear Cord_tmp0 Cord_tmp1 p v w m n l  %
%% ����ROI1,����mask
ROIpath = 'G:\Cortical_spinalcord\S028\mask';
ROIname_0 = dir(fullfile(ROIpath,'BrainMask.nii'));% ��ȡȫ�Ե�ROI
ROIname = {ROIname_0.name};

minDist1 =30;% 1.732: 2��1x1x1�Խ��߾���,4��3.48��3��2.61;�������������۲�����
ROI = struct;
ROI.name=ROIname(1);
ROI.Abb='BM';
fgOut = cell(size(ROIname));
keep = cell(size(ROIname));
keepIDfirst = cell(size(ROIname));
keepIDlast = cell(size(ROIname));

% roi1path = fullfile(ROIpath,ROIname{i});
ROIstr = spm_vol('G:\Cortical_spinalcord\S028\mask\BrainMask.nii');
ROIdata = spm_read_vols(ROIstr);
[x, y, z]   = ind2sub(size(ROIdata), find(ROIdata>0));
ROI.coords = [x, y, z]; % ROI������������
%keepfirst��keeplast����һ����ά���ϵ�һ����Ϊ���λ�ã������һ����Ϊ���λ��
[fgOut, keep,keepIDfirst,keepIDlast] = ...
TABS_dtiIntersectFibersWithRoi('and', minDist1, ROI, FG);

%����ROI2.�����ϵ�mask
ROI2path = 'G:\Cortical_spinalcord\S028\mask';
ROI2name_0 = dir(fullfile(ROIpath,'C7Mask.nii'));% ��ȡȫ�Ե�ROI
ROI2name = {ROIname_0.name};

minDist2 =30;% 1.732: 2��1x1x1�Խ��߾���,4��3.48��3��2.61;�����������Ҫ����һ��
ROI2 = struct;
ROI2.name=ROI2name;
ROI2.Abb='C6Mask';
fg2Out = cell(size(ROI2name));
keep2 = cell(size(ROI2name));
keep2IDfirst = cell(size(ROI2name));
keep2IDlast = cell(size(ROI2name));

% roi1path = fullfile(ROIpath,ROIname{i});
ROI2str = spm_vol('G:\Cortical_spinalcord\S028\mask\C6Mask.nii');
ROI2data = spm_read_vols(ROI2str);
[x, y, z]   = ind2sub(size(ROI2data), find(ROI2data>0));
ROI2.coords = [x, y, z]; % ROI������������
[fg2Out, keep2,keep2IDfirst,keep2IDlast] = ...
TABS_dtiIntersectFibersWithRoi('and', minDist2, ROI2, FG);

%��������»�ͨ��ͷ����ά��,ȥ��������mask���ϵ���ά����ȥ��������mask4mm���ϵ���ά��
SupDist=4;
DownDist=4;
% keepsupindex=ones(486,1);
for i=1:length(fibers)
        Cortex_SpinalFibers.Tracts{1,i}(1:SupDist-keepIDfirst(i),:)=[]; 
        Cortex_SpinalFibers.TractFA{1,i}(1:SupDist-keepIDfirst(i),:)=[];
        Cortex_SpinalFibers.TractMD{1,i}(1:SupDist-keepIDfirst(i),:)=[];
        Cortex_SpinalFibers.TractFE{1,i}(1:SupDist-keepIDfirst(i),:)=[];
        Cortex_SpinalFibers.TractGEO{1,i}(1:SupDist-keepIDfirst(i),:)=[];
        Cortex_SpinalFibers.TractLambdas{1,i}(1:SupDist-keepIDfirst(i),:)=[];
        Cortex_SpinalFibers.TractAng{1,i}(1:SupDist-keepIDfirst(i),:)=[];
end

for i=1:length(fibers)
    if length(fibers{1,i})-keep2IDlast(i,1)>=1&&length(fibers{1,i})-keep2IDlast(i,1)<=4
        Cortex_SpinalFibers.Tracts{1,i}(end:-1:DownDist-length(fibers{1,i})+keepID2last(i),:)=[];
        Cortex_SpinalFibers.TractFA{1,i}(end:-1:DownDist-length(fibers{1,i})+keepID2last(i),:)=[];
        Cortex_SpinalFibers.TractMD{1,i}(end:-1:DownDist-length(fibers{1,i})+keepID2last(i),:)=[];
        Cortex_SpinalFibers.TractFE{1,i}(end:-1:DownDist-length(fibers{1,i})+keepID2last(i),:)=[];
        Cortex_SpinalFibers.TractGEO{1,i}(end:-1:DownDist-length(fibers{1,i})+keepID2last(i),:)=[];
        Cortex_SpinalFibers.TractLambdas{1,i}(end:-1:DownDist-length(fibers{1,i})+keepID2last(i),:)=[];
        Cortex_SpinalFibers.TractAng{1,i}(end:-1:DownDist-length(fibers{1,i})+keepID2last(i),:)=[];
    end
end
Cortex_SpinalFibers.TractL{i}=length(Cortex_SpinalFibers.Tracts{1,i});




keepall=zeros(size(keep));
for i=1:length(keep)
    keepall(i,1)=keep(i,1)&&keep2(i,1);
end
Cortex_SpinalFibers.FList=(1:sum(keepall,1));
for i=1:length(keepall)
    if keepall(i,1)==0
        Cortex_SpinalFibers.Tracts{1,i}=[];
        Cortex_SpinalFibers.TractFA{1,i}=[];
        Cortex_SpinalFibers.TractMD{1,i}=[];
        Cortex_SpinalFibers.TractFE{1,i}=[];
        Cortex_SpinalFibers.TractL{1,i}=[];
        Cortex_SpinalFibers.TractGEO{1,i}=[];
        Cortex_SpinalFibers.TractLambdas{1,i}=[];
        Cortex_SpinalFibers.TractAng{1,i}=[];
    end
end
Cortex_SpinalFibers.Tracts(cellfun(@isempty,Cortex_SpinalFibers.Tracts))=[];
Cortex_SpinalFibers.TractFA(cellfun(@isempty,Cortex_SpinalFibers.TractFA))=[];
Cortex_SpinalFibers.TractMD(cellfun(@isempty,Cortex_SpinalFibers.TractMD))=[];
Cortex_SpinalFibers.TractFE(cellfun(@isempty,Cortex_SpinalFibers.TractFE))=[];
Cortex_SpinalFibers.TractL(cellfun(@isempty,Cortex_SpinalFibers.TractL))=[];
Cortex_SpinalFibers.TractGEO(cellfun(@isempty,Cortex_SpinalFibers.TractGEO))=[];
Cortex_SpinalFibers.TractLambdas(cellfun(@isempty,Cortex_SpinalFibers.TractLambdas))=[];
Cortex_SpinalFibers.TractAng(cellfun(@isempty,Cortex_SpinalFibers.TractAng))=[];

FList=Cortex_SpinalFibers.FList;
Tracts=Cortex_SpinalFibers.Tracts;
TractMD=Cortex_SpinalFibers.TractMD;
TractFA=Cortex_SpinalFibers.TractFA;
TractFE=Cortex_SpinalFibers.TractFE;
TractL=Cortex_SpinalFibers.TractL;
TractGEO=Cortex_SpinalFibers.TractGEO;
TractLambdas=Cortex_SpinalFibers.TractLambdas;
TractAng=Cortex_SpinalFibers.TractAng;
TractMask=Cortex_SpinalFibers.TractMask;
VDims=Cortex_SpinalFibers.VDims;






