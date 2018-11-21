//
//  ED_BaseRefreshView.h
//  CodeLib
//
//  Created by zw on 2018/11/9.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,ED_RefreshStatus) {
    ED_RefreshStatusDefuat = 1, // 初开始状态  即提示下拉刷新
    ED_RefreshStatusWillStartRefresh, // 将要进入刷新状态   即提示 松开立即刷新
    ED_RefreshStatusRefreshing, // 正在刷新   即提示 刷新中 或者 正在刷新
    ED_RefreshStatusEndRefresh, // 刷新完成  即提示刷新完毕
    
};

@class ED_BaseRefreshView;
@protocol ED_BaseRefreshViewDelegate <NSObject>


@optional

- (void)refreshViewBeginRefreshHeader:(ED_BaseRefreshView *)refreshView;

- (void)refreshViewBeginRefreshFooter:(ED_BaseRefreshView *)refreshView;



@end


@interface ED_BaseRefreshView : UIView

{
     UIEdgeInsets _originContentInset;
}


/**
 父视图 必须要滑动视图
 */
@property (nonatomic , readonly) UIScrollView *scrollView;


/**
 最初的 contentInset
 */
@property (nonatomic , readonly) UIEdgeInsets originContentInset;


/**
 刷新状态
 */
@property (nonatomic , assign) ED_RefreshStatus status;

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , weak) id<ED_BaseRefreshViewDelegate> delegate;

@property (nonatomic , copy) void(^complete)(void);


- (void)beginRefreshing;


- (void)endRefreshing;



- (void)placeSubView;

- (void)scrollViewDidChangedContentSize:(NSDictionary *)change;


- (void)scrollViewDidChangedContentOffset:(NSDictionary *)change;


- (void)scrollViewPanDidChangedState:(NSDictionary *)change;


- (void)scrollViewDidChangedContentInset:(NSDictionary *)change;


- (void)scrollViewDidChangedAdjustedContentInset:(NSDictionary *)change;


- (void)updateContentUI;


@end


