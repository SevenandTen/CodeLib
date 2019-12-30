//
//  ED_CarNumberAlertView.m
//  CodeLib
//
//  Created by zw on 2019/12/30.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_CarNumberAlertView.h"
#import "ED_CarNumberFiled.h"

@interface ED_CarNumberAlertView ()<ED_KeyBoardInputViewDelegate,UITextFieldDelegate>

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) UIButton *finishBtn;

@property (nonatomic , strong) UIView *lineView;

@property (nonatomic , strong) ED_KeyBoardInputView *cityIntputView;

@property (nonatomic , strong)  ED_KeyBoardInputView *numberIntputView;


@property (nonatomic , strong) UIImageView *logoImageView;

@property (nonatomic , strong) UILabel *tipLabel;

@property (nonatomic , strong) UIButton *switchTypeBtn;


@property (nonatomic , strong) ED_CarNumberFiled *firstFiled;

@property (nonatomic , strong) ED_CarNumberFiled *secondFiled;

@property (nonatomic , strong) ED_CarNumberFiled *thirdFiled;

@property (nonatomic , strong) ED_CarNumberFiled *forthFiled;

@property (nonatomic , strong) ED_CarNumberFiled *fivethFiled;

@property (nonatomic , strong) ED_CarNumberFiled *sixthFiled;

@property (nonatomic , strong) ED_CarNumberFiled *seventhFiled;

@property (nonatomic , strong) ED_CarNumberFiled *eigthFiled;


@property (nonatomic , copy) void(^actionBlock)(NSString *plateNumber);

@property (nonatomic , assign) BOOL anmation;




@end

@implementation ED_CarNumberAlertView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}


- (void)configureViews {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.finishBtn];
    
    [self addSubview:self.logoImageView];
     [self addSubview:self.tipLabel];
     [self addSubview:self.switchTypeBtn];
     
     [self addSubview:self.firstFiled];
     [self addSubview:self.secondFiled];
     [self addSubview:self.thirdFiled];
     [self addSubview:self.forthFiled];
     [self addSubview:self.fivethFiled];
     [self addSubview:self.sixthFiled];
     [self addSubview:self.seventhFiled];
     [self addSubview:self.eigthFiled];
    
    
    [self addSubview:self.cityIntputView];
    [self addSubview:self.numberIntputView];
    
    [self updateBtnStatus];
    
    [self.firstFiled becomeFirstResponder];

}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateFiledsFrame];
    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, 50);
    self.finishBtn.frame = CGRectMake(self.bounds.size.width - 60, 0, 50, 50);
    self.lineView.frame = CGRectMake(0, 50, self.bounds.size.width, 1/[UIScreen mainScreen].scale);
    self.tipLabel.frame = CGRectMake(self.bounds.size.width - 85, 136.5, 85, 21);
    self.logoImageView.frame = CGRectMake(self.bounds.size.width - 110, 138, 18, 18);
    self.switchTypeBtn.frame = CGRectMake(self.bounds.size.width - 110, 136.5, 110, 21);
    
    self.numberIntputView.frame = CGRectMake(0, CGRectGetMaxY(self.tipLabel.frame) + 7.5, self.bounds.size.width, self.bounds.size.height - 7.5 - CGRectGetMaxY(self.tipLabel.frame) + 7.5 );
    self.cityIntputView.frame = CGRectMake(0, CGRectGetMaxY(self.tipLabel.frame) + 7.5, self.bounds.size.width, self.bounds.size.height - 7.5 - CGRectGetMaxY(self.tipLabel.frame) + 7.5 );
    
    
    
}



