//
//  TestTabBarController.m
//  CodeLib
//
//  Created by zw on 2018/12/3.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "TestTabBarController.h"
#import "Test1ViewController.h"
#import "Test2ViewController.h"
#import "Test3ViewController.h"

@interface TestTabBarController ()

@property (nonatomic , strong) UIViewController *firstVC;

@property (nonatomic , strong) UIViewController *secondVC;

@property (nonatomic , strong) UIViewController *thirdVC;

@end

@implementation TestTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    _firstVC = [[UINavigationController alloc] initWithRootViewController:[[Test1ViewController alloc] init]];
    _secondVC = [[UINavigationController alloc] initWithRootViewController:[[Test2ViewController alloc] init]];
    _thirdVC = [[UINavigationController alloc] initWithRootViewController:[[Test3ViewController alloc] init]];
    
    [self setViewControllers:@[self.firstVC,self.secondVC,self.thirdVC]];
    // Do any additional setup after loading the view.
}


@end
