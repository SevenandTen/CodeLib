//
//  ED_RefreshNormalFooter.m
//  CodeLib
//
//  Created by zw on 2018/11/21.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_RefreshNormalFooter.h"

@interface ED_RefreshNormalFooter ()

@property (nonatomic , assign) BOOL isFirst;

@end

@implementation ED_RefreshNormalFooter


- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && [newSuperview isKindOfClass: [UIScrollView class]]) {
        self.isFirst = YES;
        if (self.footerHeight == 0) {
            self.footerHeight = 40;
        }
        if (self.scrollView.contentSize.height + self.originContentInset.top + self.originContentInset.bottom < self.scrollView.bounds.size.height  ) { // 内容小于屏幕
            self.frame = CGRectMake(0, self.scrollView.bounds.size.height - self.originContentInset.top, self.scrollView.bounds.size.width, self.footerHeight);
   
        }else{
            if (self.isFromLast) { //
                self.frame = CGRectMake(0, self.scrollView.contentSize.height + self.originContentInset.bottom , self.scrollView.bounds.size.width, self.footerHeight);
            }else{
                self.frame = CGRectMake(0, self.scrollView.contentSize.height, self.scrollView.bounds.size.width, self.footerHeight);
            }
        }
        
    }
}

- (void)scrollViewDidChangedContentOffset:(NSDictionary *)change {
    [super scrollViewDidChangedContentOffset:change];
    
    if (self.status == ED_RefreshStatusRefreshing) {
        return;
    }
    
    [self updateAlpha];
    CGFloat offsetY = self.scrollView.contentOffset.y;
    CGFloat happenY1 = 0;
    CGFloat happenY2 = 0;
    if (self.scrollView.contentSize.height + self.originContentInset.top + self.originContentInset.bottom < self.scrollView.bounds.size.height) { // 内容小于屏幕
        happenY1 = - self.originContentInset.top;
    }else{
        happenY1 = self.scrollView.contentSize.height + self.originContentInset.bottom - self.scrollView.bounds.size.height;
    }
    happenY2 = happenY1 + self.footerHeight;
    
    if (self.scrollView.isDragging) {
        if (self.status == ED_RefreshStatusDefuat && offsetY >= happenY2) {
            self.status = ED_RefreshStatusWillStartRefresh;
            [self updateContentUI];
        }else if (self.status == ED_RefreshStatusWillStartRefresh && offsetY < happenY2) {
            self.status = ED_RefreshStatusDefuat;
            [self updateContentUI];
        }
    }else if (self.status == ED_RefreshStatusWillStartRefresh) {
        self.status = ED_RefreshStatusRefreshing;
        [self updateContentUI];
        CGFloat space = self.scrollView.bounds.size.height - self.scrollView.contentSize.height - self.originContentInset.top - self.originContentInset.bottom;
        if (space < 0) {
            space = 0;
        }
        
        CGFloat insetBottom = self.originContentInset.bottom;
        if (@available(iOS 11.0, *)) {
            insetBottom = insetBottom - (self.scrollView.adjustedContentInset.bottom - self.scrollView.contentInset.bottom);
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.scrollView setContentInset:UIEdgeInsetsMake(self.scrollView.contentInset.top, self.scrollView.contentInset.left, insetBottom + self.footerHeight + space, self.scrollView.contentInset.right)];
            [self.scrollView setContentOffset:CGPointMake(0,happenY2) animated:NO];
        } completion:^(BOOL finished) {
            if (self.complete) {
                self.complete();
            }else {
                [self.delegate refreshViewBeginRefreshFooter:self];
            }
        }];
    }
}


