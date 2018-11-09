//
//  UIViewController+Instance.m
//  MyCode
//
//  Created by 崎崎石 on 2018/1/2.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import "UIViewController+Instance.h"


@implementation UIViewController (Instance)

+ (instancetype)createInstanceWithContext:(NSDictionary *)context object:(id)object {
    NSString *classString = NSStringFromClass([self class]);
    NSString *classSmallString = [NSString stringWithFormat:@"%@@small",NSStringFromClass([self class])];
    UIViewController *viewController = nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:classString ofType:@"nib"];
    NSString *smallPath = [[NSBundle mainBundle] pathForResource:classSmallString ofType:@"nib"];
    
    if ([UIScreen mainScreen].bounds.size.width <= 320) {
        if (smallPath.length > 0) {
            viewController = [[self alloc] initWithNibName:classSmallString bundle:nil];
            [viewController setUpViewControllerWithContext:context object:object];
            return viewController;
        }
        if (path.length > 0){
            viewController = [[self alloc] initWithNibName:classString bundle:nil];
            [viewController setUpViewControllerWithContext:context object:object];
            return viewController;
        }
        
    }else{
        if (path.length > 0) {
            viewController = [[self alloc] initWithNibName:classString bundle:nil];
            [viewController setUpViewControllerWithContext:context object:object];
            return viewController;
        }
        
    }
    if (!viewController) {
        viewController = [[self alloc] init];
    }
    [viewController setUpViewControllerWithContext:context object:object];
    return viewController;
    
}

+ (instancetype)createInstance {
    return [self createInstanceWithContext:nil object:nil];
}

- (void)setUpViewControllerWithContext:(NSDictionary *)context object:(id)object {
    // 子类实现
}


+ (UIViewController *)getRootViewController {
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}
@end
