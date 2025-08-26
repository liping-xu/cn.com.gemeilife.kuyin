//
//  RequestURLHeader.h
//  KoodPower
//
//  Created by lipixu on 2023/10/17.
//

#ifndef RequestURLHeader_h
#define RequestURLHeader_h

#endif /* RequestURLHeader_h */

/**
 *  是否开启测试
 */
// 0注销 1开启
// 正式：0 测试：1
//#define openTest

/**
 *  绿灯：ld + 日期(例如：160512) 正式/测试：pub001
 */
#define APP_VERSION_TYPE @"pub001"

/**
 *  友盟统计渠道
 *
 *  @return 商店：AppStore 测试：ios_GSOline
 */
#define CHANNELID @"ios_GSOline"

/**
 *  是否开启https SSL 验证
 *
 *  @return YES为开启，NO为关闭
 */
#define openHttpsSSL YES

/**
 *  是否开启DES密码
 *
 *  @return YES为开启，NO为关闭
 */
#define openDES NO

// 证书名称
//#define SSLCERNAME        @"218.205.223.3"
#define SSLCERNAME        @"www.unitedmoney.com"
// 本地测试
#define TestURL           @"https://10.122.1.188:8443"
#define TestShareURL      @"http://10.122.1.188:8442"
// 接口后缀
#define SUFFIX_STOCK_URL  @"/aft/"
// 分时后缀
#define SUFFIX_FENSHI_URL @"/timedata/dailytimer/"

// 测试URL
#ifdef openTest
#define openTestURL YES
#define FENSHI_URL       [NSString stringWithFormat:@"%@%@", TestURL, SUFFIX_FENSHI_URL]
#define STOCK_URL        [NSString stringWithFormat:@"%@%@", TestURL, SUFFIX_STOCK_URL]
//#define STOCK_URL        @"http://10.122.126.9/aft/" // 卫星
//#define SHARE_URL        [NSString stringWithFormat:@"%@%@", TestShareURL, SUFFIX_STOCK_URL]
#define OPEN_ACCOUNT_URL @"http://106.37.173.36:8081/osoa/views/downapp_index.html?channel=74&qrcode_id=747"
#endif
// 正式URL
#ifndef openTest
#define openTestURL NO
#define FENSHI_URL       [[NSUserDefaults standardUserDefaults] objectForKey:AVAILABLE_FENSHI]
#define STOCK_URL        [[NSUserDefaults standardUserDefaults] objectForKey:AVAILABLE_STOCK]
//#define SHARE_URL        [[NSUserDefaults standardUserDefaults] objectForKey:AVAILABLE_SHARE]
#define OPEN_ACCOUNT_URL @"https://wskh.dxzq.net/osoa/views/downapp_index.html?channel=4&qrcode_id=2281"
#endif

// 切换ip数组
#define STANDBY_IP @[@[@"218.205.223.3", @"https://218.205.223.3:8001", @"http://wsgs.dxzq.net"], @[@"123.125.28.66", @"https://123.125.28.66:8001", @"http://wsgs.dxzq.net"], @[@"219.143.41.38", @"https://219.143.41.38:8001", @"http://wsgs.dxzq.net"]]

// 默认URL
#define DEFAULT_FENSHI_URL [NSString stringWithFormat:@"%@%@", STANDBY_IP[0][1], SUFFIX_FENSHI_URL]
#define DEFALUT_STOCK_URL  [NSString stringWithFormat:@"%@%@", STANDBY_IP[0][1], SUFFIX_STOCK_URL]
#define DEFAULT_SHARE_URL  [NSString stringWithFormat:@"%@%@", STANDBY_IP[0][2], SUFFIX_STOCK_URL]

