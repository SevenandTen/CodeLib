//
//  UIView+Instance.m
//  MyCode
//
//  Created by 崎崎石 on 2017/12/29.
//  Copyright © 2017年 崎崎石. All rights reserved.
//

#import "UIView+Instance.h"

@implementation UIView (Instance)

+ (NSString *)defaultIdentifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)createInstanceWithContext:(NSDictionary *)context object:(id)object {
    NSString *classString = NSStringFromClass([self class]);
    NSString *classSmallString = [NSString stringWithFormat:@"%@@small",NSStringFromClass([self class])];
    UIView *view = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:classString ofType:@"nib"];
    NSString *smallPath = [[NSBundle mainBundle] pathForResource:classSmallString ofType:@"nib"];
    if ([UIScreen mainScreen].bounds.size.width <= 320) {
        if (smallPath.length > 0 ) {
            view = [[NSBundle mainBundle] loadNibNamed:classSmallString owner:nil options:nil].lastObject;
            [view setUpViewWithContext:context object:object];
            return view;
        }
        if (path.length > 0){
            view = [[NSBundle mainBundle] loadNibNamed:classString owner:nil options:nil].lastObject;
            [view setUpViewWithContext:context object:object];
            return view;
        }
        
    }else{
        if (path.length) {
            view = [[NSBundle mainBundle] loadNibNamed:classString owner:nil options:nil].lastObject;
            [view setUpViewWithContext:context object:object];
            return view;
        }
        
    }
    
    if (!view) {
        view = [[self alloc] init];
    }
    [view setUpViewWithContext:context object:object];
    
    return view;
}





+ (instancetype)createInstance {
    return [self createInstanceWithContext:nil object:nil];
}

- (void)setUpViewWithContext:(NSDictionary *)context object:(id)object {
    // 子类实现
}

- (void)updateViewWithContext:(NSDictionary *)context object:(id)object {
     // 子类实现
}

- (void)refreshViewWithObject:(id)obj flag:(BOOL)flag {
    // 子类实现
}

- (void)refreshViewWithObject:(id)obj1 object:(id)obj2 {
    // 子类实现
}

- (void)refreshViewWithObject:(id)obj {
      // 子类实现
}

@end
