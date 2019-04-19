//
//  UIView+UnreadNumber.m
//  CodeLib
//
//  Created by zw on 2019/3/29.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "UIView+UnreadNumber.h"
#import <objc/runtime.h>


static void ed_unreadLayoutSubViews(){};






@implementation UIView (UnreadNumber)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sel1 = @selector(layoutSubviews);
        SEL sel2 = @selector(ed_LayoutSubviews);
        Method method1 = class_getInstanceMethod(self, sel1);
        if (method1 == NULL) {
            class_addMethod(self, sel1, (IMP)ed_unreadLayoutSubViews ,method_getTypeEncoding(class_getInstanceMethod(self, sel2)));
        }
        method_exchangeImplementations(class_getInstanceMethod(self, sel1), class_getInstanceMethod(self, sel2));
        
    });
}


- (void)openUnreadMode {
    [self addSubview:self.ed_UnreadLabel];
     objc_setAssociatedObject(self, _cmd, @(1),OBJC_ASSOCIATION_RETAIN);
    [self ed_updateUnreadLabelFrame];
   
}


- (void)setED_unreadNumber:(NSInteger)unreadNumber {
    if (unreadNumber == 0) {
        self.ed_UnreadLabel.hidden = YES;
        return;
    }
    self.ed_UnreadLabel.hidden = NO;
    NSString *text = nil;
    if (unreadNumber > 99) {
        text = @"99+";
    }else{
        text = [NSString stringWithFormat:@"%ld",unreadNumber];
    }
    self.ed_UnreadLabel.text = text;
    [self ed_updateUnreadLabelFrame];
}

- (void)setED_unreadNumberString:(NSString *)unreadNumberString isHidden:(BOOL)isHidden {
    self.ed_UnreadLabel.hidden = isHidden;
    if (!isHidden) {
        self.ed_UnreadLabel.text = unreadNumberString;
        [self ed_updateUnreadLabelFrame];
    }
}



- (UIEdgeInsets)ed_unreadInset {
    return  [objc_getAssociatedObject(self, _cmd) UIEdgeInsetsValue];
}


- (void)setEd_unreadInset:(UIEdgeInsets)ed_unreadInset {
    NSValue *value = [NSValue valueWithUIEdgeInsets:ed_unreadInset];
    objc_setAssociatedObject(self, @selector(ed_unreadInset), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGFloat)ed_unreadHeight {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setEd_unreadHeight:(CGFloat)ed_unreadHeight {
    NSNumber *number = [NSNumber numberWithFloat:ed_unreadHeight];
    objc_setAssociatedObject(self, @selector(ed_unreadHeight), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UILabel *)ed_UnreadLabel {
    UILabel *label = objc_getAssociatedObject(self, _cmd);
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.hidden = YES;
        label.layer.masksToBounds = YES;
        label.backgroundColor = [UIColor redColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:11];
        label.hidden = YES;
        objc_setAssociatedObject(self, _cmd, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
   
    return label;
}


- (void)ed_LayoutSubviews {
    [self ed_LayoutSubviews];
    [self ed_updateUnreadLabelFrame];
}



- (void)ed_updateUnreadLabelFrame {
    if ([objc_getAssociatedObject(self, @selector(openUnreadMode)) integerValue] == 0) {
        return;
    }
    
    CGFloat width = [UIView calculateSizeWithText:self.ed_UnreadLabel.text font:self.ed_UnreadLabel.font width:self.bounds.size.width].width;
    CGFloat standardSpace = self.ed_unreadHeight == 0 ? 17 : self.ed_unreadHeight;
    if (width <= standardSpace) {
        width = standardSpace;
    }
    self.ed_UnreadLabel.layer.cornerRadius =  standardSpace / 2.0;
    CGFloat top = self.ed_unreadInset.top;
    CGFloat left = self.ed_unreadInset.left;
    CGFloat right = self.ed_unreadInset.right;
    CGFloat bottom = self.ed_unreadInset.bottom;
    CGFloat x = 0;
    CGFloat y = 0;
    
    if (left != 0) {
        x = left;
    }else if (right != 0 ) {
        x = self.bounds.size.width - right - width;
    }
    if (top != 0) {
        y = top;
    }else if (bottom != 0) {
        y = self.bounds.size.height - bottom - standardSpace;
    }
    self.ed_UnreadLabel.frame = CGRectMake(x, y, width, standardSpace);
    [self bringSubviewToFront:self.ed_UnreadLabel];
}



- (void)setEd_unreadFont:(UIFont *)ed_unreadFont {
    self.ed_UnreadLabel.font = ed_unreadFont;
}

- (void)setEd_unreadBackColor:(UIColor *)ed_unreadBackColor {
    self.ed_UnreadLabel.backgroundColor = ed_unreadBackColor;
}

- (void)setEd_unreadTextColor:(UIColor *)ed_unreadTextColor {
    self.ed_UnreadLabel.textColor = ed_unreadTextColor;
}


- (UIFont *)ed_unreadFont {
    return self.ed_UnreadLabel.font;
}

- (UIColor *)ed_unreadBackColor {
    return self.ed_UnreadLabel.backgroundColor;
}

- (UIColor *)ed_unreadTextColor {
    return self.ed_unreadTextColor;
}






+ (CGSize)calculateSizeWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    if (text.length == 0) {
        return CGSizeZero;
    }
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text];
    return [self calculateSizeWithAttributeText:attributedText font:font width:width];
}



+ (CGSize)calculateSizeWithAttributeText:(NSAttributedString *)attributedText font:(UIFont *)font width:(CGFloat)width {
    if (attributedText.length == 0) {
        return CGSizeZero;
    }
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = width;
    label.font = font;
    label.attributedText = attributedText;
    CGSize intrinsicContentSize = [label intrinsicContentSize];
    
    return CGSizeMake(ceilf(MIN(intrinsicContentSize.width, width)) , ceilf(intrinsicContentSize.height));
}





@end
