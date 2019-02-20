//
//  ED_SignView.h
//  CodeLib
//
//  Created by zw on 2019/1/23.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ED_SignView : UIView


@property (nonatomic ,strong) UIColor *lineColor;

@property (nonatomic ,assign) CGFloat lineWidth;


// 撤回
- (void)withdrawAction;

// 清空 重置
- (void)resetSign;


- (UIImage *)getSign;

@end

NS_ASSUME_NONNULL_END
