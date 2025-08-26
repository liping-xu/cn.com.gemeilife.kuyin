//
//  UIButton+Extention.m
//  Afanti
//
//  Created by 许文波 on 16/8/17.
//  Copyright © 2016年 52aft.com. All rights reserved.
//

#import "UIButton+Extention.h"

@implementation UIButton (Extention)

+ (instancetype)dx_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor
{
    return [self dx_textButton:title fontSize:fontSize normalColor:normalColor disabledColor:normalColor backgroundImageName:nil disabledImageName:nil];
}

+ (instancetype)dx_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor backgroundImageName:(NSString *)backgroundImageName
{
    return [self dx_textButton:title fontSize:fontSize normalColor:normalColor disabledColor:normalColor backgroundImageName:backgroundImageName disabledImageName:nil];
}

+ (instancetype)dx_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor disabledColor:(UIColor *)disabledColor backgroundImageName:(NSString *)backgroundImageName
{
    return [self dx_textButton:title fontSize:fontSize normalColor:normalColor disabledColor:disabledColor backgroundImageName:backgroundImageName disabledImageName:nil];
}

+ (instancetype)dx_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor backgroundImageName:(NSString *)backgroundImageName disabledImageName:(NSString *)disabledImageName
{
    return [self dx_textButton:title fontSize:fontSize normalColor:normalColor disabledColor:normalColor backgroundImageName:backgroundImageName disabledImageName:disabledImageName];
}

+ (instancetype)dx_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor disabledColor:(UIColor *)disabledColor backgroundImageName:(NSString *)backgroundImageName disabledImageName:(NSString *)disabledImageName
{
    UIButton *button = [[self alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateDisabled];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:disabledColor forState:UIControlStateDisabled];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    if (backgroundImageName != nil) {
        NSString *bgImageNameDis = [backgroundImageName stringByAppendingString:@"_disabled"];
        if (disabledImageName != nil) {
            bgImageNameDis = disabledImageName;
        }
        NSString *bgImageNameHL = [backgroundImageName stringByAppendingString:@"_highlighted"];
        UIImage *imageNor = [UIImage imageNamed:backgroundImageName];
        UIImage *imageDis = [UIImage imageNamed:bgImageNameDis];
        UIImage *imageHL = [UIImage imageNamed:bgImageNameHL];
        CGFloat w = imageNor.size.width * 0.5;
        CGFloat h = imageNor.size.height * 0.5;
        imageNor = [imageNor resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
        imageDis = [imageDis resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
        imageHL = [imageHL resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
        [button setBackgroundImage:imageNor forState:UIControlStateNormal];
        [button setBackgroundImage:imageDis forState:UIControlStateDisabled];
        if (imageHL != nil) {
            [button setBackgroundImage:imageHL forState:UIControlStateHighlighted];
        } else {
            [button setBackgroundImage:imageNor forState:UIControlStateHighlighted];
        }
    }
    
    [button sizeToFit];
    
    return button;
}

@end
