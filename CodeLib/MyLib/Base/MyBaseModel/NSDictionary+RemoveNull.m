//
//  NSDictionary+RemoveNull.m
//  MyCode
//
//  Created by 崎崎石 on 2018/5/10.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import "NSDictionary+RemoveNull.h"

@implementation NSDictionary (RemoveNull)

+ (NSDictionary *)removeNullPointFromDic:(NSDictionary *)dic {
    if (dic.count == 0) {
        return dic;
    }
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    for (NSString *key in dic) {
        id obj = [dic objectForKey:key];
        if (obj && ![obj isKindOfClass:[NSNull class]]) {
            [result setObject:obj forKey:key];
        }
    }
    return result;
    
}

- (NSArray *)arrayObjectForKey:(NSString *)key {
    id object = [self objectForKey:key];
    if (!object || [object isKindOfClass:[NSNull class]] || ![object isKindOfClass:[NSArray class]]) {
        return [NSArray array];
    }
    return object;
}

- (NSDictionary *)dictionaryObjectForKey:(NSString *)key {
    id object = [self objectForKey:key];
    if (!object || [object isKindOfClass:[NSNull class]] || ![object isKindOfClass:[NSDictionary class]]) {
        return [NSDictionary dictionary];
    }
    return object;
    
}


@end
