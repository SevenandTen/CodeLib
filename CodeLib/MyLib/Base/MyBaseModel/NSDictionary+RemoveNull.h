//
//  NSDictionary+RemoveNull.h
//  MyCode
//
//  Created by 崎崎石 on 2018/5/10.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (RemoveNull)

+ (NSDictionary *)removeNullPointFromDic:(NSDictionary *)dic;

- (NSArray *)arrayObjectForKey:(NSString *)key;

- (NSDictionary *)dictionaryObjectForKey:(NSString *)key ;



@end
