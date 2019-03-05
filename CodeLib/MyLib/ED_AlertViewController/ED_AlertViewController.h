//
//  ED_AlertViewController.h
//  SJBJingJiRen
//
//  Created by zw on 2018/8/22.
//  Copyright © 2018年 mzw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ED_AlertAction.h"
@interface ED_AlertViewController : UIViewController



- (void)addAction:(ED_AlertAction *)action;


+ (instancetype)alertWithTitle:(NSString *)title actions:(NSArray <ED_AlertAction *> *)actions;

- (instancetype)initWithTitle:(NSString *)title;

@end
