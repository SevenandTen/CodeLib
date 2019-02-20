//
//  ED_PrecentTransition.h
//  CodeLib
//
//  Created by zw on 2019/1/15.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , ED_TouchType) {
    ED_TouchDown ,  // ⬇️
    ED_TouchUp ,    // ⬆️
    ED_TouchRight , // ➡️
    ED_TouchLeft ,  // ⬅️
};

@interface ED_PrecentTransition : UIPercentDrivenInteractiveTransition

- (instancetype)initWithViewController:(UIViewController *)vc;

- (instancetype)initWithView:(UIView *)view;

@property (nonatomic ,assign) CGFloat startPercent;

@property (nonatomic ,assign) CGPoint maxOffSet;


@property (nonatomic ,assign) ED_TouchType type;

@property (nonatomic , readonly) BOOL isPanGestureInteration;


@property (nonatomic , copy) void(^actionBlock)(void);

@end


