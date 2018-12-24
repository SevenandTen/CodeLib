//
//  Test2ViewController.m
//  CodeLib
//
//  Created by zw on 2018/12/3.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "Test2ViewController.h"

@interface Test2ViewController ()

@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3"]];
    [self dealWithArray:array];
    NSLog(@"%@",array);
    
    // Do any additional setup after loading the view.
}

- (void)dealWithArray:(NSMutableArray *)array {
    array = [[NSMutableArray alloc] initWithArray:@[@"4"]];
}



@end
