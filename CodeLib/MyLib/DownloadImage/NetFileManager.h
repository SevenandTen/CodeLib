//
//  NetFileManager.h
//  BaseCode
//
//  Created by zw on 2018/8/27.
//  Copyright © 2018年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NetFileManager : NSObject

+ (instancetype)shareInstance;


- (void)startLoadFileWithUrl:(NSString *)url withView:(UIView *)view;


- (void)removeImageView:(UIView *)view forUrl:(NSString *)url;

@end
