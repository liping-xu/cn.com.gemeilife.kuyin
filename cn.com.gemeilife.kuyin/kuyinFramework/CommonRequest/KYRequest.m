//
//  KYRequest.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/7.
//

#import "KYRequest.h"

#define KDHOST_URL @"https://gm.hfljyx.com/api/"


@implementation KYRequest

//获取access_Token
+ (NSString *)getKY_X_Token
{
    NSDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginMsg"];
    return data[@"token"];
}
//获取账号密码
+ (NSString *)getPassWord
{
    NSDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginMsg"];
    return data[@"passWord"];
}

//获取帐号数据
+ (NSDictionary *)getAccountDict
{
    NSDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginMsg"];
    return data;
}

+ (void)removeAccountDict
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginMsg"];
}

+ (BOOL)isLogin
{
    NSDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginMsg"];
    if (data.count != 0) {
        return YES;
    } else {
        return NO;
    }
}

//登录接口
+ (void)KYLoginWithPostWithAccount:(NSString *)account withPassWord:(NSString *)passWord withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@merchant/login", KDHOST_URL];
    [[AFNetRequest sharedInstance] KYRequestPostNoTokenJSONWithUrl:url parameters:@{@"username":account,@"password":passWord} isDes:NO success:^(id responseObject) {
//        NSLog(@"%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:responseObject[@"data"]];
            [data setValue:passWord forKey:@"passWord"];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"LoginMsg"];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }

        } fail:^(id errorResponse, NSInteger statusCode) {
            completion(errorResponse,NO,errorResponse[@"message"]);
            
    }];

}

+ (void)KYHomePageWithGetWithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@statistic/merchantAppHome", KDHOST_URL];
    [[AFNetRequest sharedInstance] KYRequestGetWithTokenWithUrl:url parameters:nil success:^(id responseObject) {
//        NSLog(@"%@", responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }
        
            } fail:^(id errorResponse, NSInteger statusCode) {
            completion(nil, NO, errorResponse[@"message"]);

        }];
}

+ (void)KYHomePage_DeviceManageWithGetWithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    
    NSString *url = [NSString stringWithFormat:@"%@device/getDeviceList?page=1&pageSize=5000&keyword=", KDHOST_URL];
    [[AFNetRequest sharedInstance] KYRequestGetWithTokenWithUrl:url parameters:nil success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }
        
            } fail:^(id errorResponse, NSInteger statusCode) {
            completion(nil, NO, errorResponse[@"message"]);

        }];
}

//设备详情接口
+ (void)KYHomePage_DeviceDetailWithGetWithID:(NSString *)ID WIthRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@device/findDevice?ID=%@", KDHOST_URL, ID];
    [[AFNetRequest sharedInstance] KYRequestGetWithTokenWithUrl:url parameters:nil success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }
        
            } fail:^(id errorResponse, NSInteger statusCode) {
            completion(nil, NO, errorResponse[@"message"]);

        }];
}


//修改设备别名接口
+ (void)KYDeviceDetailWithPostWithID:(NSString *)ID withNick:(NSString *)nick withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@device/updateDeviceField", KDHOST_URL];
    
    NSNumber *IDnumber = [NSNumber numberWithInt:[ID intValue]];
    [[AFNetRequest sharedInstance] KYRequestPostWithTokenJSONWithUrl:url parameters:@{@"ID":IDnumber,@"nick":nick} isDes:NO success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }

        } fail:^(id errorResponse, NSInteger statusCode) {
            completion(errorResponse,NO,errorResponse[@"message"]);
        }];

}

//修改设备分组 接口
+ (void)KYDeviceDetailUpdateDeviceFieldWithPostWithID:(NSString *)ID withGid:(NSString *)gid withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@device/updateDeviceField", KDHOST_URL];
    NSNumber *IDnumber = [NSNumber numberWithInt:[ID intValue]];
    NSNumber *gidNumber = [NSNumber numberWithInt:[gid intValue]];
    [[AFNetRequest sharedInstance] KYRequestPostWithTokenJSONWithUrl:url parameters:@{@"ID":IDnumber,@"gid":gidNumber} isDes:NO success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }

        } fail:^(id errorResponse, NSInteger statusCode) {
            completion(errorResponse,NO,errorResponse[@"message"]);
        }];
}

