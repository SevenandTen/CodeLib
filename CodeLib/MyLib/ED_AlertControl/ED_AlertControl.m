//
//  ED_AlertControl.m
//  DriverCimelia
//
//  Created by zw on 2018/10/26.
//  Copyright © 2018年 zw. All rights reserved.
//

#import "ED_AlertControl.h"


@interface ED_BaseAlertViewController : UIViewController

@property (nonatomic , strong) UIView *backView;

@property (nonatomic , strong) UIView *contentView;

@property (nonatomic , copy) void(^complete)(NSInteger index , NSString *string , BOOL isSure);

@property (nonatomic , strong) UIButton *sureBtn;

@property (nonatomic , strong) UIButton *cancelBtn;

@property (nonatomic , strong) UITextField *textFiled;

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) UILabel *contentLabel;

@property (nonatomic , strong) UIImageView *tipImageView;

@property (nonatomic , strong) NSString *titleString;

@property (nonatomic , strong) NSString *contentString;

@property (nonatomic , assign) BOOL isHasImage;

@property (nonatomic , assign) BOOL imageType;

@property (nonatomic , assign) BOOL isHasCancelBtn;

@property (nonatomic , assign) UIEdgeInsets mySafeArea;


- (void)configureViews;

- (void)configureBtns;

- (void)show;

- (void)dismssWithIndex:(NSInteger)index string:(NSString *)string isSure:(BOOL)isSure;

- (void)anmation;

@end


@interface ED_InputAlertViewController : ED_BaseAlertViewController

@property (nonatomic , strong) NSString *placeHolder;

@property (nonatomic , strong) NSString *tipString;


@property (nonatomic , strong) UILabel *tipLabel;

@property (nonatomic , strong) UIView *lineView;

@property (nonatomic , assign) UIKeyboardType keyBordType;

@end


@interface ED_SureDriverAlertViewController : ED_BaseAlertViewController

@property (nonatomic , strong) UILabel *carLabel;

@property (nonatomic , strong) NSString *carNumber;

@property (nonatomic , strong) UILabel *driverLabel;

@property (nonatomic , strong) NSString*driverName;


@end


@interface ED_TransferAccountsAlertViewController : ED_BaseAlertViewController

@property (nonatomic , strong) UILabel *moneyLabel;

@property (nonatomic , strong) NSString *moneyString;

@end


@interface ED_ShareAlertViewController : ED_BaseAlertViewController


@end



@implementation ED_AlertControl


