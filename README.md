﻿# brain-spinal-fibers-analysis-project
 1. 飞利浦扫描的数据不能直接用dcm2niigui的方式转成nii格式，需要在终端下使用命令 dcm2niix 
 2. brain_spinal_imgpreproc.sh 是所有操作的第一步，对图像进行预处理。
 3. 对图像进行完预处理后进行纤维束追踪，这一步在ExploreDTI中完成。 路径：Plugins->whole brain tratography->DTI 。
 4. 得到全脑纤维束追踪，为了得到感兴趣纤维束，需要使用ROI两两套取纤维束。
 5. 需要使用mask套取纤维束，这一步是出问题最多的，即使在模板上套取纤维束，也不可能完全用程序得到让你满意的纤维束，在这一步我们尝试了很多种方式，最终选择手动挑选纤维束，将个体mask分别在大脑中的丘脑和皮层为感兴趣区套取丘脑-皮层束；丘脑和脊髓ROI套取丘脑-脊髓纤维束。所有流程都在exploreDTI中完成。
 6. 个体纤维束配准也是很重要的一步，个体纤维束配准我们选择基于个体的纤维束配准方式，cutfibers这个函数有时候效果不好，最好能手动去一下一些毛躁的点。路径：settings->Analyze->Segment only.如果需要手动截取纤维束，那就需要准确找到ROI的位置，对于脊髓很好确定。只需要在SCT工具包中使用sct_label_vertebrae即可。将得到的椎节标记信息肉眼检查是否符合生理解剖位置。
 7. 在SCT中经标记椎节等处理方式后，由于图像分割等手段会造成在exploreDTI中无法正确显示表标记的ROI,为了能在exploreDTI完整显示被标记的个体图像，需要重建个体被标记后的图像，且脑和脊髓分开处理。需要用的程序为：Brian_Spinal_reconstructdims.m,这个程序不能完全保证X和Y层面的对齐，会稍微错一点，但是我们只用z层面。为了能够个体化分析，比如以后想分析C1-C4，只想找到C4mask,可以使用Brain_Spinal_MakeSpinalMask.m,将对应层面的最下面一层记录在矩阵或文件中。
 8. 经过上述步骤，可以得到个体间两端对齐的纤维束。
 9. 为了将个体在纤维束内部对齐，需要借助AFQ的函数，已经封装好。可以直接使用。函数名为：Brain_Spinal_Resample.m，内部封装函数名为：Brain_Spinal_dtiReorientFibers.m，只需在外部输入纤维束和需要减采样成多少点即可，输入时注意纤维束需要遵守的格式，已在函数内部标注。
 10. 减采样完成后，会得到新的采样坐标，需要在原图像上根据新的采样坐标计算出新坐标点对应的弥散特性值。这一步对应的函数为：Brain_Spinal_interp.m，输入为个体的弥散特征图像和纤维束坐标点。输出为沿着纤维束的弥散特性值。另外需要说明的是，如果你进行的是组分析，个体空间的纤维束是由组空间反变换得到，则需要用：Brain_Spinal_interp2.m函数。
 11. 采样完成后，由于是个体空间分析，我们需要对纤维束进行再次精炼。使用Kmeans聚类，根据纤维束的平均弥散特性值将纤维束聚为两类，我们选择方差较小的一类，通常情况下，方差较小的一类就是数量较多的那一类。少数情况例外。
 12. 将最后得到的纤维束平均得到个体的一根平均的纤维束，如果想将四个指标融合为一个指标，可以使用PCA函数。函数名为：Brain_Spinal_PCAdata.m和Brain_Spinal_PCAdata_2.m，两者区别在于，前者是将纤维束分开做pca,例如：大脑中有tha-acc,tha-s1,tha-s2三条纤维束，一条一条做。后者将三者连在一起做。
 13. 处理好影像学数据和行为学数据之后可以进行后续处理，回归分析或是PLSR或者相关分析。PLSR程序在另外一个仓库中，回归分析使用matlab的函数fitglm，相关分析使用matlab的函数corrcoef，只需要写一个for循环即可。需要指出的是，仓库中我写的correlation函数不规范，根据自己的需要使用。
 14. 为了将相关结果或是回归结果标记在纤维束和图像上，需要几个画图使用的函数。
 15. 第一个画图函数为

 
 
 
 
