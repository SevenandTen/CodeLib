//
//  ED_BaseRefreshView.m
//  CodeLib
//
//  Created by zw on 2018/11/9.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_BaseRefreshView.h"


NSString *const ED_RefreshKeyPathContentOffset = @"contentOffset";
NSString *const ED_RefreshKeyPathContentInset = @"contentInset";
NSString *const ED_RefreshKeyPathContentSize = @"contentSize";
NSString *const ED_RefreshKeyPathPanState = @"state";

@interface ED_BaseRefreshView ()
{
    __weak UIScrollView *_scrollView;
}

@property (nonatomic , strong) UIPanGestureRecognizer *pan;

@end


@implementation ED_BaseRefreshView

@synthesize scrollView = _scrollView;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    [self removeObserver];
    if (newSuperview) {
        _scrollView = (UIScrollView *)newSuperview;
        _scrollView.alwaysBounceVertical = YES;
        
        
        [self addObserver];
    }
    
}



- (void)addObserver {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:ED_RefreshKeyPathContentSize options:options context:nil];
    
    
}


- (void)removeObserver {
    
}




@end
