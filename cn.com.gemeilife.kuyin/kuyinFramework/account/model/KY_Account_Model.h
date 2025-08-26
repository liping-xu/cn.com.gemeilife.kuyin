//
//  KY_Account_Model.h
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KY_Account_Model : NSObject

+ (instancetype)KY_Account_ModelWithDictionary:(NSDictionary *)dict;

@end


@interface KY_Account_MySelf_Model : KY_Account_Model

+ (instancetype)KY_Account_MySelf_ModelWithDictionary:(NSDictionary *)dict;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *icon;

@end


@interface KY_Account_Setting_Model : KY_Account_Model

+ (instancetype)KY_Account_Setting_ModelWithDictionary:(NSDictionary *)dict;

@property (nonatomic,copy) NSString *title;

@end

@interface KY_Account_AboutUs_Model : KY_Account_Model

+ (instancetype)KY_Account_AboutUs_ModelWithDictionary:(NSDictionary *)dict;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *value;

@end

@interface KY_Account_ChangePassWord_Model : KY_Account_Model

+ (instancetype)KY_Account_ChangePassWord_ModelWithDictionary:(NSDictionary *)dict;

@property (nonatomic,copy) NSString *placeHolder;

@end

NS_ASSUME_NONNULL_END
