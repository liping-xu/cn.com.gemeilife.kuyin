//
//  AFNetRequest.m
//  Afanti
//
//  Created by lipixu on 15/7/3.
//  Copyright (c) 2015年 52aft.com. All rights reserved.
//

#import "AFNetRequest.h"
#import "PhoneMessageTools.h"
#import "GBPing.h"
#import "GSTools.h"
#import "KDRequest.h"
#import "KYRequest.h"

static NSString *NoRefresh = @"不刷新";
static const CGFloat kPingTempTime = 5.0; // ping间隔时间


@interface AFNetRequest() <GBPingDelegate>

@property (nonatomic, strong) NSMutableArray *ipArray;
@property (nonatomic, strong) NSArray *standIPArray; // 备用ip
@property (nonatomic, strong) GSTools *errorTools; // 错误处理
@property (nonatomic, strong) POPView *noNetworkPop; // 没有网络提示


@end

@implementation AFNetRequest

+ (AFNetRequest *)sharedInstance
{
    static AFNetRequest *request = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        request = [[AFNetRequest alloc] init];
        request.operationManager = [AFHTTPSessionManager manager];
        // 设置请求格式
        request.operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        // 设置返回格式
        request.operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        request.operationManager.requestSerializer.timeoutInterval = 30;
        request.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/javascript",
                                                                              @"text/plain",
                                                                              nil];
        if (openHttpsSSL) {
            [request.operationManager setSecurityPolicy:[GSTools customSecurityPolicy]];
        } else {
            request.operationManager.securityPolicy.allowInvalidCertificates = YES;
        }
    });
    return request;
}

+ (AFNetRequest *)sharedInstanceHttp
{
    static AFNetRequest *request = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        request = [[AFNetRequest alloc] init];
        request.operationManager = [AFHTTPSessionManager manager];
        // 设置请求格式
        request.operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        // 设置返回格式
        request.operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        request.operationManager.requestSerializer.timeoutInterval = 30;
        request.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/javascript",
                                                                              @"text/plain",
                                                                              nil];
        if (openHttpsSSL) {
            [request.operationManager setSecurityPolicy:[GSTools customSecurityPolicy]];
        } else {
            request.operationManager.securityPolicy.allowInvalidCertificates = YES;
        }
    });
    return request;
}

- (AFNetworkReachabilityStatus)netWorkStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 2G/3G/4G
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.staus = status;
        if (!status) {
            [self noNetworkPop];
        }
    }];
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

- (POPView *)noNetworkPop
{
    if (!_noNetworkPop) {
        _noNetworkPop = [[POPView alloc] initWithAlertViewTitle:@"温馨提示" message:@"检测不到网络,快去设置网络吧!" buttonTitles:@[@"知道了"] cancelButton:^(NSInteger buttion0) {
        } confirmButton:^(NSInteger buttion1, NSString *fieldlString) {
            
        }];
        [POPView WindowAddSubview:_noNetworkPop];
    }
    return _noNetworkPop;
}

- (int)testNetWorkType
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")])
        {
            netType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    return netType;
}

- (id)init
{
    _mobileData = [NSMutableData data];
    return self;
}

// get请求
- (void)requestGetWithUrl:(NSString*)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(void))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@", STOCK_URL, urlStr];
    [[AFNetRequest sharedInstance].operationManager GET:url parameters:parameters headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail();
            }
            
        }];
}




- (void)requestHttpGetWithUrl:(NSString*)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(void))fail
{
//    [[AFNetRequest sharedInstanceHttp].operationManager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (fail) {
//            fail();
//        }
//    }];
}

//上传JSON数据， 接受数据格式也为JSON
- (void)requestPostJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(void))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@", STOCK_URL, urlStr];
    [self requestPostJSONWithUrl:url parameters:parameters isDes:openDES success:success fail:fail];
}

