//
//  UILabel+CalculateShowSize.m
//  MyCode
//
//  Created by 崎崎石 on 2018/3/21.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import "UILabel+CalculateShowSize.h"

@implementation UILabel (CalculateShowSize)

+ (CGSize)calculateSizeWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    if (text.length == 0) {
        return CGSizeZero;
    }
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text];
    return [self calculateSizeWithAttributeText:attributedText font:font width:width];
}

+ (CGSize)calculateSizeWithText:(NSString *)text fontNumber:(NSInteger)fontNumber width:(CGFloat)width {
    UIFont *font = [UIFont systemFontOfSize:fontNumber];
    return [self calculateSizeWithText:text font:font width:width];
}


+ (CGSize)calculateSizeWithAttributeText:(NSAttributedString *)attributedText font:(UIFont *)font width:(CGFloat)width {
    if (attributedText.length == 0) {
        return CGSizeZero;
    }
    
    UILabel * label = [[self alloc] initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = width;
    label.font = font;
    label.attributedText = attributedText;
    CGSize intrinsicContentSize = [label intrinsicContentSize];
    
    return CGSizeMake(ceilf(MIN(intrinsicContentSize.width, width)) , ceilf(intrinsicContentSize.height));
}

+ (CGSize)calculateSizeWithAttributeText:(NSAttributedString *)attributedText fontNumber:(NSInteger)fontNumber width:(CGFloat)width {
    UIFont *font = [UIFont systemFontOfSize:fontNumber];
    return [self calculateSizeWithAttributeText:attributedText font:font width:width];
   
}




@end
