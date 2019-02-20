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
@interface Test1ViewController ()<ED_PageViewHandleDelegate>

@property (nonatomic , strong) ED_PageView *pageView;



@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController setNavigationBarHidden:YES];
//
//    [self.view addSubview:self.pageView];
//    self.pageView.frame = self.view.bounds;

  

  
    

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [ED_ToastView toastOnView:nil style:ED_ToastLoadingShortMessage title:@"我不知道\n诶奇偶" showTime:1.0 hideAfterTime:1.0 showAnmation:YES hideAnmation:YES];
}

// 零界点
- (CGFloat)zeroPointWithPageView:(ED_PageView *)pageView {
    return 100;
}

//---------------------------------------------------------------------
- (UITableViewCell *)pageView:(ED_PageView *)pageView cellForRowAtIndexPath:(NSIndexPath *)indexPath viewTag:(NSInteger)tag {
   UITableViewCell *cell = [pageView dequeueReusableCellWithIdentifier:@"cell" viewTag:tag];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d + %d",tag ,indexPath.row];
    return cell;
}


- (NSInteger)pageView:(ED_PageView *)pageView numOfSectionWithViewTag:(NSInteger)tag {
    return 1;
}


- (NSInteger)pageView:(ED_PageView *)pageView numOfRowInSection:(NSInteger)section viewTag:(NSInteger)tag {
    return 100 ;
}

- (void)pageView:(ED_PageView *)pageView didSelectRowAtIndexPath:(NSIndexPath *)indexPath viewTag:(NSInteger)tag  {
    
}

//----------------------------------------------------------------------

- (NSArray<NSString *> *)titleArrayWithPageView:(ED_PageView *)pageView {
    return @[@"我不知道",@"我不知道",@"我不知道"];
}




- (ED_PageView *)pageView {
    if (!_pageView) {
        _pageView = [[ED_PageView alloc] init];
        _pageView.delegate = self;
    }
    return _pageView;
}


@end
