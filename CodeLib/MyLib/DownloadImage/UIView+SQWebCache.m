//
//  UIView+SQWebCache.m
//  CodeLib
//
//  Created by zw on 2018/12/4.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "UIView+SQWebCache.h"
#import <objc/runtime.h>
#import "NetImageWebCache.h"
#import "NetFileManager.h"

@implementation UIView (SQWebCache)

- (void)loadNetImageWithUrl:(NSString *)url placeHolder:(UIImage *)placeHolder {
    [self loadNetImageWithUrl:url placeHolder:placeHolder progress:nil complete:nil];
}

- (void)loadNetImageWithUrl:(NSString *)url placeHolder:(UIImage *)placeHolder progress:(void (^)(float))progress complete:(void (^)(UIImage *, NSError *))complete {
    if (url.length == 0) {
        return;
    }
    if (placeHolder) {
        [self dealWithImage:placeHolder];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (self.lastUrl.length != 0 && ![self.lastUrl isEqualToString:url]) {
            [[NetFileManager shareInstance] removeImageView:self forUrl:url];
        }
        UIImage *image = [[NetImageWebCache shareInstance] getImageFromCacheForKey:url];
        if (image) {
            [self updateWebImage:image];
        }else{
            [[NetFileManager shareInstance] startLoadFileWithUrl:url withView:self];
            self.lastUrl = url;
        }
    });
    
    self.progress = progress;
    self.complete = complete;
}


- (void)updateWebImage:(UIImage *)image {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dealWithImage:image];
        if (self.progress) {
             self.progress(1.0);
        }
        if (self.complete) {
            self.complete(image, nil);
        }
        
    });
    
}


- (void)dealWithImage:(UIImage *)image {
    
    
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









@end
