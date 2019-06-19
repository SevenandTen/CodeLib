//
//  ED_BasicViewController.m
//  CodeLib
//
//  Created by zw on 2018/10/30.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_BasicViewController.h"

@interface ED_BasicViewController ()
{
    UIColor * _myNavgationBarColor;
    
}

@property (nonatomic , strong) UIButton *myBackBtn;

@end

@implementation ED_BasicViewController

@synthesize contentView = _contentView;

@synthesize myNavigationItem = _myNavigationItem;

@synthesize myNavigationBar = _myNavigationBar;

@synthesize myNavigationBGView = _myNavigationBGView;

#pragma mark - Init

- (void)viewDidLoad {
    [super viewDidLoad];
    // 隐藏系统导航栏
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
    [self configureViews_Basic];
    [self initialization_Basic];
}



- (void)configureViews_Basic {
    if (self.nibName.length) {
        _contentView = self.view;
        self.view = [[UIView alloc] initWithFrame:_contentView.frame];
    }
    UIView *someView = [[UIView alloc] init];
    [self.view addSubview:someView];
    [self.view addSubview:self.contentView];
    self.contentView.frame = self.view.bounds;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    if (self.isShowNavgationBar) {
        [self.view addSubview:self.myNavigationBGView];
        [self.view addSubview:self.myNavigationBar];
        [self.myNavigationBar pushNavigationItem:self.myNavigationItem animated:NO];
        
        if (self.isShowBaseBackBtn) {
            self.myNavigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"normal_back_btn"] style:UIBarButtonItemStyleDone target:self action:@selector(didClickBaseBack)];
        }
        
    }
    
}


- (void)initialization_Basic {
    [self.myNavigationBar setTitleTextAttributes:self.myNavgationBarTitleAttribute];
    self.myNavigationBGView.backgroundColor = self.myNavgationBarColor;
    [self.myNavigationBar setBackgroundImage:[[UIImage alloc] init]forBarMetrics:UIBarMetricsDefault];
    [self.myNavigationBar setTintColor:[UIColor whiteColor]];
    self.myNavigationBar.backgroundColor = [UIColor clearColor];
    
    
}




- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    [self viewMySafeAreaDidChange];
  
}


- (void)viewMySafeAreaDidChange {
    if (self.isShowNavgationBar) {
        if (self.isLayoutFromOrigin) {
            self.myNavigationBGView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.mySafeArea.top);
            self.myNavigationBGView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
            self.myNavigationBar.frame = CGRectMake(0, self.systemSafeArea.top, self.view.bounds.size.width, self.ed_navgationBarHeight);
            self.myNavigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
            
        }else{
            self.myNavigationBGView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.mySafeArea.top);
            self.myNavigationBGView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
            self.myNavigationBar.frame = CGRectMake(0, self.systemSafeArea.top, self.view.bounds.size.width, self.ed_navgationBarHeight);
            self.myNavigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
            self.contentView.frame = CGRectMake(0, self.mySafeArea.top, self.view.bounds.size.width, self.view.bounds.size.height - self.mySafeArea.top);
            self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        }
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self viewMySafeAreaDidChange];
}

#pragma mark - Action

- (void)didClickBaseBack {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}




#pragma mark - Getter Public

- (BOOL)isShowNavgationBar {
    return YES;
}

- (BOOL)isLayoutFromOrigin {
    return NO;
}

- (CGFloat)ed_navgationBarHeight {
    return [[UINavigationController alloc] init].navigationBar.frame.size.height;
}

- (CGFloat)ed_tabBarHeight {
    return [[UITabBarController alloc] init].tabBar.frame.size.height;
}


- (NSDictionary *)myNavgationBarTitleAttribute {
    return @{NSForegroundColorAttributeName : [UIColor whiteColor] , NSFontAttributeName : [UIFont systemFontOfSize:17]};
}

- (NSDictionary *)myNavgationItemAttribute {
    return @{NSForegroundColorAttributeName : [UIColor whiteColor] , NSFontAttributeName : [UIFont systemFontOfSize:15]};
}

- (BOOL)isShowBaseBackBtn {
    return YES;
}



#pragma mark - Getter safeArea

//系统安全区

- (UIEdgeInsets)systemSafeArea {
    if (@available(iOS 11.0 , *)) {
        return self.view.safeAreaInsets;
    }
    CGFloat bottom = 0;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden) {
        bottom = self.ed_tabBarHeight;
    }
    return UIEdgeInsetsMake(20, 0, 0, bottom);
}

- (UIEdgeInsets)mySafeArea {
    CGFloat top = self.systemSafeArea.top + self.extendMySafeArea.top;
    CGFloat bottom = self.systemSafeArea.bottom + self.extendMySafeArea.bottom;
    CGFloat left = self.systemSafeArea.left + self.extendMySafeArea.left;
    CGFloat right = self.systemSafeArea.right + self.extendMySafeArea.right;
    if (self.isShowNavgationBar) {
        top = top + self.ed_navgationBarHeight;
    }
    return UIEdgeInsetsMake(top, left, bottom, right);
}


- (UIEdgeInsets)extendMySafeArea {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark - Getter  UI

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UINavigationItem *)myNavigationItem {
    if (!_myNavigationItem) {
        _myNavigationItem = [[UINavigationItem alloc] init];
    }
    return _myNavigationItem;
}

- (UINavigationBar *)myNavigationBar {
    if (!_myNavigationBar) {
        _myNavigationBar = [[UINavigationBar alloc] init];
    }
    return _myNavigationBar;
}

- (UIView *)myNavigationBGView {
    if (!_myNavigationBGView) {
        _myNavigationBGView = [[UIView alloc] init];
    }
    return _myNavigationBGView;
}

- (UIButton *)myBackBtn {
    if (!_myBackBtn) {
        _myBackBtn = [[UIButton alloc] init];
        [_myBackBtn setImage:[UIImage imageNamed:@"normal_back_btn@2x"] forState:UIControlStateNormal];
        [_myBackBtn addTarget:self action:@selector(didClickBaseBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myBackBtn;
}

- (UIColor *)myNavgationBarColor {
    if (!_myNavgationBarColor) {
        _myNavgationBarColor = [UIColor colorWithRed:28/255.0 green:196/255.0 blue:102/255.0 alpha:1];
    }
    return _myNavgationBarColor;
}

- (void)setMyNavgationBarColor:(UIColor *)myNavgationBarColor {
    _myNavgationBarColor = myNavgationBarColor;
    self.myNavigationBGView.backgroundColor = _myNavgationBarColor;
}


@end