- (void)requestPostJSONWithUrl:(NSString *)urlStr parameters:(id)parameters isDes:(BOOL)isDes success:(void (^)(id responseObject))success fail:(void (^)(void))fail
{
    NSData *data;
    if (parameters != nil) {
        data = [NSData toJSONData:parameters];
    }
    if (isDes) {
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        str = [DES encryptUseDES:str key:DESKEY];
        parameters = str;
    }
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        
        [[AFNetRequest sharedInstance].operationManager POST:urlStr parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (success) {
                        success(responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    DLog(@"%@", error);
                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                    NSInteger statusCode = response.statusCode;
                    id respone = [NSJSONSerialization JSONObjectWithData:(NSData*)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
                    if (fail) {
                        fail();
                        [self pingTest];
                    }
                    
                }];
    } else {
        if (fail) {
            fail();
        }
    }
}



- (void)requestHttpJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(void))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@", STOCK_URL, urlStr];
    [self requestHttpJSONWithUrl:url parameters:parameters isDes:openDES success:success fail:fail];
}

- (void)requestHttpJSONWithUrl:(NSString *)urlStr parameters:(id)parameters isDes:(BOOL)isDes success:(void (^)(id responseObject))success fail:(void (^)(void))fail
{
    NSData *data;
    if (parameters != nil) {
        data = [NSData toJSONData:parameters];
    }
    if (isDes) {
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        str = [DES encryptUseDES:str key:DESKEY];
        parameters = str;
    }
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        [[AFNetRequest sharedInstanceHttp].operationManager  POST:urlStr parameters:parameters headers:nil   progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DLog(@"%@", error);
            if (fail) {
                fail();
                [self pingTest];
            }
        }];
    } else {
        if (fail) {
            fail();
        }
    }
}




//上传单张图片
- (void)requestUploadImageWithActionName:(NSString *)actionName parameters:(NSDictionary *)parameters image:(UIImage *)image success:(void (^)(id responseObject))success fail:(void (^)(void))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@", STOCK_URL, actionName];
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        [[AFNetRequest sharedInstance].operationManager POST:url parameters:parameters headers:nil  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSString *fileName  = @"image.png";
            NSString *fileParam = @"photo";
            [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:fileParam fileName:fileName mimeType:@"image/png"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                DLog(@"error = %@", error);
                fail();
            }
        }];
    } else {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

//上传多张图片
- (void)requestUploadImageWithActionName:(NSString *)actionName parameters:(NSDictionary *)parameters imageArray:(NSArray *)imageArray success:(void (^)(id responseObject))success fail:(void (^)(void))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@", STOCK_URL, actionName];
    NSString *fileParam = @"photo";
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        
        [[AFNetRequest sharedInstance].operationManager POST:url parameters:parameters headers:nil  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for(NSInteger i = 0; i < imageArray.count; i++) {
                UIImage *uploadImage = imageArray[i];
                NSString *name = [NSString stringWithFormat:@"%@%zi", fileParam, i + 1];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", name];
                [formData appendPartWithFileData:UIImagePNGRepresentation(uploadImage)  name:name fileName:fileName mimeType:@"image/png"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DLog(@"error = %@", error);
            fail();
        }];
    } else {
    }
}

#pragma mark - 测试ping速度
- (void)pingTest
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *pingTime = [userDefaults objectForKey:PINGTIMETEMP];
    if (pingTime && [NSDate intervalMinSinceNow:pingTime] < kPingTempTime) {
        return;
    }
    [userDefaults setObject:[NSDate sinceNow] forKey:PINGTIMETEMP];
    
    self.ipArray = [[NSMutableArray alloc] init];
    self.standIPArray = STANDBY_IP;
    for (int i = 0; i <  self.standIPArray.count; i++) {
        GBPing *ping = [GBPing new];
        ping.host =  self.standIPArray[i][0];
        ping.delegate = self;
        ping.timeout = 1;
        ping.pingPeriod = 0.9;
        
        [ping setupWithBlock:^(BOOL success, NSError *error) {
            if (success) {
                [ping startPinging];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [ping stop];
                });
            } else {
                DLog(@"failed to start");
            }
        }];
    }
}

