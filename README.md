# brain-spinal-fibers-analysis-project
 1. 飞利浦扫描的数据不能直接用dcm2niigui的方式转成nii格式，需要在终端下使用命令 dcm2niix 
 2. brain_spinal_imgpreproc.sh 是所有操作的第一步，对图像进行预处理。
 3. 对图像进行完预处理后进行纤维束追踪，这一步在exploreDTI中完成。 路径：PLugins->whole brain tratography->DTI 。
 4. 得到全脑纤维束追踪，为了得到感兴趣纤维束，需要使用ROI两两套取纤维束。
