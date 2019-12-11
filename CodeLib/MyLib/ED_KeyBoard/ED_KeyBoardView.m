//
//  ED_KeyBoardView.m
//  CodeLib
//
//  Created by zw on 2019/11/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_KeyBoardView.h"


@interface ED_KeyBoardView ()

@property (nonatomic , assign) ED_KeyBoardType type;

@property (nonatomic , strong) UIButton *deleteBtn;

@property (nonatomic , strong) NSMutableArray *btnArray;

@end

@implementation ED_KeyBoardView

- (instancetype)initWithKeyBoardType:(ED_KeyBoardType)type {
    if (self = [super initWithFrame:CGRectZero]) {
        self.type = type;
        self.backgroundColor = [UIColor colorWithRed:210/255.0 green:213/255.0 blue:219/255.0 alpha:0.9];
        [self configureViews];
    }
    return self;
}




- (void)configureViews {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (@available(iOS 11.0 , *)) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 224.5 + [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom);
    }else{
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 224.5);
    }
    
    if (self.type == ED_KeyBoardCity) {
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
        
        
        
    }else if (self.type == ED_KeyBoardArea) {
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
        
        
        self.deleteBtn.frame = CGRectMake(screenWidth - btnWidth * 3 - 9, 10 + 42  * 3 + 36, btnWidth * 2 + 6, bthHeight);
        [self addSubview:self.deleteBtn];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.deleteBtn.bounds.size.width - 23)/2.0, 13, 23, 16)];
        imageView.image = [UIImage imageNamed:@"icon_back"];
        [self.deleteBtn addSubview:imageView];
        
        
        
    }else if (self.type == ED_KeyBoardNumber) {
        
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


#pragma mark - Private



- (UIButton *)getBtnWithBtnTitle:(NSString *)title {
    UIButton *btn = [[UIButton alloc] init];
    [btn addTarget:self action:@selector(didClickInputBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn setBackgroundImage:[self imageWithColor:[UIColor whiteColor] imageSize:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:227/255.0 green:231/255.0 blue:237/255.0 alpha:1] imageSize:CGSizeMake(10, 10)] forState:UIControlStateDisabled];
     [btn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:227/255.0 green:231/255.0 blue:237/255.0 alpha:1] imageSize:CGSizeMake(10, 10)] forState:UIControlStateHighlighted];
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


#pragma mark - Getter

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] init];
        [_deleteBtn addTarget:self action:@selector(didClickDelete) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:171/255.0 green:179/255.0 blue:189/255.0 alpha:0.5] imageSize:CGSizeMake(10, 10)] forState:UIControlStateNormal];
        [_deleteBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0 alpha:0.35] imageSize:CGSizeMake(10, 10)] forState:UIControlStateHighlighted];
        _deleteBtn.layer.masksToBounds = YES;
        _deleteBtn.layer.cornerRadius = 5;
    }
    return _deleteBtn;
}



- (NSArray *)cityArray {
    return  @[@"京",@"津",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",@"沪",@"苏",
    @"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"桂",@"琼",@"渝",@"川",@"贵",@"云",
    @"藏",@"陕",@"甘",@"青",@"宁",@"新"];
}

- (NSArray *)numberArray {
    return @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"挂"];
    
}


- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}




@end