//修改安装地址接口
+ (void)KYDeviceDetailLocationWithPostWithID:(NSString *)ID withLocation:(NSString *)location withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    //https://gm.hfljyx.com/api/device/updateDeviceField
    NSString *url = [NSString stringWithFormat:@"%@device/updateDeviceField", KDHOST_URL];
    NSNumber *IDnumber = [NSNumber numberWithInt:[ID intValue]];
    [[AFNetRequest sharedInstance] KYRequestPostWithTokenJSONWithUrl:url parameters:@{@"ID":IDnumber,@"location":location} isDes:NO success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }

        } fail:^(id errorResponse, NSInteger statusCode) {
            completion(errorResponse,NO,errorResponse[@"message"]);
        }];

}

//请求 新办卡 分组信息
+ (void)KYHomePage_CreateNewCardGroupListWithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@group/getGroupList?page=1&pageSize=200", KDHOST_URL];
    [[AFNetRequest sharedInstance] KYRequestGetWithTokenWithUrl:url parameters:nil success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }
        
            } fail:^(id errorResponse, NSInteger statusCode) {
            completion(nil, NO, errorResponse[@"message"]);

        }];
}


//请求 该分组信息中 充值选项
+ (void)KYHomePage_CreateNewCardItemListWith:(NSString *)ID WithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
//https://gm.hfljyx.com/api/recharge/getGroupRechargeList?gid=5531&page=1&pageSize=200
    NSString *url = [NSString stringWithFormat:@"%@recharge/getGroupRechargeList?gid=%@&page=1&pageSize=200", KDHOST_URL, ID];
    [[AFNetRequest sharedInstance] KYRequestGetWithTokenWithUrl:url parameters:nil success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }
        
            } fail:^(id errorResponse, NSInteger statusCode) {
            completion(nil, NO, errorResponse[@"message"]);
        }];
}

// 新办水卡 接口
+ (void)KYHomePageCreatedNewCardWithBirthDay:(NSString *)birthDay WithGID:(NSString *)gid WithMoney:(NSString *)money WithRecharge:(NSString *)recharge WithPhone:(NSString *)phone WithContact:(NSString *)contact withSex:(NSString *)sex WithStature:(NSString *)stature WithRemark:(NSString *)remark WithCardNo:(NSString *)cardNo WithCID:(NSString *)cid withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    // https://gm.hfljyx.com/api/card/createCard
    NSString *url = [NSString stringWithFormat:@"%@card/createCard", KDHOST_URL];
    NSNumber *GIDnumber = [NSNumber numberWithInt:[gid intValue]];
    NSNumber *moneyNumber = [NSNumber numberWithInt:[money intValue] * 100];
    NSNumber *rechargeNumber = [NSNumber numberWithInt:[recharge intValue] * 100];
    NSNumber *CIDnumber = [NSNumber numberWithInt:[cid intValue]];
    NSNumber *statureNumber = [NSNumber numberWithInt:[stature intValue]];
    NSDictionary *parameters = @{@"birthday":birthDay, @"gid": GIDnumber, @"money":moneyNumber, @"recharge": rechargeNumber, @"phone":phone, @"contact":contact, @"sex":sex, @"stature":statureNumber, @"remark":remark, @"cardNo":cardNo, @"cid":CIDnumber};
    [[AFNetRequest sharedInstance] KYRequestPostWithTokenJSONWithUrl:url parameters:parameters isDes:NO success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }

        } fail:^(id errorResponse, NSInteger statusCode) {
            completion(errorResponse,NO,errorResponse[@"message"]);
        }];
}

//设备详情 设备最新状态 接口
+ (void)KYDeviceDetailStatusWithGetWithID:(NSString *)ID withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@device/getDeviceStatus?id=%@", KDHOST_URL, ID];
    [[AFNetRequest sharedInstance] KYRequestGetWithTokenWithUrl:url parameters:nil success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }
        
            } fail:^(id errorResponse, NSInteger statusCode) {
            completion(nil, NO, errorResponse[@"message"]);
        }];
}

