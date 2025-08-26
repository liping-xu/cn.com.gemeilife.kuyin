//
//  NSDate+Extention.m
//  Afanti
//
//  Created by 许文波 on 16/8/16.
//  Copyright © 2016年 52aft.com. All rights reserved.
//

#import "NSDate+Extention.h"

@implementation NSDate (Extention)

/**
 *  返回MM月-dd日格式日期
 *
 *  @param string string
 *
 *  @return 格式日期
 */
+ (NSString *)dateFormateMonthAndDay:(NSString *)string
{
    return [self dateFormate:string dateFormatter:@"yyyy-MM-dd" withDestDateFormatter:@"MM月dd日"];
}

/**
 *  M月d日 HH:mm
 *
 *  @param string string
 *
 *  @return 格式日期
 */
+ (NSString *)dateFormate:(NSString *)string
{
    return [self dateFormate:string dateFormatter:@"yyyy-MM-dd HH:mm:ss" withDestDateFormatter:@"M月d日 HH:mm"];
}

/**
 *  返回指定格式日期
 *
 *  @param string          string
 *  @param dateFormate     日期格式
 *  @param destDateFormate 指定日期格式
 *
 *  @return 格式日期
 */
+ (NSString *)dateFormate:(NSString *)string dateFormatter:(NSString *)dateFormate withDestDateFormatter:(NSString *)destDateFormate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormate];
    NSDate *date = [dateFormatter dateFromString:string];
    [dateFormatter setDateFormat:destDateFormate];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

// 距离当前分钟
+ (int)intervalMinSinceNow:(NSString *)theDate
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d = [date dateFromString:theDate];
    NSTimeInterval late = [d timeIntervalSince1970] * 1;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970] * 1;
    NSString *timeString = @"";
    NSTimeInterval cha = now - late;
    if (cha / 3600 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha / 60];
        timeString = [timeString substringToIndex:timeString.length - 7];
        return [timeString intValue];
    }
    return 0;
}

+ (NSString *)sinceNow
{
    NSDate * senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *date = [dateformatter stringFromDate:senddate];
    return date;
}

@end
