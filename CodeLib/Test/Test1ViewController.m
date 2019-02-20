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
@interface Test1ViewController ()<UIWebViewDelegate>
@property (nonatomic , strong) ED_MonthView *monthView;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) UIWebView *webView;

@property (nonatomic , strong) JSContext *context;









@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
//    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//
//    [self.view addSubview:self.webView];
//    self.webView.delegate = self;
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://210.21.12.73:9090/patient/#/HandRegistration?code=SZDJ&unitId=36"]];
//
//    [self.webView loadRequest:request];
    
    
    NSDate *date = [NSDate date];
    
    NSLog(@"%@",[[date getMonthBeginDate] getStringDateWithTimeForm:@"YY-MM-dd HH:mm:ss"]);
    
     NSLog(@"%@",[[date getMonthEndDate] getStringDateWithTimeForm:@"YY-MM-dd HH:mm:ss"]);
  

  
    

}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@",request.URL);
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"start ");
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    __weak typeof(self)weakSelf = self;
    self.context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    self.context[@"isApp"] = ^ {
        NSLog(@"isApp");
    };
    self.context[@"userInvalid"] = ^ {
        NSLog(@"userInvalid");
    };
    
}


@end
