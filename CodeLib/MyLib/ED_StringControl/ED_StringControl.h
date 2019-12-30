//
//  ED_StringControl.h
//  CodeLib
//
//  Created by zw on 2019/12/25.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ED_StringControl : NSObject


+ (BOOL)isChineseCharacter:(NSString *)target;

+ (BOOL)isEnglishCharacter:(NSString *)target;

+ (BOOL)isNumberCharacter:(NSString *)target;

@end

NS_ASSUME_NONNULL_END
