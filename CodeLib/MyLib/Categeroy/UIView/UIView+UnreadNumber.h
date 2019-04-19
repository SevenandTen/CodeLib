//
//  UIView+UnreadNumber.h
//  CodeLib
//
//  Created by zw on 2019/3/29.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIView (UnreadNumber)


@property (nonatomic , assign) UIEdgeInsets ed_unreadInset;


@property (nonatomic , assign) CGFloat ed_unreadHeight;


@property (nonatomic , strong) UIFont *ed_unreadFont;

@property (nonatomic , strong) UIColor *ed_unreadBackColor;

@property (nonatomic , strong) UIColor *ed_unreadTextColor;


- (void)setED_unreadNumberString:(NSString *)unreadNumberString isHidden:(BOOL)isHidden;


- (void)setED_unreadNumber:(NSInteger)unreadNumber;


- (void)openUnreadMode; 







@end


