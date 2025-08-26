//
//  NSString+Formate.m
//  Afanti
//
//  Created by 许文波 on 16/3/22.
//  Copyright © 2016年 52aft.com. All rights reserved.
//

#import "NSString+Formate.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

#define THOUSAND_FLOAT 1000
#define MILLION_FLOAT  10000
#define BILLION_FLOAT  100000000
#define TENTHOUSAND @"万"
#define MILLION @"亿"

@implementation NSString (Formate)

- (NSString *)formate
{
    return [NSString stringWithFormat:@"%.2f", [self floatValue]];
}

- (NSString *)addPercent
{
    return [NSString stringWithFormat:@"%.2f%%", [self floatValue]];
}

/// 加 + 号 ，如果是正数加“+”，负数则直接返回
- (NSString *)addPlus
{
    CGFloat temp = [self floatValue];
    NSString *string = (temp > 0 && ![[self substringToIndex:0] isEqualToString:@"+"]) ? [NSString stringWithFormat:@"+%.2f", temp] : [NSString stringWithFormat:@"%.2f", temp];
    return string;
}

/// 保留两位小数并添加单位万。亿
- (NSString *)addUnit
{
    NSString *string = self;
    CGFloat numberFloat = [self floatValue];
    CGFloat million = MILLION_FLOAT;
    CGFloat hMillion = BILLION_FLOAT;
    if (numberFloat >= hMillion || numberFloat <= -hMillion) {
        string = [NSString stringWithFormat:@"%.2f%@", numberFloat / hMillion, MILLION];
    } else if ((numberFloat >= million && numberFloat < hMillion) || (numberFloat <= -million && numberFloat > -hMillion)) {
        string = [NSString stringWithFormat:@"%.2f%@", numberFloat / million, TENTHOUSAND];
    } else {
        string = [NSString stringWithFormat:@"%.2f", numberFloat];
    }
    return string;
}

/// 量纲元单位 5.82亿元 5122万元
- (NSString*)dimensionAddUnit
{
    NSString *string;
    CGFloat numberFloat = [self floatValue];
    CGFloat million = MILLION_FLOAT;
    CGFloat hMillion = BILLION_FLOAT;
    NSString *valueString;
    if (numberFloat >= hMillion || numberFloat <= -hMillion) {
        valueString = [NSString stringWithFormat:@"%.2f", numberFloat / hMillion];
        valueString = [self cutNumber:valueString];
        string = [NSString stringWithFormat:@"%@%@", valueString, MILLION];
    } else if ((numberFloat >= million && numberFloat < hMillion) || (numberFloat <= -million && numberFloat > -hMillion)) {
        valueString = [NSString stringWithFormat:@"%.2f", numberFloat / million];
        valueString = [self cutNumber:valueString];
        string = [NSString stringWithFormat:@"%@%@", valueString, TENTHOUSAND];
    } else {
        string = [NSString stringWithFormat:@"%.2f", numberFloat];
        string = [self cutNumber:string];
    }
    return string;
}

- (NSString *)cutNumber:(NSString *)string
{
    NSString *str = string;
    if ([string componentsSeparatedByString:@"."][0].length >= 4) {
        str = [string componentsSeparatedByString:@"."][0];
    } else {
        if (string.length > 5) {
            str = [NSString stringWithFormat:@"%.1f", [string floatValue]];
        }
    }
    return str;
}

- (NSMutableAttributedString *)attStringWithFont:(UIFont *)font
{
    NSMutableAttributedString *aContent = [[NSMutableAttributedString alloc] initWithString:self];
    [aContent addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
    return aContent;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
             result[0], result[1], result[2], result[3],result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]
             ] uppercaseString];
}

- (NSString *)stringToMD5:(NSString *)inputStr
{
    const char *cStr = [inputStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    NSString *resultStr = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    return [resultStr lowercaseString];
}


- (BOOL)isValidate
{
    NSString *stringRegex = @"^([\u4e00-\u9fa5]+|[a-zA-Z0-9]+)$";
    NSPredicate *stringTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    return [stringTest evaluateWithObject:self];
}

/// 由英文、字母或数字组成 6-20位
- (BOOL)isEvaluate
{
    NSString * regex = @"^[A-Za-z0-9_]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    //    电信号段:133/153/180/181/189/177
    
    //    联通号段:130/131/132/155/156/185/186/145/176
    
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
    
}

@end
