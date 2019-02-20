//
//  ED_ToastView.m
//  CodeLib
//
//  Created by zw on 2018/12/18.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_ToastView.h"
#import "ED_AnimationView.h"

@interface ED_ToastView()
@property (nonatomic , strong) UIView *backView;

@property (nonatomic , strong) UIImageView *logoImageView;

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) ED_AnimationView *anmationView;

@property (nonatomic , strong) UILabel *textLabel;

@property (nonatomic , strong) UILabel *loadingLabel;

@end

@implementation ED_ToastView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self.anmationView stopAnimation];
    }
}

#pragma mark —— Public

+ (ED_ToastView *)toastOnView:(UIView *)view style:(ED_ToastStyle)style title:(NSString *)title locationY:(CGFloat)loactionY showTime:(NSTimeInterval)showTime hideAfterTime:(NSTimeInterval)hideTime showAnmation:(BOOL)showAnmation hideAnmation:(BOOL)hideAnmation {
    ED_ToastView *toast = [[ED_ToastView alloc] init];
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [toast dealWithView:view style:style title:title locationY:loactionY];
    if (showTime == 0) {
        [toast showOnView:view complete:^{
            if (hideTime == 0) {
                [toast hideNow];
            }else{
                [toast hideAfterTime:hideTime anmation:hideAnmation];
            }
        }];
    }else{
        [toast showOnView:view time:showTime anmation:showAnmation complete:^{
            if (hideTime == 0) {
                [toast hideNow];
            }else{
                [toast hideAfterTime:hideTime anmation:hideAnmation];
            }
        }];
    }
    return toast;
}

+ (ED_ToastView *)toastOnView:(UIView *)view style:(ED_ToastStyle)style title:(NSString *)title  locationY:(CGFloat)locationY showTime:(NSTimeInterval)showTime showAnmation:(BOOL)showAnmation {
    ED_ToastView *toast = [[ED_ToastView alloc] init];
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [toast dealWithView:view style:style title:title locationY:locationY];
    if (showTime == 0) {
        [toast showOnView:view complete:nil];
    }else{
        [toast showOnView:view time:showTime anmation:showAnmation complete:nil];
    }
    return toast;
}


- (void)hideAfterTime:(NSTimeInterval )time anmation:(BOOL)anmation {
    if (anmation) {
        [UIView animateWithDuration:time animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self hideNow];
        }];
    }else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideNow];
        });
    }
}

- (void)hideNow {
    [self removeFromSuperview];
}

- (void)showOnView:(UIView *)view complete:(void (^)(void))complete {
    [view addSubview:self];
    if (complete) {
        complete();
    }
}

- (void)showOnView:(UIView *)view time:(NSTimeInterval)time anmation:(BOOL)anmiation complete:(void (^)(void))complete {
    
    if (anmiation) {
        [view addSubview:self];
        self.alpha = 0;
        [UIView animateWithDuration:time animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            if (complete) {
                complete();
            }
        }];
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showOnView:view complete:complete];
        });
    }
}



#pragma mark - Private

- (void)dealWithView:(UIView *)view style:(ED_ToastStyle)style title:(NSString *)title  locationY:(CGFloat)locationY{
    CGFloat width = view.bounds.size.width;
    if (width - 60 > 0) {
        width = width - 60;
    }
    CGSize size = [ED_ToastView calculateSizeWithAttributeText:title font:[UIFont systemFontOfSize:15] width:(width - 20)];
    if (style == ED_ToastSuccessShortMessage) {
        self.logoImageView.hidden = NO;
        self.titleLabel.hidden = NO;
        self.titleLabel.text = title;
        self.frame = CGRectMake((view.bounds.size.width - 140)/2.0, (view.bounds.size.height -140)/2.0, 140, 140);
    }else if (style == ED_ToastLocationTop) {
        self.textLabel.hidden = NO;
        self.frame = CGRectMake((view.bounds.size.width - (size.width + 20))/2.0, 50, size.width + 20, size.height + 20);
        self.textLabel.text = title;
    }else if (style == ED_ToastLocationBottom) {
        self.textLabel.hidden = NO;
        self.frame = CGRectMake((view.bounds.size.width - (size.width + 20))/2.0, view.bounds.size.height - 40 - size.height, size.width + 20, size.height + 20);
        self.textLabel.text = title;
        
    }else if (style == ED_ToastLocationCenter) {
        self.textLabel.hidden = NO;
        self.frame = CGRectMake((view.bounds.size.width - (size.width + 20))/2.0, (view.bounds.size.height - 20 - size.height)/2.0, size.width + 20, size.height + 20);
        self.textLabel.text = title;
        
    }else if (style == ED_ToastLoadingShortMessage){
        self.anmationView.hidden = NO;
        self.titleLabel.hidden = NO;
        self.titleLabel.text = title;
        self.frame = CGRectMake((view.bounds.size.width - 140)/2.0, (view.bounds.size.height -140)/2.0, 140, 140);
        self.anmationView.frame = CGRectMake(45, 30, 50, 50);
        [self.anmationView updateAnimation];
    }else if (style == ED_ToastLocationCustom) {
        self.textLabel.hidden = NO;
        self.frame = CGRectMake((view.bounds.size.width - (size.width + 20))/2.0, (view.bounds.size.height - 20 - size.height)/2.0, size.width + 20, size.height + 20);
        self.textLabel.text = title;
    }
    
}



+ (CGSize)calculateSizeWithAttributeText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    if (text.length == 0) {
        return CGSizeZero;
    }
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = width;
    label.font = font;
    label.attributedText = attributedText;
    CGSize intrinsicContentSize = [label intrinsicContentSize];
    
    return CGSizeMake(ceilf(MIN(intrinsicContentSize.width, width)) , ceilf(intrinsicContentSize.height));
}

- (void)configureViews {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backView];
    
    [self addSubview:self.logoImageView];
    self.logoImageView.hidden = YES;
    
    [self addSubview:self.titleLabel];
    self.titleLabel.hidden = YES;
    
    [self addSubview:self.textLabel];
    self.textLabel.hidden = YES;
    
    [self addSubview:self.anmationView];
    self.anmationView.hidden = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backView.frame = self.bounds;
    self.logoImageView.frame = CGRectMake((self.bounds.size.width - 43)/2.0, 40, 43, 30);
    self.titleLabel.frame = CGRectMake(0, self.bounds.size.height - 51, self.bounds.size.width, 21);
    self.textLabel.frame = CGRectMake(10, 10, self.bounds.size.width - 20, self.bounds.size.height - 20);
}

#pragma mark - Getter

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.8;
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 5;
    }
    return _backView;
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_ok"]];
    }
    return _logoImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (ED_AnimationView *)anmationView {
    if (!_anmationView) {
        _anmationView = [[ED_AnimationView alloc] init];
        _anmationView.showColor = [UIColor whiteColor];
    }
    return _anmationView;
}


- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}



@end