+ (ED_CarNumberAlertView *)showWithCarNumber:(NSString *)carNumber anmation:(BOOL)anmation actionBlock:(void (^)(NSString *))actionBlock {
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIView *superView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    superView.backgroundColor = [UIColor clearColor];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    ED_CarNumberAlertView *carNumberView = [[ED_CarNumberAlertView alloc] init];
    if (@available(iOS 11.0 , *)) {
           carNumberView.frame = CGRectMake(0,height, width, 392 + [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom);
       }else{
           carNumberView.frame = CGRectMake(0, height, width, 392);
       }
    [carNumberView setCarNumber:carNumber];
    [superView addSubview:backView];
    [superView addSubview:carNumberView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:carNumberView action:@selector(didClickDismiss)];
    [backView addGestureRecognizer:tap];
    carNumberView.actionBlock = actionBlock;
    carNumberView.anmation = anmation;
    
    [[UIApplication sharedApplication].keyWindow addSubview:superView];
    
    if (anmation) {
        [UIView animateWithDuration:0.25 animations:^{
            if (@available(iOS 11.0 , *)) {
                carNumberView.frame = CGRectMake(0,height - 392 - [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom, width, 392 + [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom);
            }else{
                carNumberView.frame = CGRectMake(0, height - 392, width, 392);
            }
        }];
    }else{
        if (@available(iOS 11.0 , *)) {
            carNumberView.frame = CGRectMake(0,height - 392 - [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom, width, 392 + [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom);
        }else{
            carNumberView.frame = CGRectMake(0, height - 392, width, 392);
        }
    }
    
    
    
    
    return  carNumberView;
    
}



- (void)setCarNumber:(NSString *)carNumber {
    if (!(carNumber.length == 7 || carNumber.length == 8)) {
        return;
    }
    if (carNumber.length == 7) {
        self.switchTypeBtn.selected = NO;
        [self.seventhFiled becomeFirstResponder];
        [self.firstFiled resignFirstResponder];
    }else if (carNumber.length == 8) {
        self.switchTypeBtn.selected = YES;
        self.eigthFiled.text = [carNumber substringWithRange:NSMakeRange(7, 1)];
        [self.eigthFiled becomeFirstResponder];
         [self.firstFiled resignFirstResponder];
    }
    
    self.logoImageView.image = [UIImage imageNamed:self.switchTypeBtn.selected ? @"btn_xz_pre" : @"btn_xz_nor"];
    self.firstFiled.text = [carNumber substringWithRange:NSMakeRange(0, 1)];
    self.secondFiled.text = [carNumber substringWithRange:NSMakeRange(1, 1)];
     self.thirdFiled.text = [carNumber substringWithRange:NSMakeRange(2, 1)];
     self.forthFiled.text = [carNumber substringWithRange:NSMakeRange(3, 1)];
     self.fivethFiled.text = [carNumber substringWithRange:NSMakeRange(4, 1)];
     self.sixthFiled.text = [carNumber substringWithRange:NSMakeRange(5, 1)];
     self.seventhFiled.text = [carNumber substringWithRange:NSMakeRange(6, 1)];
    
    [self updateBtnStatus];
    [self updateFiledsFrame];
}


#pragma mark - Action

- (void)didClickDismiss {
    if (self.anmation) {
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            [self.superview removeFromSuperview];
        }];
    }else{
        [self.superview removeFromSuperview];
    }
}

- (void)didClickSwitchType {
    self.switchTypeBtn.selected = !self.switchTypeBtn.selected;
    self.logoImageView.image = [UIImage imageNamed:self.switchTypeBtn.selected ? @"btn_xz_pre" : @"btn_xz_nor"];
    [self updateFiledsFrame];
    if (self.switchTypeBtn.selected) {
        if (self.seventhFiled.text.length > 0) {
             self.eigthFiled.text = @"";
            [self.eigthFiled becomeFirstResponder];
        }else {
            if ([self.seventhFiled isFirstResponder]) {
                [self.numberIntputView setLastBtnStatusWithFlag:NO];
            }
        }
    }else {
        if (self.eigthFiled.text.length > 0) {
            self.eigthFiled.text = @"";
//            [self.seventhFiled becomeFirstResponder];
        }
        if ([self.seventhFiled isFirstResponder]) {
            [self.numberIntputView setLastBtnStatusWithFlag:YES];
        }
    }
    
    [self updateBtnStatus];
}


- (void)didClickFinish {
        if (self.actionBlock) {
            NSString *carNumber = nil;
            if (self.switchTypeBtn.selected) {
                carNumber = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",self.firstFiled.text,self.secondFiled.text,self.thirdFiled.text,self.forthFiled.text,self.fivethFiled.text,self.sixthFiled.text,self.seventhFiled.text,self.eigthFiled.text];
            }else {
                carNumber = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",self.firstFiled.text,self.secondFiled.text,self.thirdFiled.text,self.forthFiled.text,self.fivethFiled.text,self.sixthFiled.text,self.seventhFiled.text];
            }
            self.actionBlock(carNumber);
            
            
        }
    
    [self didClickDismiss];
   
}



#pragma mark - Private


- (void)updateBtnStatus {
    BOOL flag;
    if (self.switchTypeBtn.selected) {
         flag = (self.firstFiled.text.length == 1) &&(self.secondFiled.text.length == 1)&&(self.thirdFiled.text.length == 1)&&(self.forthFiled.text.length == 1)&&(self.fivethFiled.text.length == 1)&&(self.sixthFiled.text.length == 1)&&(self.seventhFiled.text.length == 1)&&(self.eigthFiled.text.length == 1);
    }else{
        flag = (self.firstFiled.text.length == 1) &&(self.secondFiled.text.length == 1)&&(self.thirdFiled.text.length == 1)&&(self.forthFiled.text.length == 1)&&(self.fivethFiled.text.length == 1)&&(self.sixthFiled.text.length == 1)&&(self.seventhFiled.text.length == 1);
    }
    self.finishBtn.enabled = flag;
    
}

- (void)updateFiledsFrame {
    CGFloat normalY = 84;
    CGFloat normalWidth = 30;
    CGFloat normalHeight = 40;
    if (self.switchTypeBtn.selected) {
        self.eigthFiled.hidden = NO;
        self.firstFiled.frame = CGRectMake(28.5, normalY, normalWidth, 40);
        self.secondFiled.frame = CGRectMake(CGRectGetMaxX(self.firstFiled.frame) + 8, normalY, normalWidth, normalHeight);
        CGFloat width = self.bounds.size.width;
        self.eigthFiled.frame = CGRectMake(width - 28.5 - 30, normalY, normalWidth, normalHeight);
         self.seventhFiled.frame = CGRectMake(CGRectGetMinX(self.eigthFiled.frame) - 8 - 30, normalY, normalWidth, normalHeight);
         self.sixthFiled.frame = CGRectMake(CGRectGetMinX(self.seventhFiled.frame) - 8 - 30, normalY, normalWidth, normalHeight);
        self.fivethFiled.frame = CGRectMake(CGRectGetMinX(self.sixthFiled.frame) - 8 - 30, normalY, normalWidth, normalHeight);
         self.forthFiled.frame = CGRectMake(CGRectGetMinX(self.fivethFiled.frame) - 8 - 30, normalY, normalWidth, normalHeight);
         self.thirdFiled.frame = CGRectMake(CGRectGetMinX(self.forthFiled.frame) - 8 - 30, normalY, normalWidth, normalHeight);
    }else{
        self.eigthFiled.hidden = YES;
        self.firstFiled.frame = CGRectMake(47.5, normalY, normalWidth, 40);
        self.secondFiled.frame = CGRectMake(CGRectGetMaxX(self.firstFiled.frame) + 8, normalY, normalWidth, normalHeight);
         CGFloat width = self.bounds.size.width;
        self.seventhFiled.frame = CGRectMake(width - 47.5 - 30, normalY, normalWidth, normalHeight);
        self.sixthFiled.frame = CGRectMake(CGRectGetMinX(self.seventhFiled.frame) - 8 - 30, normalY, normalWidth, normalHeight);
        self.fivethFiled.frame = CGRectMake(CGRectGetMinX(self.sixthFiled.frame) - 8 - 30, normalY, normalWidth, normalHeight);
        self.forthFiled.frame = CGRectMake(CGRectGetMinX(self.fivethFiled.frame) - 8 - 30, normalY, normalWidth, normalHeight);
        self.thirdFiled.frame = CGRectMake(CGRectGetMinX(self.forthFiled.frame) - 8 - 30, normalY, normalWidth, normalHeight);
        
    }
}

#pragma mark - ED_KeyBoardViewDelegate

- (void)keyboard:(ED_KeyBoardInputView *)keyBoardView didInputText:(NSString *)text {
    if ([keyBoardView isEqual:self.cityIntputView]) {
        if ([text isEqualToString:@"\n"]) {
            self.firstFiled.text = @"";
        }else{
            self.firstFiled.text = text;
            [self.secondFiled becomeFirstResponder];
        }
    }else {
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        UITextField *currentTextFiled = (UITextField *) [keyWindow performSelector:@selector(firstResponder)];
         UITextField *nextTextFiled;
       
        if ([text isEqualToString:@"\n"]) {
            if (currentTextFiled.text.length > 0) {
                currentTextFiled.text = @"";
                return;
            }else {
                if ([currentTextFiled isEqual:self.secondFiled]) {
                    nextTextFiled = self.firstFiled;
                }else if ([currentTextFiled isEqual:self.thirdFiled]) {
                    nextTextFiled = self.secondFiled;
                }else if ([currentTextFiled isEqual:self.forthFiled]) {
                    nextTextFiled = self.thirdFiled;
                }else if ([currentTextFiled isEqual:self.fivethFiled]) {
                    nextTextFiled = self.forthFiled;
                }else if ([currentTextFiled isEqual:self.sixthFiled]) {
                    nextTextFiled = self.fivethFiled;
                }else if ([currentTextFiled isEqual:self.seventhFiled]) {
                    nextTextFiled = self.sixthFiled;
                }else if ([currentTextFiled isEqual:self.eigthFiled]) {
                    nextTextFiled = self.seventhFiled;
                }
                nextTextFiled.text = @"";
                [nextTextFiled becomeFirstResponder];
                
            }
            
        }else {
            if ([currentTextFiled isEqual:self.secondFiled]) {
                nextTextFiled = self.thirdFiled;
            }else if ([currentTextFiled isEqual:self.thirdFiled]) {
                nextTextFiled = self.forthFiled;
            }else if ([currentTextFiled isEqual:self.forthFiled]) {
                nextTextFiled = self.fivethFiled;
            }else if ([currentTextFiled isEqual:self.fivethFiled]) {
                nextTextFiled = self.sixthFiled;
            }else if ([currentTextFiled isEqual:self.sixthFiled]) {
                nextTextFiled = self.seventhFiled;
            }else if ([currentTextFiled isEqual:self.seventhFiled] && self.switchTypeBtn.selected) {
                nextTextFiled = self.eigthFiled;
            }
            currentTextFiled.text = text;
            [nextTextFiled becomeFirstResponder];
            
        }
    }
    [self updateBtnStatus];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField  {
    if ([textField isEqual:self.secondFiled]) {
        [self.numberIntputView setBtnStatusWithFlag:NO fromBeginIndex:0 toEndIndex:9];
        [self.numberIntputView setLastBtnStatusWithFlag:NO];
    }else if ([textField isEqual:self.eigthFiled] && self.switchTypeBtn.selected) {
         [self.numberIntputView setBtnStatusWithFlag:YES fromBeginIndex:0 toEndIndex:9];
        [self.numberIntputView setLastBtnStatusWithFlag:YES];
    }else if ([textField isEqual:self.seventhFiled] && self.switchTypeBtn.selected == NO ) {
         [self.numberIntputView setBtnStatusWithFlag:YES fromBeginIndex:0 toEndIndex:9];
         [self.numberIntputView setLastBtnStatusWithFlag:YES];
    }else{
        [self.numberIntputView setBtnStatusWithFlag:YES fromBeginIndex:0 toEndIndex:9];
         [self.numberIntputView setLastBtnStatusWithFlag:NO];
    }
    
    if ([textField isEqual:self.firstFiled]) {
        self.cityIntputView.hidden = NO;
        self.numberIntputView.hidden = YES;
    }else {
        self.cityIntputView.hidden = YES;
        self.numberIntputView.hidden = NO;
    }
    
    
        return YES;
    
    
}




#pragma mark - Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        _titleLabel.text = @"输入车牌号";
    }
    return _titleLabel;
}


- (UIButton *)finishBtn {
    if (!_finishBtn) {
        _finishBtn = [[UIButton alloc] init];
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_finishBtn setTitleColor:[UIColor colorWithRed:28/255.0 green:196/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
         [_finishBtn setTitleColor:[UIColor colorWithRed:165/255.0 green:232/255.0 blue:194/255.0 alpha:1] forState:UIControlStateDisabled];
        _finishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_finishBtn addTarget:self action:@selector(didClickFinish) forControlEvents:UIControlEventTouchUpInside];
        _finishBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _finishBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _lineView;
}


- (ED_KeyBoardInputView *)cityIntputView {
    if (!_cityIntputView) {
        _cityIntputView = [[ED_KeyBoardInputView alloc] initWithKeyBoardType:ED_KeyBoardInputCity];
        _cityIntputView.delegate = self;
    }
    return _cityIntputView;
}

- (ED_KeyBoardInputView *)numberIntputView {
    if (!_numberIntputView) {
        _numberIntputView = [[ED_KeyBoardInputView alloc] initWithKeyBoardType:ED_KeyBoardInputNumber];
        _numberIntputView.delegate = self;
    }
    return _numberIntputView;
}


- (ED_CarNumberFiled *)firstFiled {
    if (!_firstFiled) {
        _firstFiled = [[ED_CarNumberFiled alloc] init];
        _firstFiled.delegate = self;
        _firstFiled.tag = 1000;
        _firstFiled.inputView = nil;
    }
    return _firstFiled;
}

- (ED_CarNumberFiled *)secondFiled {
    if (!_secondFiled) {
        _secondFiled = [[ED_CarNumberFiled alloc] init];
        _secondFiled.delegate = self;
        _secondFiled.tag = 1001;
        _secondFiled.inputView = nil;
    }
    return _secondFiled;
}


- (ED_CarNumberFiled *)thirdFiled {
    if (!_thirdFiled) {
        _thirdFiled = [[ED_CarNumberFiled alloc] init];
        _thirdFiled.delegate = self;
        _thirdFiled.tag = 1002;
        _thirdFiled.inputView = nil;
    }
    return _thirdFiled;
}


- (ED_CarNumberFiled *)forthFiled {
    if (!_forthFiled) {
        _forthFiled = [[ED_CarNumberFiled alloc] init];
        _forthFiled.delegate = self;
        _forthFiled.tag = 1003;
        _forthFiled.inputView = nil;
    }
    return _forthFiled;
}


- (ED_CarNumberFiled *)fivethFiled {
    if (!_fivethFiled) {
        _fivethFiled = [[ED_CarNumberFiled alloc] init];
        _fivethFiled.delegate = self;
        _fivethFiled.tag = 1004;
        _fivethFiled.inputView = nil;
    }
    return _fivethFiled;
}



- (ED_CarNumberFiled *)sixthFiled {
    if (!_sixthFiled) {
        _sixthFiled = [[ED_CarNumberFiled alloc] init];
        _sixthFiled.delegate = self;
        _sixthFiled.tag = 1005;
        _sixthFiled.inputView = nil;
    }
    return _sixthFiled;
}


- (ED_CarNumberFiled *)seventhFiled {
    if (!_seventhFiled) {
        _seventhFiled = [[ED_CarNumberFiled alloc] init];
        _seventhFiled.delegate = self;
        _seventhFiled.tag = 1006;
        _seventhFiled.inputView = nil;
    }
    return _seventhFiled;
}

- (ED_CarNumberFiled *)eigthFiled {
    if (!_eigthFiled) {
        _eigthFiled = [[ED_CarNumberFiled alloc] init];
        _eigthFiled.delegate = self;
        _eigthFiled.tag = 1007;
        _eigthFiled.inputView = nil;
    }
    return _eigthFiled;
}


- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.textColor = [UIColor colorWithRed:28/255.0 green:196/255.0 blue:102/255.0 alpha:1];
        _tipLabel.text = @"新能源车";
    }
    return _tipLabel;
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_xz_nor"]];
    }
    return _logoImageView;
}


