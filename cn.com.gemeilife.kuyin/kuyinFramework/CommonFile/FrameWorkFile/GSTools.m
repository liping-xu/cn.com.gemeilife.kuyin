//
//  GSTools.m
//  Afanti
//
//  Created by 许文波 on 16/5/13.
//  Copyright © 2016年 52aft.com. All rights reserved.
//

#import "GSTools.h"

@interface GSTools()

@property (nonatomic, assign) BOOL exitAppPop; // 是否弹出

@end

@implementation GSTools

#pragma mark - 证书验证
+ (AFSecurityPolicy*)customSecurityPolicy
{
    // 先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:SSLCERNAME ofType:@"cer"]; // 证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
//    securityPolicy.pinnedCertificates = [NSSet setWithArray:@[certData]];
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:certData, nil];

//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:SSLCERNAME ofType:@"cer"]; // 证书的路径
//    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    securityPolicy.allowInvalidCertificates = YES;
//    securityPolicy.validatesDomainName = NO;
//    securityPolicy.pinnedCertificates = [NSSet setWithArray:@[certData]];
//    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:certData, nil];
    
    return securityPolicy;
}

#pragma mark - 退出应用
- (void)exitApplicationWithDic:(NSDictionary*)dic
{
    if (self.exitAppPop) {
        return;
    }
    self.exitAppPop = YES;
    POPView *pop = [[POPView alloc] initWithAlertViewTitle:dic[@"title"] message:dic[@"msg"] buttonTitles:@[@"退出应用"] cancelButton:^(NSInteger buttion0) {
        self.exitAppPop = NO;
        exit(0);
    } confirmButton:^(NSInteger buttion1, NSString *fieldlString) {
        
    }];
    [POPView WindowAddSubview:pop];
}

#pragma mark - 服务维护通告页面
+ (void)pushWaringViewWithDic:(NSDictionary*)dic
{
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    CustomTabBar *tabbar = (CustomTabBar*)app.window.rootViewController;
//    [(SuperViewController*)[GSUtils topViewControllerWithRootViewController:tabbar] cancelAcitvityView];
//    if (tabbar.currentSelectedIndex != 2) {
//        [[GSUtils topViewControllerWithRootViewController:tabbar].navigationController popToRootViewControllerAnimated:NO];
//        [tabbar selectedTab:[tabbar.buttons objectAtIndex:2]];
//    }
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    if ([userDefault objectForKey:SERVERSTOP]) {
//        return;
//    }
//    [userDefault setObject:SERVERSTOP forKey:SERVERSTOP];
//    WebViewController *webView = [[WebViewController alloc] init];
//    webView.url = dic[@"url"];
//    webView.naviTitle = dic[@"title"];
//    UINavigationController* navi = tabbar.viewControllers[2];
//    [navi pushViewController:webView animated:YES];
}

#pragma mark - 清除本地存储信息
+ (void)removeDefaultsMessages
{
    NSUserDefaults *defalut = [NSUserDefaults standardUserDefaults];
    [defalut removeObjectForKey:USERPASSWORD];
    [defalut removeObjectForKey:USERID];
    [defalut removeObjectForKey:USERACCOUNT];
    [defalut removeObjectForKey:PLATFORMNAME];
    [defalut removeObjectForKey:USERSTOCKLIST];
}

/**
 *  增加监听 回到程序/进入后台
 *
 *  @param observer 监听的对象
 */
+ (void)observerGoneInForeground:(id)observer
{
    GSTools *tools = [[GSTools alloc] init];
    [tools addObserver:observer];
}

- (void)addObserver:(id)observer
{
    [[NSNotificationCenter defaultCenter] addObserver:observer
                                             selector:@selector(appHasGoneInForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:observer
                                             selector:@selector(appHasGoneInForeground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

- (void)appHasGoneInForeground:(NSNotification *)notification
{
}

//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
