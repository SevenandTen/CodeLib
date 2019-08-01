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




@interface ViewController ()

@property (nonatomic , strong) ED_OCRView *orcView;

@property (nonatomic , strong) UIImageView *currentImageView;

@property (nonatomic , strong) ED_CirCleView *circleView;








@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
    


}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    unsigned int count = 0;
    Ivar *member = class_copyIvarList([UIViewController class], &count);
    for (int i = 0; i < count; i++) {
        Ivar var = member[i];
        const char *memberName = ivar_getName(var);
        NSString * nameStr = [NSString stringWithCString:memberName encoding:NSUTF8StringEncoding];
        NSLog(@"%@",nameStr);
    }
    free(member);
   

    
}


- (void)didClickBtn {
    NSLog(@"%@", [self valueForKey:@"_childModalViewController"]);
    
    NSLog(@"%@", [self valueForKey:@"_parentModalViewController"]);
    
    [self presentViewController:[[AViewController alloc] init] animated:YES completion:nil];
}





- (ED_OCRView *)orcView {
    if (!_orcView) {
        _orcView = [[ED_OCRView alloc] initWithFrame:self.view.bounds];
    }
    return _orcView;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.circleView startAnmation];
    });
    
}

@end