- (UIButton *)switchTypeBtn {
    if (!_switchTypeBtn) {
        _switchTypeBtn = [[UIButton alloc] init];
        [_switchTypeBtn addTarget:self action:@selector(didClickSwitchType) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchTypeBtn;
}




@end







@interface ED_KeyBoardInputView ()


@property (nonatomic , strong) UIButton *deleteBtn;

@property (nonatomic , strong) NSMutableArray *btnArray;

@property (nonatomic , assign) ED_KeyBoardInputType type;



@end


@implementation ED_KeyBoardInputView



- (instancetype)initWithKeyBoardType:(ED_KeyBoardInputType)type {
    if (self = [super initWithFrame:CGRectZero]) {
        self.type = type;
        [self configureViews];
    }
    return self;
}



- (void)configureViews {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (self.type == ED_KeyBoardInputCity) {
        CGFloat btnWidth = (screenWidth - 22 * 2 - 6 * 8)/9.0 ;
        CGFloat bthHeight = 42;
        for (int i = 0; i < self.cityArray.count; i ++) {
            NSString *title = [self.cityArray objectAtIndex:i];
            UIButton *btn = [self getBtnWithBtnTitle:title];
            NSInteger section = i / 9 ;
            NSInteger row = i % 9;
            btn.frame = CGRectMake(22 + (btnWidth + 6) * row  , 10 + section * (42 + 12) , btnWidth,bthHeight );
            [self addSubview:btn];
            [self.btnArray addObject:btn];
        }
        
        self.deleteBtn.frame = CGRectMake(screenWidth - btnWidth * 2 - 6 - 22, 10 + 42  * 3 + 36, btnWidth * 2 + 6,bthHeight);
        [self addSubview:self.deleteBtn];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.deleteBtn.bounds.size.width - 23)/2.0, 13, 23, 16)];
        imageView.image = [UIImage imageNamed:@"icon_back"];
        [self.deleteBtn addSubview:imageView];
        
        
        
    }else if (self.type == ED_KeyBoardInputNumber) {
        CGFloat btnWidth = (screenWidth - 6 * 10)/10.0 ;
        CGFloat bthHeight = 42;
        
        for (int i = 0 ; i < [self numberArray].count ; i ++ ) {
            NSString *title = [self.numberArray objectAtIndex:i];
            UIButton *btn = [self getBtnWithBtnTitle:title];
            NSInteger section = i / 10 ;
            NSInteger row = i % 10;
            if (section == 3) {
                btn.frame = CGRectMake(3 + (btnWidth + 6)*(row + 1), 10 + section * (42 + 12),  (i == (self.numberArray.count - 1)) ? btnWidth * 2 + 6 :  btnWidth, bthHeight);
            }else{
                btn.frame = CGRectMake(3 + (btnWidth + 6) * row  , 10 + section * (42 + 12) , btnWidth,bthHeight );
            }
            [self addSubview:btn];
            [self.btnArray addObject:btn];
        }
        
        
        self.deleteBtn.frame = CGRectMake(screenWidth - btnWidth * 3 - 6 - 3 - 6, 10 + 42  * 3 + 36, btnWidth * 2 + 6, bthHeight);
        [self addSubview:self.deleteBtn];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.deleteBtn.bounds.size.width - 23)/2.0, 13, 23, 16)];
        imageView.image = [UIImage imageNamed:@"icon_back"];
        [self.deleteBtn addSubview:imageView];
        
    }
    
    
}


