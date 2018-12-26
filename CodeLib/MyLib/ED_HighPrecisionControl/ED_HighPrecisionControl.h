//
//  ED_HighPrecisionControl.h
//  CodeLib
//
//  Created by zw on 2018/12/24.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ED_HighPrecisionControl : NSObject


+ (NSString *)addReslutString_A:(id)aObject with_B:(id)bObject;

+ (NSDecimalNumber *)addReslutNumber_A:(id)aObject with_B:(id)bObject;


+ (NSString *)subtractReslutString_A:(id)aObject with_B:(id)bObject;

+ (NSDecimalNumber *)subtractReslutNumber_A:(id)aObject with_B:(id)bObject;


+ (NSString *)multiplyReslutString_A:(id)aObject with_B:(id)bObject;

+ (NSDecimalNumber *)multiplyReslutNumber_A:(id)aObject with_B:(id)bObject;


+ (NSString *)divideReslutString_A:(id)aObject with_B:(id)bObject;

+ (NSNumber *)divideReslutNumber_A:(id)aObject with_B:(id)bObject;

@end
