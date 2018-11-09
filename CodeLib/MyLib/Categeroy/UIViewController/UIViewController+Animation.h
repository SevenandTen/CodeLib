//
//  UIViewController+Animation.h
//  MyCode
//
//  Created by 崎崎石 on 2018/3/2.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger , VCShowType) {
    ShowByPush,
    ShowByPresent,
    BackByDismiss,
    BackByPop,
};



@interface UIViewController (Animation)

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


//下面四个是系统共有的API
//kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade


// subType
//kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom



+ (CATransition *)showOrDismissAnimationWithAnimationType:(NSString *)type subType:(NSString *)subType;


- (void)showNextViewController:(UIViewController *)viewController showType:(VCShowType)showType animationType:(NSString *)animationType subType:(NSString *)subType;

- (void)backLastViewControoler:(UIViewController *)viewController showType:(VCShowType)showType animationType:(NSString *)animationType subType:(NSString *)subType;


- (void)pushNextViewController:(UIViewController *)viewController;

- (void)presentNextViewController:(UIViewController *)viewController;

- (void)popOtherViewController:(UIViewController *)viewController;

- (void)popLastViewController;

- (void)dismissLastViewController;




@end
