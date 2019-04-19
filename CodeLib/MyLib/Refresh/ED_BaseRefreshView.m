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
NSString *const ED_RefreshKeyPathAdjustedContentInset = @"adjustedContentInset";


@interface ED_BaseRefreshView ()
{
    __weak UIScrollView *_scrollView;
}

@property (nonatomic , strong) UIPanGestureRecognizer *pan;


@end


@implementation ED_BaseRefreshView

@synthesize scrollView = _scrollView;

@synthesize originContentInset = _originContentInset;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        self.status = ED_RefreshStatusDefuat;
        [self updateContentUI];
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

        self.pan = _scrollView.panGestureRecognizer;
        if (@available(iOS 11.0, *)) {
            _originContentInset = _scrollView.adjustedContentInset;
        }else {
            _originContentInset = _scrollView.contentInset;
        }
        self.alpha = 0;
        
        
        [self addObserver];
    }
    
}



- (void)addObserver {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:ED_RefreshKeyPathContentSize options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:ED_RefreshKeyPathContentOffset options:options context:nil];
    [self.pan addObserver:self forKeyPath:ED_RefreshKeyPathPanState options:options context:nil];
    
    if (@available(iOS 11.0,*)) {
       [self.scrollView addObserver:self forKeyPath:ED_RefreshKeyPathAdjustedContentInset options:options context:nil];
    }
  
    [self.scrollView addObserver:self forKeyPath:ED_RefreshKeyPathContentInset options:options context:nil];
  
    
    

}


- (void)removeObserver {
    [self.superview removeObserver:self forKeyPath:ED_RefreshKeyPathContentSize];
    [self.superview removeObserver:self forKeyPath:ED_RefreshKeyPathContentOffset];
    [self.pan removeObserver:self forKeyPath:ED_RefreshKeyPathPanState];
    [self.superview removeObserver:self forKeyPath:ED_RefreshKeyPathContentInset];
    if (@available(iOS 11.0,*)) {
        [self.superview removeObserver:self forKeyPath:ED_RefreshKeyPathAdjustedContentInset];
    }
    self.pan = nil;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (!self.userInteractionEnabled) {
        return;
    }
    if ([keyPath isEqualToString:ED_RefreshKeyPathContentSize]) {
        [self scrollViewDidChangedContentSize:change];
    }
    if ([keyPath isEqualToString:ED_RefreshKeyPathContentInset]) {
        [self scrollViewDidChangedContentInset:change];
    }
    if ([keyPath isEqualToString:ED_RefreshKeyPathAdjustedContentInset]) {
        [self scrollViewDidChangedAdjustedContentInset:change];
    }
    
    if (self.hidden) {
        return;
    }
    if ([keyPath isEqualToString:ED_RefreshKeyPathPanState]) {
        [self scrollViewPanDidChangedState:change];
    }
    if ([keyPath isEqualToString:ED_RefreshKeyPathContentOffset]) {
        [self scrollViewDidChangedContentOffset:change];
    }
   
}


#pragma mark - Public

- (void)scrollViewDidChangedContentOffset:(NSDictionary *)change {}

- (void)scrollViewPanDidChangedState:(NSDictionary *)change {}

- (void)scrollViewDidChangedContentSize:(NSDictionary *)change {}

- (void)scrollViewDidChangedContentInset:(NSDictionary *)change {}

- (void)scrollViewDidChangedAdjustedContentInset:(NSDictionary *)change {}

- (void)updateContentUI {}

- (void)beginRefreshing {}

- (void)endRefreshing {}

- (void)updateProgress:(CGFloat)progress {
    
}

- (void)placeSubView {
    [self addSubview:self.titleLabel];
    self.titleLabel.frame = self.bounds;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self placeSubView];
}




#pragma mark - Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
