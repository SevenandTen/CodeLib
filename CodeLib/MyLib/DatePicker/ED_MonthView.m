//
//  ED_MonthView.m
//  CodeLib
//
//  Created by zw on 2018/12/12.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_MonthView.h"
#import "ED_MonthItemCell.h"
@interface ED_MonthView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong) UICollectionView *collectView;

@property (nonatomic , assign) BOOL isFirst;

@property (nonatomic , assign) NSInteger currentIndex;

@end


@implementation ED_MonthView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}


- (void)configureViews {
    self.isFirst = YES;
    [self addSubview:self.collectView];
}


- (void)setBeginMonth:(NSInteger)month {
    self.currentIndex = 480000 + month - 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1000000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ED_MonthItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ED_MonthItemCell class]) forIndexPath:indexPath];
    [cell  refreshCellWithTitle:[NSString stringWithFormat:@"%ld月",(indexPath.row % 12 + 1)]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.itemWidth, self.bounds.size.height);
}

#pragma mark -

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGPoint point = *targetContentOffset;
    CGFloat offsetX = point.x;
    CGFloat contentLeft = self.collectView.contentInset.left;
    NSInteger row = (NSInteger)((offsetX +contentLeft)/ self.itemWidth );
    CGFloat witdh = offsetX + contentLeft - row * self.itemWidth;
    if (witdh > self.itemWidth/2.0) {
        row = row + 1;
       
    }
    CGFloat currentOffsetX = (row )*self.itemWidth - contentLeft;
    *targetContentOffset = CGPointMake(currentOffsetX, point.y);

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    
    CGFloat offSetX = self.collectView.contentOffset.x;
    CGFloat foaltRow = (offSetX + self.collectView.contentInset.left)/self.itemWidth;
    NSInteger row = (int) ((offSetX + self.collectView.contentInset.left)/self.itemWidth);
    if (row + 0.5 < foaltRow) {
        row = row + 1;
    }
    NSInteger lastMonth = self.currentIndex % 12 + 1;
    NSInteger currentMonth = row % 12 + 1;
    NSInteger years = 0;
    BOOL flag = NO;
    if (row == self.currentIndex) {
        return;
    }
    if (row > self.currentIndex) {
        flag = YES;
        NSInteger y = (row - self.currentIndex)/12; // 滑了几年
        NSInteger m = (row - self.currentIndex)%12; // 零几个月;
        years = y;
        if (m + lastMonth > 12) {
            years = years + 1;
        }
        
        
    }else{
        NSInteger y = (self.currentIndex - row)/12; // 滑了几年
        NSInteger m = (self.currentIndex  - row )%12; // 零几个月;
        years = y;
        if (lastMonth - m  <= 0) {
            years = years + 1;
        }
    }
    [self.delegate monthView:self didScrollYears:years isYearIncrease:flag lastMonth:lastMonth currentMonth:currentMonth];
    self.currentIndex = row;
    
}




- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.isFirst) {
        self.isFirst = NO;
        self.collectView.frame = self.bounds;
        [self.collectView setContentInset:UIEdgeInsetsMake(0,self.bounds.size.width/2.0 - self.itemWidth/2.0, 0, - self.bounds.size.width/2.0  + self.itemWidth/2.0)];
        CGFloat offSetX =  self.currentIndex *self.itemWidth - self.collectView.contentInset.left;
        [self.collectView setContentOffset:CGPointMake(offSetX, self.collectView.contentOffset.y) animated:NO];
    }

}



#pragma mark - Getter

- (UICollectionView *)collectView {
    if (!_collectView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeZero;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectView.dataSource = self;
        _collectView.delegate = self;
        _collectView.showsHorizontalScrollIndicator = NO;
        [_collectView registerClass:[ED_MonthItemCell class] forCellWithReuseIdentifier:NSStringFromClass([ED_MonthItemCell class])];
        _collectView.backgroundColor = [UIColor clearColor];
        if (@available(iOS 11.0 , *)) {
            [_collectView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
    }
    return _collectView;
}

- (CGFloat)itemWidth {
    if (!_itemWidth) {
        _itemWidth = 100;
    }
    return _itemWidth;
}

- (NSInteger)currentIndex {
    if (!_currentIndex) {
        _currentIndex = 500000;
    }
    return _currentIndex;
}

@end
