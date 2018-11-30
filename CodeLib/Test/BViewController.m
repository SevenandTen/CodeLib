//
//  BViewController.m
//  CodeLib
//
//  Created by zw on 2018/11/30.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "BViewController.h"
#import "CViewController.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UIView *obj in [UIApplication sharedApplication].keyWindow.subviews) {
        NSLog(@"------------------ %@",obj);
        for (UIView *view in obj.subviews) {
            NSLog(@"+++++%@",view);
        }
    }
     NSLog(@"///////////////////////////////////////////////////");
    CViewController *vc = [[CViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}



@end
