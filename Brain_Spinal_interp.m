%% 
% Functions: Brain_SPinal_coordinate_trans&interpolate
% Input:    (1):Subkect's RD image;
%           (2):coordinates from Explore DTI or AFQ;
% output    (3):RD value in native space;
%Author:    Maliang,XiDian University 7/8/2020
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

arc_length=1:50;
for k=1:length(Names)
    p1=spm_select('FPList','G:\Cortical_spinalcord\Tracted_result\',[Names{k},'_FA.nii']);
    v1=spm_vol(p1);
    w1=spm_read_vols(v1);
    p2=spm_select('FPList','G:\Cortical_spinalcord\Tracted_result\',[Names{k},'_MD.nii']);
    v2=spm_vol(p2);
    w2=spm_read_vols(v2);
    p3=spm_select('FPList','G:\Cortical_spinalcord\Tracted_result\',[Names{k},'_L1.nii']);
    v3=spm_vol(p3);
    w3=spm_read_vols(v3);
    p4=spm_select('FPList','G:\Cortical_spinalcord\Tracted_result\',[Names{k},'_RD.nii']);
    v4=spm_vol(p4);
    w4=spm_read_vols(v4);
    [M,N,P]=size(w1);
    X=1.2:1.2:1.2*M;
    Y=1.2:1.2:1.2*N;
    Z=4:4:4*P;
    trans_cord={};
    load(['G:\Cortical_spinalcord\FiberTracts\tha_x_Tracts\',Names{k},'\tha_acc\','tha_acc_seg_L_resample50.mat']);
    Cord1=fg_out.fibers;
    Cord1=Cord1';
%     for i=1:length(Cord1)
%         if(Cord1{1,i}(1,1)<Cord1{1,i}(end,1))
%             Cord1{1,i}=flipud(Cord1{1,i});%丘脑到脊髓
%         end
%     end 


    for i=1:length(Cord1)
        Cord_tmp=Cord1{1,i}';
        for j=1:length(Cord_tmp)
            Cord_tmp1(j,:)=[1.2*M-Cord_tmp(j,2)+1.2,1.2*N-Cord_tmp(j,1)+1.2,Cord_tmp(j,3)];%使用体素坐标进行插值；
        end  
        for j=1:length(Cord_tmp1)
            FA(i,j)=interp3(X,Y,Z,w1,Cord_tmp1(j,2),Cord_tmp1(j,1),Cord_tmp1(j,3));
            MD(i,j)=interp3(X,Y,Z,w2,Cord_tmp1(j,2),Cord_tmp1(j,1),Cord_tmp1(j,3));
            AD(i,j)=interp3(X,Y,Z,w3,Cord_tmp1(j,2),Cord_tmp1(j,1),Cord_tmp1(j,3));
            RD(i,j)=interp3(X,Y,Z,w4,Cord_tmp1(j,2),Cord_tmp1(j,1),Cord_tmp1(j,3));
        end
    end 
    for m=1:size(FA,1)
       fig_FA= plot(arc_length,FA(m,:),'b');
       hold on;
    end
    title([Names{k},'_FAarclength']);
    saveas(fig_FA,['G:\Cortical_spinalcord\FiberTracts\tha_x_Tracts\',Names{k},'\tha_acc\',Names{k},'FAarclength_50_L.fig']);
    hold off;
    save(['G:\Cortical_spinalcord\FiberTracts\tha_x_Tracts\',Names{k},'\tha_acc\',Names{k},'interped_FA_50_L.mat'],'FA');
    
    for m=1:size(MD,1)
       fig_FA= plot(arc_length,MD(m,:),'b');
       hold on;
    end
    title([Names{k},'_MDarclength']);
    saveas(fig_FA,['G:\Cortical_spinalcord\FiberTracts\tha_x_Tracts\',Names{k},'\tha_acc\',Names{k},'MDarclength_50_L.fig']);
    hold off;
    save(['G:\Cortical_spinalcord\FiberTracts\tha_x_Tracts\',Names{k},'\tha_acc\',Names{k},'interped_MD_50_L.mat'],'MD');
    
    for m=1:size(AD,1)
       fig_AD= plot(arc_length,AD(m,:),'b');
       hold on;
    end
    title([Names{k},'_ADarclength']);
    saveas(fig_AD,['G:\Cortical_spinalcord\FiberTracts\tha_x_Tracts\',Names{k},'\tha_acc\',Names{k},'ADarclength_50_L.fig']);
    hold off;
    save(['G:\Cortical_spinalcord\FiberTracts\tha_x_Tracts\',Names{k},'\tha_acc\',Names{k},'interped_AD_50_L.mat'],'AD');
    
    for m=1:size(RD,1)
       fig_RD= plot(arc_length,RD(m,:),'b');
       hold on;
    end
    title([Names{k},'_RDarclength']);
    saveas(fig_RD,['G:\Cortical_spinalcord\FiberTracts\tha_x_Tracts\',Names{k},'\tha_acc\',Names{k},'RDarclength_50_L.fig']);
    hold off;
    save(['G:\Cortical_spinalcord\FiberTracts\tha_x_Tracts\',Names{k},'\tha_acc\',Names{k},'interped_RD_50_L.mat'],'RD');
end
%% make correlations 
% cor=[];
% index=[];
% for i=2:34
%     cor(i,:)=corr(RD_tmp(1,:)',RD_tmp(i,:)');%
% %     plot(cor);
%     hold on;
% end
% tmp=sort(cor);
% RD_tmp_corr=RD_tmp;
% for i=1:11
%     index(i)=find(cor==tmp(i)); 
%     RD_tmp_corr(index(i),:)=0;
% end
% for k=34:-1:1
%     if RD_tmp_corr(k,:)==0
%         RD_tmp_corr(k,:)=[];
%     end
% end
% 
% figure(2);
% for i=1:size(RD_tmp_corr,1)
%     plot(arc_length,RD_tmp_corr(i,:),'r');
%     hold on;
% end
% xlabel('arc_length');
% ylabel('RD');
% 
% %
% %mean value of RD per two points;
% RD_mean2p=[];
% 
% for i=1:71
%     a=RD_tmp_corr(i,1:2:100);
%     b=RD_tmp_corr(i,2:2:100);
%     RD_mean2p(i,:)=(a+b)./2;
% end
% arc_length2=1:50;
% figure(3);
% for i=1:length(RD_mean2p)
%     plot(arc_length2,RD_mean2p(i,:),'b');
%     hold on;
% end
% xlabel('arc_length2');
% ylabel('RD');



