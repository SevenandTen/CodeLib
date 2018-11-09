//
//  UIView+Autoresizing.h
//  BaseCode
//
//  Created by zw on 2018/8/31.
//  Copyright © 2018年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

// top left right bottom

@interface UIView (Autoresizing)

//C44  
- (void)unchangeTopLeftRightBottom;

//C43

- (void)unchangeTopLeftRight;

- (void)unchangeTopLeftBottom;

- (void)unchangeTopRightBottom;

- (void)unchangeLeftRightBottom;


// C42
- (void)unchangeTopLeft;

- (void)unchangeTopRight;

- (void)unchangeBottomLeft;

- (void)unchangeBottomRight;

- (void)unchangeTopBottom;

- (void)unchangeLeftRight;

//C41

- (void)unchangeTop;

- (void)unchangeBottom;

- (void)unchangeLeft;

- (void)unchangeRight;



@end
