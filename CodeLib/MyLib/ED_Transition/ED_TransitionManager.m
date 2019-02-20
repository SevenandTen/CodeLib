//
//  ED_TransitionManager.m
//  CodeLib
//
//  Created by zw on 2019/1/14.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_TransitionManager.h"

@interface ED_TransitionManager ()

@property (nonatomic , assign) UINavigationControllerOperation operation;

@end

@implementation ED_TransitionManager




#pragma mark - UIViewControllerTransitioningDelegate


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source  {
    return self.inAnimation;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.outAnmaiton;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.toAnmation;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.backAnmation;
}

                    




#pragma mark - UINavigationControllerDelegate


// 非手势动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    self.operation = operation;
    if (operation == UINavigationControllerOperationPush) {
        return self.inAnimation;
    }
    if (operation == UINavigationControllerOperationPop) {
        return self.outAnmaiton;
    }
    
    return nil;
}


//手势动画
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if (self.operation == UINavigationControllerOperationPush) {
        return self.toAnmation.isPanGestureInteration ? self.toAnmation : nil;
    }
    if (self.operation == UINavigationControllerOperationPop) {
        return self.backAnmation.isPanGestureInteration ? self.backAnmation : nil;
    }
    return nil;
}



- (void)dealloc {
    NSLog(@"....。。。。。。。。。。。。");
}
@end
