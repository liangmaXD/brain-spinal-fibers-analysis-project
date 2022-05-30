#! /bin/bash

#namelist=${'/media/xd/Mario1/brain_SpinalData/MRIdata/namelist.TXT'}


for names in S028 S033 S034 S037 S040 S041 S042 S043 S044 S047 S048 S049 S050 S052 S053 S055 S056 S057 S058 S059 S060 S062 S063 S064 S065 S066 S068 S069 S070 S071 S072 S073 S074 S075 S077 S078 S080 S081 S082 S084 S085 S089 S090 S091 S092 S096 S098 S099 S100 S101 S102 S103 S104 S105 S106 S107 S108
do 
	cd $names/splitImage
	pwd
	sct_dmri_separate_b0_and_dwi -i $names'_spinaldmri.nii' -bvec /Users/ljx/Desktop/maliang/brain_SpinalData/MRIdata/$names/$names'.bvec'
	sct_propseg -i $names'_spinaldmri_dwi_mean.nii' -c dwi -qc qc
	sct_maths -i $names'_spinaldmri_dwi_mean_seg.nii' -mul $names'_spinaldmri_dwi_mean.nii' -o $names'_spinaldmri_dwi_mean_seg_mul.nii'
	sct_maths -i $names'_spinaldmri_dwi_mean_seg_mul.nii' -bin 0.0001 -o $names'_spinaldmri_dwi_mean_seg_mul_thr.nii'
	sct_create_mask -i $names'_spinaldmri_dwi_mean.nii' -p centerline,$names'_spinaldmri_dwi_mean_seg_mul_thr.nii' -size 35mm
	sct_crop_image -i $names'_spinaldmri.nii' -m mask_$names'_spinaldmri_dwi_mean.nii' -o $names'_spinaldmri_crop.nii'
	sct_dmri_moco -i $names'_spinaldmri_crop.nii' -bvec /Users/ljx/Desktop/maliang/brain_SpinalData/MRIdata/$names/$names'.bvec'
	#process T1 scan
	sct_deepseg_sc -i $names'_spinalT1.nii' -c t1 -qc qc
	sct_label_vertebrae -i $names'_spinalT1.nii' -s $names'_spinalT1_seg.nii' -c t1 -qc qc
	sct_register_multimodal -i $names'_spinalT1_seg_labeled.nii' -d $names'_spinaldmri_crop_moco_dwi_mean.nii' -o $names'_spinalT1_labeled_reg.nii'
	cd ..
	cd ..
	
	
done	


#
