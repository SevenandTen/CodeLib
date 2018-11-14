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
#import "ED_BaseRefreshView.h"

@interface ViewController ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic , strong) ED_BaseRefreshView *refreshView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.refreshView];
    self.refreshView.frame = CGRectMake(10, 100, 100, 100);
    
    self.refreshView.backgroundColor = [UIColor redColor];
  
   
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.refreshView removeFromSuperview];
}


#pragma mark - Getter

- (ED_BaseRefreshView *)refreshView {
    if (!_refreshView) {
        _refreshView = [[ED_BaseRefreshView alloc] init];
    }
    return _refreshView;
}

@end
