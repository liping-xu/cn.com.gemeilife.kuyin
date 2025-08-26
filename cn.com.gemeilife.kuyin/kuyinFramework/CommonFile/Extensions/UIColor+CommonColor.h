//
//  UIColor+CommonColor.h
//  Afanti
//
//  Created by 许文波 on 16/8/10.
//  Copyright © 2016年 52aft.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CommonColor)

/// 模糊搜索 #FD8F26
+ (UIColor *)dx_FD8F26Color;
/// 背景(new) #F6F6F6
+ (UIColor *)dx_F6F6F6Color;
/// lineColor #D9D9D9
+ (UIColor *)dx_D9D9D9Color;
/// 股票收益负(绿) #0FC70F
+ (UIColor *)dx_0FC70FColor;
/// 股票收益正(红) #FD2500
+ (UIColor *)dx_FD2500Color;
/// 主题色（基本按钮) #FB5D5F
+ (UIColor *)dx_FB5D5FColor;
/// (辅助文字) #999999
+ (UIColor *)dx_999999Color;
/// 背景颜色(old) #F2F2F2
+ (UIColor *)dx_F2F2F2Color;
/// 弱提示文字 #C7C7C7
+ (UIColor *)dx_C7C7C7Color;
/// 正文(次要文字) #666666
+ (UIColor *)dx_666666Color;
/// 黑色(主要文字) #333333
+ (UIColor *)dx_333333Color;
/// 根据16进制颜色返回10进制颜色
+ (UIColor *)colorWithHex:(NSInteger)hexValue;
+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
/// 根据10进制颜色返回16进制颜色
+ (NSString *)hexFromUIColor:(UIColor *)color;

@end
