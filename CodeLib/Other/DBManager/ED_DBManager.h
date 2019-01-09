//
//  ED_DBManager.h
//  MyCode
//
//  Created by 崎崎石 on 2018/2/26.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ED_DBManager : NSObject

+ (instancetype)shareInstance;

- (void)saveObject:(id)object withKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;

- (id)getObjectForKey:(NSString *)key;



@end