// 设备详情 打水 按钮
+ (void)KYDeviceDetailThrashWithPostWithUUID:(NSString *)uuid WithMoney:(NSString *)money withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    //https://gm.hfljyx.com/api/device/sendCommand
    NSString *url = [NSString stringWithFormat:@"%@device/sendCommand", KDHOST_URL];
    NSNumber *moneyNumber = [NSNumber numberWithInt:[money intValue] * 100];
    NSNumber *keyNumber = [NSNumber numberWithInt:112];
    NSDictionary *parameters = @{@"data": moneyNumber, @"key":keyNumber, @"uuid":uuid};
    [[AFNetRequest sharedInstance] KYRequestPostWithTokenJSONWithUrl:url parameters:parameters isDes:NO success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }

        } fail:^(id errorResponse, NSInteger statusCode) {
            completion(errorResponse,NO,errorResponse[@"message"]);
        }];
}

// 设备详情 开舱门 按钮
+ (void)KYDeviceDetailOpenDoorWithPostWithUUID:(NSString *)uuid withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@device/sendCommand", KDHOST_URL];
    NSNumber *moneyNumber = [NSNumber numberWithInt:0];
    NSNumber *keyNumber = [NSNumber numberWithInt:1001];
    NSDictionary *parameters = @{@"data": moneyNumber, @"key":keyNumber, @"uuid":uuid, @"type":@"A"};
    [[AFNetRequest sharedInstance] KYRequestPostWithTokenJSONWithUrl:url parameters:parameters isDes:NO success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }

        } fail:^(id errorResponse, NSInteger statusCode) {
            completion(errorResponse,NO,errorResponse[@"message"]);
        }];
}


//打水记录List 接口
+ (void)KYDeviceDetailWaterRecordWithGetWithID:(NSString *)ID WithPage:(int)page WithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@orders/getOrdersList?pageSize=20&did=%@&page=%d&payStatus=1&minMoney=1&type=1", KDHOST_URL, ID, page];
    [[AFNetRequest sharedInstance] KYRequestGetWithTokenWithUrl:url parameters:nil success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }
        
            } fail:^(id errorResponse, NSInteger statusCode) {
            completion(nil, NO, errorResponse[@"message"]);
        }];
}

//收入记录List 接口
+ (void)KYDeviceDetailWaterIncomeWithGetWithID:(NSString *)ID WithPage:(int)page  WithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@orders/getOrdersList?pageSize=20&did=%@&page=%d&payStatus=1&minMoney=1&transactionType=100", KDHOST_URL, ID, page];
    [[AFNetRequest sharedInstance] KYRequestGetWithTokenWithUrl:url parameters:nil success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }
        
            } fail:^(id errorResponse, NSInteger statusCode) {
            completion(nil, NO, errorResponse[@"message"]);
        }];
    
}

//用户管理
+ (void)KYHomePage_UserManageWithGetWithPage:(NSInteger)page WithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@member/getMemberList?page=%ld&pageSize=20&keyword=", KDHOST_URL, (long)page];
    [[AFNetRequest sharedInstance] KYRequestGetWithTokenWithUrl:url parameters:nil success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }
        
            } fail:^(id errorResponse, NSInteger statusCode) {
            completion(nil, NO, errorResponse[@"message"]);
        }];
}

//用户详情
+ (void)KYHomePage_UserDetailWithGetWithID:(NSString *)ID WithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@member/findMember?ID=%@", KDHOST_URL, ID];
    [[AFNetRequest sharedInstance] KYRequestGetWithTokenWithUrl:url parameters:nil success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }
        
            } fail:^(id errorResponse, NSInteger statusCode) {
            completion(nil, NO, errorResponse[@"message"]);
        }];
}


//用户详情 修改体测权限 接口
+ (void)KYUserDetailWithPostWithID:(NSString *)ID withMedical:(NSString *)medical withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@member/updateMemberAccount", KDHOST_URL];
    NSNumber *IDnumber = [NSNumber numberWithInt:[ID intValue]];
    [[AFNetRequest sharedInstance] KYRequestPostWithTokenJSONWithUrl:url parameters:@{@"mid":IDnumber,@"medical":medical} isDes:NO success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }

        } fail:^(id errorResponse, NSInteger statusCode) {
            completion(errorResponse,NO,errorResponse[@"message"]);
        }];

}

