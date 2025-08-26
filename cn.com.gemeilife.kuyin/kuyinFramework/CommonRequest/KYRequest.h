//
//  KYRequest.h
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KYRequest : NSObject

//获取access_Token
+ (NSString *)getKY_X_Token;
//获取帐号数据
+ (NSDictionary *)getAccountDict;
//移除帐号数据
+ (void)removeAccountDict;
//是否登录帐号
+ (BOOL)isLogin;
//获取账号密码
+ (NSString *)getPassWord;


//登录 接口
+ (void)KYLoginWithPostWithAccount:(NSString *)account withPassWord:(NSString *)passWord withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//homePage 接口
+ (void)KYHomePageWithGetWithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//设备列表 接口
+ (void)KYHomePage_DeviceManageWithGetWithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

// 设备列表搜索
+ (void)KYHomePage_deviceListSearchWithGetWithKeyword:(NSString *)keyword WithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//设备详情 接口
+ (void)KYHomePage_DeviceDetailWithGetWithID:(NSString *)ID WIthRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//设备详情 修改设备别名接口
+ (void)KYDeviceDetailWithPostWithID:(NSString *)ID withNick:(NSString *)nick withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//设备详情 修改设备分组 接口
+ (void)KYDeviceDetailUpdateDeviceFieldWithPostWithID:(NSString *)ID withGid:(NSString *)gid withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//设备详情 修改设备安装地址接口
+ (void)KYDeviceDetailLocationWithPostWithID:(NSString *)ID withLocation:(NSString *)location withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//新办水卡 新办卡 分组信息
+ (void)KYHomePage_CreateNewCardGroupListWithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;
//新办水卡 该分组信息中 充值选项
+ (void)KYHomePage_CreateNewCardItemListWith:(NSString *)ID WithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;
// 新办水卡 接口
+ (void)KYHomePageCreatedNewCardWithBirthDay:(NSString *)birthDay WithGID:(NSString *)gid WithMoney:(NSString *)money WithRecharge:(NSString *)recharge WithPhone:(NSString *)phone WithContact:(NSString *)contact withSex:(NSString *)sex WithStature:(NSString *)stature WithRemark:(NSString *)remark WithCardNo:(NSString *)cardNo WithCID:(NSString *)cid withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//设备详情 设备最新状态 接口
+ (void)KYDeviceDetailStatusWithGetWithID:(NSString *)ID withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

// 设备详情 打水 按钮
+ (void)KYDeviceDetailThrashWithPostWithUUID:(NSString *)uuid WithMoney:(NSString *)money withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

// 设备详情 开舱门 按钮
+ (void)KYDeviceDetailOpenDoorWithPostWithUUID:(NSString *)uuid withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//打水记录List 接口
+ (void)KYDeviceDetailWaterRecordWithGetWithID:(NSString *)ID WithPage:(int)page WithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//收入记录List 接口
+ (void)KYDeviceDetailWaterIncomeWithGetWithID:(NSString *)ID WithPage:(int)page  WithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//用户管理List 接口
+ (void)KYHomePage_UserManageWithGetWithPage:(NSInteger)page WithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//用户列表搜索
+ (void)KYHomePage_UserListSearchWithGetWithKeyword:(NSString *)keyword WithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//用户详情
+ (void)KYHomePage_UserDetailWithGetWithID:(NSString *)ID WithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//用户详情 修改账号余额 接口
+ (void)KYUserDetailWithPostWithID:(NSString *)ID withBalance:(NSString *)balance withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//用户详情 修改体测权限 接口
+ (void)KYUserDetailWithPostWithID:(NSString *)ID withMedical:(NSString *)medical withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//用户详情 修改备注姓名 接口
+ (void)KYUserDetailWithPostWithID:(NSString *)ID withName:(NSString *)name withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//登录 修改密码 接口
+ (void)KYAccountChangePassWordWithPostWithOldPassWord:(NSString *)OldPassWord withNewPassWord:(NSString *)NewPassWord withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//水卡管理
+ (void)KYHomePage_WaterCardManageWithGetWithPage:(NSInteger)page WithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

@end

NS_ASSUME_NONNULL_END
