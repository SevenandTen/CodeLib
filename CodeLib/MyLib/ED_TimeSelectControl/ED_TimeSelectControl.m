//
//  ED_TimeSelectControl.m
//  CodeLib
//
//  Created by zw on 2018/11/6.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_TimeSelectControl.h"
#import <UIKit/UIKit.h>

@interface ED_TimeSelectViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic , strong) UIPickerView *pickView;

@property (nonatomic , strong) UILabel *timeLabel;

@property (nonatomic , assign) BOOL hasDay;

@property (nonatomic , strong) UIButton *switchModeBtn;

@property (nonatomic , readonly) UIEdgeInsets mySafeArea;

@property (nonatomic , strong) UIView *backView;

@property (nonatomic , strong) UIView *topContentView;

@property (nonatomic , strong) UIView *contentView;

@property (nonatomic , strong) UILabel *modeLabel;



@property (nonatomic , assign) NSInteger maxYear;

@property (nonatomic , strong) NSDate *selectDate;

@property (nonatomic , copy) void(^complete)(BOOL hasDay , NSDate *date);




@end




@implementation ED_TimeSelectControl



+ (void)showTimeSelectWithDate:(NSDate *)selectDate hasDay:(BOOL)isHasDay  complete:(void (^)(BOOL, NSDate *))complete {
    ED_TimeSelectViewController *vc = [[ED_TimeSelectViewController alloc] init];
    vc.hasDay  = isHasDay;
    vc.complete = complete;
    vc.selectDate = selectDate;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

@end



@implementation ED_TimeSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.selectDate) {
        self.selectDate = [NSDate date];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy";
    NSInteger year = [[formatter stringFromDate:self.selectDate] integerValue];
    formatter.dateFormat = @"MM";
    NSInteger month = [[formatter stringFromDate:self.selectDate] integerValue];
    formatter.dateFormat = @"dd";
    NSInteger day = [[formatter stringFromDate:self.selectDate] integerValue];
    
    [self.pickView selectRow: ( 9 - (self.maxYear - year) ) inComponent:0 animated:NO];
 
    [self.pickView selectRow:(month - 1) inComponent:1 animated:NO];
    
    if (self.hasDay) {
        [self.pickView reloadComponent:2];
        [self.pickView selectRow:(day - 1) inComponent:2 animated:NO];
    }
    [self updateTimeLabel];
}

- (void)configureViews {
    [self.view addSubview:self.backView];
    self.backView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.mySafeArea.top + 44);
    
    [self.view addSubview:self.topContentView];
    self.topContentView.frame = CGRectMake(0, self.mySafeArea.top, self.view.bounds.size.width, 44);

    [self.view addSubview:self.contentView];
    self.contentView.frame = CGRectMake(0, self.mySafeArea.top + 44, self.view.bounds.size.width, self.view.bounds.size.height - 44 - self.mySafeArea.top);
    [self configureSubViews];
}

- (void)configureSubViews {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:self.topContentView.bounds];
    titleLabel.text = @"选择日期";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.topContentView addSubview:titleLabel];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.topContentView addSubview:cancelBtn];
    cancelBtn.frame = CGRectMake(0, 0, 50, 44);
    cancelBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
    
    UIButton *sureBtn = [[UIButton alloc] init];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.topContentView addSubview:sureBtn];
    sureBtn.frame = CGRectMake(self.topContentView.bounds.size.width - 50, 0, 50, 44);
    sureBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    
    [self.contentView addSubview:self.switchModeBtn];
    self.switchModeBtn.frame = CGRectMake((self.contentView.bounds.size.width - 130)/2.0, 28, 130, 40);
    self.switchModeBtn.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_change"]];
    [self.switchModeBtn addSubview:imageView];
    imageView.frame = CGRectMake(self.switchModeBtn.bounds.size.width - 36, 12, 16, 16);
    
    [self.switchModeBtn addSubview:self.modeLabel];
    self.modeLabel.frame = CGRectMake(25, 0, self.switchModeBtn.bounds.size.width - 25 - 36, 40);
    
    [self.contentView addSubview:self.timeLabel];
    self.timeLabel.frame = CGRectMake(0, CGRectGetMaxY(self.switchModeBtn.frame) + 30, self.contentView.bounds.size.width, 24);
    self.timeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [self commonColor];
    [self.contentView addSubview:lineView];
    lineView.frame = CGRectMake(16, CGRectGetMaxY(self.timeLabel.frame), self.contentView.bounds.size.width - 32, 1);
    lineView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    
    [self.contentView addSubview:self.pickView];
    self.pickView.frame = CGRectMake(0, CGRectGetMaxY(lineView.frame) + 5, self.contentView.bounds.size.width, 200);
    
    self.modeLabel.text = self.hasDay ? @"按日选择" : @"按月选择";
}


    


- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    self.backView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.mySafeArea.top + 44);
    self.topContentView.frame = CGRectMake(0, self.mySafeArea.top, self.view.bounds.size.width, 44);
    self.contentView.frame = CGRectMake(0, self.mySafeArea.top + 44, self.view.bounds.size.width, self.view.bounds.size.height - 44 - self.mySafeArea.top);
    self.backView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    self.topContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.backView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.mySafeArea.top + 44);
    self.topContentView.frame = CGRectMake(0, self.mySafeArea.top, self.view.bounds.size.width, 44);
    self.contentView.frame = CGRectMake(0, self.mySafeArea.top + 44, self.view.bounds.size.width, self.view.bounds.size.height - 44 - self.mySafeArea.top);
    self.backView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    self.topContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    
}

