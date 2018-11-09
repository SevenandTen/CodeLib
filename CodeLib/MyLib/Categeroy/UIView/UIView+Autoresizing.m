//
//  UIView+Autoresizing.m
//  BaseCode
//
//  Created by zw on 2018/8/31.
//  Copyright © 2018年 zw. All rights reserved.
//

#import "UIView+Autoresizing.h"

@implementation UIView (Autoresizing)

- (void)unchangeTopLeftRightBottom {
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (void)unchangeTopLeftRight {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
}

- (void)unchangeTopLeftBottom {
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
}

- (void)unchangeLeftRightBottom {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

- (void)unchangeTopRightBottom {
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
}


- (void)unchangeTopLeft {
    self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
}

- (void)unchangeTopRight {
    self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
}

- (void)unchangeTopBottom {
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
}


- (void)unchangeBottomLeft {
    self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
}


- (void)unchangeBottomRight {
    self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
}

- (void)unchangeLeftRight {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth ;
}


- (void)unchangeTop {
    self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
}

- (void)unchangeBottom {
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
}

- (void)unchangeLeft {
    self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
}

- (void)unchangeRight {
    self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
}
@end
