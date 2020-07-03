//
//  ED_VideoRecordControl.m
//  CodeLib
//
//  Created by zw on 2019/12/31.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_VideoRecordControl.h"

#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>



static  GPUImageMovieWriter* movieWriter = nil;

@implementation ED_VideoRecordControl

+ (void)saveVideoInPhotosWithVideoUrl:(NSURL *)videoUrl actionBlock:(nonnull void (^)(BOOL))actionBlock {
     if (@available(iOS 9,*)) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetResourceCreationOptions * options = [[PHAssetResourceCreationOptions alloc] init];
            [[PHAssetCreationRequest creationRequestForAsset] addResourceWithType:PHAssetResourceTypeVideo fileURL:videoUrl options:options];

            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (actionBlock) {
                    actionBlock(success);
                }
            }];
        }else {
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library writeVideoAtPathToSavedPhotosAlbum:videoUrl completionBlock:^(NSURL *assetURL, NSError *error) {
                if (actionBlock) {
                    if (error) {
                        actionBlock(NO);
                    }else{
                        actionBlock(YES);
                    }
                }
            }];
        }
}



#pragma mark GPUImageUIElement
+ (void)addWaterMarkTypeWithGPUImageUIElementAndInputVideoURL:(NSURL*)InputURL  date:(NSDate *)date WithCompletionHandler:(void (^)(NSURL *, int))handler {
        // 获取视频的尺寸
        AVAsset *fileas = [AVAsset assetWithURL:InputURL];
        CGSize movieSize = fileas.naturalSize;
        // 适配视图的大小
    
        GPUImageMovie *  movie = [[GPUImageMovie alloc] initWithURL:InputURL];
        movie.playAtActualSpeed = YES;
        movie.shouldRepeat = NO;
        movie.runBenchmark = YES;
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, movieSize.width, movieSize.height)];
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        label.text = @"";
        label.textColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentLeft;
    label.transform = CGAffineTransformMakeRotation(- M_PI /2 );
    
        [contentView addSubview:label];
    
       GPUImageAlphaBlendFilter * alphaBlendFilter = [[GPUImageAlphaBlendFilter alloc] init];
        alphaBlendFilter.mix = 1.0;
        
        // 创建水印图形
        GPUImageView *imageView = [[GPUImageView alloc] initWithFrame:contentView.bounds];
        GPUImageUIElement *uiElement = [[GPUImageUIElement alloc] initWithView:contentView];

        GPUImageFilter *videoFilter = [[GPUImageFilter alloc] init];
        [movie addTarget:videoFilter];
        [videoFilter addTarget:alphaBlendFilter];
        [uiElement addTarget:alphaBlendFilter];
        [alphaBlendFilter addTarget:imageView];
        [imageView setInputRotation:(kGPUImageRotate180) atIndex:0];

        
        __block GPUImageUIElement *weakElement = uiElement;
    
      __block someCount = 0;
    NSDateFormatter *formatter = [[NSDateFormatter alloc ] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        [videoFilter setFrameProcessingCompletionBlock:^(GPUImageOutput *output, CMTime time) {
               someCount = someCount + 1;
            NSDate *currentDate = [date dateByAddingTimeInterval:CMTimeGetSeconds(time)];
            label.text = [formatter stringFromDate:currentDate];
               NSLog(@"%@",@(someCount));
            [weakElement update];
        }];
        
        // GPUImageMovieWriter 视频编码
        NSString * temPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
        unlink([temPath UTF8String]); // 判断路径是否存在，如果存在就删除路径下的文件，否则是没法缓存新的数据的。
        NSURL *movieWriterURL = [NSURL fileURLWithPath:temPath];
        
      GPUImageMovieWriter *  movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieWriterURL size:movieSize];
        movieWriter.shouldPassthroughAudio = YES;
    AVAsset* videoAsset = [AVAsset assetWithURL:InputURL];
    AVAssetTrack *assetVideoTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo]firstObject];
    movieWriter.transform = assetVideoTrack.preferredTransform;
        [alphaBlendFilter addTarget:movieWriter];
        
        // 不要设置这两句，会导致内存不断升高
//        movieWriter.hasAudioTrack = YES;
//        movie.audioEncodingTarget = movieWriter;
        
        // 允许使用 GPUImageMovieWriter 进行音视频同步编码
//        [movie enableSynchronizedEncodingUsingMovieWriter:movieWriter];
        [movie startProcessing];
        [movieWriter startRecording];
        

        // 写入完成后可保存到相册
//        [movieWriter setCompletionBlock:^{
//            [movie endProcessing];
//            [movieWriter finishRecording];
//            if (handler) {
//                handler(movieWriterURL,1);
//            }
////              UISaveVideoAtPathToSavedPhotosAlbum(temPath, nil, nil, nil);
//        }];
    
    
    __weak GPUImageMovieWriter *weakmovieWriter = movieWriter;
        __weak GPUImageMovie *weakmovie = movie;
        
        // 写入完成后可保存到相册
        [movieWriter setCompletionBlock:^{
            [weakmovieWriter finishRecording];
            [weakmovie endProcessing];
            
            [[GPUImageContext sharedImageProcessingContext].framebufferCache purgeAllUnassignedFramebuffers];
            
//            [ED_VideoRecordControl getVideoInfoWithSourcePath:temPath];
            
            if (handler) {
                handler(movieWriterURL,1);
            }

    //        UISaveVideoAtPathToSavedPhotosAlbum(temPath, nil, nil, nil);
        }];
    

}




@end
