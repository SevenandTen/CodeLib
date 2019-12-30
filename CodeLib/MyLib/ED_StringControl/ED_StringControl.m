//
//  ED_StringControl.m
//  CodeLib
//
//  Created by zw on 2019/12/25.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_StringControl.h"

@implementation ED_StringControl


+ (BOOL)isChineseCharacter:(NSString *)target {
    NSString *regex = @"^[\\u4E00-\\u9FEA]+$";
     return ([target rangeOfString:regex options:NSRegularExpressionSearch].length > 0);
}

+ (BOOL)isEnglishCharacter:(NSString *)target {
    NSString *upperRegex = @"^[\\u0041-\\u005A]+$";

    NSString *lowerRegex = @"^[\\u0061-\\u007A]+$";

    BOOL isEnglish = (([target rangeOfString:upperRegex options:NSRegularExpressionSearch].length > 0) || ([target rangeOfString:lowerRegex options:NSRegularExpressionSearch].length > 0));

    return isEnglish;
}


+ (BOOL)isNumberCharacter:(NSString *)target {
    NSString *regex = @"^[\\u0030-\\u0039]+$";

     return ([target rangeOfString:regex options:NSRegularExpressionSearch].length > 0);
}


@end
