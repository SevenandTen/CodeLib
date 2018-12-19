//
//  ED_ToastView.h
//  CodeLib
//
//  Created by zw on 2018/12/18.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,ED_ToastStyle){
    ED_ToastSuccessShortMessage,    // 成功短文字
    ED_ToastLocationTop,            // 上面没圆角
    ED_ToastLocationCenter,         // 中间没圆角
    ED_ToastLocationBottom,         // 下面没圆角
    ED_ToastLoadingShortMessage,    // 正在加载
} ;


@interface ED_ToastView : UIView




+ (ED_ToastView *)toastOnView:(UIView *)view
                        style:(ED_ToastStyle)style
                        title:(NSString *)title
                     showTime:(NSTimeInterval)showTime
                hideAfterTime:(NSTimeInterval)hideTime
                 showAnmation:(BOOL)showAnmation
                 hideAnmation:(BOOL)hideAnmation;

+ (ED_ToastView *)toastOnView:(UIView *)view
                        style:(ED_ToastStyle)style
                        title:(NSString *)title
                     showTime:(NSTimeInterval)showTime
                 showAnmation:(BOOL)showAnmation;

- (void)hideAfterTime:(NSTimeInterval )time anmation:(BOOL)anmation;

- (void)hideNow;

- (void)showOnView:(UIView *)view time:(NSTimeInterval)time anmation:(BOOL)anmiation complete:(void(^)(void))complete;

- (void)showOnView:(UIView *)view complete:(void(^)(void))complete;

@end


