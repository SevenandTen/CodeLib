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
    
//    [self.view addSubview:self.monthView];
//    self.monthView.frame = CGRectMake(0, 100, self.view.bounds.size.width, 100);
    
    for (int i = 0; i < 10000; i ++) {
        for (int j = 0; j < 10000; j++) {
            NSLog(@"%d",i);
            break;
        }
    }
  
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [formatter dateFromString:@"2018-12-31"];
    NSLog(@"%@",date);
    NSString *neWTime = [formatter stringFromDate:date];
    NSLog(@"%@",neWTime);
}


#pragma mark - getter

- (ED_MonthView *)monthView {
    if (!_monthView) {
        _monthView = [[ED_MonthView alloc] init];
        [_monthView setItemWidth:100];
        [_monthView setBeginMonth:12];
    }
    return _monthView;
}






@end
