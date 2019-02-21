//
//  ED_PageView.m
//  CodeLib
//
//  Created by zw on 2019/2/19.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_PageView.h"
#import "UIScrollView+PageView.h"

@interface ED_PageView ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic , strong) UIScrollView *mainScrollView;


@property (nonatomic , strong) UIScrollView *sideslipScrollView;


@property (nonatomic , strong) UICollectionView *titleView;


@property (nonatomic , strong) NSMutableArray *viewArray;


@property (nonatomic , strong) NSMutableArray *titleArray;


@property (nonatomic , assign) BOOL isFirst;


@property (nonatomic , assign) CGPoint lastPoint;

@property (nonatomic , strong) NSMutableArray *pointArray;








@end


@implementation ED_PageView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}

- (instancetype)initWithDelegate:(id<ED_PageViewHandleDelegate>)delegate {
    if (self = [super initWithFrame:CGRectZero]) {
        self.delegate = delegate;
        _lastPoint = CGPointZero;
        [self configureViews];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.isFirst) {
        self.isFirst = YES;
        [self reloadAll];
    }
    
}

- (void)reloadAll {
    self.mainScrollView.frame = self.bounds;
    CGFloat zeroHeight = [self.delegate zeroPointWithPageView:self];
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    
    self.mainScrollView.contentSize = CGSizeMake(width, height + zeroHeight);
    
    self.titleView.frame = CGRectMake(0 , zeroHeight,width , self.titlHight);
    
    self.sideslipScrollView.frame = CGRectMake(0, zeroHeight + self.titlHight, width, height - self.titlHight);
    for (UIView *view in self.viewArray) {
        [view removeFromSuperview];
    }
    [self.viewArray removeAllObjects];
    [self.pointArray removeAllObjects];
    NSArray *titleArray = [self.delegate titleArrayWithPageView:self];
    self.sideslipScrollView.contentSize = CGSizeMake(titleArray.count *width, 0);
    for (int i = 0; i < titleArray.count; i ++) {
        UITableView *tabelView = [[UITableView alloc] init];
        tabelView.delegate = self;
        tabelView.dataSource = self;
        tabelView.frame = CGRectMake(i * width , 0, width, height - self.titlHight);
        tabelView.someOtherView = self.mainScrollView;
        NSValue *value = [NSValue valueWithCGPoint:CGPointZero];
        [self.pointArray addObject:value];
        [self.sideslipScrollView addSubview:tabelView];
        [self.viewArray addObject:tabelView];
    }
   
}



- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier viewTag:(NSInteger)tag {
    UITableView *tableView = [self.viewArray objectAtIndex:tag];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
    
}

    
 
   



#pragma mark - ConfigureViews

- (void)configureViews {
    //1.外部scrollView;
    [self addSubview:self.mainScrollView];
    
    //2.测滑scrollView;
    
    [self.mainScrollView addSubview:self.sideslipScrollView];
    
    //3.添加 titleView;
    
    [self.mainScrollView addSubview:self.titleView];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger tag = [self.viewArray indexOfObject:tableView];
    return [self.delegate pageView:self numOfRowInSection:section viewTag:tag];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger tag = [self.viewArray indexOfObject:tableView];
    return [self.delegate pageView:self numOfSectionWithViewTag:tag];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger tag = [self.viewArray indexOfObject:tableView];
    return  [self.delegate pageView:self cellForRowAtIndexPath:indexPath viewTag:tag];
}

