//
//  UIFont+Extention.h
//  Afanti
//
//  Created by 许文波 on 16/7/22.
//  Copyright © 2016年 52aft.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Extention)

// 平方字体
+ (UIFont *)PFRegularSize:(CGFloat)size;
+ (UIFont *)PFMediumSize:(CGFloat)size;
+ (UIFont *)PFSemiboldSize:(CGFloat)size;

// SF-UI-Text字体
+ (UIFont *)SFRegularSize:(CGFloat)size;
+ (UIFont *)SFMediumSize:(CGFloat)size;
+ (UIFont *)SFSemiboldSize:(CGFloat)size;

@end