+ (void)alertInputWithTitle:(NSString *)title tip:(NSString *)tip placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyboardType complete:(void (^)(NSInteger, NSString *, BOOL))complete {
    ED_InputAlertViewController *vc = [[ED_InputAlertViewController alloc] init];
    vc.titleString = title;
    vc.tipString = tip;
    vc.keyBordType = keyboardType;
    vc.isHasCancelBtn = YES;
    [vc.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [vc.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    vc.complete = complete;
    [vc show];
}

+ (void)alertSureDriverWithTitle:(NSString *)title driverName:(NSString *)driverName carNumber:(NSString *)carNumber complete:(void (^)(NSInteger, NSString *, BOOL))complete {
    ED_SureDriverAlertViewController *vc = [[ED_SureDriverAlertViewController alloc] init];
    vc.titleString = title;
    vc.driverName = driverName;
    vc.carNumber = carNumber;
    [vc.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [vc.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    vc.isHasCancelBtn = YES;
    vc.complete = complete;
    [vc show];
    
}

+ (void)alertTransferAccountWithContent:(NSString *)content money:(NSString *)money imageType:(BOOL)imageType complete:(void (^)(NSInteger, NSString *, BOOL))complete {
    ED_TransferAccountsAlertViewController *vc = [[ED_TransferAccountsAlertViewController alloc] init];
    vc.imageType = imageType;
    [vc.sureBtn setTitle:@"知道了" forState:UIControlStateNormal];
    vc.isHasCancelBtn = NO;
    vc.moneyString = money;
    vc.contentString = content;
    vc.complete = complete;
    [vc show];
}


+ (void)alertShareWithComplete:(void (^)(NSInteger, NSString *, BOOL))complete {
    ED_ShareAlertViewController *vc = [[ED_ShareAlertViewController alloc] init];
    vc.complete = complete;
    [vc show];
}

+ (void)alertDefuatWarningWithTitle:(NSString *)title content:(NSString *)content {
    [self alertDefuatWarningWithTitle:title content:content btnTitle:nil];
}

+ (void)alertDefuatWarningWithTitle:(NSString *)title content:(NSString *)content btnTitle:(NSString *)btnTitle {
    
    [self alertDefuatWarningWithTitle:title content:content btnTitle:btnTitle complete:nil];
}

+ (void)alertDefuatWarningWithTitle:(NSString *)title content:(NSString *)content btnTitle:(NSString *)btnTitle complete:(void (^)(NSInteger, NSString *, BOOL))complete {
    [self alertWithTitle:title content:content isHaveImage:NO imageType:NO isHasCancel:NO cancelBtnTitle:nil sureBtnTitle:btnTitle complete:complete];
}

+ (void)alertDefuatImageWarningWithTitle:(NSString *)title content:(NSString *)content imageType:(BOOL)imageType {
    return [self alertDefuatImageWarningWithTitle:title content:content imageType:imageType btnTitle:nil];
}

+ (void)alertDefuatImageWarningWithTitle:(NSString *)title content:(NSString *)content imageType:(BOOL)imageType btnTitle:(NSString *)btnTitle {
    return [self alertDefuatImageWarningWithTitle:title content:content imageType:imageType btnTitle:btnTitle complete:nil];
}

+ (void)alertDefuatImageWarningWithTitle:(NSString *)title content:(NSString *)content imageType:(BOOL)imageType btnTitle:(NSString *)btnTitle complete:(void (^)(NSInteger, NSString *, BOOL))complete {
    [self alertWithTitle:title content:content isHaveImage:YES imageType:imageType isHasCancel:NO cancelBtnTitle:nil sureBtnTitle:btnTitle complete:complete];
}

+ (void)alertCommonTipsWithTitle:(NSString *)title content:(NSString *)content complete:(void (^)(NSInteger, NSString *, BOOL))complete {
    [self alertCommonTipsWithTitle:title content:content cancelTitle:nil sureTitle:nil complete:complete];
}

+ (void)alertCommonTipsWithTitle:(NSString *)title content:(NSString *)content cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle complete:(void (^)(NSInteger, NSString *, BOOL))complete {
    [self alertWithTitle:title content:content isHaveImage:NO imageType:NO isHasCancel:YES cancelBtnTitle:cancelTitle sureBtnTitle:sureTitle  complete:complete];
}

+ (void)alertCommonImageTipsWithTitle:(NSString *)title content:(NSString *)content imageType:(BOOL)imageType complete:(void (^)(NSInteger, NSString *, BOOL))complete {
    [self alertCommonImageTipsWithTitle:title content:content cancelTitle:nil sureTitle:nil imageType:imageType complete:complete];
}

+ (void)alertCommonImageTipsWithTitle:(NSString *)title content:(NSString *)content cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle imageType:(BOOL)imageType complete:(void (^)(NSInteger, NSString *, BOOL))complete {
    [self alertWithTitle:title content:content isHaveImage:YES imageType:imageType isHasCancel:YES cancelBtnTitle:cancelTitle sureBtnTitle:sureTitle complete:complete];
}

+ (void)alertWithTitle:(NSString *)title content:(NSString *)content isHaveImage:(BOOL)isHaveImage imageType:(BOOL)imageType isHasCancel:(BOOL)isHasCancel cancelBtnTitle:(NSString *)cancelBtnTitle sureBtnTitle:(NSString *)sureBtnTitle complete:(void (^)(NSInteger, NSString *, BOOL))complete {
    ED_BaseAlertViewController *vc =  [[ED_BaseAlertViewController alloc] init];
    if (cancelBtnTitle.length == 0 && isHasCancel) {
        cancelBtnTitle  = @"取消";
    }
    if (sureBtnTitle.length == 0) {
        if (isHasCancel) {
            sureBtnTitle = @"确定";
        }else{
            sureBtnTitle = @"知道了";
        }
    }
    [vc.sureBtn setTitle:sureBtnTitle forState:UIControlStateNormal];
    [vc.cancelBtn setTitle:cancelBtnTitle forState:UIControlStateNormal];
    vc.titleString = title;
    vc.contentString = content;
    vc.isHasImage = isHaveImage;
    vc.imageType = imageType;
    vc.isHasCancelBtn = isHasCancel;
    vc.complete = complete;
    [vc show];
    
}


@end



@implementation ED_BaseAlertViewController

- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self anmation];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backView];
    self.backView.frame = self.view.bounds;
    [self configureViews];
    [self configureBtns];
}

- (void)configureViews {
    [self.view addSubview:self.contentView];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 5;
    CGFloat contentWidth = self.view.bounds.size.width - 56;
    CGFloat contentHeight = self.titleString.length != 0 ? 200 : 170;
    CGFloat contentLabelY = self.titleString.length != 0 ? 75 : 49;
    CGFloat contentLabelWidth = contentWidth - 40;
    CGFloat contentLabelHeight = 24;
    CGSize size = [self calculateSizeWithAttributeText:self.contentString font:[UIFont systemFontOfSize:17] width:contentLabelWidth];
    if (size.height > 24) {
        contentLabelHeight = size.height + 5;
        contentHeight = contentHeight + size.height;
         self.contentLabel.textAlignment = NSTextAlignmentLeft;
    }
   
    
    self.contentView.frame = CGRectMake(28, (self.view.bounds.size.height - contentHeight)/2.0, contentWidth, contentHeight);
    
    if (self.titleString.length != 0) {
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.text = self.titleString;
        self.titleLabel.frame = CGRectMake(0, 23, self.contentView.bounds.size.width, 21);
    }
    
    [self.contentView addSubview:self.contentLabel];
    if (self.isHasImage) {
         [self.contentView addSubview:self.tipImageView];
        CGFloat width = (contentLabelWidth - size.width - 21)/2.0;
        self.tipImageView.frame = CGRectMake(width + 20, contentLabelY + 2, 21, 21);
        self.contentLabel.frame = CGRectMake(width + 45, contentLabelY, contentLabelWidth - 25 - width, contentLabelHeight);
        if (self.imageType) {
            self.tipImageView.image = [UIImage imageNamed:@"ico_tc_ok"];
        }else{
            self.tipImageView.image = [UIImage imageNamed:@"ico_tc_jg"];
        }
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        self.contentLabel.text = self.contentString;
        if (width <= 1) {
            self.tipImageView.frame = CGRectMake(width + 20, contentLabelY , 21, 21);
            self.contentLabel.text = [NSString stringWithFormat:@"       %@",self.contentString];
            CGSize sizex = [self calculateSizeWithAttributeText:self.contentLabel.text font:[UIFont systemFontOfSize:17] width:contentLabelWidth];
            self.contentLabel.frame = CGRectMake(20, contentLabelY, contentLabelWidth , sizex.height );
        }

    }else{
        self.contentLabel.frame = CGRectMake(20, contentLabelY, contentLabelWidth, contentLabelHeight);
        self.contentLabel.text = self.contentString;
    }
    
}

- (void)configureBtns {
    if (self.isHasCancelBtn) {
        [self.contentView addSubview:self.cancelBtn];
        CGFloat width = (self.contentView.bounds.size.width - 60) / 2.0;
        self.cancelBtn.frame = CGRectMake(20, self.contentView.bounds.size.height - 15 - 44, width, 44);
        
        [self.contentView addSubview:self.sureBtn];
        self.sureBtn.frame = CGRectMake(40 + width,self.contentView.bounds.size.height - 15 - 44,  width, 44);
        
    }else{
        [self.contentView addSubview:self.sureBtn];
        self.sureBtn.frame = CGRectMake(20, self.contentView.bounds.size.height - 15 - 44, self.contentView.bounds.size.width - 40, 44);
    }
    
}

- (void)show {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:self animated:NO completion:nil];
}

