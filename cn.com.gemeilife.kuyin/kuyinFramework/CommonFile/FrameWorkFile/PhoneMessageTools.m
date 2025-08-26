//
//  PhoneMessageTools.m
//  Afanti
//
//  Created by 许文波 on 16/3/14.
//  Copyright © 2016年 52aft.com. All rights reserved.
//

#import "PhoneMessageTools.h"
//#import "SSKeychain.h"
#import "sys/utsname.h"

@implementation PhoneMessageTools

/**
 *  手机类型
 *
 *  @return
 */
+ (NSString *)phoneModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    return deviceString;
}

// 唯一标识符
+ (NSString *)getDeviceId
{
//    NSString * currentDeviceUUIDStr = [SSKeychain passwordForService:@" "account:@"uuid"];
//    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""]) {
//        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
//        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
//        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
//        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
//        [SSKeychain setPassword: currentDeviceUUIDStr forService:@" "account:@"uuid"];
//    }
//    return currentDeviceUUIDStr;
    return @"";
}

@end
