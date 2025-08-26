//
//  HeaderFiles.h
//  Afanti
//
//  Created by JDY on 15/6/25.
//  Copyright (c) 2015年 52aft.com. All rights reserved.
//

#ifndef Afanti_HeaderFiles_h
#define Afanti_HeaderFiles_h
#define MD5TOKEN (![[NSUserDefaults standardUserDefaults] objectForKey:USERACCOUNT]) ? @"" : PASSWORD

#define PASSWORD ([[NSUserDefaults standardUserDefaults] objectForKey:USERPASSWORD]) ? ([[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:USERACCOUNT], [[[[NSUserDefaults standardUserDefaults] objectForKey:USERPASSWORD] md5] uppercaseString]] md5]) : [[[NSUserDefaults standardUserDefaults] objectForKey:USERACCOUNT] md5]

// 是否登录
#define ISLOGIN [[NSUserDefaults standardUserDefaults] objectForKey:USERACCOUNT]

#define UICOLORRGB(a, b, c) [UIColor colorWithRed:a/255.f green:b/255.f blue:c/255.f alpha:1]

// MARK: RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 持仓比例颜色数组
#define COLORARRAY @[UIColorFromRGB(0xFDA93F), UIColorFromRGB(0xFF80C1), UIColorFromRGB(0x4E93EF), UIColorFromRGB(0x4EC7EF), UIColorFromRGB(0xFECF30), UIColorFromRGB(0x8A90F9), UIColorFromRGB(0xFF6666), UIColorFromRGB(0xFF9F22)]

#define UIScreenWidth [UIScreen mainScreen].bounds.size.width
#define UIScreenHeight [UIScreen mainScreen].bounds.size.height
// 控件的x、y
#define ORIGIN_X(o_x) o_x.origin.x  //x
#define ORIGIN_Y(o_y) o_y.origin.y  //y
//多个section控件tag递增算法
#define IndexPathTag indexPath.section+indexPath.row+(indexPath.section+indexPath.section)

// 高
#define AHeight(SIZE) (IPHONE6PLUS) ? SIZE * 1.2 : SIZE

//字号
#define DFont(SIZE) [UIFont PFRegularSize:(IPHONE6PLUS) ? SIZE + 1.5 : SIZE]
#define DNumFont(SIZE) [UIFont SFRegularSize:(IPHONE6PLUS) ? SIZE + 1.5 : SIZE]

#define DFontWithTile(SIZE) [UIFont PFMediumSize:(IPHONE6PLUS)? SIZE + 1.5 : SIZE]
#define DNumFontWithTile(SIZE) [UIFont SFMediumSize:(IPHONE6PLUS)? SIZE + 1.5 : SIZE]

// 汉化取词
#define LocalizedString(a) NSLocalizedString(a, @"")

//版本号
#define iOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//图片名称快捷命名
#define IMAGE(image) [UIImage imageNamed:image]
//设备
#define IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)

#endif

//打印
#ifdef DEBUG
#ifndef DLog
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#endif
#ifndef ELog
#   define ELog(err) {if(err) DLog(@"%@", err)}
#endif
#else
#ifndef DLog
#   define DLog(...)
#endif
#ifndef ELog
#   define ELog(err)
#endif
#endif


#define weakify(...) \
rac_keywordify \
metamacro_foreach_cxt(rac_weakify_,, __weak, __VA_ARGS__)


#define strongify(...) \
rac_keywordify \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
metamacro_foreach(rac_strongify_,, __VA_ARGS__) \
_Pragma("clang diagnostic pop")


#define WeakSelf(type)    __weak typeof(type) weak##type = type;
#define StrongSelf(type)  __strong typeof(type) type = weak##type;

#define TOKEN(account, password) [[NSString stringWithFormat:@"%@%@",account, [password.md5 uppercaseString]] md5]

//主页面tableview高度
#define HOMEHEIGHT UIScreenHeight-self.tabBarController.tabBar.frame.size.height - ((IPHONE6PLUS) ? 84 : (IPHONE6) ? 74 : 64)

//子页面tableview高度
#define SUBHEIGHT UIScreenHeight - 64

//友盟统计分析
//v2.0
//#define UmengAppKey @"556d263a67e58e62ba003258"

#define iSCompany [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] isEqualToString:@"net.dxzq.GSOline.company"]

#define UmengAppKey (iSCompany)? @"570c4e2167e58e541300136c" : @"570c490ce0f55a362a000986" // 友盟APPkey


//推送中的宏定义
#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000
// des加密的key
#define DESKEY @"11111111"

// 软件名称
#define DISPLAY_NAME [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"]

#pragma mark - 标识code
#define LOGIN_CODE 205 // 登录超时
#define SERVERSTOP_CODE 17 // 部分服务器维护
#define ALL_SERVERSTOP_CODE 22 // 全部维护
#define PWDERROR_CODE 202 // 密码错误


#pragma mark - 本地存储

#define USERPASSWORD @"password" // 密码
#define USERID @"userID" // id
#define USERACCOUNT @"account" // 账号
#define SERVERSTOP @"serverStop" // 服务器维护中
#define PLATFORMNAME @"platformName" // 平台信息
#define USERSTOCKLIST @"userStockList" // 自选股
#define CUSTOMACCOUNT @"customAccount" // 客户号
#define REFRESHDATA @"refreshData" // 几秒刷新
#define ALLSTOCK @"allStock" // 所有股票
#define AVAILABLE_STOCK @"availableIP" // 请求ip
#define AVAILABLE_FENSHI @"available_fenshi" // 请求分时
#define AVAILABLE_SHARE @"available_share" // 分享
#define PINGTIMETEMP @"pingTimeTemp" //  ping时间间隔
#define FIDARRAY @"fidArray" // 策略id
#define TRADEPASSWORDTIME @"TradePassWordTime" // 交易密码时间



#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \\
_Pragma("clang diagnostic push") \\
_Pragma("clang diagnostic ignored \\"-Wshadow\\"") \\
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \\
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \\
_Pragma("clang diagnostic push") \\
_Pragma("clang diagnostic ignored \\"-Wshadow\\"") \\
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \\
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \\
_Pragma("clang diagnostic push") \\
_Pragma("clang diagnostic ignored \\"-Wshadow\\"") \\
try{} @finally{} __typeof__(x) x = __weak_##x##__; \\
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \\
_Pragma("clang diagnostic push") \\
_Pragma("clang diagnostic ignored \\"-Wshadow\\"") \\
try{} @finally{} __typeof__(x) x = __block_##x##__; \\
_Pragma("clang diagnostic pop")

#endif
#endif


///导航栏高度
#define kNavBarHeaderHeight ([UIScreen mainScreen].bounds.size.height == 812 ? 88 : 64)
///iphone底部高度
#define kiPhoneFooterHeight ([UIScreen mainScreen].bounds.size.height == 812 ? 34 : 0)

