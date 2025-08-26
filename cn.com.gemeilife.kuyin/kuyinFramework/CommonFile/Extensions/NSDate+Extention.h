//
//  NSDate+Extention.h
//  Afanti
//
//  Created by 许文波 on 16/8/16.
//  Copyright © 2016年 52aft.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extention)

/// MM月-dd日格式日期
+ (NSString *)dateFormateMonthAndDay:(NSString *)string;
+ (NSString *)dateFormate:(NSString *)string;
///  距离当前分钟
+ (int)intervalMinSinceNow:(NSString *)theDate;

+ (NSString *)sinceNow;

@end
