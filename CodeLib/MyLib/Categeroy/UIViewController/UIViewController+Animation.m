//
//  UIViewController+Animation.m
//  MyCode
//
//  Created by 崎崎石 on 2018/3/2.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import "UIViewController+Animation.h"

@implementation UIViewController (Animation)

+ (CATransition *)showOrDismissAnimationWithAnimationType:(NSString *)type subType:(NSString *)subType {
    CATransition* transition = [CATransition animation];
    transition.duration = 0.8;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    /*私有API
     cube                   立方体效果
     pageCurl               向上翻一页
     pageUnCurl             向下翻一页
     rippleEffect           水滴波动效果
     suckEffect             变成小布块飞走的感觉
     oglFlip                上下翻转
     cameraIrisHollowClose  相机镜头关闭效果
     cameraIrisHollowOpen   相机镜头打开效果
     */
    
    //    transition.type = @"cube";
    transition.type = type;
    
    //下面四个是系统共有的API
    //kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    
    transition.subtype = subType;
    //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    
    return transition;
  
}


- (void)showNextViewController:(UIViewController *)viewController showType:(VCShowType)showType animationType:(NSString *)animationType subType:(NSString *)subType {
    BOOL animation = YES ;
    if (animationType.length != 0 && subType.length != 0) {
        animation = NO;
        [self.view.window.layer addAnimation:[UIViewController showOrDismissAnimationWithAnimationType:animationType subType:subType] forKey:nil];
    }
    if (showType == ShowByPush && self.navigationController) {
        [self.navigationController pushViewController:viewController animated:animation];
    }else  {
        [self presentViewController:viewController animated:animation completion:nil];
    }
}

- (void)backLastViewControoler:(UIViewController *)viewController showType:(VCShowType)showType animationType:(NSString *)animationType subType:(NSString *)subType {
    BOOL animation = YES ;
    if (animationType.length != 0 && subType.length != 0) {
        animation = NO;
        [self.view.window.layer addAnimation:[UIViewController showOrDismissAnimationWithAnimationType:animationType subType:subType] forKey:nil];
    }
    if (showType == BackByPop && self.navigationController) {
        if (viewController) {
            [self.navigationController popToViewController:viewController animated:animation];
        }else{
            [self.navigationController popViewControllerAnimated:animation];
        }
    }else{
        [self dismissViewControllerAnimated:animation completion:nil];
    }
}





- (void)pushNextViewController:(UIViewController *)viewController {
    [self showNextViewController:viewController showType:ShowByPush animationType:nil subType:nil];
}


- (void)presentNextViewController:(UIViewController *)viewController {
    [self showNextViewController:viewController showType:ShowByPresent animationType:nil subType:nil];
}


- (void)popOtherViewController:(UIViewController *)viewController {
    [self backLastViewControoler:viewController showType:BackByPop animationType:nil subType:nil];
}

- (void)popLastViewController {
    [self backLastViewControoler:nil showType:BackByPop animationType:nil subType:nil];
}

- (void)dismissLastViewController {
    [self backLastViewControoler:nil showType:BackByDismiss animationType:nil subType:nil];
}



@end