- (void)endRefreshing {
    self.status = ED_RefreshStatusEndRefresh;
    [self updateContentUI];
    CGFloat happenY1 = 0;
    CGFloat happenY2 = 0;
    
    if (self.scrollView.contentSize.height + self.originContentInset.top + self.originContentInset.bottom < self.scrollView.bounds.size.height) { // 内容小于屏幕
//        space = self.scrollView.bounds.size.height - self.scrollView.contentSize.height - self.originContentInset.top - self.originContentInset.bottom;
        happenY1 = - self.originContentInset.top;
    }else{
        happenY1 = self.scrollView.contentSize.height + self.originContentInset.bottom - self.scrollView.bounds.size.height;
    }
    happenY2 = happenY1 + self.footerHeight;
    
    CGFloat insetBottom  = self.originContentInset.bottom ;
    if (@available(iOS 11.0, *)) {
        insetBottom = insetBottom - (self.scrollView.adjustedContentInset.bottom - self.scrollView.contentInset.bottom);
    }
    [UIView animateWithDuration:0.5 animations:^{
        [self.scrollView setContentInset:UIEdgeInsetsMake(self.scrollView.contentInset.top, self.scrollView.contentInset.left, insetBottom, self.scrollView.contentInset.right)];
//        [self.scrollView setContentOffset:CGPointMake(0,happenY1 ) animated:NO];
    } completion:^(BOOL finished) {
        self.status = ED_RefreshStatusDefuat;
        [self updateContentUI];
    }];
    
    
}

- (void)updateContentUI {
    if (self.status == ED_RefreshStatusDefuat) {
        self.titleLabel.text = @"上拉可以加载更多";
    }
    if (self.status == ED_RefreshStatusWillStartRefresh) {
        self.titleLabel.text = @"松开立即加载更多";
        
    }
    if (self.status == ED_RefreshStatusRefreshing) {
        self.titleLabel.text = @"正在加载更多";
       
    }
    if (self.status == ED_RefreshStatusEndRefresh) {
        self.titleLabel.text = @"刷新完毕";
     
    }
    
}


- (void)scrollViewDidChangedContentSize:(NSDictionary *)change {
    [super scrollViewDidChangedContentSize:change];
    if (self.scrollView.contentSize.height + self.originContentInset.top + self.originContentInset.bottom < self.scrollView.bounds.size.height  ) { // 内容小于屏幕
        self.frame = CGRectMake(0, self.scrollView.bounds.size.height - self.originContentInset.top, self.scrollView.bounds.size.width, self.footerHeight);
        
    }else{
        if (self.isFromLast) { //
            self.frame = CGRectMake(0, self.scrollView.contentSize.height + self.originContentInset.bottom , self.scrollView.bounds.size.width, self.footerHeight);
        }else{
            self.frame = CGRectMake(0, self.scrollView.contentSize.height, self.scrollView.bounds.size.width, self.footerHeight);
        }
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
        
        if (self.scrollView.contentSize.height + self.originContentInset.top + self.originContentInset.bottom < self.scrollView.bounds.size.height  ) { // 内容小于屏幕
            self.frame = CGRectMake(0, self.scrollView.bounds.size.height - self.originContentInset.top, self.scrollView.bounds.size.width, self.footerHeight);
            
        }else{
            if (self.isFromLast) { //
                self.frame = CGRectMake(0, self.scrollView.contentSize.height + self.originContentInset.bottom , self.scrollView.bounds.size.width, self.footerHeight);
            }else{
                self.frame = CGRectMake(0, self.scrollView.contentSize.height, self.scrollView.bounds.size.width, self.footerHeight);
            }
        }
        [self updateAlpha];
    }
    
}

#pragma mark - Private

- (void)updateAlpha {
    CGFloat offsetY = self.scrollView.contentOffset.y;
    CGFloat happenY1 = 0;
    CGFloat happenY2 = 0;
    if (self.scrollView.contentSize.height + self.originContentInset.top + self.originContentInset.bottom < self.scrollView.bounds.size.height) { // 内容小于屏幕
        happenY1 = - self.originContentInset.top;
    }else{
        happenY1 = self.scrollView.contentSize.height + self.originContentInset.bottom - self.scrollView.bounds.size.height;
    }
    happenY2 = happenY1 + self.footerHeight;
    
    if (offsetY <= happenY1) {
        self.alpha = 0;
    } else if (offsetY > happenY2) {
        self.alpha = 1;
    } else {
        self.alpha = (offsetY - happenY1)/self.footerHeight;
    }
    
}




@end
