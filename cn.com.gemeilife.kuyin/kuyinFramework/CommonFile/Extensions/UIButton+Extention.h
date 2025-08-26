//
//  UIButton+Extention.h
//  Afanti
//
//  Created by 许文波 on 16/8/17.
//  Copyright © 2016年 52aft.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extention)

/**
 *  创建文本按钮
 *
 *  @param title               标题文字
 *  @param fontSize            字体大小
 *  @param normalColor         标题颜色
 *
 *  @return UIButton
 */
+ (instancetype)dx_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor;

/**
 *  创建文本按钮
 *
 *  @param title               标题文字
 *  @param fontSize            字体大小
 *  @param normalColor         标题颜色
 *  @param backgroundImageName 背景图像名称
 *
 *  @return UIButton
 */
+ (instancetype)dx_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor backgroundImageName:(NSString *)backgroundImageName;

/**
 创建文本按钮
 
 @param title               标题文字
 @param fontSize            字体大小
 @param normalColor         标题颜色
@param disabledColor        不能点击颜色
 @param backgroundImageName 背景图像名称
 
 @return UIButton
 */

+ (instancetype)dx_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor disabledColor:(UIColor *)disabledColor backgroundImageName:(NSString *)backgroundImageName;

/**
 创建文本按钮
 
 @param title               标题文字
 @param fontSize            字体大小
 @param normalColor         标题颜色
 @param backgroundImageName 背景图像名称
 @param disabledImageName   不能点击图像名称
 
 @return UIButton
 */

+ (instancetype)dx_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor backgroundImageName:(NSString *)backgroundImageName disabledImageName:(NSString *)disabledImageName;

/**
 创建文本按钮
 
 @param title               标题文字
 @param fontSize            字体大小
 @param normalColor         标题颜色
 @param disabledColor    不能点击颜色
 @param backgroundImageName 背景图像名称
 @param disabledImageName   不能点击图像名称
 
 @return UIButton
 */
+ (instancetype)dx_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor disabledColor:(UIColor *)disabledColor backgroundImageName:(NSString *)backgroundImageName disabledImageName:(NSString *)disabledImageName;

@end
