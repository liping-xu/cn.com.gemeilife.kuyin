//
//  KDRequest.h
//  KoodPower
//
//  Created by lipixu on 2023/10/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDRequest : NSObject

//获取帐号数据
+ (NSDictionary *)getAccountDict;
//获取access_Token
+ (NSString *)getAccess_Token;
//获取refresh_Token
+ (NSString *)getRefresh_Token;

//登录接口
+ (void)KDLoginWithPostWithAccount:(NSString *)account withPassWord:(NSString *)passWord withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;
//我的
+ (void)KDMyselfWithGetWithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;
//注册接口
+ (void)KDRegisterWithPostWithMobile:(NSString *)mobile withPassword:(NSString *)password withConfirmPassword:(NSString *)confirmPassword withAgreeProtocol:(NSInteger)agree withVerifyCode:(NSString *)verifyCode withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//发送短信验证码 按钮事件
+ (void)KDVerifyCodeWithPostWithMobile:(NSString *)mobile withType:(NSString *)type withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//验证码登录 页面事件
+ (void)KDVerifyCodeLoginWithPostWithMobile:(NSString *)mobile withCode:(NSString *)code withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//忘记密码 验证（验证码）
+ (void)KDForgetPassWordWithPostWithMobile:(NSString *)mobile withCode:(NSString *)code withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//退出登录
+ (void)KDLogoutWithRefreshToken:(NSString *)token withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;
//修改密码
+ (void)KDChangePasswordWithOldPassword:(NSString *)oldPassword withNewPassword:(NSString *)newPassword withconfirmPassword:(NSString *)confirmPassword withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;

//卖出记录
+ (void)KDSellingRecordWithTab:(NSString *)tab withPage:(NSString *)page withSize:(NSString *)size withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;


@end

NS_ASSUME_NONNULL_END
