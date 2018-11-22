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
#import "ED_RefreshNormalHeader.h"
#import <objc/runtime.h>
#import "ED_GradedColorView.h"
#import "ED_RefreshNormalFooter.h"

@interface ViewController ()<UITableViewDelegate ,UITableViewDataSource,ED_BaseRefreshViewDelegate>

@property (nonatomic , strong) ED_RefreshNormalHeader *header;

@property (nonatomic , strong) ED_RefreshNormalFooter *footer;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) ED_GradedColorView *gradedView;

@property (nonatomic , weak) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;

    [self.tableView addSubview:self.header];
    
    [self.tableView addSubview:self.footer];
    

    
    
   
    
    
    
    
}



- (void)refreshViewBeginRefreshHeader:(ED_BaseRefreshView *)refreshView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshView endRefreshing];
    });
}

- (void)refreshViewBeginRefreshFooter:(ED_BaseRefreshView *)refreshView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshView endRefreshing];
    });
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    label.text = [NSString stringWithFormat:@"%ld", section];

    return label;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell defaultIdentifier]];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}






- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerCellWithClass:[UITableViewCell class]];
    }
    return _tableView;
}


- (ED_RefreshNormalHeader *)header {
    if (!_header) {
        _header = [[ED_RefreshNormalHeader alloc] init];
        _header.isFromOrigin = YES;
        _header.delegate = self;
    }
    return _header;
}


- (ED_RefreshNormalFooter *)footer {
    if (!_footer) {
        _footer = [[ED_RefreshNormalFooter alloc] init];
        _footer.isFromLast = YES;
        _footer.delegate = self;
    }
    return _footer;
}



@end
