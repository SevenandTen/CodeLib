//
//  ED_NetListener.m
//  CodeLib
//
//  Created by zw on 2018/11/26.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_NetListener.h"
#import "Reachability.h"


NSString *const NetReachabilityChangedNotification = @"NetReachabilityChangedNotification";


@interface ED_NetListener ()

@property (nonatomic , strong) Reachability *reachability;

@end

@implementation ED_NetListener

+ (instancetype)shareInstance {
    static ED_NetListener *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ED_NetListener alloc] init];
    });
    return manager;
}


- (void)startListening {
    [self.reachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStatusChange:) name:kReachabilityChangedNotification object:_reachability];
}


- (void)stopListening {
    [self.reachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark - Private

- (void)netWorkStatusChange:(NSNotification *)noti {
    [[NSNotificationCenter defaultCenter] postNotificationName:NetReachabilityChangedNotification object:nil];
}


#pragma mark - Getter

- (ED_NetWorkEnvironment)status {
  NetworkStatus status =  [self.reachability currentReachabilityStatus];
    if (status == NotReachable ) {
        return ED_NetWorkDisable;
    }else if (status == ReachableViaWiFi) {
        return ED_NetWorkWifi;
    }else {
        return ED_NetWorkPhone;
    }
    
}

//NotReachable = 0,
//ReachableViaWiFi,
//ReachableViaWWAN

- (Reachability *)reachability {
    if (!_reachability) {
        _reachability = [Reachability reachabilityForInternetConnection];
    }
    return _reachability;
}

@end
