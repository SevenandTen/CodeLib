//
//  ViewController.m
//  CodeLib
//
//  Created by zw on 2018/10/30.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ViewController.h"

#import "ED_QRCodeView.h"





@interface ViewController ()

@property (nonatomic , strong) ED_QRCodeView *qrcodeView;





@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.qrcodeView = [[ED_QRCodeView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.qrcodeView];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.qrcodeView startRuning];
}











@end
