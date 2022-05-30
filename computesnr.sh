#! /bin/bash

#namelist=${'/media/xd/Mario1/brain_SpinalData/MRIdata/namelist.TXT'}


for names in S028 S033 S034 S037 S040 S041 S042 S043 S044 S047 S048 S049 S050 S052 S053 S055 S056 S057 S058 S059 S060 S062 S063 S064 S065 S066 S068 S069 S070 S071 S072 S073 S074 S075 S077 S078 S080 S081 S082 S084 S085 S089 S090 S091 S092 S096 S098 S099 S100 S101 S102 S103 S104 S105 S106 S107 S108
do 
	cd $names/splitImage
	pwd
	#bet2 $names'_b0.nii.gz' $names'_b0_brain.nii.gz' -m 
	#sct_create_mask -i $names'_spinaldmri_dwi_mean.nii' -p centerline,$names'_spinaldmri_dwi_mean_seg_mul_thr.nii' -size 35mm -o $names'_spinalmask.nii.gz'
	sct_compute_snr -i $names'_braindmri.nii' -m $names'_b0_brain.nii.gz' -method diff -vol 0,16 -o $names'_brain_diff' 
	sct_compute_snr -i $names'_braindmri.nii' -m $names'_b0_brain.nii.gz' -method mult  -o $names'_brain_mult'
	sct_compute_snr -i $names'_spinaldmri.nii' -m $names'_spinaldmri_dwi_mean_seg_mul_thr.nii' -method diff -vol 0,16 -o $names'_spianl_diff' 
	sct_compute_snr -i $names'_spinaldmri.nii' -m $names'_spinaldmri_dwi_mean_seg_mul_thr.nii' -method mult -o $names'_spinal_mult'
	cd ..
	cd ..
	
done	





for names in S028 S033 S034 S037 S040 S041 S042 S043 S044 S047 S048 S049 S050 S052 S053 S055 S056 S057 S058 S059 S060 S062 S063 S064 S065 S066 S068 S069 S070 S071 S072 S073 S074 S075 S077 S078 S080 S081 S082 S084 S085 S089 S090 S091 S092 S096 S098 S099 S100 S101 S102 S103 S104 S105 S106 S107 S108
do 
	cd $names/splitImage
	pwd
	#bet2 $names'_b0.nii.gz' $names'_b0_brain.nii.gz' -m 
	#sct_create_mask -i $names'_spinaldmri_dwi_mean.nii' -p centerline,$names'_spinaldmri_dwi_mean_seg_mul_thr.nii' -size 35mm -o $names'_spinalmask.nii.gz'
	sct_compute_snr -i $names'_braindmri.nii' -m $names'_b0_brain.nii.gz' -method diff -vol 0,1 -o $names'_snr_brain_diff'
	sct_compute_snr -i $names'_braindmri.nii' -m $names'_b0_brain.nii.gz' -method mult -o $names'_snr_brain_multx'
	sct_compute_snr -i $names'_spinaldmri.nii' -m $names'_spinaldmri_dwi_mean_seg.nii' -method diff -vol 0,1 -o $names'_snr__spianl_diff'
	sct_compute_snr -i $names'_spinaldmri.nii' -m $names'_spinaldmri_dwi_mean_seg.nii' -method mult -o $names'_snr_spinal_mult
	cd ..
	cd ..
	
	
done	





for names in S028 S033 S034 S037 S040 S041 S042 S043 S044 S047 S048 S049 S050 S052 S053 S055 S056 S057 S058 S059 S060 S062 S063 S064 S065 S066 S068 S069 S070 S071 S072 S073 S074 S075 S077 S078 S080 S081 S082 S084 S085 S089 S090 S091 S092 S096 S098 S099 S100 S101 S102 S103 S104 S105 S106 S107 S108
do 
       pwd
	sct_compute_snr -i $names/$names'_dmri.nii' -m /Users/ljx/Desktop/maliang/mask/$names'_b0_brain.nii.gz_mask.nii' -method diff -vol 0,16 -o /Users/ljx/Desktop/maliang/mask/$names'_snr_brain_spinal_diff'

done	