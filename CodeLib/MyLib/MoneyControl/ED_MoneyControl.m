//
//  ED_MoneyControl.m
//  DriverCimelia
//
//  Created by zw on 2019/1/2.
//  Copyright © 2019 zw. All rights reserved.
//

#import "ED_MoneyControl.h"

@implementation ED_MoneyControl


+ (NSString *)getMoneyFormatterWithObject:(id)object isHaveChar:(BOOL)isHaveChar {
    //不是string 类型 或者不是nsnumber类型 直接返回空
    if (!([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]])) {
        return nil;
    }
    
    //统统转化为字符串类型
    NSString *string = [NSString stringWithFormat:@"%@",object];
    
    NSArray *array = [string componentsSeparatedByString:@"."];
    NSMutableArray *mutArray = [[NSMutableArray alloc] initWithArray:array];
    [mutArray removeObject:@""];
    if (mutArray.count == 0) {
        return nil;
    }
    NSString *string1 = [mutArray objectAtIndex:0];
    NSMutableString *mutString1 = [[NSMutableString alloc] init];
    if (isHaveChar) {
        NSInteger length = string1.length;
        NSInteger count = (length - 1)/3;
        for (int i = 0; i < length; i ++) {
            NSString *charactSring =  [NSString stringWithFormat:@"%c", [string characterAtIndex:i]];
            [mutString1 appendString:charactSring];
            if (count > 0) {
                if (i  == length - count *3 - 1) {
                    [mutString1 appendString:@","];
                    count  -- ;
                }
            }
        }
    }else{
        [mutString1 appendString:string1];
    }

    if (mutArray.count == 2) {
        NSString *string2 = [mutArray objectAtIndex:1];
        if (string2.length == 1) {
            [mutString1 appendString:[NSString stringWithFormat:@".%@0",string2]];
            return mutString1;
        }else{
            [mutString1 appendString:[NSString stringWithFormat:@".%c%c",[string2 characterAtIndex:0],[string2 characterAtIndex:1]]];
            return mutString1;
        }
        
    }
    
    [mutString1 appendString:@".00"];
    return mutString1;
    
}

@end
