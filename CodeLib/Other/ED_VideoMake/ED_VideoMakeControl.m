//
//  ED_VideoMakeControl.m
//  CodeLib
//
//  Created by zw on 2019/10/31.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_VideoMakeControl.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>


@implementation ED_VideoMakeControl


+ (void)makeVideoWithImages:(NSArray *)imageArray complete:(void (^)(NSError *, NSURL *))complete {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    
    for (UIImage *image in imageArray) {
        [mutableArray addObject:[self imageWithImage:image scaledToSize:CGSizeMake(320, 480)]];
    }
    NSString *defultPath = [self getVideoPathCache];
          NSString *outputFielPath=[ defultPath stringByAppendingPathComponent:[self getVideoNameWithType:@"mov"]];
    
    NSURL *fileUrl = [NSURL fileURLWithPath:outputFielPath];
    NSError *error = nil;
    AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:fileUrl fileType:AVFileTypeQuickTimeMovie error:&error];
    
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecH264,AVVideoCodecKey,
                                        
                                        [NSNumber numberWithInt:320],AVVideoWidthKey,
                                        
                                        [NSNumber numberWithInt:480],AVVideoHeightKey,nil];
       
    AVAssetWriterInput *writerInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
     NSDictionary *sourcePixelBufferAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kCVPixelFormatType_32ARGB],kCVPixelBufferPixelFormatTypeKey,nil];
    
    AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:writerInput sourcePixelBufferAttributes:sourcePixelBufferAttributesDictionary];
    if ([videoWriter canAddInput:writerInput]) {
        [videoWriter addInput:writerInput];
        [videoWriter startWriting];
        [videoWriter startSessionAtSourceTime:kCMTimeZero];
    }
    
    int __block count = 0;
    
    [writerInput requestMediaDataWhenReadyOnQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0) usingBlock:^{
        
        while ([writerInput isReadyForMoreMediaData]) {
            if (count >= mutableArray.count * 10) {
                [writerInput markAsFinished];
                [videoWriter finishWritingWithCompletionHandler:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        complete(nil,fileUrl);
                    });
                }];
                break;
            }
            int idx = count/10;
            
            CVPixelBufferRef  buffer = NULL;
            buffer = (CVPixelBufferRef)[self pixelBufferFromCGImage:[[mutableArray objectAtIndex:idx] CGImage] size:CGSizeMake(320, 480)];
            if (buffer) {
                if (![adaptor appendPixelBuffer:buffer withPresentationTime:CMTimeMake(count,10)]) {
                    if (adaptor) {
                        [writerInput markAsFinished];
                        [videoWriter finishWritingWithCompletionHandler:^{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                complete(nil,fileUrl);
                            });
                        }];
                       
                        break;
                    }else{
                       
                        break;
                    }
                   
                }else{
                    
                    count ++;
                }
                
                CFRelease(buffer);
            }
        }
        
    }];

}

    

+ (CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef)image size:(CGSize)size {
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                           
                           [NSNumber numberWithBool:YES],kCVPixelBufferCGImageCompatibilityKey,
                           
                           [NSNumber numberWithBool:YES],kCVPixelBufferCGBitmapContextCompatibilityKey,nil];
    
    CVPixelBufferRef pxbuffer = NULL;
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,size.width,size.height,kCVPixelFormatType_32ARGB,(__bridge CFDictionaryRef) options,&pxbuffer);
    
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer,0);
    
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    
    NSParameterAssert(pxdata !=NULL);
    
    CGColorSpaceRef rgbColorSpace=CGColorSpaceCreateDeviceRGB();
    
    //    当你调用这个函数的时候，Quartz创建一个位图绘制环境，也就是位图上下文。当你向上下文中绘制信息时，Quartz把你要绘制的信息作为位图数据绘制到指定的内存块。一个新的位图上下文的像素格式由三个参数决定：每个组件的位数，颜色空间，alpha选项
    
    CGContextRef context = CGBitmapContextCreate(pxdata,size.width,size.height,8,4*size.width,rgbColorSpace,kCGImageAlphaPremultipliedFirst);
    
    NSParameterAssert(context);
    
    //使用CGContextDrawImage绘制图片  这里设置不正确的话 会导致视频颠倒
    
    //    当通过CGContextDrawImage绘制图片到一个context中时，如果传入的是UIImage的CGImageRef，因为UIKit和CG坐标系y轴相反，所以图片绘制将会上下颠倒
    
    CGContextDrawImage(context,CGRectMake(0,0,CGImageGetWidth(image),CGImageGetHeight(image)), image);
    
    // 释放色彩空间
    
    CGColorSpaceRelease(rgbColorSpace);
    
    // 释放context
    
    CGContextRelease(context);
    
    // 解锁pixel buffer
    
    CVPixelBufferUnlockBaseAddress(pxbuffer,0);
    
    return pxbuffer;
}



