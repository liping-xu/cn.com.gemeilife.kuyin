//
//  UILabel+AttributeLabel.h
//  Test
//
//  Created by 许文波 on 16/2/24.
//  Copyright © 2016年 dxzq.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AttributeLabel)

/// 快速初始化属性
- (void)setTextColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont*)font;

/// 字间距
- (void)setTextSpace:(NSInteger)spacing;
/// 行间距
- (void)setLineSpace:(NSInteger)spacing;

/// 图文混排
- (void)setImageWithImageName:(NSString *)imageName imageSize:(CGSize)size index:(NSInteger)index withImageSpace:(NSInteger)imageSpace;
/// 图文混排 + 图片数量
- (void)setImageWithImageName:(NSString *)imageName imageSize:(CGSize)size index:(NSInteger)index withImageSpace:(NSInteger)imageSpace withImageCount:(NSInteger)imageCount;
// 图文混排带字间距
- (void)setImageWithImageName:(NSString *)imageName imageSize:(CGSize)size index:(NSInteger)index withImageSpace:(NSInteger)imageSpace withImageCount:(NSInteger)imageCount withTextSpacing:(NSInteger)textSpacing;

// 富文本
- (void)setTexts:(NSArray *)texts warp:(BOOL)isWarp spacing:(CGFloat)spacing;
/// 文本 + 字体
- (void)setTexts:(NSArray *)texts fonts:(NSArray*)fonts warp:(BOOL)isWarp spacing:(CGFloat)spacing;
/// 文本 + 颜色
- (void)setTexts:(NSArray *)texts colors:(NSArray*)colors warp:(BOOL)isWarp spacing:(CGFloat)spacing;
/// 文本 + 颜色 + 字体
- (void)setTexts:(NSArray *)texts colors:(NSArray *)colors fonts:(NSArray *)fonts warp:(BOOL)isWarp spacing:(CGFloat)spacing;
/// 文本 + 字体 + 换行数组
- (void)setTexts:(NSArray *)texts fonts:(NSArray *)fonts warps:(NSArray *)warps spacing:(CGFloat)spacing;
/// 文本 + 颜色 + 字体 + 换行数组
- (void)setTexts:(NSArray *)texts colors:(NSArray *)colors fonts:(NSArray *)fonts warps:(NSArray *)warps spacing:(CGFloat)spacing;

@end
