//
//  ED_PhoneCodeView.m
//  MyCode
//
//  Created by 崎崎石 on 2018/5/28.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import "ED_PhoneCodeView.h"

@interface ED_PhoneCodeView()

@property (nonatomic , strong) UIButton *codeBtn;

@property (nonatomic , strong) NSTimer *timer;

@property (nonatomic , assign) NSInteger totalTime;

@property (nonatomic , strong) UILabel *codeLabel;


@property (nonatomic , strong) NSString *nomalTitle;

@property (nonatomic , strong) UIColor *normalColor;

@property (nonatomic , strong) UIColor *unableColor;

@property (nonatomic , assign) NSInteger maxTime;

@end

@implementation ED_PhoneCodeView

#pragma mark - Init

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _totalTime = 60;
        [self configureViews];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _totalTime = 60;
        [self configureViews];
    }
    return self;
}


#pragma mark - configureViews

- (void)configureViews {
    [self addSubview:self.codeLabel];
    self.codeLabel.frame = self.bounds;
    self.codeLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.codeBtn];
    self.codeBtn.frame = self.bounds;
    self.codeBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

}

#pragma mark - Public

- (void)setFont:(UIFont *)font {
    self.codeLabel.font = font;
}

- (void)setNormalTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    self.nomalTitle = title;
    self.normalColor = titleColor;
    if (self.codeBtn.enabled) {
        self.codeLabel.text = title;
        self.codeLabel.textColor = titleColor;
    }
}

- (void)setUnableTime:(NSInteger)time unableColor:(UIColor *)unableColor {
    self.maxTime = time;
    self.unableColor = unableColor;
    if (self.codeBtn.enabled) {
        self.totalTime = time;
    }
}




#pragma mark - Action

- (void)didClickCodeBtn {
    [self.phoneCodeDelegate phoneCodeViewDidClick:self];
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerStart) userInfo:nil repeats:YES];
    self.codeBtn.enabled = NO;
    self.codeLabel.text = [NSString stringWithFormat:@"%ld秒",self.totalTime] ;
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)timerStart {
    self.totalTime = self.totalTime - 1;
    if (self.totalTime == 0) {
        [self.timer invalidate];
        self.timer = nil;
        self.codeLabel.text = self.nomalTitle.length != 0 ? self.nomalTitle : @"获取验证码";
        if (self.normalColor) {
            self.codeLabel.textColor = self.normalColor;
        }
        self.codeBtn.enabled = YES;
       
        self.totalTime = self.maxTime == 0 ? 60 : self.maxTime ;
        
    }else{
        self.codeLabel.text = [NSString stringWithFormat:@"%ld秒",self.totalTime] ;
        if (self.unableColor) {
            self.codeLabel.textColor = self.unableColor;
        }
    }
}

- (void)dealloc {
    [self.timer  invalidate];
    self.timer = nil;
}

- (UIButton *)codeBtn {
    if (!_codeBtn) {
        _codeBtn = [[UIButton alloc] init];
        [_codeBtn addTarget:self action:@selector(didClickCodeBtn) forControlEvents:UIControlEventTouchUpInside];
        _codeBtn.backgroundColor = [UIColor clearColor];
    }
    return _codeBtn;
}


- (UILabel *)codeLabel {
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc] init];
        _codeLabel.textAlignment = NSTextAlignmentRight;
        _codeLabel.text = @"获取验证码";
        _codeLabel.font = [UIFont systemFontOfSize:14];
        int a = 0xff993f;
        _codeLabel.textColor = [UIColor colorWithRed:((a >> 16) &0xff)/255.0 green:((a >> 8) &0xff)/255.0  blue:(a&0xff)/255.0 alpha:1.0];
    }
    return _codeLabel;
}

@end
