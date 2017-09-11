# DSDH-HashingCode
This repository is the source code for our paper Deep Supervised Discrete Hashing (https://arxiv.org/pdf/1705.10999.pdf)
Qi Li, Zhenan Sun, Ran He and Tieniu Tan.
This is a demo on the CIFAR-10 dataset with the DSDH implementaion. Part of the code is modified from DPSH(https://cs.nju.edu.cn/lwj/).

Stage 1:
1. Download the CIFAR-10 dataset from the 
   website(https://www.cs.toronto.edu/~kriz/cifar-10-matlab.tar.gz), unzip the file 
   and put the folder 'cifar-10-batches-mat/' in the current folder.
   
2. Download the Pretrained CNN model VGG-F 
   from the website(http://www.vlfeat.org/matconvnet/models/imagenet-vgg-f.mat), 
   and put it in the current folder.
   
Stage 2:                                                                             
1. Installing and compiling the library in the MatConvNet, Please refer to http://www.vlfeat.org/matconvnet/install/ for more 
  information about installing MatConvNet.
  
2. demo run main.m for the demo.
