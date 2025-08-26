//
//  UITabBarController+autoRotate.m
//  横屏
//
//  Created by JDY on 15/7/21.
//  Copyright (c) 2015年 dengchuanjiang. All rights reserved.
//

#import "UITabBarController+autoRotate.h"

@implementation UITabBarController (autoRotate)
- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
- (NSUInteger)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

@end
