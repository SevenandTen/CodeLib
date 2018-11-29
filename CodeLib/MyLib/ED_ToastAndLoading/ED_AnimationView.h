//
//  ED_AnimationView.h
//  CodeLib
//
//  Created by zw on 2018/11/28.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ED_AnimationView : UIView


@property (nonatomic , strong) UIColor *showColor;

- (void)updateAnimation;

- (void)stopAnimation;

@end
