//
//  ED_RefreshNormalHeader.m
//  CodeLib
//
//  Created by zw on 2018/11/20.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_RefreshNormalHeader.h"

@interface ED_RefreshNormalHeader ()

@property (nonatomic , assign) BOOL isFirst;


@end

@implementation ED_RefreshNormalHeader

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && [newSuperview isKindOfClass: [UIScrollView class]]) {
        self.isFirst = YES;
        if (self.headerHeight == 0) {
            self.headerHeight = 50;
        }
        if (self.isFromOrigin) {
            self.frame = CGRectMake(0, - self.headerHeight, self.scrollView.frame.size.width, self.headerHeight);
        }else{
            self.frame = CGRectMake(0 , - self.originContentInset.top - self.headerHeight, self.scrollView.frame.size.width, self.headerHeight);
        }
    }
}


- (void)scrollViewDidChangedContentOffset:(NSDictionary *)change {
    [super scrollViewDidChangedContentOffset:change];
    CGFloat offSetY = self.scrollView.contentOffset.y;
    CGFloat happenY1 = - self.originContentInset.top;
    CGFloat happenY2 = happenY1 - self.headerHeight;
    if (self.status == ED_RefreshStatusRefreshing) {
        //处理section 头的停留问题
        // 下拉  offSetY < happenY2  不管
        if (offSetY <= happenY2) {
            return;
        }
        //上滑会置顶
        CGFloat insetTop ;
        if ( offSetY <= happenY1) {
            insetTop = offSetY * (-1);
        }else{
            insetTop = happenY1 * (-1);
        }
        if (@available(iOS 11.0 , *)) {
            insetTop = insetTop - (self.scrollView.adjustedContentInset.top - self.scrollView.contentInset.top);
        }
        [self.scrollView setContentInset:UIEdgeInsetsMake(insetTop, self.originContentInset.left, self.originContentInset.bottom, self.originContentInset.right)];
        return;
    }
    [self updateAlpha];
    if (self.scrollView.isDragging) {
        if (self.status == ED_RefreshStatusDefuat && offSetY <= happenY2 ) {
            // 下拉刷新变成 松开刷新
            self.status =  ED_RefreshStatusWillStartRefresh;
            [self updateContentUI];
        }else if (self.status == ED_RefreshStatusWillStartRefresh && offSetY > happenY2){
            self.status = ED_RefreshStatusDefuat;
            // 松开刷新变成 下拉刷新
            [self updateContentUI];
        }
    }else if (self.status == ED_RefreshStatusWillStartRefresh) {
        self.status = ED_RefreshStatusRefreshing;
        [self updateContentUI];
    }

}



- (void)updateContentUI {
    if (self.status == ED_RefreshStatusDefuat) {
        self.titleLabel.text = @"下拉可以刷新";
    }
    if (self.status == ED_RefreshStatusWillStartRefresh) {
        self.titleLabel.text = @"松开立即刷新";
        
    }
    
    if (self.status == ED_RefreshStatusRefreshing) {
        self.titleLabel.text = @"正在刷新";
        CGFloat insetTop = self.originContentInset.top;
        if (@available(iOS 11.0, *)) {
            insetTop = insetTop - (self.scrollView.adjustedContentInset.top - self.scrollView.contentInset.top);
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.scrollView setContentInset:UIEdgeInsetsMake(insetTop + self.headerHeight, self.originContentInset.left, self.originContentInset.bottom, self.originContentInset.right)];
            [self.scrollView setContentOffset:CGPointMake(0,- self.originContentInset.top - self.headerHeight) animated:NO];
        } completion:^(BOOL finished) {
            if (self.complete) {
                self.complete();
            }else {
                 [self.delegate refreshViewBeginRefreshHeader:self];
            }
        }];
    }
    if (self.status == ED_RefreshStatusEndRefresh) {
        self.titleLabel.text = @"刷新完毕";
        CGFloat insetTop  = self.originContentInset.top;
        if (@available(iOS 11.0, *)) {
            insetTop = insetTop - (self.scrollView.adjustedContentInset.top - self.scrollView.contentInset.top);
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.scrollView setContentInset:UIEdgeInsetsMake(insetTop, self.originContentInset.left, self.originContentInset.bottom, self.originContentInset.right)];
            [self.scrollView setContentOffset:CGPointMake(0,- self.originContentInset.top ) animated:NO];
        } completion:^(BOOL finished) {
            self.status = ED_RefreshStatusDefuat;
            [self updateContentUI];
        }];
    }
}

#pragma mark - Public

- (void)endRefreshing {
    self.status = ED_RefreshStatusEndRefresh;
    [self updateContentUI];
}



#pragma mark - Private

- (void)updateAlpha {
    CGFloat offSetY = self.scrollView.contentOffset.y;
    CGFloat happenY1 = - self.originContentInset.top;
    CGFloat happenY2 = happenY1 - self.headerHeight;
    if (offSetY <= happenY2) {
        self.alpha = 1;
    }else if (offSetY >= happenY1) {
        self.alpha = 0;
    }else{
        self.alpha = (offSetY - happenY1)/(happenY2 - happenY1);
    }
}




- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isFirst) {
        self.isFirst = NO;
        if (@available(iOS 11.0 , *)) {
            _originContentInset = self.scrollView.adjustedContentInset;
        }else{
            _originContentInset = self.scrollView.contentInset;
        }
        if (self.isFromOrigin) {
            self.frame = CGRectMake(0, - self.headerHeight, self.scrollView.frame.size.width, self.headerHeight);
        }else{
            self.frame = CGRectMake(0 , - self.originContentInset.top - self.headerHeight, self.scrollView.frame.size.width, self.headerHeight);
        }
        [self updateAlpha];
    }
    
}


@end