#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     NSInteger tag = [self.viewArray indexOfObject:tableView];
    [self.delegate pageView:self didSelectRowAtIndexPath:indexPath viewTag:tag];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint point = scrollView.contentOffset;
    if ([scrollView isEqual:self.sideslipScrollView]){


    }else if ([scrollView isEqual:self.titleView]) {

    }else{
        CGFloat num = self.sideslipScrollView.contentOffset.x /self.bounds.size.width;
        NSInteger tag = (NSInteger)(self.sideslipScrollView.contentOffset.x /self.bounds.size.width);
        if (num > tag + 0.5) {
            tag = tag + 1;
        }
        CGFloat zeroHeight = [self.delegate zeroPointWithPageView:self];
        
        
        if ([scrollView isEqual:self.mainScrollView]) {
            if (point.y > zeroHeight) {
                [scrollView setContentOffset:CGPointMake(point.x, zeroHeight)];
                
                return;
                
            }else {
                UIScrollView *subView = [self.viewArray objectAtIndex:tag];
                if (self.lastPoint.y >= point.y) { //下拉
                    if (subView.contentOffset.y != 0) {
                        [scrollView setContentOffset:self.lastPoint];
                        return;
                    }
         
                }else{ //上啦
                    
                }
                 self.lastPoint = point;
            }
            
           
            
            
         
        }else{
            
            CGPoint lastPoint = [[self.pointArray objectAtIndex:tag] CGPointValue];
            if (point.y < 0) {
                [scrollView setContentOffset:CGPointMake(point.x, 0)];
                [self.pointArray replaceObjectAtIndex:tag withObject:[NSValue valueWithCGPoint:CGPointMake(point.x, 0)]];
                return;
            }
            if (lastPoint.y > point.y) { // 下拉
           

            }else { // 上拉
                if (self.mainScrollView.contentOffset.y <zeroHeight) {
                     [scrollView setContentOffset:lastPoint];
                    return;
                    
                }
            }
            
           [self.pointArray replaceObjectAtIndex:tag withObject:[NSValue valueWithCGPoint:CGPointMake(point.x, point.y)]];
            
        }
    }

}








#pragma mark - UICollectionViewDelegate


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.delegate) {
        return [self.delegate titleArrayWithPageView:self].count;
    }
    return 0;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ED_PageTitleCell *cell = [self.titleView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ED_PageTitleCell class]) forIndexPath:indexPath];
    NSString *title = [[self.delegate titleArrayWithPageView:self] objectAtIndex:indexPath.row];
    [cell refreshCellWithTitle:title isSelect:YES];
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.bounds.size.width / [self.delegate titleArrayWithPageView:self].count;
    return CGSizeMake(width, self.titlHight);
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


- (UIScrollView *)sideslipScrollView {
    if (!_sideslipScrollView) {
        _sideslipScrollView = [[UIScrollView alloc] init];
        _sideslipScrollView.contentSize = CGSizeZero;
        _sideslipScrollView.delegate = self;
        if (@available(iOS 11, *)) {
            [_sideslipScrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
        _sideslipScrollView.pagingEnabled = YES;
        _sideslipScrollView.bounces = NO;
    } 
    return _sideslipScrollView;
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
    
    }
    return _titleView;
}


- (CGFloat)titlHight {
    if (!_titlHight) {
        _titlHight = 40;
    }
    return _titlHight;
}

- (NSMutableArray *)viewArray {
    if (!_viewArray) {
        _viewArray = [[NSMutableArray alloc] init];
    }
    return _viewArray;
}

- (NSMutableArray *)pointArray {
    if (!_pointArray) {
        _pointArray = [[NSMutableArray alloc] init];
    }
    return _pointArray;
}

@end





@interface ED_PageTitleCell ()

@property (nonatomic , strong) UILabel *titLabel;

@end


@implementation ED_PageTitleCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titLabel];
    }
    return self;
}

- (void)layoutSubviews {
    self.titLabel.frame = self.bounds;
}

- (void)refreshCellWithTitle:(NSString *)title isSelect:(BOOL)isSelect {
    self.titLabel.text = title;
}

#pragma mark - Getter

- (UILabel *)titLabel {
    if (!_titLabel) {
        _titLabel = [[UILabel alloc] init];
        _titLabel.font = [UIFont systemFontOfSize:15];
        _titLabel.textColor = [UIColor redColor];
        _titLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titLabel;
}




@end



