//
//  KY_Account_Model.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/9.
//

#import "KY_Account_Model.h"

@implementation KY_Account_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    DLog(@"%@", key);
}

+ (instancetype)KY_Account_ModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end

@implementation KY_Account_MySelf_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

+ (instancetype)KY_Account_MySelf_ModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end

@implementation KY_Account_Setting_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

+ (instancetype)KY_Account_Setting_ModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end

@implementation KY_Account_AboutUs_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

+ (instancetype)KY_Account_AboutUs_ModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end

@implementation KY_Account_ChangePassWord_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

+ (instancetype)KY_Account_ChangePassWord_ModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end
