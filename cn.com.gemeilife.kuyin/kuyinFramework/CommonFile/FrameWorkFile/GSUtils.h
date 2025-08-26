//
//  GSUtils.h
//  Afanti
//
//  Created by 许文波 on 16/4/14.
//  Copyright © 2016年 52aft.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSUtils : NSObject
// 获取当前活动viewcontroller
+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController;

@end
