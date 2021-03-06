//
//  NSDate+FormatDate.h
//  BaseCode
//
//  Created by zw on 2018/10/24.
//  Copyright © 2018年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 时间格式化工具 by 石崎崎
 
 */
@interface NSDate (FormatDate)




/**
 获取当前时间 最早时间 即 00:00:00
 @return date
 */
- (NSDate*)getDayBeginDate;


/**
  获取当前时间 最晚时间 即 23:59:59
 @return date 
 */
- (NSDate*)getDayEndData;



/**
 根据时间挫 和 时间格式获取 时间字符串

 @param timestamp 时间挫
 @param timeForm 时间格式
 @return 时间字符串
 */
+ (NSString *)getStringDateWithTimestamp:(id)timestamp timeForm:(NSString *)timeForm;


/**
  根据当前时间 和你想样的 时间格式 比如 2018-10-25   你就要传入 yyyy-MM-dd 转化为时间字符串
 @param timeForm 时间格式 yyyy-MM-dd
 @return 时间字符串
 */
- (NSString *)getStringDateWithTimeForm:(NSString *)timeForm;



/**
 根据 string  和 时间格式 获取 date

 @param string 时间字符串
 @param timeForm 时间格式 yyyy-MM-dd
 @return date
 */
+ (NSDate *)getDateFromString:(NSString *)string timeForm:(NSString *)timeForm;



// 获取当月开始时间
- (NSDate *)getMonthBeginDate;

// 获取当月结束时间
- (NSDate *)getMonthEndDate;

@end


