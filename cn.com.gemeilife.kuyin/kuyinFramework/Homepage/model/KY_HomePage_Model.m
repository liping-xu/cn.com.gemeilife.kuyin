//
//  KY_HomePage_Model.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/1.
//

#import "KY_HomePage_Model.h"

@implementation KY_HomePage_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    DLog(@"%@", key);
}

+ (instancetype)kd_HomePage_ModelWithDictionary:(NSDictionary *)dict
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


@implementation KY_CreateNewCard_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

+(instancetype)kd_CreateNewCardWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end

@implementation KY_DeviceList_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"ID"]) {
        self.Title = value;
    }
}

+ (instancetype)KY_DeviceList_ModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end

@implementation KY_DeviceDetail_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

+ (instancetype)KY_DeviceDetail_ModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end

@implementation KY_WaterRecord_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

+ (instancetype)KY_WaterRecord_ModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end

@implementation KY_Income_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

+ (instancetype)KY_Income_ModelWithDictionary:(NSDictionary *)dict;
{
    return [[self alloc] initWithDictionary:dict];
}

@end


@implementation KY_CreateNewCard_GroupList_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

+ (instancetype)KY_CreateNewCard_GroupList_ModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end


@implementation KY_CreateNewCard_Group_ItemList_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

+ (instancetype)KY_CreateNewCard_Group_ItemList_ModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end

@implementation KY_DeviceDetailStatus_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

+ (instancetype)KY_DeviceDetailStatus_ModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end

@implementation KY_DeviceDetail_parameterSetting_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

+ (instancetype)KY_DeviceDetail_parameterSetting_ModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end


@implementation KY_UserList_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+ (instancetype)KY_UserList_ModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end

@implementation KY_UserDetail_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+ (instancetype)KY_UserDetail_ModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end

@implementation KY_WaterCardList_Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+ (instancetype)KY_WaterCardList_ModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end
