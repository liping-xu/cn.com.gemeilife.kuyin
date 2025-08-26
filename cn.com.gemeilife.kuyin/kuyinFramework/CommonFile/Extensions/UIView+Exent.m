//
//  UIView+Exent.m
//  Afanti
//
//  Created by 许利平 on 16/2/25.
//  Copyright © 2016年 52aft.com. All rights reserved.
//

#import "UIView+Exent.h"

@implementation UIView (Exent)
- (UIViewController*)superViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

#pragma mark - 模块间间距

/**
 *  模块间间距
 *
 *  @return 模块间距
 */
+ (UIView *)spacingView
{
    UIView *view = [[UIView alloc] init];
    [view layerContentsWithImageName:@"GSyinying"];
    return view;
}

/**
 *  返回frame的模块间距
 *
 *  @param frame frame
 *
 *  @return 模块间间距
 */
+ (UIView *)spacingViewWithFrame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view layerContentsWithImageName:@"GSyinying"];
    return view;
}

/**
 *  模块间距
 *
 *  @param name 图片名称
 */
- (void)layerContentsWithImageName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    self.layer.contents = (id)image.CGImage;
}

#pragma mark - 设置部分圆角
/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
{
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect
{
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

@end
