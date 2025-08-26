//
//  UIFont+Extention.m
//  Afanti
//
//  Created by 许文波 on 16/7/22.
//  Copyright © 2016年 52aft.com. All rights reserved.
//

#import "UIFont+Extention.h"

@implementation UIFont (Extention)

+ (UIFont *)PFRegularSize:(CGFloat)size
{
    return  [self fontWithName:@"PingFangSC-Regular" size:size];
}

+ (UIFont *)PFMediumSize:(CGFloat)size
{
    return  [self fontWithName:@"PingFangSC-Medium" size:size];
}

+ (UIFont *)PFSemiboldSize:(CGFloat)size
{
    return  [self fontWithName:@"PingFangSC-Semibold" size:size];
}

+ (UIFont *)SFRegularSize:(CGFloat)size
{
    return  [self fontWithName:@"SFUIText-Regular" size:size];
}

+ (UIFont *)SFMediumSize:(CGFloat)size
{
    return [self fontWithName:@"SFUIText-Medium" size:size];
}

+ (UIFont *)SFSemiboldSize:(CGFloat)size
{
    return [self fontWithName:@"SFUIText-Semibold" size:size];
}

@end
