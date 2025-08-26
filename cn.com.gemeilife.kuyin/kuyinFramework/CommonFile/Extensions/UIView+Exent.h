//
//  UIView+Exent.h
//  Afanti
//
//  Created by 许利平 on 16/2/25.
//  Copyright © 2016年 52aft.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Exent)
/// 返回父控制
- (UIViewController *)superViewController;
/// 模块间距
+ (UIView *)spacingView;
/// 模块间距 + frame
+ (UIView *)spacingViewWithFrame:(CGRect)frame;

#pragma mark - 设置部分圆角

/// 设置部分圆角(绝对布局)
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;

///  设置部分圆角(相对布局)
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;

@end
