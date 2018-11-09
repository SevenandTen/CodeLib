//
//  UIView+Frame.h
//  MyCode
//
//  Created by 崎崎石 on 2017/12/27.
//  Copyright © 2017年 崎崎石. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic , assign) CGFloat width;

@property (nonatomic , assign) CGFloat height;

@property (nonatomic , assign) CGSize size;

@property (nonatomic , assign) CGFloat originX;

@property (nonatomic , assign) CGFloat originY;

@property (nonatomic , assign) CGFloat centerX;

@property (nonatomic , assign) CGFloat centerY;

@property (nonatomic , assign) CGPoint origin;

@property (nonatomic , readonly) CGFloat maxY;

@property (nonatomic , readonly) CGFloat maxX;





@end
