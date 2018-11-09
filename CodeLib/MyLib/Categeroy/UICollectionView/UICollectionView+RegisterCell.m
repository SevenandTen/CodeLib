//
//  UICollectionView+RegisterCell.m
//  MyCode
//
//  Created by 崎崎石 on 2018/3/23.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import "UICollectionView+RegisterCell.h"

@implementation UICollectionView (RegisterCell)

- (void)registerCellWithClass:(Class)cls {
    [self registerCellWithClass:cls identifier:nil];
}

- (void)registerCellWithClass:(Class)cls identifier:(NSString *)identifier {
    NSString *clsString = NSStringFromClass(cls);
    if (identifier.length == 0) {
        identifier = clsString;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:clsString ofType:@"nib"];
    if (path.length > 0) {
        [self registerNib:[UINib nibWithNibName:clsString bundle:nil] forCellWithReuseIdentifier:identifier];
     
       
    }else{
        [self registerClass:cls forCellWithReuseIdentifier:identifier];
    }
}

@end
