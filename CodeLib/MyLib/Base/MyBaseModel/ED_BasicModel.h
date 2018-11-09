//
//  ED_BasicModel.h
//  MyCode
//
//  Created by 崎崎石 on 2018/1/10.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+RemoveNull.h"

@interface ED_BasicModel : NSObject<NSCoding>



+ (instancetype)shareInstance;


- (instancetype)initWithDic:(NSDictionary *)dic;


+ (NSArray *)createModelsWithArray:(NSArray<NSDictionary *> *)array;


- (void)dealWithData:(NSDictionary *)data;



@end
