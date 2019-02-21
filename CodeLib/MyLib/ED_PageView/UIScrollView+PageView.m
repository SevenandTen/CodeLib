//
//  UIScrollView+PageView.m
//  CodeLib
//
//  Created by zw on 2019/2/21.
//  Copyright © 2019 seventeen. All rights reserved.
//


#import "UIScrollView+PageView.h"
#import <objc/runtime.h>

static BOOL defaultGestureRecognizerSimultaneouslyHandle(id object ,SEL sel,UIGestureRecognizer * gestureRecognizer, UIGestureRecognizer * otherGestureRecognizer) {
    return NO;
}

@implementation UIScrollView (PageView)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sel1 = @selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:);
        SEL sel2 = @selector(myPageViewGestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:);
        Method method1 = class_getInstanceMethod(self, sel1);
        if (method1 == NULL) {
            class_addMethod(self, sel1, (IMP)defaultGestureRecognizerSimultaneouslyHandle ,method_getTypeEncoding(class_getInstanceMethod(self, sel2)));
        }
        method_exchangeImplementations(class_getInstanceMethod(self, sel1), class_getInstanceMethod(self, sel2));
        
    });
}



- (BOOL)myPageViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([self.someOtherView isEqual:otherGestureRecognizer.view]) {
        return YES;
    }
    return [self myPageViewGestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
}


- (UIScrollView *)someOtherView {
   return  objc_getAssociatedObject(self, _cmd);
}

- (void)setSomeOtherView:(UIScrollView *)someOtherView {
    objc_setAssociatedObject(self, @selector(someOtherView), someOtherView, OBJC_ASSOCIATION_ASSIGN);
}






@end
