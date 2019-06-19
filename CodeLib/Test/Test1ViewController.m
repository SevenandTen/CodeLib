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
#import "UIImage+QRcode.h"

#import "UIView+UnreadNumber.h"
#import "UIImage+ModifyColor.h"
#import "ED_EnvironmentManager.h"
#import <objc/runtime.h>
@interface Test1ViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>{
    
}

//@property (nonatomic , strong) ED_PageView *pageView;
//
@property (nonatomic , strong) ED_RefreshNormalHeader *header;

@property (nonatomic , strong) ED_RefreshNormalFooter *footer;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) UIWebView *webView;

@property (nonatomic , strong) UIScrollView *scrollView;


@property (nonatomic , strong) ED_TransitionManager *manager;


@end

@implementation Test1ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray * array = [NSArray array];
    id objec = [array objectAtIndex:100];
}










@end
