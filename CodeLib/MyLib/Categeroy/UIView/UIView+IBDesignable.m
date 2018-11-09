//
//  UIView+IBDesignable.m
//  MyCode
//
//  Created by 崎崎石 on 2017/12/7.
//  Copyright © 2017年 崎崎石. All rights reserved.
//

#import "UIView+IBDesignable.h"

@implementation UIView (IBDesignable)

- (void)setIbCordRadius:(CGFloat)ibCordRadius {
    self.layer.cornerRadius = ibCordRadius;
}

- (CGFloat)ibCordRadius {
    return self.layer.cornerRadius;
}

- (void)setIbBorderWidth:(CGFloat)ibBorderWidth {
    self.layer.borderWidth = ibBorderWidth;
}

- (CGFloat)ibBorderWidth {
    return self.layer.borderWidth ;
}

- (void)setIbBorderColor:(UIColor *)ibBorderColor {
    self.layer.borderColor = ibBorderColor.CGColor;
}

- (UIColor *)ibBorderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

@end
