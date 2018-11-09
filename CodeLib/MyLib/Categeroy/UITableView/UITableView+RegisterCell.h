//
//  UITableView+RegisterCell.h
//  MyCode
//
//  Created by 崎崎石 on 2018/2/26.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (RegisterCell)

- (void)registerCellWithClass:(Class)cls;

- (void)registerCellWithClass:(Class)cls identifier:(NSString *)identifier;

@end
