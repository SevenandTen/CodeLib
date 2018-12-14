//
//  Test3ViewController.m
//  CodeLib
//
//  Created by zw on 2018/12/3.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "Test3ViewController.h"

@interface Test3ViewController ()

@end

@implementation Test3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    // Do any additional setup after loading the view.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UIView *obj in [UIApplication sharedApplication].keyWindow.subviews) {
        NSLog(@"------------------ %@",obj);
        for (UIView *view in obj.subviews) {
            NSLog(@"+++++%@",view);
            for (UIView *subView in view.subviews) {
                NSLog(@"/////////////%@",subView);
            }
        }
    }
    NSLog(@"%@",self.view);
}



@end
