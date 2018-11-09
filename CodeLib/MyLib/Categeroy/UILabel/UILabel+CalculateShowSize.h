//
//  UILabel+CalculateShowSize.h
//  MyCode
//
//  Created by 崎崎石 on 2018/3/21.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CalculateShowSize)

+ (CGSize)calculateSizeWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width;

+ (CGSize)calculateSizeWithText:(NSString *)text fontNumber:(NSInteger)fontNumber width:(CGFloat)width;


+ (CGSize)calculateSizeWithAttributeText:(NSAttributedString *)attributedText fontNumber:(NSInteger)fontNumber width:(CGFloat)width;


+ (CGSize)calculateSizeWithAttributeText:(NSAttributedString *)attributedText font:(UIFont *)font width:(CGFloat)width;

@end
