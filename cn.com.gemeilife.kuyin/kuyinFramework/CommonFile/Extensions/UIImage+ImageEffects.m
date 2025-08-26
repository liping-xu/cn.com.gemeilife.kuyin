//
//  UIImage+ImageEffects.m
//  Afanti
//
//  Created by lipixu on 15/7/31.
//  Copyright (c) 2015年 52aft.com. All rights reserved.
//

#import "UIImage+ImageEffects.h"
#import <Accelerate/Accelerate.h>
#import <float.h>

@implementation UIImage (ImageEffects)

/**
 *  创建圆角头像图像
 *
 *  @param size        尺寸
 *  @param backColor   背景颜色
 *
 *  @return 裁切后的图像
 */
- (UIImage *)dx_avatarImageWithSize:(CGSize )size
                          backColor:(UIColor *)backColor
{
    return [self dx_avatarImageWithSize:size backColor:backColor borderColor:nil borderWidth:0];
}

/**
 *  创建圆角头像图像
 *
 *  @param size        尺寸
 *  @param backColor   背景颜色
 *  @param borderColor 边框颜色
 *  @param borderWidth 边框宽度
 *
 *  @return 裁切后的图像
 */
- (UIImage *)dx_avatarImageWithSize:(CGSize )size
                          backColor:(UIColor *)backColor
                        borderColor:(UIColor *)borderColor
                        borderWidth:(CGFloat )borderWidth
{
    CGSize inSize = size;
    if (inSize.width == 0) {
        inSize = CGSizeMake(34, 34);
    }
    
    CGRect rect = CGRectMake(0, 0, inSize.width, inSize.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
    [backColor setFill];
    UIRectFill(rect);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
    [self drawInRect:rect];
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    borderPath.lineWidth = borderWidth;
    [borderColor setStroke];
    [borderPath stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
