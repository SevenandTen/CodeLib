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
#import "ED_HighPrecisionControl.h"

@interface Test1ViewController ()<ED_MonthViewDelegate>
@property (nonatomic , strong) ED_MonthView *monthView;





@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@",[ED_HighPrecisionControl addReslutNumber_A:@(100.000001) with_B:@"200"]);
    NSLog(@"%@",[ED_HighPrecisionControl divideReslutString_A:@"1000" with_B:@(0)]);
}







@end
