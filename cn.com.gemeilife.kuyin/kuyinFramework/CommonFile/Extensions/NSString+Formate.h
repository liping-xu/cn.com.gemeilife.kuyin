//
//  NSString+Formate.h
//  Afanti
//
//  Created by 许文波 on 16/3/22.
//  Copyright © 2016年 52aft.com. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface NSString (Formate)

/// 保留两位小数
- (NSString *)formate;
/// 加 % 号
- (NSString *)addPercent;
/// 加 + 号
- (NSString *)addPlus;
/// 保留两位小数并添加单位 万。亿
- (NSString *)addUnit;
/// 量纲元单位 5.82亿元 5122万元
- (NSString*)dimensionAddUnit;
- (NSMutableAttributedString *)attStringWithFont:(UIFont *)font;
/**
 *  计算文本占用的宽高
 *
 *  @param font    显示的字体
 *  @param maxSize 最大的显示范围
 *
 *  @return 占用的宽高
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
/// md5
- (NSString *)md5;
- (BOOL)isValidate;
- (NSString *)stringToMD5:(NSString *)inputStr;
/// 由英文、字母或数字组成 6-20位
- (BOOL)isEvaluate;

- (BOOL)isMobileNumber:(NSString *)mobileNum;
@end
