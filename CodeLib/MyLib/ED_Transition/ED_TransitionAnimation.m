//
//  ED_TransitionAnimation.m
//  CodeLib
//
//  Created by zw on 2019/1/14.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_TransitionAnimation.h"

@implementation ED_TransitionAnimation


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.duration == 0) {
        return 1;
    }
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = transitionContext.containerView;
    
    if (self.transition) {
        self.transition(fromView, toView, containerView, transitionContext);
    }else{
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
        [UIView animateWithDuration:1 animations:^{
            fromView.frame = CGRectMake(width, 0, width, height );
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }

}

@end
