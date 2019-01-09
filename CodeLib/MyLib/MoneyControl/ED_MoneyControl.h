//
//  ED_MoneyControl.h
//  DriverCimelia
//
//  Created by zw on 2019/1/2.
//  Copyright © 2019 zw. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ED_MoneyControl : NSObject


// 格式化金钱字符串 加，去尾巴操作
+ (NSString *)getMoneyFormatterWithObject:(id)object isHaveChar:(BOOL) isHaveChar;

@end


