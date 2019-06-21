//
//  ED_RectView.m
//  CodeLib
//
//  Created by zw on 2019/6/20.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_RectView.h"

@interface ED_RectView ()

@property (nonatomic , assign) CGPoint point1;

@property (nonatomic , assign) CGPoint point2;

@property (nonatomic , assign) CGPoint point3;

@property (nonatomic , assign) CGPoint point4;

@end

@implementation ED_RectView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    if ([self pointIsZero:self.point1] &&[self pointIsZero:self.point2] &&[self pointIsZero:self.point3] &&[self pointIsZero:self.point4]  ) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 1);
    
    CGContextMoveToPoint(context, self.point1.x, self.point1.y);
    CGContextAddLineToPoint(context, self.point2.x, self.point2.y);
    CGContextAddLineToPoint(context, self.point3.x, self.point3.y);
    CGContextAddLineToPoint(context, self.point4.x, self.point4.y);
    CGContextAddLineToPoint(context, self.point1.x, self.point1.y);
    
    CGContextStrokePath(context);
}


#pragma mark - public

- (void)refreshPoint1:(CGPoint)point1 point2:(CGPoint)point2 point3:(CGPoint)point3 point4:(CGPoint)point4 {
    self.point1 = point1;
    self.point2 = point2;
    self.point3 = point3;
    self.point4 = point4;
//    dispatch_async(dispatch_get_main_queue(), ^{
         [self setNeedsDisplay];
//    });
   
}


- (BOOL)pointIsZero:(CGPoint) point {
    if (point.x == CGPointZero.x && point.y == CGPointZero.y) {
        return YES;
    }
    return NO;
}




@end
