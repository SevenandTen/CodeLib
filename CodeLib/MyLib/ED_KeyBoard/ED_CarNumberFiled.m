//
//  ED_CarNumberFiled.m
//  CodeLib
//
//  Created by zw on 2019/12/6.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_CarNumberFiled.h"

@interface ED_CarNumberFiled ()

@end

@implementation ED_CarNumberFiled


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3;
        self.layer.borderWidth =  2/[UIScreen mainScreen].scale;
        self.tintColor = [UIColor clearColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.layer.borderColor = [UIColor colorWithRed:147/255.0 green:164/255.0 blue:181/255.0 alpha:1].CGColor;
        self.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (BOOL)becomeFirstResponder {
    self.layer.borderColor = [UIColor colorWithRed:28/255.0 green:196/255.0 blue:102/255.0 alpha:1].CGColor;
    return  [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    self.layer.borderColor = [UIColor colorWithRed:147/255.0 green:164/255.0 blue:181/255.0 alpha:1].CGColor;
    return [super resignFirstResponder];
}



- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController*menuController = [UIMenuController sharedMenuController];
    if(menuController) {
    [UIMenuController sharedMenuController].menuVisible=NO;
    }
//    return NO;
    return [super canPerformAction:action withSender:sender];
}


@end