+ (NSString *)getNowDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    
    return  [formatter stringFromDate:date];
}



+ (NSString *)getVideoPathCache {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * videoCache = [[paths firstObject] stringByAppendingPathComponent:@"videos"];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:videoCache isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) {
        [fileManager createDirectoryAtPath:videoCache withIntermediateDirectories:YES attributes:nil error:nil];
    };
    return videoCache;
}


+ (NSString *)getVideoNameWithType:(NSString *)fileType{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HHmmss"];
    NSDate * NowDate = [NSDate dateWithTimeIntervalSince1970:now];
    NSString * timeStr = [formatter stringFromDate:NowDate];
    NSString *fileName = [NSString stringWithFormat:@"video_%@.%@",timeStr,fileType];
    return fileName;
}



+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize{
//    新创建的位图上下文 newSize为其大小
    UIGraphicsBeginImageContext(newSize);
//    对图片进行尺寸的改变
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
//    从当前上下文中获取一个UIImage对象  即获取新的图片对象
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
    
}

+ (void)getVideoAllPictureWithVideoUrl:(NSURL *)videoUrl timeImages:(NSArray<UIImage *> *)imageArray{
    AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:videoUrl options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    CMTime time = asset.duration;
    int second = (int)CMTimeGetSeconds(time);
    NSMutableArray *times = [[NSMutableArray alloc] init];
    for (int i = 0;i/60 <= second; i ++  ) {
        [times addObject:[NSValue valueWithCMTime:CMTimeMake(i, 60)]];
    }
    NSMutableArray *contenetImageArray = [[NSMutableArray alloc] init];
    
    int __block count = 0;
    __weak typeof(self)weakSelf = self;
    
    [generator generateCGImagesAsynchronouslyForTimes:times completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
        if (result == AVAssetImageGeneratorSucceeded) {
            
            UIImage *currentImage = [UIImage imageWithCGImage:image];
            int idx = count/60;
            [contenetImageArray addObject:currentImage];
            UIImage *timeImage = [imageArray objectAtIndex:idx];
            UIImage *otherImage = [weakSelf combineImageOne:currentImage imageTwo:timeImage];
            NSLog(@"....");
            
//
//            [contenetImageArray addObject:[self combineImageOne:currentImage imageTwo:timeImage]];
            
//            if ((count + 1)/60 == second) {
//                [self makeVideoWithImages:contenetImageArray complete:^(NSError *error, NSURL *videoUrl) {
//                    if (@available(iOS 9,*)) {
//                        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//                        PHAssetResourceCreationOptions * options = [[PHAssetResourceCreationOptions alloc] init];
//                        [[PHAssetCreationRequest creationRequestForAsset] addResourceWithType:PHAssetResourceTypeVideo fileURL:videoUrl options:options];
//
//                        } completionHandler:^(BOOL success, NSError * _Nullable error) {
//                            if (success) {
//                                NSLog(@"保存成功");
//                                
//                            }else {
//                                NSLog(@"%@",error.description);
//                            }
//                        }];
//                    }else {
//                        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//                        [library writeVideoAtPathToSavedPhotosAlbum:videoUrl completionBlock:^(NSURL *assetURL, NSError *error) {
//                            if (error) {
//                                NSLog(@"%@",error.description);
//                            }else{
//                                 NSLog(@"保存成功");
//                                
//                            }
//                        }];
//                    }
//                }];
//            }
            
            NSLog(@"%ld -- %f",count,second);
            count ++;
        }
    }];
   
}