- (void)dismssWithIndex:(NSInteger)index string:(NSString *)string isSure:(BOOL)isSure {
    [self dismissViewControllerAnimated:NO completion:nil];
    if (self.complete) {
        self.complete(index, string, isSure);
    }
}

- (void)anmation {
    [self animationAlert:self.contentView];
}

- (void)animationAlert:(UIView *)view {
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.25;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
    
}

#pragma mark - Action

- (void)didClickCancel {
    [self dismssWithIndex:0 string:self.textFiled.text isSure:NO];
}

- (void)didClickSure {
    [self dismssWithIndex:0 string:self.textFiled.text isSure:YES];
}

#pragma mark - Pirvate

- (CGSize)calculateSizeWithAttributeText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    if (text.length == 0) {
        return CGSizeZero;
    }
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = width;
    label.font = font;
    label.attributedText = [[NSAttributedString alloc] initWithString:text];;
    CGSize intrinsicContentSize = [label intrinsicContentSize];
    
    return CGSizeMake(ceilf(MIN(intrinsicContentSize.width, width)) , ceilf(intrinsicContentSize.height));
}

#pragma mark - Getter

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.65;
    }
    return _backView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        _sureBtn.backgroundColor = [UIColor colorWithRed:28/255.0 green:196/255.0 blue:102/255.0 alpha:1];
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = 22;
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(didClickSure) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _sureBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        UIColor *color = [UIColor colorWithRed:28/255.0 green:196/255.0 blue:102/255.0 alpha:1];
        _cancelBtn = [[UIButton alloc] init];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.cornerRadius = 22;
        _cancelBtn.layer.borderWidth = 1;
        _cancelBtn.layer.borderColor = color.CGColor;
        [_cancelBtn setTitleColor:color forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(didClickCancel) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
    }
    return _cancelBtn;
}