#pragma mark - Private

- (void)updateTimeLabel {
    NSInteger year = [self.pickView selectedRowInComponent:0];
    NSInteger month = [self.pickView selectedRowInComponent:1];
    NSInteger day = 0;
    NSString *dateString = nil;
    month = month + 1;
    year = self.maxYear - 9 + year;
    if (self.hasDay) {
        day = [self.pickView selectedRowInComponent:2];
        day = day + 1;
        dateString = [NSString stringWithFormat:@"%ld-%02ld-%02ld",year,month,day];
    }else{
        dateString = [NSString stringWithFormat:@"%ld-%02ld",year,month];
    }
    self.timeLabel.text = dateString;
}



#pragma mark - Action

- (void)switchMode {
    self.hasDay = ! self.hasDay;
    self.modeLabel.text = self.hasDay ? @"按日选择" : @"按月选择";
    [self.pickView reloadAllComponents];
    [self updateTimeLabel];
    
}

- (void)cancelClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sureClick {
   
    NSInteger year = [self.pickView selectedRowInComponent:0];
    NSInteger month = [self.pickView selectedRowInComponent:1];
    NSInteger day = 0;
    BOOL flag = YES;
    NSString *dateString = nil;
    if (month == -1 || year == - 1) {
        flag = NO;
    }
    if (self.hasDay) {
         day = [self.pickView selectedRowInComponent:2];
        if (day == - 1) {
            flag = NO;
        }
    }
    if (flag) {
        month = month + 1;
        year = self.maxYear - 9 + year;
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"时间还在选择中" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:year completion:nil];
        return;
    }
    
   
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (self.hasDay) {
        day = day + 1;
        dateString = [NSString stringWithFormat:@"%ld%02ld%02ld",year,month,day];
        formatter.dateFormat = @"yyyyMMdd";
    }else{
        dateString = [NSString stringWithFormat:@"%ld%02ld",year,month];
        formatter.dateFormat = @"yyyyMM";
    }
    
    [self dismissViewControllerAnimated:year completion:nil];
    NSDate *date  = [formatter dateFromString:dateString];
    if (self.complete) {
        self.complete(self.hasDay, date);
    }

    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.hasDay) {
        return 3;
    }
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0 ) {
        return 10;
    }
    if (component == 1) {
        return 12;
    }
    NSInteger year = [self.pickView selectedRowInComponent:0] + self.maxYear - 9;
    NSInteger month = [self.pickView selectedRowInComponent:1] + 1;
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
        return 31;
    }
    if (month == 4 || month == 6 || month == 11 || month == 9) {
        return 30;
    }
    if (month == 2) {
        if ((year % 4 == 0&&year % 100!= 0) || year % 400 == 0) {
            return 29;
        }
        return 28;
    }
    return 31;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *string = nil;
    if (component == 0) {
        string = [NSString stringWithFormat:@"%ld年", self.maxYear - 9 + row];
    }
    if (component == 1) {
        string = [NSString stringWithFormat:@"%ld月", row + 1];
    }
    if (component == 2) {
        string = [NSString stringWithFormat:@"%ld日", row + 1];
    }
    
    return [[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] ,NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ((component == 0 ||component == 1) && self.hasDay ) {
        [self.pickView reloadComponent:2];
    }
    [self updateTimeLabel];
    
    
}

#pragma mark - Getter

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = self.commonColor;
    }
    return _backView;
}

- (UIView *)topContentView {
    if (!_topContentView) {
        _topContentView = [[UIView alloc] init];
    }
    return _topContentView;
}

- (UIButton *)switchModeBtn {
    if (!_switchModeBtn) {
        _switchModeBtn = [[UIButton alloc] init];
        [_switchModeBtn addTarget:self action:@selector(switchMode) forControlEvents:UIControlEventTouchUpInside];
        _switchModeBtn.layer.masksToBounds = YES;
        _switchModeBtn.layer.cornerRadius = 20;
        _switchModeBtn.layer.borderWidth = 1;
        _switchModeBtn.layer.borderColor = self.commonColor.CGColor;
    }
    return _switchModeBtn;
}

- (UILabel *)timeLabel {
    if (!_timeLabel ) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:17];
    }
    return _timeLabel;
}

- (UIPickerView *)pickView {
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] init];
        _pickView.delegate = self;
        _pickView.dataSource = self;
    }
    return _pickView;
}

- (UIColor *)commonColor {
    return [UIColor colorWithRed:28/255.0 green:192/255.0 blue:102/255.0 alpha:1];
}

- (UIEdgeInsets)mySafeArea {
    if (@available(iOS 11.0 , *)) {
        return self.view.safeAreaInsets;
    }
    return UIEdgeInsetsMake(20, 0, 0, 0);
}


- (UILabel *)modeLabel {
    if (!_modeLabel) {
        _modeLabel = [[UILabel alloc] init];
        _modeLabel.textColor = [self commonColor];
        _modeLabel.font = [UIFont boldSystemFontOfSize:15];
        
    }
    return _modeLabel;
}

- (NSInteger)maxYear {
    if (!_maxYear) {
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy";
        _maxYear = [[formatter stringFromDate:date] integerValue];
    }
    return _maxYear;
}

@end
