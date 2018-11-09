//
//  UIViewController+Instance.h
//  MyCode
//
//  Created by 崎崎石 on 2018/1/2.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Instance)

+ (instancetype)createInstance;

+ (instancetype)createInstanceWithContext:(NSDictionary *)context object:(id)object;

- (void)setUpViewControllerWithContext:(NSDictionary *)context object:(id)object;


+ (UIViewController *)getRootViewController;

@end
