//
//  GSTools.h
//  Afanti
//
//  Created by 许文波 on 16/5/13.
//  Copyright © 2016年 52aft.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSTools : NSObject

@property (nonatomic, copy) void (^notification)(NSNotification *notification);

+ (AFSecurityPolicy*)customSecurityPolicy;
- (void)exitApplicationWithDic:(NSDictionary*)dic;
+ (void)pushWaringViewWithDic:(NSDictionary*)dic;
+ (void)removeDefaultsMessages;
+ (void)observerGoneInForeground:(id)observer;
//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
