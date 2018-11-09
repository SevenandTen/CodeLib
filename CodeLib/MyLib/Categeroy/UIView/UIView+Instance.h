//
//  UIView+Instance.h
//  MyCode
//
//  Created by 崎崎石 on 2017/12/29.
//  Copyright © 2017年 崎崎石. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Instance)

+ (instancetype)createInstance;

+ (instancetype)createInstanceWithContext:(NSDictionary *)context object:(id)object;

- (void)setUpViewWithContext:(NSDictionary *)context object:(id)object;


- (void)updateViewWithContext:(NSDictionary *)context object:(id)object;


+ (NSString *)defaultIdentifier;

- (void)refreshViewWithObject:(id)obj flag:(BOOL)flag;


- (void)refreshViewWithObject:(id)obj1 object:(id)obj2;


- (void)refreshViewWithObject:(id)obj;

@end
