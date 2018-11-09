//
//  UIView+IBDesignable.h
//  MyCode
//
//  Created by 崎崎石 on 2017/12/7.
//  Copyright © 2017年 崎崎石. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IBDesignable)

@property (nonatomic ,assign) IBInspectable CGFloat ibCordRadius;

@property (nonatomic ,assign) IBInspectable CGFloat ibBorderWidth;

@property (nonatomic ,assign) IBInspectable UIColor *ibBorderColor;


@end