- (UITextField *)textFiled {
    if (!_textFiled) {
        _textFiled = [[UITextField alloc] init];
        _textFiled.borderStyle = UITextBorderStyleNone;
        _textFiled.font = [UIFont systemFontOfSize:17];
    }
    return _textFiled;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:17];
        _contentLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _contentLabel;
}

- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc] init];
    }
    return _tipImageView;
}

- (UIEdgeInsets)mySafeArea {
    if (@available(iOS 11.0 , *)) {
        return self.view.safeAreaInsets;
    }
     return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end



@implementation ED_InputAlertViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameDidChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [self.textFiled becomeFirstResponder];
}


- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configureViews {
    [self.view addSubview:self.contentView];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 5;
    CGFloat contentWidth = self.view.bounds.size.width - 56;
    CGFloat contentHeight = 230;
    self.contentView.frame = CGRectMake(28, (self.view.bounds.size.height - contentHeight)/2.0, contentWidth, contentHeight);
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.text = self.titleString;
    self.titleLabel.frame = CGRectMake(0, 23, self.contentView.bounds.size.width, 21);
    CGFloat tipWidth = 0;
    if (self.tipString.length > 0) {
        NSString *tip = [NSString stringWithFormat:@"(%@)",self.tipString];
        tipWidth = [self calculateSizeWithAttributeText:tip font:[UIFont systemFontOfSize:14] width:100].width;
        [self.contentView addSubview:self.tipLabel];
        self.tipLabel.text = tip;
        self.tipLabel.frame = CGRectMake(contentWidth - 30 - tipWidth, 90, tipWidth, 20);
    }
    CGFloat textFiledWidth = contentWidth - 60 - tipWidth;
    [self.contentView addSubview:self.textFiled];
    self.textFiled.frame = CGRectMake(30, 80, textFiledWidth, 30);
    self.textFiled.keyboardType = self.keyBordType;
    self.textFiled.placeholder = self.placeHolder;
    [self.contentView addSubview:self.lineView];
    self.lineView.frame = CGRectMake(30, 113, contentWidth - 60, 0.5);

}

- (void)anmation {
    
}


#pragma mark - Action