- (void)ping:(GBPing *)pinger didReceiveReplyWithSummary:(GBPingSummary *)summary
{
    [self.ipArray addObject:summary];
    self.ipArray = [NSMutableArray arrayWithArray:[self sortPingData:self.ipArray]];
    NSUserDefaults *userDerfaults = [NSUserDefaults standardUserDefaults];
    if (self.ipArray.count > 0) {
        GBPingSummary *availableIP = self.ipArray[0];
        for (NSArray *ar in self.standIPArray) {
            if ([availableIP.host isEqualToString:ar[0]]) {
                NSString *ip = [NSString stringWithFormat:@"%@%@", ar[1], SUFFIX_STOCK_URL];
                NSString *fenshi = [NSString stringWithFormat:@"%@%@", ar[1], SUFFIX_FENSHI_URL];
                NSString *share = [NSString stringWithFormat:@"%@%@", ar[2], SUFFIX_STOCK_URL];
                [userDerfaults setObject:ip forKey:AVAILABLE_STOCK];
                [userDerfaults setObject:fenshi forKey:AVAILABLE_FENSHI];
                [userDerfaults setObject:share forKey:AVAILABLE_SHARE];
                break;
            }
        }
    } else {
        [userDerfaults setObject:DEFALUT_STOCK_URL forKey:AVAILABLE_STOCK];
        [userDerfaults setObject:DEFAULT_FENSHI_URL forKey:AVAILABLE_FENSHI];
        [userDerfaults setObject:DEFAULT_SHARE_URL forKey:AVAILABLE_SHARE];
    }
    [userDerfaults synchronize];
}

- (NSArray*)sortPingData:(NSArray *)array
{
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(GBPingSummary *obj1, GBPingSummary *obj2){
        if ([obj1 rtt] > [obj2 rtt]) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
    }];
    return sortedArray;
}

- (GSTools *)errorTools
{
    if (!_errorTools) {
        _errorTools = [[GSTools alloc] init];
    }
    return _errorTools;
}

/**
 *  异步POST请求:以body方式,支持数组
 *
 *  @param url     请求的url
 *  @param body    body数据
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)postWithUrl:(NSString *)url body:(NSData *)body success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure
{
    
    if(!body)
        return;
    NSString *requestUrl = url;
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestUrl parameters:nil error:nil];
    request.timeoutInterval= 30;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 设置body
    [request setHTTPBody:body];
    //    NSString *sd= [NSData transformedValue:@(body.length)];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    if (openHttpsSSL) {
        [manager setSecurityPolicy:[GSTools customSecurityPolicy]];
    } else {
        manager.securityPolicy.allowInvalidCertificates = YES;
    }

//    [[manager dataTaskWithRequest:request  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        if (!error) {
//            NSString *result  =[[ NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//            //result=@"{\"keys\": [         \"pt_khh\",         \"phone\"     ] } ";
//            success(@{});
//        } else {
//            failure(error);
//        }
//    }] resume];
}

- (void)cancelRequest
{
    if (_operationManager) {
        [_operationManager.operationQueue cancelAllOperations];
    }
}

// 公用的字典
+ (NSDictionary*)paramOfAccount:(NSString*)account AppId:(NSString*)appId deviceToken:(NSString*)deviceToken token:(NSString*)token data:(NSDictionary*)dataDic
{
    NSDictionary *dic;
    if (account) {
        NSString *platformName = [[NSUserDefaults standardUserDefaults] objectForKey:PLATFORMNAME];
        NSString *method = @"phone";
        if (platformName) {
            method = platformName;
            token = account.md5;
        }
        if (!deviceToken) {
            deviceToken = @"";
        }
        dic = @{@"account":@{@"userName":account, @"method":method, @"phoneType":@"ios", @"deviceToken":deviceToken}, @"appId":appId, @"token":token, @"data":dataDic};
    } else {
        dic = @{@"account":@{}, @"appId":appId, @"token":@"", @"data":dataDic};
    }
    return dic;
}

// 登录
+ (NSDictionary*)paramPhoneMessageOfAccount:(NSString*)account AppId:(NSString*)appId deviceToken:(NSString*)deviceToken token:(NSString*)token data:(NSDictionary*)dataDic
{
    NSDictionary *dic;
    if (account) {
        NSString *platformName = [[NSUserDefaults standardUserDefaults] objectForKey:PLATFORMNAME];
        NSString *method = @"phone";
        if (platformName) {
            method = platformName;
            token = account.md5;
        }
        if (!deviceToken) {
            deviceToken = @"";
        }
        //设备名称
        NSString *deviceName = [[UIDevice currentDevice] systemName];
        //手机型号
        NSString *phoneModel = [PhoneMessageTools phoneModel];
        dic = @{@"account":@{@"userName":account, @"method":method, @"phoneType":@"ios", @"deviceToken":deviceToken, @"phoneIMEI":[PhoneMessageTools getDeviceId],
                             @"phoneProducer":deviceName,
                             @"phoneModel":phoneModel}, @"appId":appId, @"token":token, @"data":dataDic};
    } else {
        dic = @{@"account":@{}, @"appId":appId, @"token":@"", @"data":dataDic};
    }
    return dic;
}

/**
 *  验证码请求字典
 *
 *  @param phoneNum 手机号
 *  @param type     1代表注册，2代表忘记密码，3开户，4大赛报名
 *
 *  @return 返回
 */
