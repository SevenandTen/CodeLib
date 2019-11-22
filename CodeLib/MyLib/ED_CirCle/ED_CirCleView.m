//
//  ED_CirCleView.m
//  CodeLib
//
//  Created by zw on 2019/7/17.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_CirCleView.h"

@interface ED_CirCleView ()

@property (nonatomic , strong) CALayer *backLayer;

@property (nonatomic , strong) CAShapeLayer *bottomLayer;

@property (nonatomic , strong) CAShapeLayer *topLayer;

@property (nonatomic , strong) CADisplayLink *link;

@property (nonatomic , strong) UIView *anmationView;

@property (nonatomic , strong) UIView *pointView;


@property (nonatomic , assign) BOOL flag;





@end

@implementation ED_CirCleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame] ) {
        self.flag = NO;
        [self configureLayer];
    }
    return self;
}



- (void)configureLayer {
    self.layer.masksToBounds = YES;
    [self.layer addSublayer:self.backLayer];
    self.backLayer.masksToBounds = YES;
    
    [self.backLayer addSublayer:self.bottomLayer];
    [self.backLayer addSublayer:self.topLayer];
    
    [self addSubview:self.anmationView];
    
    [self.anmationView addSubview:self.pointView];

}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.flag) {
        return;
    }else{
        self.flag = YES;
    }
    
    self.backLayer.backgroundColor = [UIColor whiteColor].CGColor;
    self.backLayer.frame = self.bounds;
    CGFloat centerX = self.bounds.size.width/2.0;
    CGFloat centerY = self.bounds.size.height/2.0;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:(centerY > centerX ? centerX :centerY) -5 startAngle:0  endAngle:M_PI * 2  clockwise:YES];

    self.topLayer.path = bezierPath.CGPath;
    self.bottomLayer.path = bezierPath.CGPath;
    
    CGFloat anmationWidth = ((centerY > centerX ? centerX :centerY) -5 ) * 2;
    
    self.anmationView.frame = CGRectMake((self.bounds.size.width - anmationWidth)/2.0, (self.bounds.size.height - anmationWidth)/2.0, anmationWidth, anmationWidth);
    
    self.pointView.frame = CGRectMake(self.anmationView.bounds.size.width - 4, (self.anmationView.bounds.size.height - 8 )/2.0, 8, 8);


    
}

#pragma mark - Public

- (void)startAnmation {

        [CATransaction begin];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [CATransaction setAnimationDuration:0.5];
        self.topLayer.strokeEnd =  1;
        [CATransaction commit];
        CABasicAnimation *animation =  [CABasicAnimation
                                        animationWithKeyPath:@"transform.rotation.z"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue =  [NSNumber numberWithFloat: 2 *  M_PI ];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        animation.duration  = 0.5;  //动画持续时间
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO; //动画后是否回到最初状态（配合kCAFillModeForwards使用）
        animation.repeatCount = 1; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
        [self.anmationView.layer addAnimation:animation forKey:nil];
    
    if (self.progress == 1) {
        return;
    }
    
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.bottomLayer.strokeColor = [UIColor colorWithRed:255/255.0 green:153/255.0 blue:0/255.0 alpha:1].CGColor;
            [CATransaction begin];
            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [CATransaction setAnimationDuration:0.9];
            self.topLayer.strokeEnd =  self.progress;
            [CATransaction commit];
            CABasicAnimation *animation =  [CABasicAnimation
                                            animationWithKeyPath:@"transform.rotation.z"];
            //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
            animation.fromValue = [NSNumber numberWithFloat:2 *  M_PI];
            animation.toValue =  [NSNumber numberWithFloat: 2* self.progress *  M_PI ];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            animation.duration  = 0.9;  //动画持续时间
            animation.fillMode = kCAFillModeForwards;
            animation.removedOnCompletion = NO; //动画后是否回到最初状态（配合kCAFillModeForwards使用）
            animation.repeatCount = 1; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
            [self.anmationView.layer addAnimation:animation forKey:nil];
        });
//
   
    
   
  
}


#pragma mark - Action

- (void)runAnmation {
   
}





#pragma mark - Getter

- (CALayer *)backLayer {
    if (!_backLayer) {
        _backLayer = [CALayer layer];
    }
    return _backLayer;
}


- (CAShapeLayer *)bottomLayer {
    if (!_bottomLayer) {
        _bottomLayer = [CAShapeLayer layer];
        _bottomLayer.fillColor = [UIColor clearColor].CGColor;
        _bottomLayer.strokeColor = [UIColor colorWithRed:240/255.0 green:243/255.0 blue:249/255.0 alpha:1].CGColor;
        _bottomLayer.lineWidth = 8;
        _bottomLayer.strokeStart = 0;
        _bottomLayer.strokeEnd = 1;
        _bottomLayer.lineCap = kCALineCapRound;
        _bottomLayer.lineDashPhase = 0.8;
    }
    return _bottomLayer;
}





- (CAShapeLayer *)topLayer {
    if (!_topLayer) {
        _topLayer = [CAShapeLayer layer];
        _topLayer = [CAShapeLayer layer];
        _topLayer.fillColor = [UIColor clearColor].CGColor;
        _topLayer.strokeColor = [UIColor colorWithRed:51/255.0 green:135/255.0 blue:255/255.0 alpha:1].CGColor;
        _topLayer.lineWidth = 8;
        _topLayer.strokeStart = 0;
        _topLayer.strokeEnd = 0;
        _topLayer.lineCap = kCALineCapButt;
        _topLayer.lineDashPhase = 0;
    }
    return _topLayer;
}

- (UIView *)anmationView {
    if (!_anmationView) {
        _anmationView = [[UIView alloc] init];
        _anmationView.backgroundColor = [UIColor clearColor];
    }
    return _anmationView;
}


- (UIView *)pointView {
    if (!_pointView) {
        _pointView = [[UIView alloc] init];
        _pointView.layer.masksToBounds = YES;
        _pointView.layer.cornerRadius = 4;
        _pointView.layer.borderWidth = 1;
        _pointView.layer.borderColor = [UIColor colorWithRed:51/255.0 green:135/255.0 blue:255/255.0 alpha:1].CGColor;
        _pointView.backgroundColor = [UIColor whiteColor];
    }
    return _pointView;
    
}


@end