#pragma mark - Public

- (void)setBtnStatusWithFlag:(BOOL)flag fromBeginIndex:(NSInteger)beginIndex toEndIndex:(NSInteger)endIndex {
    if (beginIndex >= self.btnArray.count || endIndex >= self.btnArray.count) {
        return;
    }
    
    for (NSInteger i = beginIndex ;i <= endIndex ; i ++ ) {
        UIButton *btn = [self.btnArray objectAtIndex:i];
        btn.enabled = flag;
    }
}

- (void)setLastBtnStatusWithFlag:(BOOL)flag {
    UIButton *btn = [self.btnArray lastObject];
    btn.enabled = flag;
}

- (void)setBtnStatusWithFlag:(BOOL)flag index:(NSInteger)index {
    if (index >= self.btnArray.count) {
        return;
    }
    UIButton *btn = [self.btnArray objectAtIndex:index];
    btn.enabled = flag;
}



#pragma mark - Private



- (UIButton *)getBtnWithBtnTitle:(NSString *)title {
    UIButton *btn = [[UIButton alloc] init];
    [btn addTarget:self action:@selector(didClickInputBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(didEndTouch:) forControlEvents:UIControlEventTouchUpOutside];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    // cornerRadius
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    btn.layer.borderColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1].CGColor;
    
    //normal
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self imageWithColor:[UIColor whiteColor] imageSize:CGSizeMake(10, 10)] forState:UIControlStateNormal];
   
    
    // disable
     [btn setTitleColor:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1] forState:UIControlStateDisabled];
     [btn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:241/255.0 green:242/255.0 blue:243/255.0 alpha:1] imageSize:CGSizeMake(10, 10)] forState:UIControlStateDisabled];
    
    
    // Highlighted
     [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
     [btn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:27/255.0 green:196/255.0 blue:101/255.0 alpha:1] imageSize:CGSizeMake(10, 10)] forState:UIControlStateHighlighted];
    return btn;
    
}



