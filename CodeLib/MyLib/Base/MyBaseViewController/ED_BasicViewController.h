 //
//  ED_BasicViewController.h
//  CodeLib
//
//  Created by zw on 2018/10/30.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ED_BasicViewController : UIViewController


/**
 我的安全区
 */
@property (nonatomic , readonly) UIEdgeInsets mySafeArea;


/**
 扩展安全区
 */
@property (nonatomic , readonly) UIEdgeInsets extendMySafeArea;


/**
 系统安全区
 */
@property (nonatomic , readonly) UIEdgeInsets systemSafeArea;



/**
 是否显示导航栏 子类重载方法  defuat YES
 */
@property (nonatomic , readonly) BOOL isShowNavgationBar;


/**
 是否从原点布局 子类重载方法  defuat  NO
 */
@property (nonatomic , readonly) BOOL isLayoutFromOrigin;

/**
 是否显示返回按钮  defuat  yes
 */
@property (nonatomic , readonly) BOOL isShowBaseBackBtn;


/**
 基础视图
 */
@property (nonatomic , strong, readonly) UIView *contentView;


/**
 导航栏
 */
@property (nonatomic, strong , readonly) UINavigationBar *myNavigationBar;

/**
 导航元素
 */
@property (nonatomic, strong , readonly) UINavigationItem *myNavigationItem;



/**
 导航背景颜色
 */
@property (nonatomic , strong , readonly) UIView *myNavigationBGView;





/**
 系统导航栏高度
 */
@property (nonatomic , readonly) CGFloat ed_navgationBarHeight;


/**
 系统 tab 高度
 */
@property (nonatomic , readonly) CGFloat ed_tabBarHeight;


/**
 背景颜色
 */
@property (nonatomic , strong) UIColor *myNavgationBarColor;


/**
 
 */
@property (nonatomic , readonly) NSDictionary *myNavgationItemAttribute;


/**
 导航的设置
 */
@property (nonatomic , readonly) NSDictionary *myNavgationBarTitleAttribute;



/**
 安全区改变
 */
- (void)viewMySafeAreaDidChange;




@end

