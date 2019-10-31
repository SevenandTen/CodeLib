//
//  ViewController.m
//  CodeLib
//
//  Created by zw on 2018/10/30.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ViewController.h"
#import "ED_OCRView.h"
#import "ED_ORCControl.h"

#import "ED_ToastView.h"
#import "ED_CirCleView.h"
#import <AdSupport/AdSupport.h>
#import "TestNavgationController.h"
#import <objc/runtime.h>
#import "AViewController.h"
#import "HttpRequest.h"
#import "ED_QRCodeView.h"
#import "ED_VideoMakerView.h"




@interface ViewController ()





@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ED_VideoMakerView *videoMakerView = [[ED_VideoMakerView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:videoMakerView];

   

}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {





}






@end
