//
//  ED_PageContainCell.m
//  CodeLib
//
//  Created by zw on 2019/2/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_PageContainCell.h"
#import "ED_PageContext.h"
#import "UIScrollView+PageView.h"

@interface  ED_PageContainCell()

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) UICollectionView *collectView;


@property (nonatomic , strong) NSIndexPath *indexPath;


@end


@implementation ED_PageContainCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

#pragma mark - configureViews

- (void)configureViews {
    [self addSubview:self.tableView];
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }else{
        [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
    }
}


- (CGPoint)getCurrentContentOffSet {
    return self.tableView.contentOffset;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@",........................xxxxxxxxxx");
    CGPoint point = self.tableView.contentOffset;
    ED_PageContext *otherContext = [[ED_PageContextManager shareIntance].dataSource objectAtIndex:self.indexPath.row];
    CGPoint lastPoint = otherContext.lastPoint;

    if (point.y == 0 || point.y == lastPoint.y) {
        return;
    }

    if (point.y < 0) {
        [self.tableView setContentOffset:CGPointMake(point.x, 0)];
        otherContext.lastPoint = CGPointMake(point.x, 0);
        return;
        
    }
    
    
    if (self.tableView.someOtherView) {
        if (lastPoint.y > point.y) { // 下拉
           
        }else{
            if (self.tableView.someOtherView.contentOffset.y < [ED_PageContextManager shareIntance].zeroHeight) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView setContentOffset:lastPoint];
                });
                
                return;
            }
           
        }
    }
     otherContext.lastPoint = point;
    
    
    
    // tableView 
    
}


- (void)refreshCellWithIndexPath:(NSIndexPath *)indexPath scrollView:(UIScrollView *)scrollView {
    self.indexPath = indexPath;
    self.tableView.someOtherView = nil;
    
    ED_PageContext *context = [[ED_PageContextManager shareIntance].dataSource objectAtIndex:indexPath.row];
    [self.tableView setContentOffset:context.lastPoint];
    
    
    
    self.tableView.someOtherView = scrollView;
    
    
    
}

#pragma mark - Getter


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = [ED_PageContextManager shareIntance].delegate;
        _tableView.dataSource = [ED_PageContextManager shareIntance].delegate;
    }
    return _tableView;
}



@end
