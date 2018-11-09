//
//  ED_PhoneCodeView.h
//  MyCode
//
//  Created by 崎崎石 on 2018/5/28.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ED_PhoneCodeView;
@protocol ED_PhoneCodeViewDelegate<NSObject>

- (void)phoneCodeViewDidClick:(ED_PhoneCodeView *)phoneCodeView;

@end

@interface ED_PhoneCodeView : UIView

@property (nonatomic , weak) id <ED_PhoneCodeViewDelegate> phoneCodeDelegate;

- (void)setFont:(UIFont *)font;

- (void)setNormalTitle:(NSString *)title titleColor:(UIColor *)titleColor;

- (void)setUnableTime:(NSInteger)time unableColor:(UIColor *)unableColor;

@end
