//
//  NSData+Extention.m
//  DemoTest
//
//  Created by 许文波 on 16/8/18.
//  Copyright © 2016年 dxzq.net. All rights reserved.
//

#import "NSData+Extention.h"

@implementation NSData (Extention)

+ (NSData *)toJSONData:(id)data
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    } else {
        return nil;
    }
}

@end
