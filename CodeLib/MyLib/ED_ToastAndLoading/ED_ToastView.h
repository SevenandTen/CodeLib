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
    ED_ToastLocationCustom,         // 用户自定义
} ;


@interface ED_ToastView : UIView



/**
 成功勾勾的toast

 @param title 底下标题
 @return 可忽略
 */
+ (ED_ToastView *)successToastWithTitle:(NSString *)title;


/**
 UI 新的toast

 @param title 标题
 @param locationY 绝对位置
 @return 可以忽略
 */
+ (ED_ToastView *)defaultToastWithTitle:(NSString *)title locationY:(CGFloat)locationY;


/**
  UI 新的toast

 @param title 标题
 @param referenceView 参照视图
 @return 可以忽略
 */
+ (ED_ToastView *)defaultToastWithTitle:(NSString *)title referenceView:(UIView *)referenceView;




/**
  UI 新的toast

 @param title 标题
 @param referenceView 参照视图
 @param space 与参照视图的距离
 @return 可以忽略
 */
+ (ED_ToastView *)defaultToastWithTitle:(NSString *)title referenceView:(UIView *)referenceView space:(CGFloat)space;















+ (ED_ToastView *)toastOnView:(UIView *)view
                        style:(ED_ToastStyle)style
                        title:(NSString *)title
                    locationY:(CGFloat)loactionY
                     showTime:(NSTimeInterval)showTime
                hideAfterTime:(NSTimeInterval)hideTime
                 showAnmation:(BOOL)showAnmation
                 hideAnmation:(BOOL)hideAnmation;

+ (ED_ToastView *)toastOnView:(UIView *)view
                        style:(ED_ToastStyle)style
                        title:(NSString *)title
                    locationY:(CGFloat)locationY
                     showTime:(NSTimeInterval)showTime
                 showAnmation:(BOOL)showAnmation;

- (void)hideAfterTime:(NSTimeInterval )time anmation:(BOOL)anmation;

- (void)hideNow;

- (void)showOnView:(UIView *)view time:(NSTimeInterval)time anmation:(BOOL)anmiation complete:(void(^)(void))complete;

- (void)showOnView:(UIView *)view complete:(void(^)(void))complete;

@end


