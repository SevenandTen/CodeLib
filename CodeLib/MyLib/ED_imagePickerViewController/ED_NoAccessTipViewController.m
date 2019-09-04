//
//  ED_NoAccessTipViewController.m
//  CodeLib
//
//  Created by zw on 2019/8/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_NoAccessTipViewController.h"

@interface ED_NoAccessTipViewController ()

@property (nonatomic , strong) UILabel *tipLabel;

@end

@implementation ED_NoAccessTipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myNavigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(didClickCancel)];
    [self configureViews];
    // Do any additional setup after loading the view.
}

- (void)configureViews {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.tipLabel];
    self.tipLabel.frame = CGRectMake(0, 40, self.contentView.frame.size.width, 40);
    if (self.appName.length) {
        self.tipLabel.text = [NSString stringWithFormat:@"请在iPhone的“设置隐私-照片’选项中，\n允许%@访问你的手机相册。",self.appName];
    }else{
        self.tipLabel.text = @"请在iPhone的“设置隐私-照片’选项中，\n允许访问你的手机相册。";
    }
    
}

#pragma mark - Action

- (void)didClickCancel {
    if (self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



#pragma mark - Getter

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

@end
