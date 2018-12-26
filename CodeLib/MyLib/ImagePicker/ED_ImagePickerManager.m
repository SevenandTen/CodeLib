//
//  ED_ImagePickerManager.m
//  CodeLib
//
//  Created by zw on 2018/12/26.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_ImagePickerManager.h"

@interface ED_ImagePickerManager ()

@end

@implementation ED_ImagePickerManager

+ (instancetype)shareInstance {
    static ED_ImagePickerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ED_ImagePickerManager alloc] init];
    });
    return manager;
}

@end
