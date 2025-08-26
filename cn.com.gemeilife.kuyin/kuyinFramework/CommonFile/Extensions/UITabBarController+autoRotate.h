//
//  UITabBarController+autoRotate.h
//  横屏
//
//  Created by JDY on 15/7/21.
//  Copyright (c) 2015年 dengchuanjiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (autoRotate)
-(BOOL)shouldAutorotate;
- (NSUInteger)supportedInterfaceOrientations;

@end