- (UIImage *)imageWithColor:(UIColor *)imageColor imageSize:(CGSize)imageSize {
    // 使用颜色创建UIImage
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [imageColor set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



#pragma mark - Action

- (void)didClickInputBtn:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:didInputText:)]) {
        [self.delegate keyboard:self didInputText:sender.titleLabel.text];
    }
    
}

- (void)didClickDelete {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(keyboard:didInputText:)]) {
         [self.delegate keyboard:self didInputText:@"\n"];
    }
}


- (void)didTouchBtn:(UIButton *)sender  {
    
}

- (void)didEndTouch:(UIButton *)sender {
    
}





#pragma mark - Getter


- (NSArray *)cityArray {
    return  @[@"京",@"津",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",@"沪",@"苏",
    @"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"桂",@"琼",@"渝",@"川",@"贵",@"云",
    @"藏",@"陕",@"甘",@"青",@"宁",@"新"];
}

- (NSArray *)numberArray {
    return @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"挂"];
    
}



- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] init];
        [_deleteBtn addTarget:self action:@selector(didClickDelete) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:199/255.0 green:204/255.0 blue:210/255.0 alpha:1] imageSize:CGSizeMake(10, 10)] forState:UIControlStateNormal];
        [_deleteBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0 alpha:0.35] imageSize:CGSizeMake(10, 10)] forState:UIControlStateHighlighted];
        _deleteBtn.layer.masksToBounds = YES;
        _deleteBtn.layer.cornerRadius = 5;
    }
    return _deleteBtn;
}


- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}




@end
