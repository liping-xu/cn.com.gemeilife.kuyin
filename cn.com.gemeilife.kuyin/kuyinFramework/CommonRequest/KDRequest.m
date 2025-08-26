//
//  KDRequest.m
//  KoodPower
//
//  Created by lipixu on 2023/10/17.
//

#import "KDRequest.h"

#define KDHOST_URL @"http://192.168.1.230:8100/business/v1"

@implementation KDRequest

//获取帐号数据
+ (NSDictionary *)getAccountDict
{
    NSDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginMsg"];
    return data;
}
//获取access_Token
+ (NSString *)getAccess_Token
{
    NSDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginMsg"];    
    return data[@"access_token"];
}
//获取refresh_Token
+ (NSString *)getRefresh_Token
{
    NSDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginMsg"];
    return data[@"refresh_token"];
}
//登录
+ (void)KDLoginWithPostWithAccount:(NSString *)account withPassWord:(NSString *)passWord withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/login",KDHOST_URL];
    
    [[AFNetRequest sharedInstance] KDRequestPostNoTokenJSONWithUrl:url parameters:@{@"account":account,@"password":passWord} isDes:NO success:^(id responseObject) {
        NSLog(@"%@", responseObject);
        if ([responseObject[@"code"] isEqualToString:@"OK"]) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"result"]];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"LoginMsg"];
            completion(data, YES, responseObject[@"message"]);
        } else {
            completion(nil, NO, responseObject[@"message"]);
        }
            
        } fail:^(id errorResponse, NSInteger statusCode) {
            completion(errorResponse,NO,errorResponse[@"message"]);
        }];
}

//我的接口
+ (void)KDMyselfWithGetWithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/info",KDHOST_URL];
    [[AFNetRequest sharedInstance] KDrequestGetWithUrl:url parameters:nil success:^(id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"OK"]) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"result"]];
            completion(data, YES, responseObject[@"message"]);
        } else {
            completion(nil, NO, @"接口获取失败");
        }
        
    } fail:^(id errorResponse, NSInteger statusCode) {
//        NSLog(@"%@, %ld", errorResponse, (long)statusCode);
        completion(nil, NO, errorResponse[@"message"]);

    }];
    
}


//注册接口
+ (void)KDRegisterWithPostWithMobile:(NSString *)mobile withPassword:(NSString *)password withConfirmPassword:(NSString *)confirmPassword withAgreeProtocol:(NSInteger)agree withVerifyCode:(NSString *)verifyCode withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/register",KDHOST_URL];
    NSNumber *agreeNum = [NSNumber numberWithInteger:agree];
    [[AFNetRequest sharedInstance] KDRequestPostJSONWithUrl:url parameters:@{@"mobile":mobile, @"password":password, @"confirm_password":confirmPassword, @"agree_protocol":agreeNum, @"verify_code":verifyCode} isDes:NO success:^(id responseObject) {
//            NSLog(@"%@", responseObject);
            if ([responseObject[@"code"] isEqualToString:@"OK"]) {
                NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"result"]];
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"LoginMsg"];
                completion(data, YES, responseObject[@"message"]);

            } else {
                completion(nil, YES, @"注册失败");
            }
        
        } fail:^(id errorResponse, NSInteger statusCode) {
//            NSLog(@"%@, %ld", errorResponse, (long)statusCode);
            completion(nil, NO, errorResponse[@"message"]);
        }];

}

//发送短信验证码 按钮事件
+ (void)KDVerifyCodeWithPostWithMobile:(NSString *)mobile withType:(NSString *)type withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/verify-code",KDHOST_URL];
    [[AFNetRequest sharedInstance] KDRequestPostNoTokenJSONWithUrl:url parameters:@{@"mobile":mobile, @"type":type} isDes:NO success:^(id responseObject) {
        NSLog(@"%@", responseObject);
        //这里result是一个字符串
        if ([responseObject[@"code"] isEqualToString:@"OK"]) {
            completion(responseObject, YES, responseObject[@"result"]);
        } else {
            completion(nil, NO, @"短信验证码发送失败");
        }
    } fail:^(id errorResponse, NSInteger statusCode) {
        NSLog(@"%@, %ld", errorResponse, (long)statusCode);
        completion(nil, NO, errorResponse[@"message"]);
    }];
}

