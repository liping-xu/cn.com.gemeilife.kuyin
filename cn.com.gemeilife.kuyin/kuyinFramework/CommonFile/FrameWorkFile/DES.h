//
//  DES.h
//  Sorting
//
//  Created by lipixu on 15/7/8.
//  Copyright (c) 2015年 lipixu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES : NSObject
//加密
+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
//解密
+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;
@end
