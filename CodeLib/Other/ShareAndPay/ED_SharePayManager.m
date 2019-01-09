//
//  ED_SharePayManager.m
//  BaseCode
//
//  Created by 崎崎石 on 2018/7/3.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import "ED_SharePayManager.h"
@interface ED_SharePayManager ()


@end

@implementation ED_SharePayManager

+ (ED_SharePayManager *)shareInstance {
    static ED_SharePayManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ED_SharePayManager alloc] init];
    });
    return manager;
}



#pragma mark - Public

- (BOOL)handleOpenURL:(NSURL *)url {
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [self dealAliPayResult:resultDic];
        }];
        return YES;
    }
    return [WXApi handleOpenURL:url delegate:self];
}


- (void)dealAliPayResult:(NSDictionary *)dic {
    NSString *resultStatus = [dic objectForKey:@"resultStatus"];
    if ([resultStatus isEqualToString:@"9000"]) {
        [self.delegate sharePayManager:self havePayWithResult:YES msg:nil];
    }else {
        [self.delegate sharePayManager:self havePayWithResult:NO msg:nil];
    }
}


- (void)payWithOrderString:(NSString *)orderString scheme:(NSString *)scheme {
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:scheme   callback:^(NSDictionary *resultDic) {
        [self dealAliPayResult:resultDic];
    }];
}

- (BOOL)payWithTimeStamp:(UInt32)timeStamp noceStr:(NSString *)nonceStr sign:(NSString *)sign prepayId:(NSString *)prepayId {
    if ([WXApi isWXAppInstalled]) {
        PayReq *req = [[PayReq alloc] init];
        req.partnerId = @"1507219301";
        req.prepayId= prepayId;
        req.package = @"Sign=WXPay";
        req.nonceStr= nonceStr;
        req.timeStamp = timeStamp;
        req.sign= sign;
        [WXApi sendReq:req];
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)shareTextMessage:(NSString *)message toWXView:(WXShareView)sharePlace {
    if ([WXApi isWXAppInstalled]) {
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.text = message;
        req.bText = YES;
        req.scene = sharePlace;
        [WXApi sendReq:req];
        return YES;
    }
    return NO;
}


- (BOOL)shareImageMessage:(UIImage *)image thumImage:(UIImage *)thumImage toWXView:(WXShareView)sharePlace {
    if ([WXApi isWXAppInstalled]) {
        WXMediaMessage *message = [WXMediaMessage message];
        [message setThumbImage:thumImage];
        WXImageObject *ext = [WXImageObject object];
        ext.imageData = UIImagePNGRepresentation(image);
        message.mediaObject = ext;
        [self sendMessage:message toWXView:sharePlace];
        return YES;
    }
    return NO;
}

- (BOOL)shareMusicMessage:(NSString *)musicTitle musicDes:(NSString *)musicDes musicThumImage:(UIImage *)thumImage musicUrl:(NSString *)musicUrl musicDataUrl:(NSString *)musicDataUrl toWXView:(WXShareView)sharePlace {
    if ([WXApi isWXAppInstalled]) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = musicTitle;
        message.description = musicDes;
        WXMusicObject *ext = [WXMusicObject object];
        ext.musicUrl = musicUrl;
        ext.musicDataUrl = musicDataUrl;
        message.mediaObject = ext;
        [self sendMessage:message toWXView:sharePlace];
        return YES;
    }
    return NO;
    
}

- (BOOL)shareViedoMessage:(NSString *)videoTitle videoDes:(NSString *)videoDes videoThumImage:(UIImage *)thumImage videoUrl:(NSString *)videoUrl toWXView:(WXShareView)sharePlace {
    if ([WXApi isWXAppInstalled]) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = videoTitle;
        message.description = videoDes;
        [message setThumbImage:thumImage];
        WXVideoObject *ext = [WXVideoObject object];
        ext.videoUrl = videoUrl;
        message.mediaObject = ext;
        [self sendMessage:message toWXView:sharePlace];
        return YES;
    }
    return NO;
}


- (BOOL)shareWebMessage:(NSString *)webTitle webDes:(NSString *)webDes webThumImage:(UIImage *)thumImage webUrl:(NSString *)webUrl toWXView:(WXShareView)sharePlace {
    if ([WXApi isWXAppInstalled]) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = webTitle;
        message.description = webDes;
        [message setThumbImage:thumImage];
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = webUrl;
        message.mediaObject = ext;
        [self sendMessage:message toWXView:sharePlace];
        return YES;
    }
    return NO;
}

- (BOOL)shareMiniAppMessage:(NSString *)miniAppTitle miniAppDes:(NSString *)miniAppDes miniAppthumImage:(UIImage *)thumImage miniAppWebpageUrl:(NSString *)webPageUrl miniAppUserName:(NSString *)userName miniAppPath:(NSString *)path toWXView:(WXShareView)sharePlace {
    if ([WXApi isWXAppInstalled]) {
        WXMiniProgramObject *wxMiniObject = [WXMiniProgramObject object];
        wxMiniObject.webpageUrl =webPageUrl;
        wxMiniObject.userName = userName;
        wxMiniObject.path = path;
        wxMiniObject.hdImageData = UIImagePNGRepresentation(thumImage);
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = miniAppTitle;
        message.title = miniAppDes;
        message.mediaObject = wxMiniObject;
        message.thumbData =  UIImagePNGRepresentation(thumImage);
        [self sendMessage:message toWXView:sharePlace];
        return YES;
    }
    return NO;
    
}

- (BOOL)loginUseWX {
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"123";
        [WXApi sendReq:req];
        return YES;
    }
    return NO;
    
}


#pragma mark - Private

- (void)sendMessage:(WXMediaMessage *)message toWXView:(WXShareView)sharePlace {
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = sharePlace;
    [WXApi sendReq:req];
    
}

- (void)onResp:(BaseResp *)resp {
    
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *sendResp = (SendAuthResp *)resp;
        if (sendResp.code.length > 0) {
            [self.delegate sharePayManager:self haveLoginWithResult:YES token:sendResp.code];
        }else{
            [self.delegate sharePayManager:self haveLoginWithResult:NO token:sendResp.code];
        }
        
        // 获取code
    }else if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        //分享
        NSLog(@"分享");
    }else if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *payResp  = (PayResp *)resp;
        if (payResp.errCode == 0) {
             [self.delegate sharePayManager:self havePayWithResult:YES msg:nil];
        }else {
           [self.delegate sharePayManager:self havePayWithResult:NO msg:nil];
        }
        
        
    }else  {
        NSLog(@"其他");
    }
    
}




@end
