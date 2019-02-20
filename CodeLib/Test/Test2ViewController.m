//
//  Test2ViewController.m
//  CodeLib
//
//  Created by zw on 2018/12/3.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "Test2ViewController.h"
#import "ED_SignView.h"

@interface Test2ViewController ()

@property (nonatomic , strong) ED_SignView *signView;
@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 4;  i ++) {
        CGFloat width = (self.view.bounds.size.width - 50)/4.0;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10 * (i + 1) + width *i , 100, width, 50)];
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 101 + i;
        [self.view addSubview:btn];
    }
    
    [self.view addSubview:self.signView];
    self.signView.frame = CGRectMake(0, 200, self.view.bounds.size.width ,self.view.bounds.size.height - 100 );

}



- (void)didClickBtn:(UIButton *)sender {
    NSInteger tag = sender.tag - 100 ;
    if (tag == 1) {
        //清空
        [self.signView resetSign];
    }else if (tag == 2) {
        //撤销
        [self.signView withdrawAction];
    }else if (tag == 3) {
        // 图片
        UIImage *image = [self.signView getSign];
        NSLog(@"......");
        
    }else if (tag == 4) {
        double red = arc4random() % 256/255.0;
        double green = arc4random() % 256/255.0;
        double bule = arc4random() %256/255.0;
        UIColor *color = [UIColor colorWithRed:red green:green blue:bule alpha:1];
        [self.signView setLineColor:color];
        
        [self.signView setLineWidth:arc4random() %5];
    }
}


#pragma mark - Getter


- (ED_SignView *)signView {
    if (!_signView) {
        _signView = [[ED_SignView alloc] init];
    }
    return _signView;
}






@end
