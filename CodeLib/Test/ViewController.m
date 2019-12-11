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
#import "ED_CarNumberFiled.h"
#import "ED_CarNumberInputView.h"





@interface ViewController ()

@property (nonatomic , strong) ED_CarNumberInputView *carNumberView;





@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.carNumberView = [[ED_CarNumberInputView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.carNumberView];
    
    
    
 
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];

    
    
    
    
}











@end
