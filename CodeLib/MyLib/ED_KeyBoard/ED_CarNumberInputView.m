//
//  ED_CarNumberInputView.m
//  CodeLib
//
//  Created by zw on 2019/12/6.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_CarNumberInputView.h"
#import "ED_CarNumberFiled.h"
#import "ED_KeyBoardView.h"

@interface ED_CarNumberInputView ()<UITextFieldDelegate,ED_KeyBoardViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic , strong) UIButton *sureBtn;

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

@property (nonatomic , strong) ED_KeyBoardView *cityInputView;

@property (nonatomic , strong) ED_KeyBoardView *otherInputView;

@end

@implementation ED_CarNumberInputView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}


- (void)configureViews {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBlank)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    [self addSubview:self.sureBtn];
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
    [self updateBtnStatus];
}



- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateFiledsFrame];
    
    self.tipLabel.frame = CGRectMake(self.bounds.size.width - 85, 86.5, 85, 21);
    self.logoImageView.frame = CGRectMake(self.bounds.size.width - 110, 88, 18, 18);
    self.switchTypeBtn.frame = CGRectMake(self.bounds.size.width - 110, 86.5, 110, 21);
    self.sureBtn.frame = CGRectMake(12, 147.5, self.bounds.size.width - 24, 50);
}

#pragma mark - Action

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
                [self.otherInputView setLastBtnStatusWithFlag:NO];
            }
        }
    }else {
        if (self.eigthFiled.text.length > 0) {
            self.eigthFiled.text = @"";
            [self.seventhFiled becomeFirstResponder];
        }
        if ([self.seventhFiled isFirstResponder]) {
            [self.otherInputView setLastBtnStatusWithFlag:YES];
        }
    }
    
    [self updateBtnStatus];
}

- (void)didClickSure {
    if (self.delegate && [self.delegate respondsToSelector:@selector(carNumberView:didClickSureWithCarNumber:)]) {
        NSString *carNumber = nil;
        if (self.switchTypeBtn.selected) {
            carNumber = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",self.firstFiled.text,self.secondFiled.text,self.thirdFiled.text,self.forthFiled.text,self.fivethFiled.text,self.sixthFiled.text,self.seventhFiled.text,self.eigthFiled.text];
        }else {
            carNumber = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",self.firstFiled.text,self.secondFiled.text,self.thirdFiled.text,self.forthFiled.text,self.fivethFiled.text,self.sixthFiled.text,self.seventhFiled.text];
        }
        
        
        [self.delegate carNumberView:self didClickSureWithCarNumber:carNumber];
    }
}



- (void)didClickBlank {
    [self endEditing:YES];
}



#pragma mark - Private




- (void)updateBtnStatus {
    BOOL flag;
    if (self.switchTypeBtn.selected) {
         flag = (self.firstFiled.text.length == 1) &&(self.secondFiled.text.length == 1)&&(self.thirdFiled.text.length == 1)&&(self.forthFiled.text.length == 1)&&(self.fivethFiled.text.length == 1)&&(self.sixthFiled.text.length == 1)&&(self.seventhFiled.text.length == 1)&&(self.eigthFiled.text.length == 1);
    }else{
        flag = (self.firstFiled.text.length == 1) &&(self.secondFiled.text.length == 1)&&(self.thirdFiled.text.length == 1)&&(self.forthFiled.text.length == 1)&&(self.fivethFiled.text.length == 1)&&(self.sixthFiled.text.length == 1)&&(self.seventhFiled.text.length == 1);
    }
    _sureBtn.enabled = flag;
    _sureBtn.backgroundColor = flag ? [UIColor colorWithRed:28/255.0 green:196/255.0 blue:102/255.0 alpha:1] : [UIColor colorWithRed:165/255.0 green:232/255.0 blue:194/255.0 alpha:1];
}

