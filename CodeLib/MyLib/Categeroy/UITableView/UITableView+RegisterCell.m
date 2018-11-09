//
//  UITableView+RegisterCell.m
//  MyCode
//
//  Created by 崎崎石 on 2018/2/26.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import "UITableView+RegisterCell.h"

@implementation UITableView (RegisterCell)

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
        [self registerNib:[UINib nibWithNibName:clsString bundle:nil] forCellReuseIdentifier:identifier];
    }else{
        [self registerClass:cls forCellReuseIdentifier:identifier];
    }
}

@end
