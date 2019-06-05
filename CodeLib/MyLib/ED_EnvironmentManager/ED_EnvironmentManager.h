//
//  ED_EnvironmentManager.h
//  CodeLib
//
//  Created by zw on 2019/5/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ED_ENVIRONMENTMANAGER_IS_APPSTORE   0

@interface ED_EnvironmentManager : NSObject

@property (nonatomic ,readonly) NSString *baseHost;

@property (nonatomic ,readonly) NSString *platFormHost;

@property (nonatomic ,readonly) NSString *appSecret;

@property (nonatomic ,readonly) NSString *appCode;

@property (nonatomic ,readonly) NSString *pushHost;

@property (nonatomic ,readonly) NSString *pushHttpHost;

@property (nonatomic ,readonly) NSString *mpushKey;

@property (nonatomic ,readonly) NSString *fileUploadUrl;

@property (nonatomic ,readonly) NSString *shareStockPre;

@property (nonatomic ,readonly) NSString *shareArroundHost;

@property (nonatomic ,readonly) NSString *ipHost;

@property (nonatomic ,readonly) NSString *umengKey;

@property (nonatomic ,readonly) NSString *channelKey;

@property (nonatomic ,readonly) NSString *mapKey;

@property (nonatomic ,readonly) NSString *weiXinAppKey;

@property (nonatomic ,readonly) NSString *QQAppKey;





/**
 当前环境   1 内网
 2——9 测试频道。   2 阿里云服务器测试
 
 11——19 准生产环境频道   11 阿里云准生产
 
 1077  正式环境
 */
@property (nonatomic ,readonly) NSInteger currentEnviroment;





@property (nonatomic , readonly) NSString  *currentEnviromentName;





+ (instancetype)shareInstance;


- (void)changeEnviromentWithNumber:(NSNumber *)number ;


- (void)showChooseEnviroments;


@end


