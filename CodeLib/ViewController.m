//
//  ViewController.m
//  CodeLib
//
//  Created by zw on 2018/10/30.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ViewController.h"
#import "ED_LocationManager.h"
#import "UIImageView+SQWebCache.h"
#import "UITableView+RegisterCell.h"
#import "ED_BasicTabelViewCell.h"
#import "UIView+Instance.h"
#import "ED_TimeSelectControl.h"

@interface ViewController ()<UITableViewDelegate ,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myNavigationItem.title = @"不知道";

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *string = @"20090228";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMdd";
    
    [ED_TimeSelectControl showTimeSelectWithDate:[formatter dateFromString:string] hasDay:NO complete:^(BOOL hasDay, NSDate *date) {
        if (hasDay) {
            NSLog(@"%@",[formatter stringFromDate:date]);
        }else {
            formatter.dateFormat = @"yyyyMM";
            NSLog(@"%@",[formatter stringFromDate:date]);
        }
        
    }];
}




@end
