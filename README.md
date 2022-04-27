# brain-spinal-fibers-analysis-project
 1. 飞利浦扫描的数据不能直接用dcm2niigui的方式转成nii格式，需要在终端下使用命令 dcm2niix 
 2. brain_spinal_imgpreproc.sh 是所有操作的第一步，对图像进行预处理。
 3. 对图像进行完预处理后进行纤维束追踪，这一步在exploreDTI中完成。 路径：PLugins->whole brain tratography->DTI 。
 4. 得到全脑纤维束追踪，为了得到感兴趣纤维束，需要使用ROI两两套取纤维束。
 5. 需要使用mask套取纤维束，这一步是出问题最多的，即使在模板上套取纤维束，也不可能完全用程序得到让你满意的纤维束，在这一步我们尝试了很多种方式，最终选择手动挑选纤维束，将个体mask分别在大脑中的丘脑和皮层为感兴趣区套取丘脑-皮层束；丘脑和脊髓ROI套取丘脑-脊髓纤维束。所有流程都在exploreDTI中完成。
 6. 个体纤维束配准也是很重要的一步，个体纤维束配准我们选择基于个体的纤维束配准方式。