- (void)updateFiledsFrame {
    if (self.switchTypeBtn.selected) {
        self.eigthFiled.hidden = NO;
        self.firstFiled.frame = CGRectMake(28.5, 30, 30, 40);
        self.secondFiled.frame = CGRectMake(CGRectGetMaxX(self.firstFiled.frame) + 8, 30, 30, 40);
        CGFloat width = self.bounds.size.width;
        self.eigthFiled.frame = CGRectMake(width - 28.5 - 30, 30, 30, 40);
         self.seventhFiled.frame = CGRectMake(CGRectGetMinX(self.eigthFiled.frame) - 8 - 30, 30, 30, 40);
         self.sixthFiled.frame = CGRectMake(CGRectGetMinX(self.seventhFiled.frame) - 8 - 30, 30, 30, 40);
        self.fivethFiled.frame = CGRectMake(CGRectGetMinX(self.sixthFiled.frame) - 8 - 30, 30, 30, 40);
         self.forthFiled.frame = CGRectMake(CGRectGetMinX(self.fivethFiled.frame) - 8 - 30, 30, 30, 40);
         self.thirdFiled.frame = CGRectMake(CGRectGetMinX(self.forthFiled.frame) - 8 - 30, 30, 30, 40);
    }else{
        self.eigthFiled.hidden = YES;
        self.firstFiled.frame = CGRectMake(47.5, 30, 30, 40);
        self.secondFiled.frame = CGRectMake(CGRectGetMaxX(self.firstFiled.frame) + 8, 30, 30, 40);
         CGFloat width = self.bounds.size.width;
        self.seventhFiled.frame = CGRectMake(width - 47.5 - 30, 30, 30, 40);
        self.sixthFiled.frame = CGRectMake(CGRectGetMinX(self.seventhFiled.frame) - 8 - 30, 30, 30, 40);
        self.fivethFiled.frame = CGRectMake(CGRectGetMinX(self.sixthFiled.frame) - 8 - 30, 30, 30, 40);
        self.forthFiled.frame = CGRectMake(CGRectGetMinX(self.fivethFiled.frame) - 8 - 30, 30, 30, 40);
        self.thirdFiled.frame = CGRectMake(CGRectGetMinX(self.forthFiled.frame) - 8 - 30, 30, 30, 40);
        
    }
}

#pragma mark - ED_KeyBoardViewDelegate

- (void)keyboard:(ED_KeyBoardView *)keyBoardView didInputText:(NSString *)text {
    if ([keyBoardView isEqual:self.cityInputView]) {
        if ([text isEqualToString:@"\n"]) {
            self.firstFiled.text = @"";
        }else{
            self.firstFiled.text = text;
            [self.secondFiled becomeFirstResponder];
        }
    }else {
        if ([text isEqualToString:@"\n"]) {
            UITextField *currentTextFiled;
            if (self.switchTypeBtn.selected && self.eigthFiled.text.length > 0) {
                currentTextFiled = self.eigthFiled;
            }else if (self.seventhFiled.text.length > 0) {
                currentTextFiled = self.seventhFiled;
            }else if (self.sixthFiled.text.length > 0) {
                currentTextFiled = self.sixthFiled;
            }else if (self.fivethFiled.text.length > 0) {
                currentTextFiled = self.fivethFiled;
            }else if (self.forthFiled.text.length > 0) {
                currentTextFiled = self.forthFiled;
            }else if (self.thirdFiled.text.length > 0) {
                currentTextFiled = self.thirdFiled;
            }else if (self.secondFiled.text.length > 0) {
                currentTextFiled = self.secondFiled;
            }else if (self.firstFiled.text.length > 0) {
                currentTextFiled = self.firstFiled;
            }else {
                
            }
            currentTextFiled.text = @"";
            [currentTextFiled becomeFirstResponder];
            
            
        }else {
            UITextField *currentTextFiled;
            UITextField *nextTextFiled;
            if (self.secondFiled.text.length == 0) {
                currentTextFiled = self.secondFiled;
                nextTextFiled = self.thirdFiled;
            }else if (self.thirdFiled.text.length == 0) {
                currentTextFiled = self.thirdFiled;
                nextTextFiled = self.forthFiled;
            }else if (self.forthFiled.text.length == 0) {
                currentTextFiled = self.forthFiled;
                nextTextFiled = self.fivethFiled;
            }else if (self.fivethFiled.text.length == 0) {
                currentTextFiled = self.fivethFiled;
                nextTextFiled = self.sixthFiled;
            }else if (self.sixthFiled.text.length == 0) {
                currentTextFiled = self.sixthFiled;
                nextTextFiled = self.seventhFiled;
            }else if (self.seventhFiled.text.length == 0) {
                currentTextFiled = self.seventhFiled;
                if (self.switchTypeBtn.selected) {
                    nextTextFiled = self.eigthFiled;
                }
                
            }else if (self.switchTypeBtn.selected && self.eigthFiled.text.length == 0) {
                currentTextFiled = self.eigthFiled;
                
            }else {
                
            }
            currentTextFiled.text = text;
            [nextTextFiled becomeFirstResponder];
            
        }
    }
    [self updateBtnStatus];
}



