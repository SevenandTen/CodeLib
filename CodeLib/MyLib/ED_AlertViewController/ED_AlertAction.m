//
//  ED_AlertAction.m
//  SJBJingJiRen
//
//  Created by zw on 2018/8/22.
//  Copyright © 2018年 mzw. All rights reserved.
//

#import "ED_AlertAction.h"

@interface ED_AlertAction()

@property (nonatomic , copy) void(^handle)(void);

@end

@implementation ED_AlertAction

+ (instancetype)actionWithTitle:(NSString *)title handle:(void (^)(void))handle {
    return  [[ED_AlertAction alloc] initWithTitle:title handle:handle];
}


- (instancetype)initWithTitle:(NSString *)title handle:(void (^)(void))handle {
    if (self = [super init]) {
        self.title = title;
        self.handle = handle;
    }
    return self;
}


- (void)startAction {
    if (self.handle) {
        self.handle();
    }
}


@end
