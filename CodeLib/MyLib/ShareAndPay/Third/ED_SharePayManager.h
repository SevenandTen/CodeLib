//
//  ED_SharePayManager.h
//  BaseCode
//
//  Created by 崎崎石 on 2018/7/3.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>



typedef NS_ENUM(NSInteger ,WXShareView) {
    WXChat = 0,    /**< 聊天界面    */
    WXFriend = 1,   /**< 朋友圈      */
    WXCollect = 2,  /**< 收藏       */
};

@class ED_SharePayManager;
@protocol SharePayDelegate<NSObject>

// 分享回调
- (void)sharePayManager:(ED_SharePayManager *)manager
   haveSharedWithResult:(BOOL)isSuccessed;

// 微信登录回调
- (void)sharePayManager:(ED_SharePayManager *)manager
    haveLoginWithResult:(BOOL)isSuccessed
                  token:(NSString *)token;


// 支付回调
- (void)sharePayManager:(ED_SharePayManager *)manager
      havePayWithResult:(BOOL)isSuccessed
                    msg:(NSString *)msg;


@end


@interface ED_SharePayManager : NSObject<WXApiDelegate>

@property (nonatomic , weak) id<SharePayDelegate>delegate;

+ (ED_SharePayManager *)shareInstance;


// appdelegate .m 中用到
- (BOOL)handleOpenURL:(NSURL *)url;

// 处理支付宝回调结果
- (void)dealAliPayResult:(NSDictionary *)dic;


// 调用支付宝支付

- (void)payWithOrderString:(NSString *)orderString scheme:(NSString *)scheme;

//微信支付
- (BOOL)payWithTimeStamp:(UInt32)timeStamp noceStr:(NSString *)nonceStr sign:(NSString *)sign prepayId:(NSString *)prepayId;

// 微信分享文本消息
- (BOOL)shareTextMessage:(NSString *)message toWXView:(WXShareView)sharePlace;

//微信分享图片消息
- (BOOL)shareImageMessage:(UIImage *)image
                  thumImage:(UIImage *)thumImage
                   toWXView:(WXShareView)sharePlace;


//分享音乐消息
- (BOOL)shareMusicMessage:(NSString *)musicTitle
                 musicDes:(NSString *)musicDes
           musicThumImage:(UIImage *)thumImage
                 musicUrl:(NSString *)musicUrl
             musicDataUrl:(NSString *)musicDataUrl
                 toWXView:(WXShareView)sharePlace;

//分享视频消息
- (BOOL)shareViedoMessage:(NSString *)videoTitle
                 videoDes:(NSString *)videoDes
           videoThumImage:(UIImage *)thumImage
                 videoUrl:(NSString *)videoUrl
                 toWXView:(WXShareView)sharePlace;

//分享网页消息
- (BOOL)shareWebMessage:(NSString *)webTitle
                 webDes:(NSString *)webDes
           webThumImage:(UIImage *)thumImage
                 webUrl:(NSString *)webUrl
               toWXView:(WXShareView)sharePlace;

// 分享小程序
- (BOOL)shareMiniAppMessage:(NSString *)miniAppTitle
                 miniAppDes:(NSString *)miniAppDes
           miniAppthumImage:(UIImage *)thumImage
          miniAppWebpageUrl:(NSString *)webPageUrl
            miniAppUserName:(NSString *)userName
                miniAppPath:(NSString *)path
                   toWXView:(WXShareView)sharePlace;


// 微信第三方登录
- (BOOL)loginUseWX;






@end
