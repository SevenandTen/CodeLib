//
//  UICollectionView+RegisterCell.h
//  MyCode
//
//  Created by 崎崎石 on 2018/3/23.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (RegisterCell)

- (void)registerCellWithClass:(Class)cls;

- (void)registerCellWithClass:(Class)cls identifier:(NSString *)identifier;

@end
