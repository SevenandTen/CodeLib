//
//  ED_PictureLibraryViewController.m
//  CodeLib
//
//  Created by zw on 2019/8/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_PictureLibraryViewController.h"
#import <Photos/Photos.h>

@interface ED_PictureLibraryViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) NSMutableArray *dataSource;

@end

@implementation ED_PictureLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myNavigationItem.title = @"相册列表";
    [self configureViews];
    [self loadData];
    // Do any additional setup after loading the view.
}


- (void)configureViews {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
}



- (void)loadData {
    PHFetchResult *systemResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    PHFetchResult *customResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in systemResult) {
        if (collection.estimatedAssetCount != 0) {
            [self.dataSource addObject:collection];
        }
        
    }
    
    for (PHAssetCollection *collection in customResult) {
        if (collection.estimatedAssetCount != 0) {
            [self.dataSource addObject:collection];
        }
    }
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}





#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end
