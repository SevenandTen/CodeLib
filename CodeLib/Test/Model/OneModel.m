//
//  OneModel.m
//  CodeLib
//
//  Created by zw on 2019/1/18.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "OneModel.h"

@implementation OneModel

//- (void)eat {
//    NSLog(@"1111111");
//}

//- (void)eat {
//    NSLog(@"yyyyyyy");
//}

- (void)swim:(NSString *)str {
    NSLog(@"xxxxxxxxxxxxx");
}


+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(eat)) {
        NSLog(@"11111111");
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"222222");
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"333333333");
    if (aSelector == @selector(eat)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"44444444");
  
}




@end
