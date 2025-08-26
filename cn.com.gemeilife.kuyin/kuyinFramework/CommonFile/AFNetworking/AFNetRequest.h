//
//  AFNetRequest.h
//  Afanti
//
//  Created by lipixu on 15/7/3.
//  Copyright (c) 2015年 52aft.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "DES.h"


typedef void (^OnFinishBlock)(NSDictionary *finishDictionary,NSData *receivedData,NSString *ANSIString,NSError *error);

@interface AFNetRequest : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>{
    OnFinishBlock           _finishBlock;
    __strong NSMutableData  *_mobileData;
    int netType;
}

/**
 *[AFNetWorking]的operationManager对象
 */
@property (nonatomic, strong) AFHTTPSessionManager* operationManager;

/**
 *当前的请求operation队列
 */
@property (nonatomic, assign) AFNetworkReachabilityStatus staus;

+ (AFNetRequest *)sharedInstance;
+ (AFNetRequest *)sharedInstanceHttp;
//判断网络状态
- (AFNetworkReachabilityStatus)netWorkStatus;

-(int)testNetWorkType;         //检测网络类型(0:没有网络 1:2G 2:3G 3:4G 5:WIFI)

// get请求
- (void)requestGetWithUrl:(NSString*)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(void))fail;
- (void)requestHttpGetWithUrl:(NSString*)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(void))fail;
//快点get请求
- (void)KDrequestGetWithUrl:(NSString*)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(id errorResponse, NSInteger statusCode))fail;
//快点post请求
- (void)KDRequestPostJSONWithUrl:(NSString *)urlStr parameters:(id)parameters isDes:(BOOL)isDes success:(void (^)(id responseObject))success fail:(void (^)(id errorResponse, NSInteger statusCode))fail;
//快点post请求 NOToken 登录
- (void)KDRequestPostNoTokenJSONWithUrl:(NSString *)urlStr parameters:(id)parameters isDes:(BOOL)isDes success:(void (^)(id responseObject))success fail:(void (^)(id errorResponse, NSInteger statusCode))fail;
//快点PUT请求 
- (void)KDrequestPUTWithUrl:(NSString*)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(id errorResponse, NSInteger statusCode))fail;


//JSON方式上传JSON数据 接受数据为JSON（可修改） POST方式
- (void)requestPostJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(void))fail;
- (void)requestPostJSONWithUrl:(NSString *)urlStr parameters:(id)parameters isDes:(BOOL)isDes success:(void (^)(id responseObject))success fail:(void (^)(void))fail;

- (void)requestHttpJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(void))fail;
- (void)requestHttpJSONWithUrl:(NSString *)urlStr parameters:(id)parameters isDes:(BOOL)isDes success:(void (^)(id responseObject))success fail:(void (^)(void))fail;

//上传单张图片 POST方式
- (void)requestUploadImageWithActionName:(NSString *)actionName parameters:(NSDictionary *)parameters image:(UIImage *)image success:(void (^)(id responseObject))success fail:(void (^)(void))fail;

//上传多张图片 POST方式
- (void)requestUploadImageWithActionName:(NSString *)actionName parameters:(NSDictionary *)parameters imageArray:(NSArray *)imageArray success:(void (^)(id responseObject))success fail:(void (^)(void))fail;
// 异步POST请求:以body方式
- (void)postWithUrl:(NSString *)url body:(NSData *)body success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure;

// 取消网络请求
- (void)cancelRequest;

// 公用的字典
+ (NSDictionary*)paramOfAccount:(NSString*)account AppId:(NSString*)appId deviceToken:(NSString*)deviceToken token:(NSString*)token data:(NSDictionary*)dataDic;

// 登录
+ (NSDictionary*)paramPhoneMessageOfAccount:(NSString*)account AppId:(NSString*)appId deviceToken:(NSString*)deviceToken token:(NSString*)token data:(NSDictionary*)dataDic;
// 验证码请求
+ (NSDictionary*)paramOfPhoneNum:(NSString*)phoneNum type:(NSString*)type;
// 忘记密码
+ (NSDictionary*)paramOfPhoneNum:(NSString*)phoneNum checkCode:(NSString*)checkCode newPassword:(NSString*)newPassword;
// 注册信息
+ (NSDictionary*)paramOfPhoneNum:(NSString*)phoneNum checkCode:(NSString*)checkCode password:(NSString*)password nickName:(NSString*)nickName;

//酷饮 post请求 NOToken登录
- (void)KYRequestPostNoTokenJSONWithUrl:(NSString *)urlStr parameters:(id)parameters isDes:(BOOL)isDes success:(void (^)(id responseObject))success fail:(void (^)(id errorResponse, NSInteger statusCode))fail;

//酷饮get请求 带X_Token
- (void)KYRequestGetWithTokenWithUrl:(NSString*)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(id errorResponse, NSInteger statusCode))fail;

//酷饮 POST请求 带X_Token
- (void)KYRequestPostWithTokenJSONWithUrl:(NSString *)urlStr parameters:(id)parameters isDes:(BOOL)isDes success:(void (^)(id responseObject))success fail:(void (^)(id errorResponse, NSInteger statusCode))fail;



@end
