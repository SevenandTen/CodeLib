//
//  ED_SparatorLineView.m
//  CodeLib
//
//  Created by zw on 2019/9/6.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_SparatorLineView.h"

@interface ED_SparatorLineView ()

@property (nonatomic ,strong) CAShapeLayer *shapeLayer;


@end

@implementation ED_SparatorLineView
@synthesize lineColor = _lineColor;
@synthesize lineLength = _lineLength;
@synthesize space = _space;
@synthesize style = _style;


- (instancetype)initWithLineLength:(CGFloat)lineLength space:(CGFloat)space lineColor:(UIColor *)lineColor style:(ED_SparatorLineViewStyle)style {
    if (self = [super initWithFrame:CGRectZero]) {
        _lineLength = lineLength;
        _lineColor = lineColor;
        _style = style;
        _space = space;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    ED_SparatorLineView *object = [self initWithLineLength:3 space:5 lineColor:[UIColor blackColor] style:ED_SparatorLineViewStyleHorizontal];
    object.frame = frame;
    return object;
}


- (void)layoutSubviews {
    if (self.bounds.size.width == 0 || self.bounds.size.height == 0) {
        return;
    }
    if (self.shapeLayer) {
        [self.shapeLayer removeFromSuperlayer];
    }
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.bounds;
    if (self.style == ED_SparatorLineViewStyleHorizontal) {
        [self.shapeLayer setLineWidth:self.bounds.size.height];
    }else {
        [self.shapeLayer setLineWidth:self.bounds.size.width];
    }
    [self.shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [self.shapeLayer setStrokeColor:self.lineColor.CGColor];
    
    [self.shapeLayer setLineJoin:kCALineJoinRound];
//    self.shapeLayer.lineCap = kCALineCapRound;
    
    //  设置线宽，线间距
    [self.shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:self.lineLength], [NSNumber numberWithInt:self.space], nil]];
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:0];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);

    if (self.style == ED_SparatorLineViewStyleHorizontal ) {
        CGPathAddLineToPoint(path, NULL,self.bounds.size.width, 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, self.bounds.size.height);
    }

    
    [self.shapeLayer setPath:path];
    CGPathRelease(path);
    [self.layer addSublayer:self.shapeLayer];
    
}

@end
