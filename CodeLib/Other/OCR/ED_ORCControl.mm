//
//  ED_ORCControl.m
//  CodeLib
//
//  Created by zw on 2019/6/19.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/types_c.h>
#import <opencv2/core.hpp>
#import <opencv2/features2d.hpp>
#import <opencv2/calib3d.hpp>
#import <opencv2/objdetect.hpp>
#import <opencv2/highgui.hpp>
#import <opencv2/imgproc.hpp>
#import <opencv2/objdetect/objdetect.hpp>
#import <opencv2/imgcodecs/ios.h>

#import <opencv2/videoio/cap_ios.h>



#import "ED_ORCControl.h"

@implementation ED_ORCControl

+ (UIImage *)opencvGrayProcessingWithImage:(UIImage *)image {
//    cv::Mat reslutImage ;
    cv::Mat targetImage ;
    UIImageToMat(image ,targetImage);
    cvtColor(targetImage,targetImage,cv::COLOR_BGR2GRAY);
   
    return MatToUIImage(targetImage);
}


//
//C++：void cvAdaptiveThreshold(InputArray src, OutputArray dst, double maxValue, int adaptiveMethod, int thresholdType, int blockSize, double C)
//参数说明:
//src:输入图像.
//dst:输出图像.
//max_value :使用 CV_THRESH_BINARY 和CV_THRESH_BINARY_INV 的最大值.
//adaptive_method :自适应阈值算法使用：CV_ADAPTIVE_THRESH_MEAN_C 或 CV_ADAPTIVE_THRESH_GAUSSIAN_C .
//threshold_type :取阈值类型：必须是CV_THRESH_BINARY或者CV_THRESH_BINARY_INV.
//block_size :用来计算阈值的象素邻域大小: 3, 5, 7, …
//param1 :与方法有关的参数。
//对方法 CV_ADAPTIVE_THRESH_MEAN_C 和 CV_ADAPTIVE_THRESH_GAUSSIAN_C，
//它是一个从均值或加权均值提取的常数,尽管它可以是负数。

+ (UIImage *)opencvBinaryzationWithImage:(UIImage *)image {
    cv::Mat sourceMatImage ;
    UIImageToMat(image ,sourceMatImage);
//    cv::adaptiveThreshold(targetImage,targetImage,CV_THRESH_TRIANGLE,CV_ADAPTIVE_THRESH_GAUSSIAN_C,CV_THRESH_BINARY_INV,11,CV_ADAPTIVE_THRESH_MEAN_C);
    // 二值化
    threshold(sourceMatImage, sourceMatImage, 128, 255, cv::THRESH_BINARY);
    //自动阈值分割,邻域均值
    adaptiveThreshold(sourceMatImage,sourceMatImage,255,cv::ADAPTIVE_THRESH_MEAN_C,cv::THRESH_BINARY,11,2);
    //自动阈值分割，高斯邻域
//    adaptiveThreshold(sourceMatImage,sourceMatImage,255,cv::ADAPTIVE_THRESH_GAUSSIAN_C,cv::THRESH_BINARY,11,2);
    
    
    return MatToUIImage(sourceMatImage);
    
}


@end
