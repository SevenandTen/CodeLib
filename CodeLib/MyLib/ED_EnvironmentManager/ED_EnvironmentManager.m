//
//  ED_EnvironmentManager.m
//  CodeLib
//
//  Created by zw on 2019/5/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_EnvironmentManager.h"
#import "ED_EnviromentView.h"

#define ED_ENVIRONMENTMANAGER_KEY @"ED_ENVIRONMENTMANAGER_KEY"

@implementation ED_EnvironmentManager

@synthesize baseHost = _baseHost;
@synthesize platFormHost = _platFormHost;
@synthesize appSecret = _appSecret;
@synthesize appCode = _appCode;
@synthesize pushHost = _pushHost;
@synthesize pushHttpHost = _pushHttpHost;
@synthesize mpushKey = _mpushKey;
@synthesize fileUploadUrl = _fileUploadUrl;
@synthesize shareStockPre = _shareStockPre;
@synthesize shareArroundHost = _shareArroundHost;
@synthesize ipHost = _ipHost;
@synthesize umengKey = _umengKey;
@synthesize channelKey = _channelKey;
@synthesize mapKey = _mapKey;
@synthesize weiXinAppKey = _weiXinAppKey;
@synthesize QQAppKey = _QQAppKey;
@synthesize currentEnviroment = _currentEnviroment;
@synthesize currentEnviromentName = _currentEnviromentName;

+ (instancetype)shareInstance {
    static ED_EnvironmentManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:nil] init];;
    });
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return nil;
}



