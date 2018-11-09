//
//  UIImageView+SQWebCache.m
//  BaseCode
//
//  Created by zw on 2018/8/27.
//  Copyright © 2018年 zw. All rights reserved.
//

#import "UIImageView+SQWebCache.h"
#import <objc/runtime.h>
#import "NetImageWebCache.h"
#import "NetFileManager.h"

@implementation UIImageView (SQWebCache)


- (void)loadNetImageWithUrl:(NSString *)url placeHolder:(UIImage *)placeHolder {
    [self loadNetImageWithUrl:url placeHolder:placeHolder progress:nil complete:nil];
}

- (void)loadNetImageWithUrl:(NSString *)url placeHolder:(UIImage *)placeHolder progress:(void (^)(float))progress complete:(void (^)(UIImage *, NSError *))complete {
    if (url.length == 0) {
        return;
    }
    if (placeHolder) {
        self.image = placeHolder;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (self.lastUrl.length != 0 && ![self.lastUrl isEqualToString:url]) {
            [[NetFileManager shareInstance] removeImageView:self forUrl:url];
        }
        UIImage *image = [[NetImageWebCache shareInstance] getImageFromCacheForKey:url];
        if (image) {
            [self updateWebImage:image];
        }else{
            [[NetFileManager shareInstance] startLoadFileWithUrl:url withImageView:self];
            self.lastUrl = url;
        }
    });
    
    self.progress = progress;
    self.complete = complete;
}


#pragma mark - lastUrl

- (NSString *)lastUrl {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLastUrl:(NSString *)lastUrl {
    objc_setAssociatedObject(self, @selector(lastUrl), lastUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - complete

- (void (^)(UIImage *, NSError *))complete {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setComplete:(void (^)(UIImage *, NSError *))complete {
    objc_setAssociatedObject(self, @selector(complete), complete, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


#pragma mark - progress

- (void (^)(float))progress {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProgress:(void (^)(float))progress {
    objc_setAssociatedObject(self, @selector(progress), progress, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)updateWebImageWithError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.complete) {
            self.complete(nil, error);
        }
    });
}


- (void)updateWebImageProgressWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrit {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.progress) {
            self.progress(totalBytesWritten/(totalBytesExpectedToWrit * 1.0));
        }
    });
}


- (void)updateWebImage:(UIImage *)image {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.image = image;
        self.progress(1.0);
        self.complete(image, nil);
    });

}


@end
