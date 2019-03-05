//
//  ED_AlertAction.h
//  SJBJingJiRen
//
//  Created by zw on 2018/8/22.
//  Copyright © 2018年 mzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ED_AlertAction : NSObject

@property (nonatomic , strong) NSString *title;

@property (nonatomic , assign) BOOL isSelected;

+ (instancetype)actionWithTitle:(NSString *)title handle:(void(^)(void)) handle;


- (instancetype)initWithTitle:(NSString *)title handle:(void(^)(void)) handle;


- (void)startAction;

@end
