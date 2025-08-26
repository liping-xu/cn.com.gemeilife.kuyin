//
//  UIImage+ImageEffects.h
//  Afanti
//
//  Created by lipixu on 15/7/31.
//  Copyright (c) 2015年 52aft.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageEffects)

/// 圆角头像(无边框)
- (UIImage *)dx_avatarImageWithSize:(CGSize )size
                          backColor:(UIColor *)backColor;
/// 圆角头像(边框)
- (UIImage *)dx_avatarImageWithSize:(CGSize )size
                          backColor:(UIColor *)backColor
                        borderColor:(UIColor *)borderColor
                        borderWidth:(CGFloat )borderWidth;

@end
