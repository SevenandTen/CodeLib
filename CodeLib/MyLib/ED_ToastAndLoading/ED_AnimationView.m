//
//  ED_AnimationView.m
//  CodeLib
//
//  Created by zw on 2018/11/28.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_AnimationView.h"

@interface ED_AnimationView () {
    UIColor *_showColor;
}

@property (nonatomic , strong) CALayer *backLayer;



@end

@implementation ED_AnimationView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        [self configureLayer];
    }
    return self;
}


- (void)configureLayer {
    self.layer.masksToBounds = YES;
    [self.layer addSublayer:self.backLayer];
    self.backLayer.masksToBounds = YES;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.backLayer.backgroundColor = self.showColor.CGColor;
    self.backLayer.frame = self.bounds;
    CGFloat centerX = self.bounds.size.width/2.0;
    CGFloat centerY = self.bounds.size.height/2.0;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:(centerY > centerX ? centerX :centerY) -5 startAngle:0  endAngle:M_PI * 2 - M_PI/6.0 clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 2;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineDashPhase = 0.8;
    shapeLayer.path = bezierPath.CGPath;
    [self.backLayer setMask:shapeLayer];
    [self updateAnimation];
}

- (void)setShowColor:(UIColor *)showColor {
    _showColor = showColor;
    self.backLayer.backgroundColor = showColor.CGColor;
}

- (UIColor *)showColor {
    if (!_showColor) {
        _showColor = [UIColor redColor];
    }
    return _showColor;
}


- (void)animation {
    //动画
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2.0*M_PI];
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.duration = 1;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_backLayer addAnimation:rotationAnimation forKey:@"rotationAnnimation"];
}


- (void)appWillBecomeActive {
    [self updateAnimation];
}


- (void)updateAnimation {
    [_backLayer removeAllAnimations];
    [self animation];
}

- (void)stopAnimation {
    [_backLayer removeAllAnimations];
}


- (void)dealloc {
    [_backLayer removeAllAnimations];
}



#pragma mark - Getter

- (CALayer *)backLayer {
    if (!_backLayer) {
        _backLayer = [CALayer layer];
    }
    return _backLayer;
}




@end
