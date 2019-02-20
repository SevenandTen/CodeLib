//
//  BViewController.m
//  CodeLib
//
//  Created by zw on 2018/11/30.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "BViewController.h"
#import "CViewController.h"
#import "ED_TransitionManager.h"

@interface BViewController ()
@property (nonatomic , strong) ED_TransitionManager *manager;


@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    self.manager = [[ED_TransitionManager alloc] init];
    self.manager.toAnmation = [[ED_PrecentTransition alloc] initWithViewController:self];
//    self.manager.outAnmaiton =  [[ED_TransitionAnimation alloc] init];
    self.manager.inAnimation = [[ED_TransitionAnimation alloc] init];
//    self.manager.outAnmaiton.duration =
    CViewController *vc = [[CViewController alloc] init];
    __weak typeof(self)weakSelf = self;
    self.navigationController.delegate = self.manager;
    self.manager.toAnmation.actionBlock = ^{
        [weakSelf.navigationController pushViewController:vc animated:YES ];
    };
//       vc.transitioningDelegate = self.manager;
    self.navigationController.delegate = self.manager;
    // Do any additional setup after loading the view.
   
}








@end
