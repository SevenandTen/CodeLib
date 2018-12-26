//
//  ED_HighPrecisionControl.m
//  CodeLib
//
//  Created by zw on 2018/12/24.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_HighPrecisionControl.h"

@implementation ED_HighPrecisionControl


+ (NSDecimalNumber *)addReslutNumber_A:(id)aObject with_B:(id)bObject {
    return [self resultNumber_A:aObject with_B:bObject type:@"+"];
}


+ (NSString *)addReslutString_A:(id)aObject with_B:(id)bObject {
    return [self resultString_A:aObject with_B:bObject type:@"+"];
}


+ (NSDecimalNumber *)subtractReslutNumber_A:(id)aObject with_B:(id)bObject {
    return [self resultNumber_A:aObject with_B:bObject type:@"-"];
}

+ (NSString *)subtractReslutString_A:(id)aObject with_B:(id)bObject {
    return [self resultString_A:aObject with_B:bObject type:@"-"];
}


+ (NSDecimalNumber *)multiplyReslutNumber_A:(id)aObject with_B:(id)bObject {
    return [self resultNumber_A:aObject with_B:bObject type:@"*"];
}

+ (NSString *)multiplyReslutString_A:(id)aObject with_B:(id)bObject {
    return [self resultString_A:aObject with_B:bObject type:@"*"];
}

+ (NSNumber *)divideReslutNumber_A:(id)aObject with_B:(id)bObject {
    return [self resultNumber_A:aObject with_B:bObject type:@"/"];
}

+ (NSString *)divideReslutString_A:(id)aObject with_B:(id)bObject {
    return [self resultString_A:aObject with_B:bObject type:@"/"];
}








#pragma mark - Private




+ (NSDecimalNumber *)resultNumber_A:(id)aObject with_B:(id)bObject type:(NSString *)type {
       // a对象 不是NSString衍生类  类型 或者不是NSNumber 的衍生类
    if (!([aObject isKindOfClass:[NSString class]] || [aObject isKindOfClass:[NSNumber class]])) {
        return nil;
    }
    
    //同上
    if (!([bObject isKindOfClass:[NSString class]] || [bObject isKindOfClass:[NSNumber class]])) {
        return nil;
    }
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",aObject]];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",bObject]];
   
    
    
    if ([type isEqualToString:@"+"]) {
       return [aNumber decimalNumberByAdding:bNumber];
    }else if ([type isEqualToString:@"-"]) {
        return [aNumber decimalNumberBySubtracting:bNumber];
    }else if ([type isEqualToString:@"*"]) {
        return [aNumber decimalNumberByMultiplyingBy:bNumber];
    }else if ([type isEqualToString:@"/"]){
        NSDecimalNumber *zeroNumber = [NSDecimalNumber decimalNumberWithString:@"0"];
        NSComparisonResult result = [bNumber compare:zeroNumber];
        if (result == NSOrderedSame) {
            return nil;
        }
        
        
        return [aNumber decimalNumberByDividingBy:bNumber];
    }
    return nil;
    
}


+ (NSString *)resultString_A:(id)aObject with_B:(id)bObject type:(NSString *)type {
    id object = [self resultNumber_A:aObject with_B:bObject type:type];
    
    return object ? [NSString stringWithFormat:@"%@",object] : nil;
   
}

@end
