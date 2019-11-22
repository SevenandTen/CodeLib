//
//  UILabel+FillContent.m
//  DriverCimelia
//
//  Created by zw on 2019/8/23.
//  Copyright © 2019 zw. All rights reserved.
//

#import "UILabel+FillContent.h"
#import <CoreText/CoreText.h>

@implementation UILabel (FillContent)

- (void)getWordFillLabel {
    if (self.text.length == 1 || self.text.length == 0) {
        return;
    }
    CGRect textSize = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.font} context:nil];
    CGFloat margin = (self.frame.size.width - textSize.size.width) / (self.text.length - 1);
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attributeString addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1)];
    self.attributedText = attributeString;
}

@end
