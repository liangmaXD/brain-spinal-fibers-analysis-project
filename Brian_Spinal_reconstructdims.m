% 1.此程序的作用是重建在个体图像在处理完之后的维度，以便在ExploreDTI里面个个体原本图像对齐
% author:maliang
% 23/7/2020 ,XiDianUniversity
% warning !!!:程序请使用SPM8及以下作为工具
%% Read subject space image including spinalcord image and Brain image
%读取图像
% Brain Image 
Names={
'S028'...
'S033'...
'S034'...
'S040'...
'S041'...
'S042'...
'S043'...
'S044'...
'S047'...
'S048'...
'S049'...
'S050'...
'S052'...
'S053'...
'S055'...
'S056'...
'S058'...
'S059'...
'S060'...
'S062'...
'S064'...
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
'S092'...
'S096'...
'S098'...
'S099'...
'S100'...
'S101'...
'S102'...
'S103'...
'S104'...
'S105'...
'S106'...
'S107'...
'S108'...
};
%'S037'... 57,63,66,71先删除纤维束注释部分是因为这些人的纤维束太短
for a=1:length(Names)
    BrainImagepath=['H:\maliang\brain_SpinalData\MRIdata\',Names{a},'\spltImage'];
    BrainImage='tha_mask_on_dti.nii';
    Brain_v=spm_vol(spm_select('FPList',BrainImagepath,BrainImage));
    Brain_w=spm_read_vols(Brain_v);

    %Spinalcord Image
    SpinalImagepath=['H:\maliang\brain_SpinalData\MRIdata\',Names{a},'\splitImage'];
    SpinalImage=[Names{a},'_spinalT1_labeled_reg.nii'];
    Spinal_v=spm_vol(spm_select('FPList',SpinalImagepath,SpinalImage));
    Spinal_w=spm_read_vols(Spinal_v);

    %DTI追踪的图像;
    Imagepath_FA='G:\Cortical_spinalcord\Tracted_result';
    FA_Image=[Names{a},'_FA.nii'];
    FA_v=spm_vol(spm_select('FPList',Imagepath_FA,FA_Image));
    FA_w=spm_read_vols(FA_v);

    %数据拼接完成之后的图像；
    LabeledImagepath='G:\Cortical_spinalcord\labeledImage';%sct标记的椎节图像
    LabeledImage=[Names{a},'_tha_Labeled.nii'];
    %% 检查数据是否正常，比如某一层是否存在全零的状况；
    BrainDims=size(Brain_w);
    SpinalDims=size(Spinal_w);
    FADims=size(FA_w);  %只看B0像有多少层；
    index=0;
    for z= SpinalDims(1,3):-1:1
        if length(find(Spinal_w(:,:,z)==0))==SpinalDims(1,1)*SpinalDims(1,2)
%           Spinal_w(:,:,z)=[];
            index=index+1;
            fprintf(['脊髓数据的第',num2str(z),'层全为0\n']);
        end
    end
    for i=1:index
        Spinal_w(:,:,SpinalDims(1,3)-index+i)=Spinal_w(:,:,SpinalDims(1,3)-index);
    end

    %% 比较图像维度大小
    %由于脊髓凸显在处理过程中做过脊髓的裁剪，所以在xoy平面上数据维度和原始的数据维度
    %肯定不匹配，因此只比较在z轴上是否是维度匹配；
    BrainDims=size(Brain_w);
    SpinalDims=size(Spinal_w);

    if BrainDims(1,3)+SpinalDims(1,3)~=FADims(1,3)
        fprintf('数据分割过程中在脊髓顶端缺少层!\n');
        NumofSupplyLayer=FADims(1,3)-(BrainDims(1,3)+SpinalDims(1,3));%脊髓的顶端补上相应的层，我们直接补充W的最顶层就可以了
        SupplySpinal_w=zeros(SpinalDims(1,1),SpinalDims(1,2),NumofSupplyLayer);
        Spinal_w=cat(3,Spinal_w,SupplySpinal_w);
        fprintf('轴向数据补充完成!\n');
    else
        fprintf('轴向数据层数匹配!\n');
    end                                    %轴向数据补充层完成
    SpinalDims=size(Spinal_w);             %更新脊髓数据的轴向维度;
    %% XOY平面数据维度重建
    % 这部分主要进行脊髓上的XOY平面数据维度重建，大脑的数据不用进行再重建，因为维度本身匹配
    %我们把脊髓直接配准到dmri_dwi_mean...这个文件上，横向的补充理论上来说已经不需要了
    if FADims(1,1)~=SpinalDims(1,1)
        Xlayers=FADims(1,1)-SpinalDims(1,1);  %得到X方向上需要补充的层数
        Ylayers=FADims(1,2)-SpinalDims(1,2);  %得到Y方向上需要补充的层数

        %以脊髓整体为中心，补充在脊髓的两边；
        if  mod(Xlayers,2)==0
            LeftXlayers=Xlayers/2; 
            RightXlayers=Xlayers/2;
        else
            LeftXlayers=(Xlayers-1)/2;
            RightXlayers=(Xlayers+1)/2;
        end
        %以脊髓整体为中心，补充在脊髓的前后
        if  mod(Ylayers,2)==0
            AnteriorYlayers=Ylayers/2; 
            PosteriorYlayers=Ylayers/2;
        else
            AnteriorYlayers=(Ylayers-1)/2;
             PosteriorYlayers=(Ylayers+1)/2;
        end

        %补充X方向上的数据维度
        for x=1:SpinalDims(1,1)
            Spinal_w(x+LeftXlayers,:,:)=Spinal_w(x,:,:);
        end
        Spinal_w(1:LeftXlayers,:,:)=0;
        Spinal_w(SpinalDims(1,1)+LeftXlayers+1:SpinalDims(1,1)+Xlayers,:,:)=0;

        %补充Y方向上的数据维度
        for Y=1:SpinalDims(1,2)
            Spinal_w(:,Y+AnteriorYlayers,:)=Spinal_w(:,Y,:);
        end
        Spinal_w(:,1:AnteriorYlayers,:)=0;
        Spinal_w(:,SpinalDims(1,2)+AnteriorYlayers+1:SpinalDims(1,2)+Ylayers,:)=0;
    else
        fprintf('XOY平面数据维度匹配\n');
    end 
    %% 重新将脊髓和脑子拼接在一起；
    %修改矩阵信息
    Spinal_v.dim=size(Spinal_w);
    whole_v=FA_v;
    whole_v.fname=[LabeledImagepath,'\',LabeledImage];
    if FA_v.dim(1,1)==Brain_v.dim(1,1)&&Brain_v.dim(1,1)==Spinal_v.dim(1,1)&&FA_v.dim(1,3)==Brain_v.dim(1,3)+Spinal_v.dim(1,3)&&FA_v.dim(1,2)==Brain_v.dim(1,2)&&FA_v.dim(1,2)==Spinal_v.dim(1,2)
        whole_v.dim=FA_v.dim;
    else
        fprintf('矩阵拼接&补充错误，请返回检查!\n');
        return ;%如果拼接错误，终止程序进程；
    end

    whole_v.dt=FA_v.dt;
    whole_v.pinfo=FA_v.pinfo;
    whole_v.mat=FA_v.mat;
    %拼接矩阵
    whole_w=zeros(size(FA_w));
    whole_w(:,:,1:SpinalDims(1,3))=Spinal_w(:,:,:);
    whole_w(:,:,SpinalDims(1,3)+1:SpinalDims(1,3)+BrainDims(1,3))=Brain_w(:,:,:);

    %增加对比度
    for z =1:37
        for j=1:192
            for i=1:192
                if whole_w(i,j,z)~=0
                    whole_w(i,j,z)=whole_w(i,j,z)*1000;
                end
            end
        end 
    end

    spm_write_vol(whole_v,whole_w);
end