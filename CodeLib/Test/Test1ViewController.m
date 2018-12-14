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

@interface Test1ViewController ()<ED_MonthViewDelegate>
@property (nonatomic , strong) ED_MonthView *monthView;




@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.monthView];
    self.monthView.frame = CGRectMake(0, 100, self.view.bounds.size.width, 100);
    

}


- (void)monthView:(ED_MonthView *)view didScrollYears:(NSInteger)years isYearIncrease:(BOOL)isYearIncrease lastMonth:(NSInteger)lastMonth currentMonth:(NSInteger)currentMonth {
    NSLog(@"last %ld",lastMonth);
    NSLog(@"current %ld",currentMonth);
    if (isYearIncrease) {
        NSLog(@"+ %ld",years);
    }else{
        NSLog(@"-%ld",years);
    }
}

- (ED_MonthView *)monthView {
    if (!_monthView) {
        _monthView = [[ED_MonthView alloc] init];
        _monthView.delegate = self;
        [_monthView setBeginMonth:12];
    }
    return _monthView;
}




@end
