//
//  ED_BasicModel.m
//  MyCode
//
//  Created by 崎崎石 on 2018/1/10.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import "ED_BasicModel.h"
#import <objc/runtime.h>
#import "NSDictionary+RemoveNull.h"

@interface ED_BasicModel ()


@end


@implementation ED_BasicModel

#pragma mark - Public

+ (instancetype)shareInstance {
    return nil;
}


+ (NSArray *)createModelsWithArray:(NSArray<NSDictionary *> *)array {
    if (![array isKindOfClass:[NSArray class]] || [array isKindOfClass:[NSNull class]] || array.count == 0 ) {
        return @[];
    }
    NSMutableArray *models = [[NSMutableArray alloc] init];
    if (array.count != 0) {
        for (NSDictionary *dic in array) {
            id model = [[self alloc] initWithDic:dic];
            [models addObject:model];
        }
    }
   
    return models;
}

- (void)dealWithData:(NSDictionary *)data {
    
}


- (NSDictionary *)modelToDictionary {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    unsigned int count = 0;
    Ivar *member = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar var = member[i];
        const char *memberName = ivar_getName(var);
        NSString * nameStr = [NSString stringWithCString:memberName encoding:NSUTF8StringEncoding];
        id object = [self valueForKey:nameStr];
        if (object) {
            if ([object isKindOfClass:[ED_BasicModel class]]) {
                ED_BasicModel *model = (ED_BasicModel *)object;
                [dic setObject:[model modelToDictionary] forKey:[nameStr substringFromIndex:1]];
                
            }else {
                [dic setObject:object forKey:[nameStr substringFromIndex:1]];
            }
            
        }
    }
    free(member);
    
    return dic;
}

#pragma mark - Init

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        NSDictionary *param = [NSDictionary removeNullPointFromDic:dic];
        [self setValuesForKeysWithDictionary:param];
        [self dealWithData:param];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *member = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar var = member[i];
            const char *memberName = ivar_getName(var);
            NSString * nameStr = [NSString stringWithCString:memberName encoding:NSUTF8StringEncoding];
            [self setValue:[aDecoder decodeObjectForKey:nameStr] forKey:nameStr];
        }
        free(member);
    }
    return self;
}


#pragma mark - Override

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *member = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar var = member[i];
        const char *memberName = ivar_getName(var);
        NSString * nameStr = [NSString stringWithCString:memberName encoding:NSUTF8StringEncoding];
        [aCoder encodeObject:[self valueForKey:nameStr] forKey:nameStr];
    }
    free(member);
}




@end
