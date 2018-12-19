//
//  ViewController.m
//  CodeLib
//
//  Created by zw on 2018/10/30.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ViewController.h"
#import "ED_LocationManager.h"
#import "UIImageView+SQWebCache.h"
#import "UITableView+RegisterCell.h"
#import "ED_BasicTabelViewCell.h"
#import "UIView+Instance.h"
#import "ED_TimeSelectControl.h"
#import "ED_BaseRefreshView.h"
#import "ED_RefreshNormalHeader.h"
#import <objc/runtime.h>
#import "ED_GradedColorView.h"
#import "ED_RefreshNormalFooter.h"
#import "ED_NetListener.h"
#import "HttpRequest.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "ED_AnimationView.h"
#import "BViewController.h"


@interface ViewController ()<UITableViewDelegate ,UITableViewDataSource,ED_BaseRefreshViewDelegate,CBCentralManagerDelegate>

@property (nonatomic , strong) ED_RefreshNormalHeader *header;

@property (nonatomic , strong) ED_RefreshNormalFooter *footer;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) ED_GradedColorView *gradedView;

@property (nonatomic , weak) UIScrollView *scrollView;

@property (nonatomic , strong) CBCentralManager *manager;

@property (nonatomic , strong) NSMutableArray *dataSource;





@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
   


   
    
    
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UIView *obj in [UIApplication sharedApplication].keyWindow.subviews) {
        NSLog(@"------------------ %@",obj);
        for (UIView *view in obj.subviews) {
            NSLog(@"+++++%@",view);
        }
    }
    
    NSLog(@"///////////////////////////////////////////////////");
    BViewController *vc = [[BViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
    
}




- (void)netWorkChange {
    ED_NetWorkEnvironment status = [ED_NetListener shareInstance].status;
    if (status == ED_NetWorkDisable) {
        NSLog(@"网路不可用");
    }else if (status == ED_NetWorkWifi) {
        NSLog(@"wifi");
    }else {
        NSLog(@"4g");
    }
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff");
            break;
        case CBCentralManagerStatePoweredOn:
        {
            NSLog(@">>>CBCentralManagerStatePoweredOn");
            // 开始扫描周围的外设。
            /*
             -- 两个参数为Nil表示默认扫描所有可见蓝牙设备。
             -- 注意：第一个参数是用来扫描有指定服务的外设。然后有些外设的服务是相同的，比如都有FFF5服务，那么都会发现；而有些外设的服务是不可见的，就会扫描不到设备。
             -- 成功扫描到外设后调用didDiscoverPeripheral
             */
            [self.manager scanForPeripheralsWithServices:nil options:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark 发现外设
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary*)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"-------------------------------------");
    NSLog(@"Find device:%@", peripheral.name );
    NSLog(@"11111 :%@", advertisementData );
    NSLog(@"22222 :%@", RSSI );
    
   
    
}
    

//- (void)refreshViewBeginRefreshHeader:(ED_BaseRefreshView *)refreshView {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [refreshView endRefreshing];
//    });
//}
//
//- (void)refreshViewBeginRefreshFooter:(ED_BaseRefreshView *)refreshView {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [refreshView endRefreshing];
//    });
//}
//
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 50;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
//    label.text = [NSString stringWithFormat:@"%ld", section];
//
//    return label;
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 10;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell defaultIdentifier]];
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
//    return cell;
//}
//



- (CBCentralManager *)manager {
    if (!_manager) {
        _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return _manager;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerCellWithClass:[UITableViewCell class]];
    }
    return _tableView;
}


- (ED_RefreshNormalHeader *)header {
    if (!_header) {
        _header = [[ED_RefreshNormalHeader alloc] init];
        _header.isFromOrigin = YES;
        _header.delegate = self;
    }
    return _header;
}


- (ED_RefreshNormalFooter *)footer {
    if (!_footer) {
        _footer = [[ED_RefreshNormalFooter alloc] init];
        _footer.isFromLast = YES;
        _footer.delegate = self;
    }
    return _footer;
}



@end