#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField  {
    UITextField *currentTextFiled;
    if (self.firstFiled.text.length == 0) {
        currentTextFiled = self.firstFiled;
    }else if (self.secondFiled.text.length == 0) {
        currentTextFiled = self.secondFiled;
    }else if (self.thirdFiled.text.length == 0) {
        currentTextFiled = self.thirdFiled;
    }
    else if (self.forthFiled.text.length == 0) {
        currentTextFiled = self.forthFiled;
    }
    else if (self.fivethFiled.text.length == 0) {
        currentTextFiled = self.fivethFiled;
    }else if (self.sixthFiled.text.length == 0) {
        currentTextFiled = self.sixthFiled;
    }else if (self.seventhFiled.text.length == 0) {
        currentTextFiled = self.seventhFiled;
    }else if (self.switchTypeBtn.selected && self.eigthFiled.text.length == 0) {
        currentTextFiled = self.eigthFiled;
    }else{
        if (self.switchTypeBtn.selected) {
            currentTextFiled = self.eigthFiled;
        }else{
            currentTextFiled = self.seventhFiled;
        }
    }
    
    if (textField.tag == currentTextFiled.tag) {
        if ([currentTextFiled isEqual:self.secondFiled]) {
            [self.otherInputView setBtnStatusWithFlag:NO fromBeginIndex:0 toEndIndex:9];
            [self.otherInputView setLastBtnStatusWithFlag:NO];
        }else if ([currentTextFiled isEqual:self.eigthFiled] && self.switchTypeBtn.selected) {
             [self.otherInputView setBtnStatusWithFlag:YES fromBeginIndex:0 toEndIndex:9];
            [self.otherInputView setLastBtnStatusWithFlag:YES];
        }else if ([currentTextFiled isEqual:self.seventhFiled] && self.switchTypeBtn.selected == NO ) {
             [self.otherInputView setBtnStatusWithFlag:YES fromBeginIndex:0 toEndIndex:9];
             [self.otherInputView setLastBtnStatusWithFlag:YES];
        }else{
            [self.otherInputView setBtnStatusWithFlag:YES fromBeginIndex:0 toEndIndex:9];
             [self.otherInputView setLastBtnStatusWithFlag:NO];
        }
        
       
        
        return YES;
    }
     [textField resignFirstResponder];
    [currentTextFiled becomeFirstResponder];
     if ([currentTextFiled isEqual:self.secondFiled]) {
              [self.otherInputView setBtnStatusWithFlag:NO fromBeginIndex:0 toEndIndex:9];
              [self.otherInputView setLastBtnStatusWithFlag:NO];
          }else if ([currentTextFiled isEqual:self.eigthFiled] && self.switchTypeBtn.selected) {
               [self.otherInputView setBtnStatusWithFlag:YES fromBeginIndex:0 toEndIndex:9];
              [self.otherInputView setLastBtnStatusWithFlag:YES];
          }else if ([currentTextFiled isEqual:self.seventhFiled] && self.switchTypeBtn.selected == NO ) {
               [self.otherInputView setBtnStatusWithFlag:YES fromBeginIndex:0 toEndIndex:9];
               [self.otherInputView setLastBtnStatusWithFlag:YES];
          }else{
              [self.otherInputView setBtnStatusWithFlag:YES fromBeginIndex:0 toEndIndex:9];
               [self.otherInputView setLastBtnStatusWithFlag:NO];
          }
   
    return NO;
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.firstFiled isFirstResponder] || [self.secondFiled isFirstResponder] || [self.thirdFiled isFirstResponder]|| [self.forthFiled isFirstResponder]|| [self.fivethFiled isFirstResponder]|| [self.sixthFiled isFirstResponder]|| [self.seventhFiled isFirstResponder]|| [self.eigthFiled isFirstResponder]) {
        return YES;
    }
    return NO;
}




