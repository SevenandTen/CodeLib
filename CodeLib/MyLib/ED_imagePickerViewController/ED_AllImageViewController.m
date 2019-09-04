//
//  ED_imagePickerViewController.m
//  CodeLib
//
//  Created by zw on 2019/8/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

// 每个Cell 的间隔
#define ED_PictureSpace  5

// 每行展示多少个
#define ED_PictureNumberOfLine   4

#import "ED_AllImageViewController.h"
#import "ED_ImagePickerCell.h"

@interface ED_AllImageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong) UICollectionView *collectView;

@property (nonatomic , strong) NSMutableArray *dataSource;



@end

@implementation ED_AllImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
    // Do any additional setup after loading the view.
}


- (void)configureViews {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.collectView];
    self.collectView.frame = self.contentView.bounds;
    self.collectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ED_ImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ED_ImagePickerCell class]) forIndexPath:indexPath];
    return cell;
}


#pragma mark - Getter

- (UICollectionView *)collectView {
    if (!_collectView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeZero;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = ED_PictureSpace;
        flowLayout.minimumInteritemSpacing = ED_PictureSpace;
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectView.dataSource = self;
        _collectView.delegate = self;
        [_collectView registerClass:[ED_ImagePickerCell class] forCellWithReuseIdentifier:NSStringFromClass([ED_ImagePickerCell class])];
    }
    return _collectView;
}


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end
