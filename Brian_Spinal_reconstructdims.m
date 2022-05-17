% 1.�˳�����������ؽ��ڸ���ͼ���ڴ�����֮���ά�ȣ��Ա���ExploreDTI���������ԭ��ͼ�����
% author:maliang
% 23/7/2020 ,XiDianUniversity
% warning !!!:������ʹ��SPM8��������Ϊ����
%% Read subject space image including spinalcord image and Brain image
%��ȡͼ��
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
%'S037'... 57,63,66,71��ɾ����ά��ע�Ͳ�������Ϊ��Щ�˵���ά��̫��
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

    %DTI׷�ٵ�ͼ��;
    Imagepath_FA='G:\Cortical_spinalcord\Tracted_result';
    FA_Image=[Names{a},'_FA.nii'];
    FA_v=spm_vol(spm_select('FPList',Imagepath_FA,FA_Image));
    FA_w=spm_read_vols(FA_v);

    %����ƴ�����֮���ͼ��
    LabeledImagepath='G:\Cortical_spinalcord\labeledImage';%sct��ǵ�׵��ͼ��
    LabeledImage=[Names{a},'_tha_Labeled.nii'];
    %% ��������Ƿ�����������ĳһ���Ƿ����ȫ���״����
    BrainDims=size(Brain_w);
    SpinalDims=size(Spinal_w);
    FADims=size(FA_w);  %ֻ��B0���ж��ٲ㣻
    index=0;
    for z= SpinalDims(1,3):-1:1
        if length(find(Spinal_w(:,:,z)==0))==SpinalDims(1,1)*SpinalDims(1,2)
%           Spinal_w(:,:,z)=[];
            index=index+1;
            fprintf(['�������ݵĵ�',num2str(z),'��ȫΪ0\n']);
        end
    end
    for i=1:index
        Spinal_w(:,:,SpinalDims(1,3)-index+i)=Spinal_w(:,:,SpinalDims(1,3)-index);
    end

    %% �Ƚ�ͼ��ά�ȴ�С
    %���ڼ���͹���ڴ����������������Ĳü���������xoyƽ��������ά�Ⱥ�ԭʼ������ά��
    %�϶���ƥ�䣬���ֻ�Ƚ���z�����Ƿ���ά��ƥ�䣻
    BrainDims=size(Brain_w);
    SpinalDims=size(Spinal_w);

    if BrainDims(1,3)+SpinalDims(1,3)~=FADims(1,3)
        fprintf('���ݷָ�������ڼ��趥��ȱ�ٲ�!\n');
        NumofSupplyLayer=FADims(1,3)-(BrainDims(1,3)+SpinalDims(1,3));%����Ķ��˲�����Ӧ�Ĳ㣬����ֱ�Ӳ���W�����Ϳ�����
        SupplySpinal_w=zeros(SpinalDims(1,1),SpinalDims(1,2),NumofSupplyLayer);
        Spinal_w=cat(3,Spinal_w,SupplySpinal_w);
        fprintf('�������ݲ������!\n');
    else
        fprintf('�������ݲ���ƥ��!\n');
    end                                    %�������ݲ�������
    SpinalDims=size(Spinal_w);             %���¼������ݵ�����ά��;
    %% XOYƽ������ά���ؽ�
    % �ⲿ����Ҫ���м����ϵ�XOYƽ������ά���ؽ������Ե����ݲ��ý������ؽ�����Ϊά�ȱ���ƥ��
    %���ǰѼ���ֱ����׼��dmri_dwi_mean...����ļ��ϣ�����Ĳ�����������˵�Ѿ�����Ҫ��
    if FADims(1,1)~=SpinalDims(1,1)
        Xlayers=FADims(1,1)-SpinalDims(1,1);  %�õ�X��������Ҫ����Ĳ���
        Ylayers=FADims(1,2)-SpinalDims(1,2);  %�õ�Y��������Ҫ����Ĳ���

        %�Լ�������Ϊ���ģ������ڼ�������ߣ�
        if  mod(Xlayers,2)==0
            LeftXlayers=Xlayers/2; 
            RightXlayers=Xlayers/2;
        else
            LeftXlayers=(Xlayers-1)/2;
            RightXlayers=(Xlayers+1)/2;
        end
        %�Լ�������Ϊ���ģ������ڼ����ǰ��
        if  mod(Ylayers,2)==0
            AnteriorYlayers=Ylayers/2; 
            PosteriorYlayers=Ylayers/2;
        else
            AnteriorYlayers=(Ylayers-1)/2;
             PosteriorYlayers=(Ylayers+1)/2;
        end

        %����X�����ϵ�����ά��
        for x=1:SpinalDims(1,1)
            Spinal_w(x+LeftXlayers,:,:)=Spinal_w(x,:,:);
        end
        Spinal_w(1:LeftXlayers,:,:)=0;
        Spinal_w(SpinalDims(1,1)+LeftXlayers+1:SpinalDims(1,1)+Xlayers,:,:)=0;

        %����Y�����ϵ�����ά��
        for Y=1:SpinalDims(1,2)
            Spinal_w(:,Y+AnteriorYlayers,:)=Spinal_w(:,Y,:);
        end
        Spinal_w(:,1:AnteriorYlayers,:)=0;
        Spinal_w(:,SpinalDims(1,2)+AnteriorYlayers+1:SpinalDims(1,2)+Ylayers,:)=0;
    else
        fprintf('XOYƽ������ά��ƥ��\n');
    end 
    %% ���½����������ƴ����һ��
    %�޸ľ�����Ϣ
    Spinal_v.dim=size(Spinal_w);
    whole_v=FA_v;
    whole_v.fname=[LabeledImagepath,'\',LabeledImage];
    if FA_v.dim(1,1)==Brain_v.dim(1,1)&&Brain_v.dim(1,1)==Spinal_v.dim(1,1)&&FA_v.dim(1,3)==Brain_v.dim(1,3)+Spinal_v.dim(1,3)&&FA_v.dim(1,2)==Brain_v.dim(1,2)&&FA_v.dim(1,2)==Spinal_v.dim(1,2)
        whole_v.dim=FA_v.dim;
    else
        fprintf('����ƴ��&��������뷵�ؼ��!\n');
        return ;%���ƴ�Ӵ�����ֹ������̣�
    end

    whole_v.dt=FA_v.dt;
    whole_v.pinfo=FA_v.pinfo;
    whole_v.mat=FA_v.mat;
    %ƴ�Ӿ���
    whole_w=zeros(size(FA_w));
    whole_w(:,:,1:SpinalDims(1,3))=Spinal_w(:,:,:);
    whole_w(:,:,SpinalDims(1,3)+1:SpinalDims(1,3)+BrainDims(1,3))=Brain_w(:,:,:);

    %���ӶԱȶ�
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