- (void)keyBoardFrameDidChange:(NSNotification *)noti {
    NSValue *value = [noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [value CGRectValue];
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if (keyboardFrame.origin.y < screenHeight) {
        CGFloat contentMaxY = CGRectGetMaxY(self.contentView.frame);
        if (contentMaxY < keyboardFrame.origin.y) {
            
        }else {
            self.contentView.frame = CGRectMake(28, self.contentView.frame.origin.y - (contentMaxY - keyboardFrame.origin.y), self.contentView.frame.size.width, self.contentView.frame.size.height);
        }
        //键盘出现
    }else {
        // 键盘消失
        self.contentView.frame = CGRectMake(28,(self.view.bounds.size.height - self.contentView.frame.size.height)/2.0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    }
}


#pragma mark - Getter

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textAlignment = NSTextAlignmentRight;
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
    }
    return _tipLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _lineView;
}

@end



@implementation ED_SureDriverAlertViewController


- (void)configureViews {
    [self.view addSubview:self.contentView];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 5;
    CGFloat contentWidth = self.view.bounds.size.width - 56;
    CGFloat contentHeight = 200;
    self.contentView.frame = CGRectMake(28, (self.view.bounds.size.height - contentHeight)/2.0, contentWidth, contentHeight);
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.text = self.titleString;
    self.titleLabel.frame = CGRectMake(0, 23, self.contentView.bounds.size.width, 21);
    [self.contentView addSubview:self.driverLabel];
    self.driverLabel.text = self.driverName;
    self.driverLabel.frame = CGRectMake(0, 78, contentWidth/2.0 - 2.5, 24);
    
    CGFloat carLabelWidth = [self calculateSizeWithAttributeText:self.carNumber font:[UIFont systemFontOfSize:12] width:MAXFLOAT].width + 5;
    [self.contentView addSubview:self.carLabel];
    self.carLabel.text = self.carNumber;
    self.carLabel.frame = CGRectMake(contentWidth/2.0 + 2.5, 81, carLabelWidth, 18);
    
}


#pragma mark - Getter

- (UILabel *)driverLabel {
    if (!_driverLabel) {
        _driverLabel = [[UILabel alloc] init];
        _driverLabel.font = [UIFont systemFontOfSize:17];
        _driverLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        _driverLabel.textAlignment = NSTextAlignmentRight;
    }
    return _driverLabel;
}


- (UILabel *)carLabel {
    if (!_carLabel) {
        _carLabel = [[UILabel alloc] init];
        _carLabel.textColor = [UIColor whiteColor];
        _carLabel.backgroundColor = [UIColor colorWithRed:51/255.0 green:153/255.0 blue:1 alpha:1];
        _carLabel.textAlignment = NSTextAlignmentCenter;
        _carLabel.font = [UIFont systemFontOfSize:12];
        _carLabel.layer.masksToBounds = YES;
        _carLabel.layer.cornerRadius = 3;
    }
    return _carLabel;
}



@end


@implementation ED_TransferAccountsAlertViewController

- (void)configureViews {
    [self.view addSubview:self.contentView];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 5;
    CGFloat contentWidth = self.view.bounds.size.width - 56;
    CGFloat contentHeight = 200;
    CGFloat contentLabelWidth = contentWidth - 40;
    CGFloat contentLabelHeight = 24;
    CGFloat contentLabelY = 43;
    CGSize size = [self calculateSizeWithAttributeText:self.contentString font:[UIFont systemFontOfSize:17] width:contentLabelWidth];
    if (size.height > 24) {
        contentLabelHeight = size.height + 5;
        contentHeight = contentHeight + size.height;
    }
    
    self.contentView.frame = CGRectMake(28, (self.view.bounds.size.height - contentHeight)/2.0, contentWidth, contentHeight);
    
    [self.contentView addSubview:self.tipImageView];
    CGFloat width = (contentLabelWidth - size.width)/2.0;
    self.tipImageView.frame = CGRectMake(width + 20, contentLabelY + 2, 21, 21);
    [self.contentView addSubview:self.contentLabel];
    
    self.contentLabel.frame = CGRectMake(width + 45, contentLabelY, contentLabelWidth - 25 - width, contentLabelHeight);
    if (self.imageType) {
        self.tipImageView.image = [UIImage imageNamed:@"ico_tc_ok"];
    }else{
        self.tipImageView.image = [UIImage imageNamed:@"ico_tc_jg"];
    }
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.text = self.contentString;
    if (width <= 1) {
        self.contentLabel.frame = CGRectMake(20, contentLabelY, contentLabelWidth , contentLabelHeight );
        self.contentLabel.text = [NSString stringWithFormat:@"       %@",self.contentString];
    }
    
    if (self.moneyString.length > 0) {
        [self.contentView addSubview:self.moneyLabel];
        self.moneyLabel.frame = CGRectMake(0, CGRectGetMaxY(self.contentLabel.frame) + 26, contentWidth, 24);
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"金额：" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1]}];
        [string appendAttributedString:[[NSAttributedString alloc] initWithString:self.moneyString]];
        self.moneyLabel.attributedText = string;
    }
    
}


