//
//  ED_NetListener.h
//  CodeLib
//
//  Created by zw on 2018/11/26.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , ED_NetWorkEnvironment) {
    ED_NetWorkDisable,
    ED_NetWorkWifi,
    ED_NetWorkPhone,
};


extern NSString *const NetReachabilityChangedNotification;

@interface ED_NetListener : NSObject

+ (instancetype)shareInstance;


- (void)startListening;


- (void)stopListening;


@property (nonatomic , readonly) ED_NetWorkEnvironment status;

@end