+ (NSDictionary*)paramOfPhoneNum:(NSString*)phoneNum type:(NSString*)type
{
    return @{@"phoneNum":phoneNum, @"phoneType":@"ios", @"type":type};
}

/**
 *  忘记密码
 *
 *  @param phoneNum    手机号
 *  @param checkCode   验证码
 *  @param newPassword 新密码
 *
 *  @return 返回
 */
+ (NSDictionary*)paramOfPhoneNum:(NSString*)phoneNum checkCode:(NSString*)checkCode newPassword:(NSString*)newPassword
{
    return @{@"phoneNum":phoneNum, @"checkCode":checkCode, @"newPassWord":newPassword};
}

/**
 *  注册
 *
 *  @param phoneNum  手机号
 *  @param checkCode 验证码
 *  @param password  密码
 *  @param nickName  昵称
 *
 *  @return 返回
 */
+ (NSDictionary*)paramOfPhoneNum:(NSString*)phoneNum checkCode:(NSString*)checkCode password:(NSString*)password nickName:(NSString*)nickName
{
    return @{@"phoneNum":phoneNum, @"phoneType":@"ios", @"passWord":password, @"checkCode":checkCode, @"nickName":nickName};
}

//快点NOToken
- (void)KDRequestPostNoTokenJSONWithUrl:(NSString *)urlStr parameters:(id)parameters isDes:(BOOL)isDes success:(void (^)(id responseObject))success fail:(void (^)(id errorResponse, NSInteger statusCode))fail
{
    NSData *data;
    if (parameters != nil) {
        data = [NSData toJSONData:parameters];
    } else {
        return;
    }
    if (isDes) {
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        str = [DES encryptUseDES:str key:DESKEY];
        parameters = str;
    }
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        
        [[AFNetRequest sharedInstance].operationManager POST:urlStr parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (success) {
                        success(responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    DLog(@"%@", error);
                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                    NSInteger statusCode = response.statusCode;
                    id respone = [NSJSONSerialization JSONObjectWithData:(NSData*)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
                    if (fail) {
                        fail(respone,statusCode);
                        [self pingTest];
                    }
                    
                }];
    } else {
        if (fail) {
            fail(@{@"message":@"网络断了！"},404);
        }
    }
}

//快点POST
- (void)KDRequestPostJSONWithUrl:(NSString *)urlStr parameters:(id)parameters isDes:(BOOL)isDes success:(void (^)(id responseObject))success fail:(void (^)(id errorResponse, NSInteger statusCode))fail
{
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        NSString *url = [NSString stringWithFormat:@"%@", urlStr];
        NSString *str = [KDRequest getAccess_Token];
        if (str.length != 0) {
            [[AFNetRequest sharedInstance].operationManager POST:url parameters:parameters headers:@{@"Authorization":str} progress:^(NSProgress * _Nonnull uploadProgress) {
                            
                        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                if (success) {
                                    success(responseObject);
                                }
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            
                            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                            //服务器返回的业务逻辑报文信息
                            NSInteger statusCode = response.statusCode;
                            id respone = [NSJSONSerialization JSONObjectWithData:(NSData*)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
                            DLog(@"%@", error);
                            if (fail) {
                                fail(respone, statusCode);
                                [self pingTest];
                            }
                        }];
            
        }
    } else {
        if (fail) {
            fail(@{@"message":@"网络断了！"},404);
        }
    }
}

//快点get请求
- (void)KDrequestGetWithUrl:(NSString*)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(id errorResponse, NSInteger statusCode))fail;
{
    NSString *url = [NSString stringWithFormat:@"%@", urlStr];
    NSString *str = [KDRequest getAccess_Token];
    if (str.length != 0) {
        [[AFNetRequest sharedInstance].operationManager GET:url parameters:parameters headers:@{@"Authorization":str} progress:^(NSProgress * _Nonnull downloadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (success) {
                        success(responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                    NSInteger statusCode = response.statusCode;
                    id respone = [NSJSONSerialization JSONObjectWithData:(NSData*)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
                    if (fail) {
                        fail(respone,statusCode);
                    }
                }];
    }
}

//快点put请求
- (void)KDrequestPUTWithUrl:(NSString*)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(id errorResponse, NSInteger statusCode))fail;
{
    NSString *url = [NSString stringWithFormat:@"%@", urlStr];
    NSString *str = [KDRequest getAccess_Token];
    if (str.length != 0) {
        [[AFNetRequest sharedInstance].operationManager PUT:url parameters:parameters headers:@{@"Authorization":str} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                    NSInteger statusCode = response.statusCode;
                    id respone = [NSJSONSerialization JSONObjectWithData:(NSData*)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
                    if (fail) {
                        fail(respone,statusCode);
                    }
                    
                }];
        
    }
    
    
}

//酷饮NOToken
- (void)KYRequestPostNoTokenJSONWithUrl:(NSString *)urlStr parameters:(id)parameters isDes:(BOOL)isDes success:(void (^)(id responseObject))success fail:(void (^)(id errorResponse, NSInteger statusCode))fail
{
    NSData *data;
    if (parameters != nil) {
        data = [NSData toJSONData:parameters];
    } else {
        return;
    }
    if (isDes) {
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        str = [DES encryptUseDES:str key:DESKEY];
        parameters = str;
    }
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        
        [[AFNetRequest sharedInstance].operationManager POST:urlStr parameters:parameters headers:@{@"from":@"iOS"} progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (success) {
                        success(responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    DLog(@"%@", error);
                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                    NSInteger statusCode = response.statusCode;
                    id respone = [NSJSONSerialization JSONObjectWithData:(NSData*)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
                    if (fail) {
                        fail(respone,statusCode);
                        [self pingTest];
                    }
                    
                }];
    } else {
        if (fail) {
            fail(@{@"message":@"网络断了！"},404);
        }
    }
}

//酷饮get请求
- (void)KYRequestGetWithTokenWithUrl:(NSString*)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(id errorResponse, NSInteger statusCode))fail
{
    NSString *url = [NSString stringWithFormat:@"%@", urlStr];
    NSString *str = [KYRequest getKY_X_Token];
    if (str.length != 0) {
        [[AFNetRequest sharedInstance].operationManager GET:url parameters:parameters headers:@{@"x-token":str,
                      @"Content-Encoding":@"gzip",
                      @"from":@"iOS"} progress:^(NSProgress * _Nonnull downloadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (success) {
                        success(responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                    NSInteger statusCode = response.statusCode;
                    id respone = [NSJSONSerialization JSONObjectWithData:(NSData*)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
                    if (fail) {
                        fail(respone,statusCode);
                    }
                }];
    } else {
        //token不存在
    }
}

//酷饮 withToken
- (void)KYRequestPostWithTokenJSONWithUrl:(NSString *)urlStr parameters:(id)parameters isDes:(BOOL)isDes success:(void (^)(id responseObject))success fail:(void (^)(id errorResponse, NSInteger statusCode))fail
{
    NSData *data;
    if (parameters != nil) {
        data = [NSData toJSONData:parameters];
    } else {
        return;
    }
    if (isDes) {
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        str = [DES encryptUseDES:str key:DESKEY];
        parameters = str;
    }
    NSString *X_Token = [KYRequest getKY_X_Token];
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        
        [[AFNetRequest sharedInstance].operationManager POST:urlStr parameters:parameters headers:@{@"x-token":X_Token,
                      @"Content-Encoding":@"gzip",
                      @"from":@"iOS"} progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (success) {
                        success(responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    DLog(@"%@", error);
                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                    NSInteger statusCode = response.statusCode;
                    id respone = [NSJSONSerialization JSONObjectWithData:(NSData*)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
                    if (fail) {
                        fail(respone,statusCode);
                        [self pingTest];
                    }
                    
                }];
    } else {
        if (fail) {
            fail(@{@"message":@"网络断了！"},404);
        }
    }
}




@end
