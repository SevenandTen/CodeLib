//
//  ED_VideoRecordViewController.m
//  CodeLib
//
//  Created by zw on 2020/1/2.
//  Copyright © 2020 seventeen. All rights reserved.
//

#import "ED_VideoRecordViewController.h"

#import "ED_VideoRecordView.h"

@interface ED_VideoRecordViewController ()<ED_VideoRecordViewDelegate>

@property (nonatomic , strong) ED_VideoRecordView *recordView;

@property (nonatomic , strong) UIButton *dismissBtn;



@end

@implementation ED_VideoRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    [self.view addSubview:self.recordView];
    self.recordView.frame = self.view.bounds;
    self.recordView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.dismissBtn];
    if (@available(iOS 11.0 ,*)) {
         self.dismissBtn.frame = CGRectMake(10.5, 8 + [UIApplication sharedApplication].delegate.window.safeAreaInsets.top, 33, 33);
    }else{
         self.dismissBtn.frame = CGRectMake(10.5, 28, 33, 33);
    }
    
    
   
    // Do any additional setup after loading the view.
}


+ (ED_VideoRecordViewController *)showWithViewController:(UIViewController *)viewController actionBlock:(void (^)(NSURL *))actionBlock {
    ED_VideoRecordViewController *vc = [[ED_VideoRecordViewController alloc] init];
    vc.actionBlock = actionBlock;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [viewController presentViewController:nav animated:YES completion:nil];
    return vc;
}


- (void)recordView:(ED_VideoRecordView *)view didFinishWithUrl:(NSURL *)fileUrl {
    if (self.actionBlock) {
        self.actionBlock(fileUrl);
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Action


- (void)didClickDismiss {
      [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Getter


- (ED_VideoRecordView *)recordView {
    if (!_recordView) {
        _recordView = [[ED_VideoRecordView alloc] init];
        _recordView.delegate = self;
    }
    return _recordView;
}


- (UIButton *)dismissBtn {
    if (!_dismissBtn) {
        _dismissBtn = [[UIButton alloc] init];
        [_dismissBtn addTarget:self action:@selector(didClickDismiss) forControlEvents:UIControlEventTouchUpInside];
        [_dismissBtn setImage:[UIImage imageNamed:@"btm_back"] forState:UIControlStateNormal];
        
    }
    return _dismissBtn;
}


@end
