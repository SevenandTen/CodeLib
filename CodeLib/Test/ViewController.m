//
//  ViewController.m
//  CodeLib
//
//  Created by zw on 2018/10/30.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ViewController.h"
#import "ED_OCRView.h"



@interface ViewController ()

@property (nonatomic , strong) ED_OCRView *orcView;






@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.orcView];
//    self.orcView.frame = self.view.bounds;
    
   

}



- (ED_OCRView *)orcView {
    if (!_orcView) {
        _orcView = [[ED_OCRView alloc] initWithFrame:self.view.bounds];
    }
    return _orcView;
}



@end
