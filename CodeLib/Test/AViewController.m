//
//  AViewController.m
//  CodeLib
//
//  Created by zw on 2019/7/30.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "AViewController.h"
#import "CViewController.h"
#import "BViewController.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
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
    NSLog(@"%@", [self valueForKey:@"_childModalViewController"]);
    
    NSLog(@"%@", [self valueForKey:@"_parentModalViewController"]);
   
    CViewController *cc = [[CViewController alloc] init];
    [self presentViewController:cc animated:YES completion:nil];
}

@end
