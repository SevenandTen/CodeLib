//
//  ED_GlobelAlertViewController.m
//  CodeLib
//
//  Created by zw on 2020/1/16.
//  Copyright © 2020 seventeen. All rights reserved.
//

#import "ED_GlobelAlertViewController.h"
#import "ED_GlobelAlertCell.h"

@interface ED_GlobelAlertViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) NSArray *dataSource;

@property (nonatomic , strong) NSArray *otherDataSource;

@property (nonatomic , copy) void(^actionBlock)(NSInteger section ,NSInteger row);

@property (nonatomic , strong) UIView *backView;



@end

@implementation ED_GlobelAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat height = [self getContentHeight];
        self.tableView.frame = CGRectMake(0, self.view.bounds.size.height - height , self.view.bounds.size.width,height);
    }];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}


+ (ED_GlobelAlertViewController *)showWithItems:(NSArray *)items cancelItems:(NSArray *)cancleItems viewController:(UIViewController *)viewController actionBlock:(void (^)(NSInteger, NSInteger))actionBlock {
    ED_GlobelAlertViewController *vc = [[ED_GlobelAlertViewController alloc] init];
    vc.actionBlock = actionBlock;
    vc.dataSource = items;
    vc.otherDataSource = cancleItems;
    [viewController presentViewController:vc animated:NO completion:nil];
    return vc;
}

- (void)configureViews {
    [self.view addSubview:self.backView];
    self.backView.frame = self.view.bounds;
    self.backView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickClose)];
     [self.backView addGestureRecognizer:tap];
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, [self getContentHeight]);
    if (@available(iOS 11.0,*)) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom)];
        footerView.backgroundColor = [UIColor whiteColor];
        self.tableView.tableFooterView = footerView;
    }else{
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
  
    CGFloat height = [self getContentHeight];
    
    self.tableView.frame = CGRectMake(0, self.view.bounds.size.height - height , self.view.bounds.size.width,height);
}


#pragma mark - Action

- (void)didClickClose {
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat height = [self getContentHeight];
        self.tableView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width,height);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
        if (self.actionBlock) {
            self.actionBlock(-1, -1);
        }
    }];
}


#pragma mark - Private


- (CGFloat)getContentHeight {
    CGFloat height = 50 * self.dataSource.count;
      if (self.otherDataSource.count > 0) {
          height = height + 5 + 50 * self.otherDataSource.count;
      }
      if (@available(iOS 11.0 , *)) {
          height = height + [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom;
      }
    return height;
}


#pragma mark - UITableViewDelegate , UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataSource.count > 0 && self.otherDataSource.count > 0) {
         return 2;
     }else  {
         return 1;
     }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataSource.count;
    }
    return self.otherDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1f;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ED_GlobelAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ED_GlobelAlertCell class])];
    if (indexPath.section == 0) {
        [cell refreshCellWithObject:[self.dataSource objectAtIndex:indexPath.row]];
        if (indexPath.row == self.dataSource.count - 1) {
            [cell setLineColor:[UIColor clearColor]];
        }else{
            [cell setLineColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0  alpha:1]];
        }
        
    }else {
        [cell refreshCellWithObject:[self.otherDataSource objectAtIndex:indexPath.row]];
        if (indexPath.row == self.otherDataSource.count - 1) {
            [cell setLineColor:[UIColor clearColor]];
        }else{
            [cell setLineColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0  alpha:1]];
        }
    }
    
    return  cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat height = [self getContentHeight];
        self.tableView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width,height);
    } completion:^(BOOL finished) {
             [self dismissViewControllerAnimated:NO completion:nil];
        if (self.actionBlock) {
            self.actionBlock(indexPath.section, indexPath.row);
        }
    }];
}



#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView registerClass:[ED_GlobelAlertCell class] forCellReuseIdentifier:NSStringFromClass([ED_GlobelAlertCell class])];
        _tableView.rowHeight = 50;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    }
    return _backView;
}

@end
