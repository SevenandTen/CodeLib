//
//  CViewController.m
//  CodeLib
//
//  Created by zw on 2018/11/30.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "CViewController.h"
#import <objc/runtime.h>

@interface CViewController ()

@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIViewController *aVc = self.presentingViewController.presentingViewController;
    UIViewController *bBc = self.presentingViewController;
//
//    NSLog(@"%@", [bBc valueForKey:@"_parentModalViewController"]);
//    NSLog(@"%@", [bBc valueForKey:@"_childModalViewController"]);
//
//    NSLog(@"%@", [self valueForKey:@"_parentModalViewController"]);
//    NSLog(@"%@", [self valueForKey:@"_childModalViewController"]);
//
//    [bBc setValue:nil forKeyPath:@"_parentModalViewController"];
//    [bBc setValue:nil forKeyPath:@"_childModalViewController"];
//
//    [self setValue:aVc forKeyPath:@"_parentModalViewController"];
//
//    [aVc setValue:self forKeyPath:@"_childModalViewController"];
//
//    unsigned int count = 0;
//    Ivar *member = class_copyIvarList([UIViewController class], &count);
//    for (int i = 0; i < count; i++) {
//        Ivar var = member[i];
//        const char *memberName = ivar_getName(var);
//        NSString * nameStr = [NSString stringWithCString:memberName encoding:NSUTF8StringEncoding];
////        [self setValue:[aDecoder decodeObjectForKey:nameStr] forKey:nameStr];
////        NSLog(@"%@ -------- %@ ",nameStr, [self valueForKey:nameStr]);
//    }
//
//
//
//    NSLog(@"--------------------------------");
//
    NSLog(@"a    %@", aVc.view);
    NSLog(@"b    %@", bBc.view);
    NSLog(@"c    %@",self.view);
    
     NSLog(@"///////////////////////////////////////////////////");
    
    for (UIView *obj in [UIApplication sharedApplication].keyWindow.subviews) {
        NSLog(@"------------------ %@",obj);
        for (UIView *view in obj.subviews) {
            NSLog(@"+++++%@",view);
        }
    }
    NSArray *array = [UIApplication sharedApplication].keyWindow.subviews;
    for (UIView *view in array) {
        [view removeFromSuperview];
    }
    [aVc setValue:nil forKeyPath:@"_childModalViewController"];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:aVc.view];
    
}



@end
