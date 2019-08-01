//
//  CViewController.m
//  CodeLib
//
//  Created by zw on 2019/7/30.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "CViewController.h"
#import "BViewController.h"
#import "AViewController.h"
#import <objc/runtime.h>

@interface CViewController ()

@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didClickBtn {
//    NSLog(@"%@", [self valueForKey:@"_childModalViewController"]);
//
//    NSLog(@"%@", [self valueForKey:@"_parentModalViewController"]);
    
    AViewController *ac = self.presentingViewController;
    
     BViewController *bc = [[BViewController alloc] init];
    
//    NSLog(@"%@",[ac valueForKey:@"_modalTransitionView"]);
//    NSLog(@"%@",[bc valueForKey:@"_modalTransitionView"]);
//    NSLog(@"%@",[self valueForKey:@"_modalTransitionView"]);
    
    
    [bc setValue:ac forKey:@"_parentModalViewController"];
    [bc setValue:ac forKey:@"_modalSourceViewController"];
    
    [bc setValue:self forKey:@"_presentedUserInterfaceStyleViewController"];
    [bc setValue:self forKey:@"_childModalViewController"];
    [bc setValue:self forKey:@"_presentedStatusBarViewController"];
//
    [self setValue:bc forKey:@"_parentModalViewController"];
    [self setValue:bc forKey:@"_modalSourceViewController"];
    
    
    [ac setValue:bc forKey:@"_presentedStatusBarViewController"];
    [ac setValue:bc forKey:@"_childModalViewController"];
    [ac setValue:bc forKey:@"_presentedUserInterfaceStyleViewController"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
  // _presentedStatusBarViewController // _presentedUserInterfaceStyleViewController //_modalSourceViewController
    
    unsigned int count = 0;
    Ivar *member = class_copyIvarList([UIViewController class], &count);
    for (int i = 0; i < count; i++) {
        Ivar var = member[i];
        const char *memberName = ivar_getName(var);
        NSString * nameStr = [NSString stringWithCString:memberName encoding:NSUTF8StringEncoding];
        if ([bc valueForKey:nameStr]) {
             NSLog(@"%@ -------\n--------%@",nameStr ,[bc valueForKey:nameStr] );
        }

    }
    free(member);
    
    
//
//    NSLog(@"%@", [self valueForKey:@"_childModalViewController"]);
//
//    NSLog(@"%@", [self valueForKey:@"_parentModalViewController"]);
//
//
//    NSLog(@"%@", [ac valueForKey:@"_childModalViewController"]);
//
//    NSLog(@"%@", [ac valueForKey:@"_parentModalViewController"]);
    
    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    int i = 0 ;
//    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
//        NSLog(@"%@+++++++++++++++++++++++++++++   %@",@(i),view);
//        for (UIView *subView in view.subviews) {
//             NSLog(@"%@-------------------------   %@",@(i),subView);
//
//        }
//
//        i ++;
//    }
//
    [self.view.superview addSubview:bc.view];
    [self.view removeFromSuperview];
    
}

@end
