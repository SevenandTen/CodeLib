//
//  ED_AlertControl.h
//  DriverCimelia
//
//  Created by zw on 2018/10/26.
//  Copyright © 2018年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>






@interface ED_AlertControl : NSObject

//------------------------------------------------------------------------------------------------------



/**
 弹出输入风格

 @param title 标题
 @param tip 输入框后面提示 注意 括号不用传  例如 后面显示 （1~100的整数） 则 tip为 1~100的整数 如果不需要提示 传nil
 @param placeHolder 输入框占位字符 本版本 因为输入框会成为第一响应 这个 设不设制 无所谓
 @param keyboardType  输入框键盘的风格
 @param complete    @param  index 不用关注  string 为输入框输入的字符  isSure 为 Yes点击的是 确定按钮 为NO 为取消按钮 所以先判断 isSure 在取String
 */
+ (void)alertInputWithTitle:(NSString *)title
                        tip:(NSString *)tip
                placeHolder:(NSString *)placeHolder
               keyBoardType:(UIKeyboardType) keyboardType
                   complete:(void(^)(NSInteger index , NSString * string , BOOL isSure))complete;


//-------------------------------------------------------------------------------------------------------



/**
 确认司机弹出框  固定风格

 @param title 标题
 @param driverName 司机名称
 @param carNumber 车牌号
 @param complete @param    isSure 为 Yes点击的是 确定按钮 为NO 为取消按钮  只用判断 isSure
 */
+ (void)alertSureDriverWithTitle:(NSString *)title
                      driverName:(NSString *)driverName
                       carNumber:(NSString *)carNumber
                        complete:(void(^)(NSInteger index , NSString * string , BOOL isSure))complete;


//---------------------------------------------------------------------------------------------------------



/**
 转账申请已提交

 @param content 图片 后面的描述文本
 @param money 金额大小  备注 自己吧 钱的格式配置好穿  比如 传 ¥500.00
 @param imageType 图片风格   Y 为 绿色 成功图片。  N为 红色 警告图片
 @param complete 点击按钮回掉 参数 不用关注
 */
+ (void)alertTransferAccountWithContent:(NSString *)content
                                  money:(NSString *)money
                              imageType:(BOOL)imageType
                               complete:(void(^)(NSInteger index , NSString * string , BOOL isSure))complete;


//------------------------------------------------------------------------------------------------------------



/**
 弹出分享框

 @param complete 点击后的回掉。  关注 index  index = 0 点了空白处。 index = 1 为 微信  index = 2 为朋友圈 index = 3 为扣扣分享
 */
+ (void)alertShareWithComplete:(void(^)(NSInteger index , NSString * string , BOOL isSure))complete;

//------------------------------------------------------------------------------------------------------------

/**
 这下面三个 是一个风格  标题+说明文字+一个按钮
 
 @param title 标题 title 不传 则没有标题
 @param content 说明文字
 @param btnTitle 按钮 文字。 默认为知道了
 @param complete 点击按钮后的回掉 不需要关注任何参数
 */
+ (void)alertDefuatWarningWithTitle:(NSString *)title
                            content:(NSString *)content;

+ (void)alertDefuatWarningWithTitle:(NSString *)title
                            content:(NSString *)content
                           btnTitle:(NSString *)btnTitle;

+ (void)alertDefuatWarningWithTitle:(NSString *)title
                            content:(NSString *)content
                           btnTitle:(NSString *)btnTitle
                           complete:(void(^)(NSInteger index , NSString * string , BOOL isSure))complete;


//------------------------------------------------------------------------------------------------------------


/**
  这下面三个 是一个风格  标题+说明文字+一个按钮 + 图片
 
 @param title 标题 title 不传 则没有标题
 @param content 说明文字
 @param imageType 图片风格   Y 为 绿色 成功图片。  N为 红色 警告图片
 @param btnTitle 按钮 文字。 默认为知道了
 @param complete 点击按钮后的回掉 不需要关注任何参数
 */

+ (void)alertDefuatImageWarningWithTitle:(NSString *)title
                                 content:(NSString *)content
                               imageType:(BOOL)imageType;

+ (void)alertDefuatImageWarningWithTitle:(NSString *)title
                                 content:(NSString *)content
                               imageType:(BOOL)imageType
                                btnTitle:(NSString *)btnTitle;



+ (void)alertDefuatImageWarningWithTitle:(NSString *)title
                                 content:(NSString *)content
                               imageType:(BOOL)imageType
                                btnTitle:(NSString *)btnTitle
                                complete:(void(^)(NSInteger index , NSString * string , BOOL isSure))complete;

//------------------------------------------------------------------------------------------------------------

/**
 这下面两个 是一个风格  标题+说明文字+两个按钮
 
 @param title 标题 title 不传 则没有标题
 @param content 说明文字
 @param cancelTitle 左边 按钮文字 默认为取消
 @param sureTitle 右边 按钮文字 默认为确定
 @param complete 点击按钮后的回掉   isSure 为Y 则为点击了 右边按钮  反之
 */


+ (void)alertCommonTipsWithTitle:(NSString *)title
                         content:(NSString *)content
                        complete:(void(^)(NSInteger index , NSString * string , BOOL isSure))complete;



+ (void)alertCommonTipsWithTitle:(NSString *)title
                         content:(NSString *)content
                     cancelTitle:(NSString *)cancelTitle
                       sureTitle:(NSString *)sureTitle
                        complete:(void(^)(NSInteger index , NSString * string , BOOL isSure))complete;

//------------------------------------------------------------------------------------------------------------


/**
 这下面两个 是一个风格  标题+说明文字+两个按钮
 
 @param title title 不传 则没有标题
 @param content 说明文字
 @param cancelTitle 左边 按钮文字 默认为取消
 @param sureTitle 右边 按钮文字 默认为确定
 @param imageType 图片风格   Y 为 绿色 成功图片。  N为 红色 警告图片
 @param complete 点击按钮后的回掉   isSure 为Y 则为点击了 右边按钮  反之
 */

+ (void)alertCommonImageTipsWithTitle:(NSString *)title
                         content:(NSString *)content
                       imageType:(BOOL)imageType
                        complete:(void(^)(NSInteger index , NSString * string , BOOL isSure))complete;

+ (void)alertCommonImageTipsWithTitle:(NSString *)title
                              content:(NSString *)content
                          cancelTitle:(NSString *)cancelTitle
                            sureTitle:(NSString *)sureTitle
                            imageType:(BOOL)imageType
                             complete:(void(^)(NSInteger index , NSString * string , BOOL isSure))complete;
//------------------------------------------------------------------------------------------------------------



+ (void)alertWithTitle:(NSString *)title
               content:(NSString *)content
           isHaveImage:(BOOL)isHaveImage
             imageType:(BOOL)imageType
           isHasCancel:(BOOL)isHasCancel
        cancelBtnTitle:(NSString *)cancelBtnTitle
          sureBtnTitle:(NSString *)sureBtnTitle
              complete:(void(^)(NSInteger index , NSString * string , BOOL isSure))complete;

//------------------------------------------------------------------------------------------------------------

@end


