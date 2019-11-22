//
//  ViewController.m
//  CodeLib
//
//  Created by zw on 2018/10/30.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ViewController.h"

#import "ED_QRCodeView.h"
#import "ED_SparatorLineView.h"
#import "ED_CirCleView.h"





@interface ViewController ()

@property (nonatomic , strong) ED_QRCodeView *qrcodeView;





@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboradFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    ED_SparatorLineView *lineView = [[ED_SparatorLineView alloc] initWithLineLength:3 space:3 lineColor:[UIColor redColor] style:ED_SparatorLineViewStyleVertical];
//    lineView.frame = CGRectMake(0, 0, 300, self.view.bounds.size.height);
//    [self.view addSubview:lineView];
    
//    ED_CirCleView *circleView = [[ED_CirCleView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [circleView startAnmation];
//    [self.view addSubview:circleView];
    
    UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    UIView *intputView = [[UIView alloc] initWithFrame:CGRectZero];
    textFiled.placeholder = @"你来啊";
    intputView.backgroundColor = [UIColor redColor];
    textFiled.inputView = intputView;
    
    [self.view addSubview:textFiled];
    
    
    
 
    
}


//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.qrcodeView startRuning];
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}




- (void)keyboradFrameWillChange:(NSNotification *)noti  {
    
    NSValue *keyBoardEndBounds=[[noti userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    NSLog(@"%@",NSStringFromCGRect(endRect));
    
}






@end
