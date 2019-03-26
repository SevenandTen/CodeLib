//
//  HorizontallyOpposedView.h
//  DriverCimelia
//
//  Created by zw on 2018/10/10.
//  Copyright © 2018年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>


// 水平对置View 


@interface HorizontallyOpposedView : UIView

@property (nonatomic , assign) UIEdgeInsets contentInset;

- (void)updateRightTitle:(NSString *)title;

- (void)updateLeftTitle:(NSString *)title;

- (void)updateTitleLeft:(NSString *)left right:(NSString *)right;

- (void)updateRightTitleColor:(UIColor *)color;

- (void)updateLeftTitleColor:(UIColor *)color;

- (void)updateTitleColorLeft:(UIColor *)left right:(UIColor *)right;

- (void)updateLeftFont:(UIFont *)font;

- (void)updateRihtFont:(UIFont *)font;

- (void)updateFontLeft:(UIFont *)left right:(UIFont *)right;

@end


