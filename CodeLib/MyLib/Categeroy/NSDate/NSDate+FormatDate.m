//
//  NSDate+FormatDate.m
//  BaseCode
//
//  Created by zw on 2018/10/24.
//  Copyright © 2018年 zw. All rights reserved.
//

#import "NSDate+FormatDate.h"

@implementation NSDate (FormatDate)


- (NSDate *)getDayBeginDate {
    return [self getDayDateWithYourWantTime:@" 00:00:00"];
}

- (NSDate *)getDayEndData {
    return [self getDayDateWithYourWantTime:@" 23:59:59"];
}

- (NSString *)getStringDateWithTimeForm:(NSString *)timeForm {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = timeForm;
    return [formatter stringFromDate:self];
}

+ (NSString *)getStringDateWithTimestamp:(id)timestamp timeForm:(NSString *)timeForm {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp longLongValue]/1000.0];
    return [date getStringDateWithTimeForm:timeForm];
}



#pragma mark - Private

- (NSDate *)getDayDateWithYourWantTime:(NSString *)timeString {
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = @"YY-MM-dd";
    NSString *dateString1 = [formatter1 stringFromDate:self];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    formatter2.dateFormat = @"YY-MM-dd HH:mm:ss";
    NSString *dateString2 = [dateString1 stringByAppendingString:timeString];
    NSDate *date = [formatter2 dateFromString:dateString2];
    return date;
}

@end