//验证码登录 页面事件
+ (void)KDVerifyCodeLoginWithPostWithMobile:(NSString *)mobile withCode:(NSString *)code withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/login/verify-code",KDHOST_URL];
    [[AFNetRequest sharedInstance] KDRequestPostNoTokenJSONWithUrl:url parameters:@{@"mobile":mobile, @"code":code} isDes:NO success:^(id responseObject) {
//        NSLog(@"%@", responseObject);
        if ([responseObject[@"code"] isEqualToString:@"OK"]) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"result"]];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"LoginMsg"];
            completion(data, YES, responseObject[@"message"]);
        } else {
            completion(nil, NO, @"短信验证码发送失败");
        }
        
    } fail:^(id errorResponse, NSInteger statusCode) {
//        NSLog(@"%@, %ld", errorResponse, (long)statusCode);
        completion(nil, NO, errorResponse[@"message"]);
    }];

}

//忘记密码 验证（验证码）
+ (void)KDForgetPassWordWithPostWithMobile:(NSString *)mobile withCode:(NSString *)code withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/validate-verify-code",KDHOST_URL];
    [[AFNetRequest sharedInstance] KDRequestPostNoTokenJSONWithUrl:url parameters:@{@"mobile":mobile, @"code":code} isDes:NO success:^(id responseObject) {
//            NSLog(@"%@", responseObject);
        if ([responseObject[@"code"] isEqualToString:@"OK"]) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"result"]];
            completion(data, YES, responseObject[@"message"]);
            } else {
            completion(nil, NO, @"短信验证码验证失败");
            }
        
        } fail:^(id errorResponse, NSInteger statusCode) {
//            NSLog(@"%@, %ld", errorResponse, (long)statusCode);
            completion(nil, NO, errorResponse[@"message"]);
        }];

}

+ (void)KDLogoutWithRefreshToken:(NSString *)token withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/logout",KDHOST_URL];
    [[AFNetRequest sharedInstance] KDRequestPostJSONWithUrl:url parameters:@{@"refresh_token":token} isDes:NO success:^(id responseObject) {
//        NSLog(@"%@", responseObject);
        if ([responseObject[@"code"] isEqualToString:@"OK"]) {
            completion(nil, YES, @"退出接口调用成功");
        } else {
            completion(nil, NO, @"退出接口调用失败");
        }

    } fail:^(id errorResponse, NSInteger statusCode) {
//        NSLog(@"%@, %ld", errorResponse, (long)statusCode);
        completion(nil, NO, errorResponse[@"message"]);
    }];

}

//修改密码
+ (void)KDChangePasswordWithOldPassword:(NSString *)oldPassword withNewPassword:(NSString *)newPassword withconfirmPassword:(NSString *)confirmPassword withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/update-password",KDHOST_URL];
    
    [[AFNetRequest sharedInstance] KDrequestPUTWithUrl:url parameters:@{@"old_password":oldPassword, @"new_password":newPassword, @"confirm_password":confirmPassword} success:^(id responseObject) {
//            NSLog(@"%@", responseObject);
        if ([responseObject[@"code"] isEqualToString:@"OK"]) {
            completion(nil, YES, @"修改密码成功");
        } else {
            completion(nil, NO, @"修改密码失败");
        }
        
        } fail:^(id errorResponse, NSInteger statusCode) {
//            NSLog(@"%@, %ld", errorResponse, (long)statusCode);
            completion(nil, NO, errorResponse[@"message"]);

        }];
}

//卖出记录
+ (void)KDSellingRecordWithTab:(NSString *)tab withPage:(NSString *)page withSize:(NSString *)size withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/recycle-orders",KDHOST_URL];
    [[AFNetRequest sharedInstance] KDRequestPostJSONWithUrl:url parameters:@{@"tab":tab, @"page":[NSNumber numberWithInt:page.intValue], @"size":[NSNumber numberWithInt:size.intValue]} isDes:NO success:^(id responseObject) {
//        NSLog(@"%@", responseObject);
        if ([responseObject[@"code"] isEqualToString:@"OK"]) {
            completion(responseObject, YES, @"卖出记录接口调用成功");
        } else {
            completion(nil, NO, @"卖出记录接口调用失败");
        }

    } fail:^(id errorResponse, NSInteger statusCode) {
//        NSLog(@"%@, %ld", errorResponse, (long)statusCode);
        completion(nil, NO, errorResponse[@"message"]);
    }];

    
    
}

@end
