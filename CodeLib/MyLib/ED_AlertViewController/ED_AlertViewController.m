//
//  ED_AlertViewController.m
//  SJBJingJiRen
//
//  Created by zw on 2018/8/22.
//  Copyright © 2018年 mzw. All rights reserved.
//



/*
 自定义 alert 目前只支持从底部弹出
 
 
 
 */

#import "ED_AlertViewController.h"
#import "ED_AlertContentCell.h"


@interface ED_AlertViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UIView *backView;


@property (nonatomic , strong) NSMutableArray *actionArray;


@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) NSString *titleString;


@property (nonatomic , readonly) UIEdgeInsets mySafeArea;

@end

@implementation ED_AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.view.bounds) - self.tableView.frame.size.height - self.mySafeArea.bottom, self.tableView.frame.size.width, self.tableView.frame.size.height + self.mySafeArea.bottom);
     
    }];
}


- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.view.bounds) - self.tableView.frame.size.height - self.mySafeArea.bottom, self.tableView.frame.size.width, self.tableView.frame.size.height + self.mySafeArea.bottom);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.view.bounds), self.view.bounds.size.width, self.tableView.frame.size.height);
}

#pragma mark - Public

- (void)addAction:(ED_AlertAction *)action {
    [self.actionArray addObject:action];
}


+ (instancetype)alertWithTitle:(NSString *)title actions:(NSArray<ED_AlertAction *> *)actions {
    ED_AlertViewController *vc = [[ED_AlertViewController alloc] initWithTitle:title];
    if (actions.count != 0) {
        for (ED_AlertAction *action in actions) {
            [vc addAction:action];
        }
    }
    return vc;
}

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.titleString = title;
    }
    return self;
}




- (void)configureViews {
    [self.view addSubview:self.backView];
    self.backView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    CGFloat height = 0;
    if (self.titleString.length == 0) {
        height =  self.actionArray.count * 50;
    }else{
        height = 45 + self.actionArray.count * 50;
    }
    
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.view.bounds), self.view.bounds.size.width, height);
    if (height > self.view.bounds.size.height) {
        self.tableView.scrollEnabled = YES;
    }else {
        self.tableView.scrollEnabled = NO;
    }
    
    [self.backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAlert)]];
}

#pragma mark - Action

- (void)dismissAlert {
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.view.bounds), self.view.bounds.size.width, self.tableView.frame.size.height);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.actionArray.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    ED_AlertContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ED_AlertContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (indexPath.row == 0) {
        [cell refreshCellWithString:self.titleString isTitle:YES];
    }else {
        ED_AlertAction *action = [self.actionArray objectAtIndex:indexPath.row - 1];
        [cell refreshCellWithString:action.title isTitle:!action.isSelected];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return;
    }else {
        ED_AlertAction *action = [self.actionArray objectAtIndex:indexPath.row - 1];
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.view.bounds), self.view.bounds.size.width, self.tableView.frame.size.height);
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:nil];
            [action startAction];
        }];
        
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (self.titleString.length == 0) {
            return 0;
        }
        return 45.f;
    }
    return 50;
}



#pragma mark - Getter

- (UIEdgeInsets)mySafeArea {
    if (@available(iOS 11.0,*)) {
        return self.view.safeAreaInsets;
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - Getter

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.65;
    }
    return _backView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSMutableArray *)actionArray {
    if (!_actionArray) {
        _actionArray = [[NSMutableArray alloc] init];
    }
    return _actionArray;
}




@end
