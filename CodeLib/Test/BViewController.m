//
//  BViewController.m
//  CodeLib
//
//  Created by zw on 2019/7/30.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "BViewController.h"


@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn];
    self.parentViewController;
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
    NSLog(@"%@", [self valueForKey:@"_childModalViewController"]);
    
    NSLog(@"%@", [self valueForKey:@"_parentModalViewController"]);
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
       
}

@end
