//
//  UIColor+CommonColor.m
//  Afanti
//
//  Created by 许文波 on 16/8/10.
//  Copyright © 2016年 52aft.com. All rights reserved.
//

#import "UIColor+CommonColor.h"

@implementation UIColor (CommonColor)

/// 模糊搜索 #FD8F26
+ (UIColor *)dx_FD8F26Color
{
    return [UIColor colorWithHex:0xFD8F26];
}

/// 背景(new) #F6F6F6
+ (UIColor *)dx_F6F6F6Color
{
    return [UIColor colorWithHex:0xF6F6F6];
}

/// lineColor #D9D9D9
+ (UIColor *)dx_D9D9D9Color
{
    return [UIColor colorWithHex:0xD9D9D9];
}

/// 股票收益负(绿) #0FC70F
+ (UIColor *)dx_0FC70FColor
{
    return [UIColor colorWithHex:0x0FC70F];
}

/// 股票收益正(红) #FD2500
+ (UIColor *)dx_FD2500Color
{
    return [UIColor colorWithHex:0xFD2500];
}

/// 主题色（基本按钮) #FB5D5F
+ (UIColor *)dx_FB5D5FColor
{
    return [UIColor colorWithHex:0xFB5D5F];
}

/// (辅助文字) #999999
+ (UIColor *)dx_999999Color
{
    return [UIColor colorWithHex:0x999999];
}

/// 背景颜色(old) #F2F2F2
+ (UIColor *)dx_F2F2F2Color
{
    return [UIColor colorWithHex:0xF2F2F2];
}

/// 弱提示文字 #C7C7C7
+ (UIColor *)dx_C7C7C7Color
{
    return [UIColor colorWithHex:0xC7C7C7];
}

/// 正文(次要文字) #666666
+ (UIColor *)dx_666666Color
{
    return [UIColor colorWithHex:0x666666];
}

/// 黑色(主要文字) #333333
+ (UIColor *)dx_333333Color
{
    return [UIColor colorWithHex:0x333333];
}

/// 根据16进制颜色返回10进制颜色
+ (UIColor *) colorWithHex:(NSInteger)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hexValue & 0xFF)) / 255.0 alpha:alphaValue];
}

/// 根据10进制颜色返回16进制颜色
+ (NSString *) hexFromUIColor:(UIColor *)color
{
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    return [NSString stringWithFormat:@"#%x%x%x", (int)((CGColorGetComponents(color.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}

@end
