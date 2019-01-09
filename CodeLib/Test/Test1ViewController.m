//
//  Test1ViewController.m
//  CodeLib
//
//  Created by zw on 2018/12/3.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "Test1ViewController.h"
#import "UIImageView+SQWebCache.h"
#import "UIButton+SQWebCache.h"
#import "HttpRequest.h"
#import "ED_MonthView.h"
#import "ED_ToastView.h"
#import "ED_HighPrecisionControl.h"

@interface Test1ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong) ED_MonthView *monthView;

@property (nonatomic , strong) UITableView *tableView;





@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:imageView];
    [imageView loadNetImageWithUrl:@"https://ss0.baidu.com/7Po3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=f2db86688ccb39dbdec06156e01709a7/2f738bd4b31c87018e9450642a7f9e2f0708ff16.jpg" placeHolder:nil];
 
    
  
    

}




#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}





@end
