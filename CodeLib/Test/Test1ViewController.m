//
//  Test1ViewController.m
//  CodeLib
//
//  Created by zw on 2018/12/3.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "Test1ViewController.h"
#import "UIImageView+SQWebCache.h"
#import "UIButton+SQWebCache.h"
#import "HttpRequest.h"
#import "ED_MonthView.h"
#import "ED_ToastView.h"

@interface Test1ViewController ()<ED_MonthViewDelegate>
@property (nonatomic , strong) ED_MonthView *monthView;




@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//      [ED_ToastView toastOnView:nil style:ED_ToastLocationBottom title:@"保存图片成功" showTime:0.5 hideAfterTime:1 showAnmation:YES hideAnmation:NO];
    
    [ED_ToastView toastOnView:nil style:ED_ToastLoadingShortMessage title:@"请稍后..." showTime:0.5 showAnmation:YES];
}







@end
