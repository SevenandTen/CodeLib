//
//  ED_PageView.m
//  CodeLib
//
//  Created by zw on 2019/2/19.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_PageView.h"
#import "UIScrollView+PageView.h"
#import "ED_PageContext.h"
#import "ED_PageTitleCell.h"
#import "ED_PageContainCell.h"

@interface ED_PageView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic , strong) UIScrollView *mainScrollView;

@property (nonatomic , strong) UICollectionView *titleView;

@property (nonatomic , strong) UICollectionView *containView;





@property (nonatomic , strong) UIView *lineView;

@property (nonatomic , strong) UIView *topLineView;

@property (nonatomic , strong) UIView *bottomLineView;





@end


@implementation ED_PageView



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectZero]) {
        [self configureViews];
    }
    return self;
}


#pragma mark - ConfigureViews

- (void)configureViews {
    //1.外部scrollView;
    [self addSubview:self.mainScrollView];

    [self.mainScrollView addSubview:self.titleView];
    
    [self.mainScrollView addSubview:self.containView];
    
    [self.titleView addSubview:self.topLineView];
    [self.titleView addSubview:self.bottomLineView];
    [self.titleView addSubview:self.lineView];


}


- (void)layoutSubviews {
    [super layoutSubviews];
    ED_PageContextManager *manager = [ED_PageContextManager shareIntance];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    self.mainScrollView.frame = self.bounds;
    self.mainScrollView.contentSize = CGSizeMake(width, height + [ED_PageContextManager shareIntance].zeroHeight);
    self.titleView.frame = CGRectMake(0, manager.zeroHeight, width, manager.titleHeight);
    
    self.containView.frame = CGRectMake(0, manager.zeroHeight + manager.titleHeight, width, height - manager.titleHeight);
    
    self.topLineView.frame = CGRectMake(0, 0, self.titleView.frame.size.width, 1/[UIScreen mainScreen].scale);
    
    self.bottomLineView.frame = CGRectMake(0, self.titleView.frame.size.height - 1 /[UIScreen mainScreen].scale, self.titleView.frame.size.width, 1/[UIScreen mainScreen].scale);
    self.topLineView.backgroundColor = [ED_PageContextManager shareIntance].lineColor;
    self.bottomLineView.backgroundColor = [ED_PageContextManager shareIntance].lineColor;
  

    CGFloat lineWidth =  [ED_PageContextManager shareIntance].lineWidth;
    CGFloat itemWidth =  0;
    
 
    self.lineView.backgroundColor = [ED_PageContextManager shareIntance].seletColor;
    if ([ED_PageContextManager shareIntance].totalWidth > self.titleView.frame.size.width) {
        itemWidth = [ED_PageContextManager shareIntance].itemWidth;
       
    }else {
        itemWidth = self.titleView.frame.size.width / [ED_PageContextManager shareIntance].dataSource.count;
    }
      self.lineView.frame = CGRectMake((itemWidth - lineWidth)/2, self.titleView.frame.size.height - 2, lineWidth, 2);
   

    
}



