//
//  ED_EnviromentView.m
//  CodeLib
//
//  Created by zw on 2019/5/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_EnviromentView.h"
#import "ED_EnvironmentManager.h"
@interface ED_EnviromentView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) NSArray *dataSource;

@property (nonatomic , strong) UILabel *tipLabel;

@property (nonatomic , strong) UIView *backView;

@end


@implementation ED_EnviromentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame ]) {
        self.backgroundColor = [UIColor whiteColor];
        [self configureViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backView.frame = self.bounds;
    self.tipLabel.frame = CGRectMake(12, 0, self.bounds.size.width - 20, 30);
    self.tableView.frame = CGRectMake(12, 30, self.bounds.size.width - 24, self.bounds.size.height - 30);
}

- (void)configureViews {
    [self addSubview:self.tipLabel];
    [self addSubview:self.backView];
    self.tipLabel.text = [NSString stringWithFormat:@"%@",[ED_EnvironmentManager shareInstance].currentEnviromentName];
    
    [self addSubview:self.tableView];
}


+ (void)show {
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    ED_EnviromentView *view = [[ED_EnviromentView alloc] initWithFrame:window.bounds];
    [window addSubview:view];
   
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"name"];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    NSNumber *number = [dic objectForKey:@"value"];
    [self removeFromSuperview];
    [[ED_EnvironmentManager shareInstance] changeEnviromentWithNumber:number];
    
}


#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = [UIColor redColor];
    }
    return _tipLabel;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.4;
        
    }
    return _backView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ED_EnvironmentManager" ofType:@"plist"];
        _dataSource = [NSArray arrayWithContentsOfFile:path];
    }
    return _dataSource;
}

@end
