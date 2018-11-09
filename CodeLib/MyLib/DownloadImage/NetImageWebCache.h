//
//  NetImageWebCache.h
//  BaseCode
//
//  Created by zw on 2018/8/27.
//  Copyright © 2018年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NetImageWebCache : NSCache

+ (instancetype)shareInstance;


- (UIImage *)getImageFromCacheForKey:(NSString *)key;


- (void)setImageData:(NSData *)data ForKey:(NSString *)key;

@end
