//
//  ED_CrashControl.h
//  CodeLib
//
//  Created by zw on 2019/4/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ED_CrashControl : NSObject

+ (void)beginListenCrash;

+ (void)saveExceptionInfo:(NSDictionary *)info ;

+ (void)saveSignalInfo:(NSDictionary *)info ;

+ (NSDictionary *)getExceptionInfo;

+ (NSDictionary *)getSignalInfo;


@end

NS_ASSUME_NONNULL_END