+ (UIImage *)combineImageOne:(UIImage *)image1 imageTwo:(UIImage *)image2 {
    CGImageRef imgRef = image2.CGImage;
    CGFloat w = CGImageGetWidth(imgRef);
    CGFloat h = CGImageGetHeight(imgRef);
    
    //以1.png的图大小为底图
   
    CGImageRef imgRef1 = image1.CGImage;
    CGFloat w1 = CGImageGetWidth(imgRef1);
    CGFloat h1 = CGImageGetHeight(imgRef1);
    
    //以1.png的图大小为画布创建上下文
    UIGraphicsBeginImageContext(CGSizeMake(w1, h1));
    [image1 drawInRect:CGRectMake(0, 0, w1, h1)];//先把1.png 画到上下文中
    [image2 drawInRect:CGRectMake(0, 0, w, h)];//再把小图放在上下文中
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
    UIGraphicsEndImageContext();//关闭上下文

    CGImageRelease(imgRef);
    CGImageRelease(imgRef1);
    return resultImg ;
}



+ (void)addWaterMarkTypeWithGPUImageAndInputVideoURL:(NSURL*)InputURL AndWaterMarkVideoURL:(NSURL*)InputURL2 WithCompletionHandler:(void (^)(NSURL* outPutURL, int code))handler{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *outPutFileName = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mov",outPutFileName]];
    NSURL* outPutVideoUrl = [NSURL fileURLWithPath:myPathDocs];
    
    GPUImageMovie* movieFile = [[GPUImageMovie alloc] initWithURL:InputURL];
    GPUImageMovie* movieFile2 = [[GPUImageMovie alloc] initWithURL:InputURL2];
    GPUImageScreenBlendFilter* filter =  [[GPUImageScreenBlendFilter alloc] init];
    [movieFile addTarget:filter];
    [movieFile2 addTarget:filter];
    
    GPUImageMovieWriter* movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:outPutVideoUrl size:CGSizeMake(540, 960) fileType:AVFileTypeQuickTimeMovie outputSettings:    @
                                        {
                                        AVVideoCodecKey: AVVideoCodecH264,
                                        AVVideoWidthKey: @540,   //Set your resolution width here
                                        AVVideoHeightKey: @960,  //set your resolution height here
                                        AVVideoCompressionPropertiesKey: @
                                            {
                                                //2000*1000  建议800*1000-5000*1000
                                                //AVVideoAverageBitRateKey: @2500000, // Give your bitrate here for lower size give low values
                                            AVVideoAverageBitRateKey: @5000000,
                                            AVVideoProfileLevelKey: AVVideoProfileLevelH264HighAutoLevel,
                                            AVVideoAverageNonDroppableFrameRateKey: @30,
                                            },
                                        }
                                        ];
    [filter  addTarget:movieWriter];
    AVAsset* videoAsset = [AVAsset assetWithURL:InputURL];
    AVAssetTrack *assetVideoTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo]firstObject];
    movieWriter.transform = assetVideoTrack.preferredTransform;
    //    [movie enableSynchronizedEncodingUsingMovieWriter:movieWriter];
    [movieWriter startRecording];
    [movieFile startProcessing];
    [movieFile2 startProcessing];
    [movieWriter setCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"movieWriter Completion");
            
            handler(outPutVideoUrl,1);
        });

    }];
    
}




@end