#pragma mark - UICollectionViewDelegate


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [ED_PageContextManager shareIntance].dataSource.count;
    
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.titleView isEqual:collectionView]) {
        ED_PageTitleCell *cell = [self.titleView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ED_PageTitleCell class]) forIndexPath:indexPath];
        BOOL flag = ([ED_PageContextManager shareIntance].currentIndex == indexPath.row);
        [cell refreshCellWithIndexPath:indexPath isSelected:flag];
        return cell;
    }
    ED_PageContainCell *containCell =  [self.containView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ED_PageContainCell class]) forIndexPath:indexPath];
    [containCell refreshCellWithIndexPath:indexPath scrollView:self.mainScrollView];
    
    return containCell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.titleView isEqual:collectionView]) {
        [self.containView setContentOffset:CGPointMake(self.containView.frame.size.width * indexPath.row, 0) animated:YES];
      
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.titleView]) {
        NSLog(@"%f",[ED_PageContextManager shareIntance].totalWidth);
        CGFloat width = self.titleView.frame.size.width;
        if (width >= [ED_PageContextManager shareIntance].totalWidth) {
            return CGSizeMake(width/[ED_PageContextManager shareIntance].dataSource.count, self.titleView.frame.size.height);
        }else{
          
            return CGSizeMake([ED_PageContextManager shareIntance].itemWidth, self.titleView.frame.size.height);
        }
        
    }
    return self.containView.frame.size;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint point = scrollView.contentOffset;
    if ([scrollView isEqual:self.mainScrollView]) {
        CGFloat zeroHeight = [ED_PageContextManager shareIntance].zeroHeight;
        if (point.y > zeroHeight) {
            [scrollView setContentOffset:CGPointMake(point.x,zeroHeight)];
            [ED_PageContextManager shareIntance].lastPoint = CGPointMake(point.x,zeroHeight);
        }else{
            CGPoint lastPoint = [ED_PageContextManager shareIntance].lastPoint;
            if (lastPoint.y >= point.y) { //下拉
                ED_PageContainCell *cell = (ED_PageContainCell *) [self.containView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:[ED_PageContextManager shareIntance].currentIndex inSection:0]];
                CGPoint contentOffSet = [cell getCurrentContentOffSet];
                if (contentOffSet.y != 0) {

                    [scrollView setContentOffset:lastPoint];
                    return;
                }
            }else{ // 上啦

            }
            [ED_PageContextManager shareIntance].lastPoint = point;
        }

    }else if ([scrollView isEqual:self.containView]) {
        CGFloat num = point.x / self.containView.frame.size.width;
        CGFloat itemWidth = 0;
        CGFloat lineWidth = [ED_PageContextManager shareIntance].lineWidth;
        if ([ED_PageContextManager shareIntance].totalWidth > self.containView.frame.size.width) {
             itemWidth = [ED_PageContextManager shareIntance].itemWidth;
        }else{
            itemWidth = self.titleView.frame.size.width / [ED_PageContextManager shareIntance].dataSource.count;
        }
         self.lineView.frame = CGRectMake((itemWidth - lineWidth)/2 + num *itemWidth, self.lineView.frame.origin.y, self.lineView.frame.size.width, self.lineView.frame.size.height);
        
        
    
        
    }
    
    

}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self  scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.containView]) {
        CGPoint point = scrollView.contentOffset;
        CGFloat width = self.containView.frame.size.width;
        CGFloat indexFloat = point.x /width;
        NSInteger indexInt = (NSInteger)(point.x/ width);
        if (indexFloat > indexInt + 0.5) {
            indexInt = indexInt + 1;
        }
        [ED_PageContextManager shareIntance].currentIndex = indexInt;
        [self.titleView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:[ED_PageContextManager shareIntance].currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        [self.titleView reloadData];
    }
   
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

#pragma mark - Getter


- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]  init];
        _mainScrollView.contentSize = CGSizeZero;
        _mainScrollView.delegate = self;
        if (@available(iOS 11, *)) {
            [_mainScrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
    }
    return _mainScrollView;
}


- (UICollectionView *)titleView {
    if (!_titleView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeZero;
        layout.minimumLineSpacing = 0 ;
        layout.minimumInteritemSpacing = 0;
        _titleView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _titleView.dataSource = self;
        _titleView.delegate = self;
        [_titleView registerClass:[ED_PageTitleCell class] forCellWithReuseIdentifier:NSStringFromClass([ED_PageTitleCell class])];
        _titleView.backgroundColor = [UIColor whiteColor];

    }
    return _titleView;

}

- (UICollectionView *)containView {
    if (!_containView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeZero;
        layout.minimumLineSpacing = 0 ;
        layout.minimumInteritemSpacing = 0;
        _containView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _containView.dataSource = self;
        _containView.delegate = self;
        [_containView registerClass:[ED_PageTitleCell class] forCellWithReuseIdentifier:NSStringFromClass([ED_PageTitleCell class])];
        _containView.backgroundColor = [UIColor whiteColor];
        _containView.pagingEnabled = YES;
        [_containView registerClass:[ED_PageContainCell class] forCellWithReuseIdentifier:NSStringFromClass([ED_PageContainCell class])];
        
    }
    return _containView;
}





- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
    }
    return _lineView;
}


- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    }
    return _topLineView;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    }
    return _bottomLineView ;
}



@end