#pragma mark - Getter

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


- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn addTarget:self action:@selector(didClickSure) forControlEvents:UIControlEventTouchUpInside];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.layer.cornerRadius = 25;
        _sureBtn.layer.masksToBounds = YES;
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _sureBtn;
}

- (ED_CarNumberFiled *)firstFiled {
    if (!_firstFiled) {
        _firstFiled = [[ED_CarNumberFiled alloc] init];
        _firstFiled.delegate = self;
        _firstFiled.tag = 1000;
        _firstFiled.inputView = self.cityInputView;
    }
    return _firstFiled;
}

- (ED_CarNumberFiled *)secondFiled {
    if (!_secondFiled) {
        _secondFiled = [[ED_CarNumberFiled alloc] init];
        _secondFiled.delegate = self;
        _secondFiled.tag = 1001;
        _secondFiled.inputView = self.otherInputView;
    }
    return _secondFiled;
}


- (ED_CarNumberFiled *)thirdFiled {
    if (!_thirdFiled) {
        _thirdFiled = [[ED_CarNumberFiled alloc] init];
        _thirdFiled.delegate = self;
        _thirdFiled.tag = 1002;
        _thirdFiled.inputView = self.otherInputView;
    }
    return _thirdFiled;
}


- (ED_CarNumberFiled *)forthFiled {
    if (!_forthFiled) {
        _forthFiled = [[ED_CarNumberFiled alloc] init];
        _forthFiled.delegate = self;
        _forthFiled.tag = 1003;
        _forthFiled.inputView = self.otherInputView;
    }
    return _forthFiled;
}


- (ED_CarNumberFiled *)fivethFiled {
    if (!_fivethFiled) {
        _fivethFiled = [[ED_CarNumberFiled alloc] init];
        _fivethFiled.delegate = self;
        _fivethFiled.tag = 1004;
        _fivethFiled.inputView = self.otherInputView;
    }
    return _fivethFiled;
}



- (ED_CarNumberFiled *)sixthFiled {
    if (!_sixthFiled) {
        _sixthFiled = [[ED_CarNumberFiled alloc] init];
        _sixthFiled.delegate = self;
        _sixthFiled.tag = 1005;
        _sixthFiled.inputView = self.otherInputView;
    }
    return _sixthFiled;
}


- (ED_CarNumberFiled *)seventhFiled {
    if (!_seventhFiled) {
        _seventhFiled = [[ED_CarNumberFiled alloc] init];
        _seventhFiled.delegate = self;
        _seventhFiled.tag = 1006;
        _seventhFiled.inputView = self.otherInputView;
    }
    return _seventhFiled;
}

- (ED_CarNumberFiled *)eigthFiled {
    if (!_eigthFiled) {
        _eigthFiled = [[ED_CarNumberFiled alloc] init];
        _eigthFiled.delegate = self;
        _eigthFiled.tag = 1007;
        _eigthFiled.inputView = self.otherInputView;
    }
    return _eigthFiled;
}


- (ED_KeyBoardView *)cityInputView {
    if (!_cityInputView) {
        _cityInputView = [[ED_KeyBoardView alloc] initWithKeyBoardType:ED_KeyBoardCity];
        _cityInputView.delegate = self;
    }
    return _cityInputView;
}


- (ED_KeyBoardView *)otherInputView {
    if (!_otherInputView) {
        _otherInputView = [[ED_KeyBoardView alloc] initWithKeyBoardType:ED_KeyBoardArea];
        _otherInputView.delegate = self;
    }
    return _otherInputView;
}





@end