#pragma mark - Getter

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.font = [UIFont systemFontOfSize:17];
        _moneyLabel.textColor = [UIColor colorWithRed:1 green:153/255.0 blue:0 alpha:1];
    }
    return _moneyLabel;
}

@end



@implementation ED_ShareAlertViewController

- (void)configureViews {
    UIView *backView = [[UIView alloc] init];
    backView.frame = self.view.bounds;
    backView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBlank)];
    [backView addGestureRecognizer:tap];
    [self.view addSubview:backView];
    
    [self.view addSubview:self.contentView];
    self.contentView.frame  = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 200 + self.mySafeArea.bottom);
    UILabel *tipLabel  = [[UILabel alloc] init];
    tipLabel.text = @"分享到";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
    [self.contentView addSubview:tipLabel];
    tipLabel.frame = CGRectMake(self.view.bounds.size.width/2.0 - 25, 26, 50, 21);
    
    UIView *leftLineView = [[UIView alloc] initWithFrame:CGRectMake(17, 37, self.view.bounds.size.width/2.0 - 25 - 34, 1)];
    leftLineView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    [self.contentView addSubview:leftLineView];
    
    UIView *rightLineView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2.0 + 25 + 17, 37,  self.view.bounds.size.width/2.0 - 25 - 34, 1)];
    rightLineView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    [self.contentView addSubview:rightLineView];
    
    CGFloat btnOriginY = CGRectGetMaxY(tipLabel.frame) + 45;
    NSArray *array = @[@"微信好友",@"朋友圈",@"QQ"];
    NSArray *imageArray = @[@"ico_share_weixin",@"ico_share_pyq",@"ico_share_qq"];
    for (int i = 0; i < array.count; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = 1001 + i;
        [btn addTarget:self action:@selector(didClickShareBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        if (i == 0) {
            btn.frame = CGRectMake(45, btnOriginY, 40, 40);
        }
        if (i == 1) {
            btn.frame = CGRectMake(self.view.bounds.size.width/2.0 - 20, btnOriginY, 40, 40);
        }
        if (i == 2) {
            btn.frame = CGRectMake(self.view.bounds.size.width - 85, btnOriginY, 40, 40);
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, btnOriginY + 40 + 10, 70, 21)];
        label.text = array[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [self.contentView addSubview:label];
        label.center = CGPointMake(btn.center.x, label.center.y);
    
    }
    
    
    
}


- (void)configureBtns {
    
}

- (void)anmation {
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.frame = CGRectMake(0, self.view.bounds.size.height - self.contentView.frame.size.height, self.contentView.frame.size.width, self.contentView.frame.size.height);
    }];
}

#pragma mark - Action


- (void)didClickBlank {
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.frame = CGRectMake(0, self.view.bounds.size.height , self.contentView.frame.size.width, self.contentView.frame.size.height);
    } completion:^(BOOL finished) {
         [self dismssWithIndex:0 string:nil isSure:NO];
    }];
}


- (void)didClickShareBtn:(UIButton *)btn {
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.frame = CGRectMake(0, self.view.bounds.size.height , self.contentView.frame.size.width, self.contentView.frame.size.height);
    } completion:^(BOOL finished) {
        [self dismssWithIndex:btn.tag - 1000 string:nil isSure:YES];
    }];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    self.contentView.frame = CGRectMake(self.contentView.frame.origin.x,self.view.bounds.size.height  - 200 -self.mySafeArea.bottom ,self.contentView.frame.size.width, 200 + self.mySafeArea.bottom);
}



@end
