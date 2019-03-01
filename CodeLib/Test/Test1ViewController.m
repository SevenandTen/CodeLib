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
#import <objc/runtime.h>
#import "AppDelegate.h"
#import "ED_TransitionManager.h"
#import "ViewController.h"
#import "OneModel.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "NSDate+FormatDate.h"
#import "ED_PageView.h"
#import "ED_ToastView.h"
#import "ED_PageContext.h"
#import "ED_RefreshNormalFooter.h"
#import "ED_RefreshNormalHeader.h"
@interface Test1ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) ED_PageView *pageView;

@property (nonatomic , strong) ED_RefreshNormalHeader *header;

@property (nonatomic , strong) ED_RefreshNormalFooter *footer;

@property (nonatomic , strong) UITableView *tableView;

@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    
    [[ED_PageContextManager shareIntance] fillWithTitleArray:@[@"我 i 哦哦",@"大叔控",@"我 i 哦哦",@"大叔控",@"我 i 哦哦",@"大叔控",@"我 i 哦哦",@"大叔控",@"我 i 哦哦",@"大叔控",@"我 i 哦哦",@"大叔控",@"我 i 哦哦",@"大叔控",@"我 i 哦哦",@"大叔控",@"到家哦"] fontNumber:15];
    [ED_PageContextManager shareIntance].delegate = self;
    [ED_PageContextManager shareIntance].titleHeight = 40;
    [ED_PageContextManager shareIntance].zeroHeight = 100;



    [self.view addSubview:self.pageView];
    self.pageView.frame = self.view.bounds;
//    [self.view addSubview:self.tableView];
//    self.tableView.frame = self.view.bounds;
//    [self.tableView addSubview:self.header];
//    [self.tableView addSubview:self.footer];
//    __weak typeof(self)weakSelf = self;
//    self.header.complete = ^(void) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.header endRefreshing];
//        });
//    };
//
//    self.footer.complete =^(void) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.footer endRefreshing];
//        });
//    };

  

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d +++扫地机几件",indexPath.row];
    return cell;
}


- (ED_PageView *)pageView {
    if (!_pageView) {
        _pageView = [[ED_PageView alloc] init];
    }
    return _pageView;
}



- (ED_RefreshNormalHeader *)header {
    if (!_header) {
        _header = [[ED_RefreshNormalHeader alloc] init];
        _header.isFromOrigin = YES;
    }
    return _header;
}

- (ED_RefreshNormalFooter *)footer {
    if (!_footer) {
        _footer = [[ED_RefreshNormalFooter alloc] init];
    }
    return _footer;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
@end