//用户详情 修改账号余额 接口
+ (void)KYUserDetailWithPostWithID:(NSString *)ID withBalance:(NSString *)balance withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@member/updateMemberAccount", KDHOST_URL];
    NSNumber *IDnumber = [NSNumber numberWithInt:[ID intValue]];
    NSNumber *balanceNumber = [NSNumber numberWithInt:[balance intValue]];

    [[AFNetRequest sharedInstance] KYRequestPostWithTokenJSONWithUrl:url parameters:@{@"mid":IDnumber,@"balance":balanceNumber} isDes:NO success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }

        } fail:^(id errorResponse, NSInteger statusCode) {
            completion(errorResponse,NO,errorResponse[@"message"]);
        }];

}

//用户详情 修改备注姓名 接口
+ (void)KYUserDetailWithPostWithID:(NSString *)ID withName:(NSString *)name withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion;
{
    NSString *url = [NSString stringWithFormat:@"%@member/updateMemberAccount", KDHOST_URL];
    NSNumber *IDnumber = [NSNumber numberWithInt:[ID intValue]];
    [[AFNetRequest sharedInstance] KYRequestPostWithTokenJSONWithUrl:url parameters:@{@"mid":IDnumber,@"name":name} isDes:NO success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }

        } fail:^(id errorResponse, NSInteger statusCode) {
            completion(errorResponse,NO,errorResponse[@"message"]);
        }];

}


//用户详情 用户列表搜索
+ (void)KYHomePage_UserListSearchWithGetWithKeyword:(NSString *)keyword WithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@member/getMemberList?page=1&pageSize=20&keyword=%@", KDHOST_URL, keyword];
    [[AFNetRequest sharedInstance] KYRequestGetWithTokenWithUrl:url parameters:nil success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }
        
            } fail:^(id errorResponse, NSInteger statusCode) {
            completion(nil, NO, errorResponse[@"message"]);
        }];
}

// 设备列表搜索
+ (void)KYHomePage_deviceListSearchWithGetWithKeyword:(NSString *)keyword WithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{

    NSString *url = [NSString stringWithFormat:@"%@device/getDeviceList?page=1&pageSize=5000&keyword=%@", KDHOST_URL, keyword];
    [[AFNetRequest sharedInstance] KYRequestGetWithTokenWithUrl:url parameters:nil success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }
        
            } fail:^(id errorResponse, NSInteger statusCode) {
            completion(nil, NO, errorResponse[@"message"]);
        }];
}

//登录 修改密码 接口
+ (void)KYAccountChangePassWordWithPostWithOldPassWord:(NSString *)OldPassWord withNewPassWord:(NSString *)NewPassWord withRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@merchant/changePassword", KDHOST_URL];
//    NSNumber *IDnumber = [NSNumber numberWithInt:[ID intValue]];
    [[AFNetRequest sharedInstance] KYRequestPostWithTokenJSONWithUrl:url parameters:@{@"password":OldPassWord,@"newPassword":NewPassWord} isDes:NO success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            
            NSMutableDictionary *loginDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginMsg"] mutableCopy];
            [loginDict setValue:NewPassWord forKey:@"passWord"];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }

        } fail:^(id errorResponse, NSInteger statusCode) {
            completion(errorResponse,NO,errorResponse[@"message"]);
        }];
    
}

//水卡管理
+ (void)KYHomePage_WaterCardManageWithGetWithPage:(NSInteger)page WithRequest:(void(^)(NSDictionary *resultDic, BOOL isSuccess, NSString *message))completion
{
    NSString *url = [NSString stringWithFormat:@"%@card/getProxyCardBalanceList?page=%ld&pageSize=20&status=2&cardNo=", KDHOST_URL, (long)page];
    [[AFNetRequest sharedInstance] KYRequestGetWithTokenWithUrl:url parameters:nil success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            completion(data, YES, responseObject[@"msg"]);
        } else {
            completion(nil, NO, responseObject[@"msg"]);
        }
        
            } fail:^(id errorResponse, NSInteger statusCode) {
            completion(nil, NO, errorResponse[@"message"]);
        }];
}



@end

