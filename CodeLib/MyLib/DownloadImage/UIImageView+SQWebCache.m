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


- (void)dealWithImage:(UIImage *)image {
    if (!image) {
        return;
    }
    if (self.image) {
        self.image = image;
    }else{
        self.image = image;
        [self.layer removeAllAnimations];
        self.alpha = 0;
        [UIView animateWithDuration:2 animations:^{
            self.alpha = 1;
        }];
        
       
        
        
    }
    
}

@end


