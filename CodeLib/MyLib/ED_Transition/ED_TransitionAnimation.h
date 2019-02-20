//
//  ED_TransitionAnimation.h
//  CodeLib
//
//  Created by zw on 2019/1/14.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <UIKit/UIKit.h>
@interface ED_TransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic , assign) NSTimeInterval duration;


@property (nonatomic , copy) void(^transition)(UIView *fromView , UIView *toView, UIView *containView ,id <UIViewControllerContextTransitioning>transitionContext);

@end

