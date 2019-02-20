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

+ (NSDate *)getDateFromString:(NSString *)string timeForm:(NSString *)timeForm {
    if (string.length == 0) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = timeForm;
    return [formatter dateFromString:string];
}


- (NSDate *)getMonthBeginDate {
    NSString *dateString = [self getStringDateWithTimeForm:@"YY-MM"];
    dateString = [dateString stringByAppendingString:@"-01 00:00:00"];
    return [NSDate getDateFromString:dateString timeForm:@"YY-MM-dd HH:mm:ss"];
}

- (NSDate *)getMonthEndDate {
    NSString *monthString = [self getStringDateWithTimeForm:@"MM"];
    NSString *yearString = [self getStringDateWithTimeForm:@"YY"];
    NSInteger month = [monthString integerValue];
    NSInteger year = [yearString integerValue];
    NSInteger day = 0;
    if (month == 2 ) {
        if ((year %4 == 0 && year % 100 != 0) || (year %400 == 0)) {
            day = 29;
        }else{
            day = 28;
        }
    }else if (month == 4 || month == 6 || month ==9 || month == 11) {
        day = 30;
    }else{
        day = 31;
    }
    NSString *dateString = [NSString stringWithFormat:@"%@-%@-%d 23:59:59",yearString,monthString,day];
    return [NSDate getDateFromString:dateString timeForm:@"YY-MM-dd HH:mm:ss"];
    
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
