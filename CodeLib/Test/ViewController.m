//
//  ViewController.m
//  CodeLib
//
//  Created by zw on 2018/10/30.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ViewController.h"
#import "ED_OCRView.h"
#import "ED_ORCControl.h"


@interface ViewController ()

@property (nonatomic , strong) ED_OCRView *orcView;

@property (nonatomic , strong) UIImageView *currentImageView;






@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
//    [self.view addSubview:imageView];
//    imageView.image = [UIImage imageNamed:@"test.jpg"];
//    self.currentImageView = imageView;
    
    [self.view addSubview:self.orcView];
    self.orcView.frame = self.view.bounds;
    
   

}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UIImage * image = [ED_ORCControl opencvGrayProcessingWithImage:self.currentImageView.image];
//    self.currentImageView.image =  [ED_ORCControl opencvBinaryzationWithImage:image];
//}


- (ED_OCRView *)orcView {
    if (!_orcView) {
        _orcView = [[ED_OCRView alloc] initWithFrame:self.view.bounds];
    }
    return _orcView;
}



@end
