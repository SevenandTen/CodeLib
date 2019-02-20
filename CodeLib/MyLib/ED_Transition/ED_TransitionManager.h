//
//  ED_TransitionManager.h
//  CodeLib
//
//  Created by zw on 2019/1/14.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ED_TransitionAnimation.h"
#import "ED_PrecentTransition.h"

#import <UIKit/UIKit.h>

//UINavigationControllerDelegate pop push

//UIViewControllerTransitioningDelegate present dismiss

@interface ED_TransitionManager : NSObject<UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>


//动画管理者 present or push
@property (nonatomic , strong) ED_TransitionAnimation *inAnimation;

//动画管理者 dismiss or pop
@property (nonatomic , strong) ED_TransitionAnimation *outAnmaiton;


// 手势交互动画
@property (nonatomic , strong) ED_PrecentTransition *toAnmation;

//
@property (nonatomic , strong) ED_PrecentTransition *backAnmation;


@end

