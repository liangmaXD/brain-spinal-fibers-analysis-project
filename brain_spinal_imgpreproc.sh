#!/bin/sh
# 此文件为孔亚卓老师编写，主要预处理步骤包含topup磁化系数矫正、eddy头动涡流矫正及dtifit张量拟合。可根据需要添加别的处理不住
  #另外需要说明的是，topup中的acq.txt及zeros.txt需要根据具体扫描情况确定。
# dti_pipeline
# $1 - filename of input DTI AP
# $2 - filename of input DTI PA
# $3 - filename of input bvals
# $4 - filename of input bvecs
#
# Yazhuo Kong, FMRIB, OXFORD -- 07/2019

if [ $# -ne 4 ] ; then  #[$# -ne 4] 表示，如果给这个函数输入的参数不等于（not equal，ne）4
  echo "Usage: cord_dti.sh <input DTI AP> <input DTI PA> <bvals> <bvecs>"#输出这个函数的使用方法
  exit 1 #exit 0 代表正常运行退出，exit 1代表运行失败退出
fi #if 结束，类似于c中 的{}；

fullpath=`dirname $1` ;                                          # path to file
mv $1 $fullpath/AP.nii.gz;
mv $2 $fullpath/PA.nii.gz;
mv $3 $fullpath/bvals;
mv $4 $fullpath/bvecs;

echo Working on $fullpath

fslroi $fullpath/AP $fullpath/B01_AP.nii.gz 0 1;
fslroi $fullpath/PA $fullpath/B01_PA.nii.gz 0 1;


fslmerge -t $fullpath/B0_4D_AP_PA $fullpath/B01_AP.nii.gz $fullpath/B01_PA.nii.gz;
fslmerge -t $fullpath/Big_4D $fullpath/AP $fullpath/PA;

topup --imain=$fullpath/B0_4D_AP_PA --datain=$fullpath/acq.txt --out=$fullpath/topup --fout=$fullpath/field --config=$FSLDIR/etc/flirtsch/b02b0_1.cnf -v --iout=$fullpath/unwarped;
#acq.txt 为扫描参数，zeros.txt 为表示哪些图像是ap，哪些图像是pa ,关于这两个参数的具体解释可以参考"https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/topup/TopupUsersGuide?highlight=%28topup%29"
#applytopup -i ${fullpath}/AP,${fullpath}/PA -a ${fullpath}/acp.txt -x 1,2 -t ${fullpath}/topup -o ${fullpath}/data -v;

fslmaths $fullpath/unwarped -Tmean $fullpath/nodif;

paste $fullpath/bvals ~/bin/zero.txt > $fullpath/bvals2;
paste $fullpath/bvecs ~/bin/zeros.txt > $fullpath/bvecs2;

eddy --imain=$fullpath/Big_4D --acqp=acq.txt --mask=$fullpath/nodif --index=index.txt --bvals=$fullpath/bvals2 --bvecs=$fullpath/bvecs2 --out=$fullpath/eddy_unwarped_images --topup=$fullpath/topup --fwhm=5 --flm=quadratic -v;

#dtifit -k $fullpath/data -r $fullpath/bvecs -b $fullpath/bvals -o $fullpath/DTItopup -m $fullpath/nodif;

dtifit -k $fullpath/eddy_unwarped_images -r $fullpath/bvecs2 -b $fullpath/bvals2 -o $fullpath/DTIeddy -m $fullpath/nodif;
