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
#import "ED_AlertViewController.h"

#import <MapKit/MapKit.h>
@interface Test1ViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>

@property (nonatomic , strong) ED_PageView *pageView;

@property (nonatomic , strong) ED_RefreshNormalHeader *header;

@property (nonatomic , strong) ED_RefreshNormalFooter *footer;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) UIWebView *webView;

@property (nonatomic , strong) UIScrollView *scrollView;

@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = self.view.bounds;
    [self.view addSubview:self.scrollView];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];

    self.webView.delegate = self;
    [self.scrollView addSubview:self.webView];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://sijibao.ipnavi.cn/sjbServer2/app/resources/html/sjbWalletServe.html"]];

    [self.webView loadRequest:request];
  

}




- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%@", NSStringFromCGSize(webView.scrollView.contentSize));
    self.webView.frame = CGRectMake(0, 0, webView.scrollView.contentSize.width, webView.scrollView.contentSize.height);
    self.webView.scrollView.scrollEnabled = NO;
    self.scrollView.contentSize = webView.scrollView.contentSize;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
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
