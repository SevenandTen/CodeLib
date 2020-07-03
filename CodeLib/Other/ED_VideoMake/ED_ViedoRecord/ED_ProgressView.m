//
//  ED_ProgressView.m
//  CodeLib
//
//  Created by zw on 2019/12/31.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_ProgressView.h"

@interface ED_ProgressView()

@property (nonatomic , strong) CAShapeLayer *progressLayer;

@property (nonatomic , strong) CAShapeLayer *backLayer;

@property (nonatomic , assign) BOOL flag;

@property (nonatomic , strong) UIView *whiteView;

@property (nonatomic , copy) void(^actionBlock)(void);

@property (nonatomic , assign) NSInteger count ;

@property (nonatomic , strong) NSTimer *timer;


@end

@implementation ED_ProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.flag = YES;
        self.count = 0;
        [self configureViews];
    }
    return self;
}

- (void)configureViews {
    [self.layer addSublayer:self.backLayer];
    [self.layer addSublayer:self.progressLayer];
    [self addSubview:self.whiteView];
}

- (void)startRecordTimeActionBlock:(void (^)(void))actionBlock {
    self.actionBlock = actionBlock;
    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:20];
    self.progressLayer.strokeEnd =  1;
    [CATransaction commit];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.actionBlock) {
            self.actionBlock();
        }
        self.progressLayer.strokeEnd = 0;
    });

}


- (void)stopRecordTime {
    [self.progressLayer removeAllAnimations];
    self.actionBlock = nil;
     self.progressLayer.strokeEnd = 0;

}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.flag) {
        return;
    }
    self.flag  = NO;
    
    CGFloat centerX = self.bounds.size.width/2.0;
     CGFloat centerY = self.bounds.size.height/2.0;
     UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:(centerY > centerX ? centerX :centerY) -5 startAngle:0  endAngle:M_PI * 2  clockwise:YES];
    self.backLayer.frame = self.bounds;
    self.progressLayer.frame = self.bounds;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat whiteWidth = ( width > height ? height : width ) - 20;
    
    
    self.whiteView.frame = CGRectMake((width - whiteWidth)/2.0, (height - whiteWidth)/2.0, whiteWidth, whiteWidth );
    self.whiteView.layer.masksToBounds = YES;
    self.whiteView.layer.cornerRadius = whiteWidth / 2.0;
    
    self.backLayer.path = bezierPath.CGPath;
    self.progressLayer.path = bezierPath.CGPath;
    
    self.transform = CGAffineTransformMakeRotation(- M_PI_2);
    
}









#pragma mark - Getter

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
//        _progressLayer.strokeColor = [UIColor colorWithRed:51/255.0 green:135/255.0 blue:255/255.0 alpha:1].CGColor;
        _progressLayer.strokeColor = [UIColor redColor].CGColor;
        _progressLayer.lineWidth = 10;
        _progressLayer.strokeStart = 0;
        _progressLayer.strokeEnd = 0;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.lineDashPhase = 0;
        
    }
    return _progressLayer;
}


- (CAShapeLayer *)backLayer {
    if (!_backLayer) {
        _backLayer = [CAShapeLayer layer];
        _backLayer.fillColor = [UIColor clearColor].CGColor;
//        _backLayer.strokeColor = [UIColor colorWithRed:51/255.0 green:135/255.0 blue:255/255.0 alpha:1].CGColor;
        _backLayer.strokeColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
        _backLayer.lineWidth = 10;
        _backLayer.strokeStart = 0;
        _backLayer.strokeEnd = 1;
        _backLayer.lineCap = kCALineCapRound;
        _backLayer.lineDashPhase = 0;
    }
    return _backLayer;
}


- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}

@end
