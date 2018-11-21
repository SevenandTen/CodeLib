//
//  ED_RefreshNormalFooter.m
//  CodeLib
//
//  Created by zw on 2018/11/21.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_RefreshNormalFooter.h"

@interface ED_RefreshNormalFooter ()



@end

@implementation ED_RefreshNormalFooter


- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && [newSuperview isKindOfClass: [UIScrollView class]]) {
//        self.isFirst = YES;
        if (self.footerHeight == 0) {
            self.footerHeight = 40;
        }
       
    }
}

@end
