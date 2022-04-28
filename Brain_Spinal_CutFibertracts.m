%% 使用AFQ的函数截取脊髓的最下面
FG.name = 'Cortex_Spinal';
FG.Abb = [];
Cortex_SpinalFibersPath = 'G:\Cortical_spinalcord\S028\test.mat';
Cortex_SpinalFibers = load(Cortex_SpinalFibersPath);
fibers = Cortex_SpinalFibers.Tracts;
num_of_fibers = length(fibers);

p = spm_select('FPList','G:\Cortical_spinalcord\Tracted_result','S028_FA.nii'); %选取模板的FA图像
v = spm_vol(p);
w = spm_read_vols(v);
[m,n,~]=size(w);
for i = 1:num_of_fibers
    Cord_tmp0 = fibers{1,i};
    Cord_tmp1(:,1) = Cord_tmp0(:,1)./abs(v.mat(1,1));%转换成体素坐标(实际上换的是尺度大小)
    Cord_tmp1(:,2) = Cord_tmp0(:,2)./abs(v.mat(2,2));%体素中的中心是整数，但纤维上的点不一定是体素中心，所以会有小数
    Cord_tmp1(:,3) = Cord_tmp0(:,3)./abs(v.mat(3,3));
    Cord_tmp1=[m-Cord_tmp1(:,2)+1,n-Cord_tmp1(:,1)+1,Cord_tmp1(:,3)];%坐标的翻转-转置-翻转（换方向）
    FG.fibers{1,i} = double(Cord_tmp1'); % nearpoint函数需要输入同类型的3xN和3xM矩阵
    Cord_tmp1 = [];
end
clear Cord_tmp0 Cord_tmp1 p v w m n l  %
%% 导入ROI1,大脑mask
ROIpath = 'G:\Cortical_spinalcord\S028\mask';
ROIname_0 = dir(fullfile(ROIpath,'BrainMask.nii'));% 读取全脑的ROI
ROIname = {ROIname_0.name};

minDist1 =30;% 1.732: 2倍1x1x1对角线距离,4倍3.48，3倍2.61;距离设置是主观测量。
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
ROI.coords = [x, y, z]; % ROI处于体素坐标
%keepfirst和keeplast是这一条纤维束上第一个不为零的位置，和最后一个不为零的位置
[fgOut, keep,keepIDfirst,keepIDlast] = ...
TABS_dtiIntersectFibersWithRoi('and', minDist1, ROI, FG);

%导入ROI2.脊髓上的mask
ROI2path = 'G:\Cortical_spinalcord\S028\mask';
ROI2name_0 = dir(fullfile(ROIpath,'C7Mask.nii'));% 读取全脑的ROI
ROI2name = {ROIname_0.name};

minDist2 =30;% 1.732: 2倍1x1x1对角线距离,4倍3.48，3倍2.61;这个距离设置要讨论一下
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
ROI2.coords = [x, y, z]; % ROI处于体素坐标
[fg2Out, keep2,keep2IDfirst,keep2IDlast] = ...
TABS_dtiIntersectFibersWithRoi('and', minDist2, ROI2, FG);

%与操作留下互通两头的纤维束,去掉最上面mask以上的纤维束，去掉最下面mask4mm以上的纤维束
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






