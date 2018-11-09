//
//  UIImageView+SQWebCache.h
//  BaseCode
//
//  Created by zw on 2018/8/27.
//  Copyright © 2018年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SQWebCache)


- (void)loadNetImageWithUrl:(NSString *)url placeHolder:(UIImage *)placeHolder;


- (void)loadNetImageWithUrl:(NSString *)url placeHolder:(UIImage *)placeHolder
                   progress:(void(^)(float value))progress
                   complete:(void(^)(UIImage *image,NSError *error))complete;


- (void)updateWebImage:(UIImage *)image;



- (void)updateWebImageProgressWriteData:(int64_t)bytesWritten
                      totalBytesWritten:(int64_t)totalBytesWritten
              totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrit;


- (void)updateWebImageWithError:(NSError *)error;


@property (nonatomic , strong) NSString *lastUrl;


@property (nonatomic , copy) void(^complete)(UIImage *image,NSError *error);


@property (nonatomic , copy) void(^progress)(float value);



@end