- (void)changeEnviromentWithNumber:(NSNumber *)number {
    if (number) {
        [[NSUserDefaults standardUserDefaults] setObject:number forKey:ED_ENVIRONMENTMANAGER_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        @throw @"切换环境";
    }
}


- (void)showChooseEnviroments {
    if (ED_ENVIRONMENTMANAGER_IS_APPSTORE == 1) {
        return;
    }else {
        [ED_EnviromentView show];
    }
}


#pragma mark - Getter

- (NSString *)baseHost {
    if (!_baseHost) {
        if (self.currentEnviroment == 1077) {
            _baseHost = @"http://sjb-service.sijibao.com";
        }else if (self.currentEnviroment == 1){
            _baseHost = @"http://192.168.0.206:8131";
        }else if (self.currentEnviroment == 2) {
            _baseHost = @"http://sjb-servicetest.sijibao.com";
        }else if (self.currentEnviroment == 11) {
            _baseHost = @"http://47.105.134.221:8131";
        }else{
            _baseHost = @"http://sjb-service.sijibao.com";
        }
    }
    return _baseHost;
}


- (NSString *)platFormHost {
    if (!_pushHttpHost) {
        if (self.currentEnviroment == 1077) {
            _pushHttpHost = @"http://rop-service.sijibao.com/ropservice/router";
        }else if (self.currentEnviroment == 1){
            _pushHttpHost = @"http://192.168.0.206:8101/ropservice/router";
        }else if (self.currentEnviroment == 2) {
            _pushHttpHost = @"http://rop-servicetest.sijibao.com/ropservice/router";
        }else if (self.currentEnviroment == 11) {
            _pushHttpHost = @"http://47.105.134.221:8101/ropservice/router";
        }else{
            _pushHttpHost = @"http://rop-service.sijibao.com/ropservice/router";
        }
    }
    return _platFormHost;
}

- (NSString *)appSecret {
    if (!_appSecret) {
        if (self.currentEnviroment == 2) {
            _appSecret = @"827acf2a001248bc8ae419aedb3045e6";
        }else{
            _appSecret = @"2dddc367e1f2452f853d15c43bbd8078";
        }
    }
    return _appSecret;
}

- (NSString *)appCode {
    if (!_appCode) {
        if (self.currentEnviroment == 2) {
            _appCode = @"100004";
        }else{
            _appCode = @"100002";
        }
    }
    return _appCode;
}

- (NSString *)pushHost {
    if (self.currentEnviroment == 1077) {
        _pushHost = @"http://msgpush.sijibao.com:8090";
    }else if (self.currentEnviroment == 1){
        _pushHost = @"http://192.168.0.202:8090";
    }else if (self.currentEnviroment == 2) {
        _pushHost = @"http://msgpushtest.sijibao.com:8090";
    }else if (self.currentEnviroment == 11) {
        _pushHost = @"http://msgpush.sijibao.com:8090";
    }else{
        _pushHost = @"http://msgpush.sijibao.com:8090";
    }
    return _pushHost;
}

- (NSString *)pushHttpHost {
    if (!_pushHttpHost) {
        if (self.currentEnviroment == 1077) {
            _pushHttpHost = @"http://msgpush.sijibao.com:8085";
        }else if (self.currentEnviroment == 1){
            _pushHttpHost = @"http://192.168.0.202:8085";
        }else if (self.currentEnviroment == 2) {
            _pushHttpHost = @"http://msgpushtest.sijibao.com:8085";
        }else if (self.currentEnviroment == 11) {
            _pushHttpHost = @"http://msgpush.sijibao.com:8085";
        }else{
            _pushHttpHost = @"http://msgpush.sijibao.com:8085";
        }
    }
    return _pushHttpHost;
    
}

- (NSString *)mpushKey {
    if (!_mpushKey) {
        if (self.currentEnviroment == 1077) {
            _mpushKey = @"D9D1A1363A522BE6380563443DADDB8B";
        }else if (self.currentEnviroment == 1){
            _mpushKey = @"221BF6D5ED43F62E5A135BD05710F643";
        }else if (self.currentEnviroment == 2) {
            _mpushKey = @"597942374BE974C23F0D13AE8828CF48";
        }else if (self.currentEnviroment == 11) {
            _mpushKey = @"D9D1A1363A522BE6380563443DADDB8B";
        }else{
            _mpushKey = @"D9D1A1363A522BE6380563443DADDB8B";
        }
    }
    return _mpushKey;
}


- (NSString *)fileUploadUrl {
    if (!_fileUploadUrl) {
        if (self.currentEnviroment == 1077) {
            _fileUploadUrl = @"https://boot-service.sijibao.com/common/api/file/upload";
        }else if (self.currentEnviroment == 1){
            _fileUploadUrl = @"http://192.168.0.202:8155/common/api/file/upload";
        }else if (self.currentEnviroment == 2) {
            _fileUploadUrl = @"http://boot-servicetest.sijibao.com/common/api/file/upload";
        }else if (self.currentEnviroment == 11) {
            _fileUploadUrl = @"http://47.105.134.221:8155/common/api/file/upload";
        }else{
            _fileUploadUrl = @"https://boot-service.sijibao.com/common/api/file/upload";
        }
    }
    return _fileUploadUrl;
}


- (NSString *)shareStockPre {
    if (!_shareStockPre) {
        if (self.currentEnviroment == 1077) {
            _shareStockPre = @"http://m.sijibao.com/m_sjb/h5";
        }else if (self.currentEnviroment == 1){
            _shareStockPre = @"http://qiye.sijibao.com/Apptest/stockShare";
        }else if (self.currentEnviroment == 2) {
            _shareStockPre = @"http://qiye.sijibao.com/Apptest/stockShare";
        }else if (self.currentEnviroment == 11) {
            _shareStockPre = @"http://m.sijibao.com/m_sjb/h5";
        }else{
            _shareStockPre = @"http://m.sijibao.com/m_sjb/h5";
        }
    }
    return _shareStockPre;
}

- (NSString *)shareArroundHost {
    if (!_shareArroundHost) {
        if (self.currentEnviroment == 1077) {
            _shareArroundHost = @"http://qiye.sijibao.com";
        }else if (self.currentEnviroment == 1){
            _shareArroundHost = @"http://120.31.131.193:8081";
        }else if (self.currentEnviroment == 2) {
            _shareArroundHost = @"http://39.104.233.122:8081";
        }else if (self.currentEnviroment == 11) {
            _shareArroundHost = @"http://qiye.sijibao.com";
        }else{
            _shareArroundHost = @"http://qiye.sijibao.com";
        }
    }
    return _shareArroundHost;
}

- (NSString *)channelKey {
    if (!_channelKey) {
        if (ED_ENVIRONMENTMANAGER_IS_APPSTORE == 1) {
            _channelKey = @"App Store";
        }else{
           _channelKey = @"App Test";
        }
    }
    return _channelKey;
}

- (NSString *)mapKey {
    if (!_mapKey) {
        if (ED_ENVIRONMENTMANAGER_IS_APPSTORE == 1) {
            _mapKey = @"68beffa8447ad96f8396ee0ae5bc75ef";
        }else{
            _mapKey = @"0d17dece41e18581c29b6ed8bbd33af5";
        }
    }
    return _mapKey;
}

-(NSString *)weiXinAppKey {
    if (!_weiXinAppKey) {
        if (ED_ENVIRONMENTMANAGER_IS_APPSTORE == 1) {
            _weiXinAppKey = @"wxf2f3204483e36aba";
        }else{
            _weiXinAppKey = @"wxf2f3204483e36aba";
        }
    }
    return _weiXinAppKey;
}


- (NSString *)QQAppKey {
    if (!_QQAppKey) {
        if (ED_ENVIRONMENTMANAGER_IS_APPSTORE == 1) {
            _QQAppKey = @"1103490122";
        }else{
            _QQAppKey = @"1104802836";
        }

    }
    return _QQAppKey;
}

- (NSString *)umengKey {
    if (!_umengKey) {
        _umengKey = @"54ab4020fd98c5b492000d64";
    }
    return _umengKey;
}

- (NSString *)ipHost {
    if (!_ipHost) {
        _ipHost = [self.baseHost stringByAppendingString:@"/sjbServer2"];
    }
    return _ipHost;
}


- (NSInteger)currentEnviroment {
    if (!_currentEnviroment) {
        if (ED_ENVIRONMENTMANAGER_IS_APPSTORE == 1) {
            _currentEnviroment = 1077;
        }else {
            NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:ED_ENVIRONMENTMANAGER_KEY];
            if (number) {
                _currentEnviroment =  [number integerValue];
            }else {
                _currentEnviroment = 2;
            }
        }
    }
    return _currentEnviroment;
}


- (NSString *)currentEnviromentName {
    if (!_currentEnviromentName) {
        if (self.currentEnviroment == 1077) {
            _currentEnviromentName = @"正式环境";
        }else if (self.currentEnviroment == 1){
            _currentEnviromentName = @"内网环境（开发专用）";
        }else if (self.currentEnviroment == 2) {
            _currentEnviromentName = @"测试环境";
        }else if (self.currentEnviroment == 11) {
            _currentEnviromentName = @"准生产环境";
        }else{
            _currentEnviromentName = @"正式环境";
        }
    }
    return _currentEnviromentName;
}



@end
