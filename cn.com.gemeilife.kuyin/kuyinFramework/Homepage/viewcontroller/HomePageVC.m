//
//  HomePageVC.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/7/23.
//

#import "HomePageVC.h"
#import "KYRequest.h"
#import "LoginVC.h"
#import "KY_HomePage_Cell.h"
#import "KY_CreateNewCardVC.h"
#import "KY_DeviceManageVC.h"
#import "KY_UserManageVC.h"
#import "KY_MemberRechargeVC.h"

@interface HomePageVC () <Items_cell_TapActionDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIView *tableHeadView;

//head白色view
@property (nonatomic,weak) UIView *contentView;

//名字label
@property (nonatomic,weak) UILabel *accountLabel;

//headLabel数组
@property (nonatomic, strong) NSMutableArray *headLabelArray;
//contentLabel数组
@property (nonatomic, strong) NSMutableArray *contentLabelArray;

@property (nonatomic,weak) UILabel *newsLabel;
@property (nonatomic,weak) UILabel *phoneLabel;
@property (nonatomic,weak) UILabel *totalMoneyLabel;


@end

@implementation HomePageVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabBar];
    if ([KYRequest isLogin]) {
        [self requestNetWorkData];
    } else {
        _tableHeadView = nil;
        self.tableView.tableHeaderView = self.tableHeadView;
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.delegate = self;
//    [self.navigationController.navigationController setNavigationBarHidden:YES];
    self.navIsHidden = YES;
    self.view.backgroundColor = [UIColor clearColor];
    [self configureTableHeaderUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"DataNeedsRefresh" object:nil];
}

- (void)refreshData {
    // 刷新数据的方法
    [self requestNetWorkData];

}


- (void)configureTableHeaderUI
{
    self.leftBtn.hidden = YES;
    CGFloat tableViewH = UIScreenHeight - [UIDevice vg_tabBarFullHeight];
    [self allocWithFrame:CGRectMake(0, 0, UIScreenWidth, tableViewH) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xF3F3F3];
    self.tableView.tableHeaderView = self.tableHeadView;
    
    CGFloat headX = 0;
    CGFloat headY = 0;
    CGFloat headW = UIScreenWidth;
    CGFloat imageH = [UIDevice vg_statusBarHeight];
    UIImage *image = [UIImage imageNamed:@"newHeader_bg_bottom"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(headX, headY, headW, imageH)];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFill; // 图片填充模式
    [self.view addSubview:imageView];
    
    
    UIView *HomePage_backGroundView = [[UIView alloc] initWithFrame:self.tableView.bounds];
    // 创建一个CAGradientLayer对象
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height);
    // 设置渐变颜色
    gradientLayer.colors = @[(id)[UIColor colorWithRed:43 / 255.0f green:100 / 255.0f blue:61 / 255.0f alpha:1].CGColor,
                            (id)[UIColor colorWithRed:57 / 255.0f green:135 / 255.0f blue:91 / 255.0f alpha:1].CGColor];
    // 设置渐变方向
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(0.0, 34.0);
    
    CGFloat buttom_ImageViewH = 44.0f;
    CGFloat buttom_ImageViewW = UIScreenWidth;
    CGFloat buttom_ImageViewY = tableViewH - buttom_ImageViewH;
    CGFloat buttom_ImageViewX = 0;
    UIImageView *buttom_ImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HomePage_buttom_New_bg"]];
    buttom_ImageView.backgroundColor = [UIColor clearColor];
    
    buttom_ImageView.frame = CGRectMake(buttom_ImageViewX, buttom_ImageViewY, buttom_ImageViewW, buttom_ImageViewH);
    buttom_ImageView.contentMode = UIViewContentModeScaleAspectFill; // 图片填充模式
    [HomePage_backGroundView addSubview:buttom_ImageView];
    
    [HomePage_backGroundView.layer insertSublayer:gradientLayer atIndex:0];
    self.tableView.backgroundView = HomePage_backGroundView;
    
}

- (UIView *)tableHeadView
{
    if (!_tableHeadView) {
        CGFloat margin = 10.0f;
        CGFloat headX = 0;
        CGFloat headY = 0;
        CGFloat headW = UIScreenWidth;
        CGFloat headH = 440;
        CGFloat imageH = 250;
        _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(headX, headY, headW, headH)];
        _tableHeadView.backgroundColor = [UIColor clearColor];
        
        NSDictionary *dict = [KYRequest getAccountDict];
        NSDictionary *user = [NSDictionary dictionaryWithDictionary:dict[@"user"]];
        
        //HeadimageView
        CGFloat headImageViewX = margin;
        CGFloat headImageViewY = margin * 2;
        CGFloat headImageViewW = 80.0f;
        CGFloat headImageViewH = headImageViewW;
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headImageViewX, headImageViewY, headImageViewW, headImageViewH)];
        headImageView.backgroundColor = [UIColor clearColor];
//        headImageView.layer.borderWidth = 0.5f;
//        headImageView.layer.borderColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3f] CGColor];
        headImageView.layer.cornerRadius = headImageViewH * 0.5;
        headImageView.layer.masksToBounds = YES;
        headImageView.image = IMAGE(@"HeadIcon");
        headImageView.contentMode = UIViewContentModeScaleAspectFill; // 图片填充模式
        [_tableHeadView addSubview:headImageView];

        
        
        
        //name
        CGFloat newsLH = 24;
        CGFloat newsLX = CGRectGetMaxX(headImageView.frame) + margin;
        CGFloat newsLY = CGRectGetMinY(headImageView.frame) + margin;
        CGFloat newsLW = headW - newsLX - margin * 2;
        UILabel *newsLabel = [[UILabel alloc] initWithFrame:CGRectMake(newsLX, newsLY, newsLW, newsLH)];
//        newsLabel.text = @"展厅｜18555512345";
//        [newsLabel setTexts:@[@"展厅｜", @"18555512345"] colors:@[[UIColor whiteColor],[UIColor whiteColor]] fonts:@[[UIFont boldSystemFontOfSize:16.0f], [UIFont systemFontOfSize:18.0f]] warp:NO spacing:0.0f];
        newsLabel.textColor = [UIColor whiteColor];
        newsLabel.textAlignment = NSTextAlignmentLeft;
        newsLabel.adjustsFontSizeToFitWidth = YES;
        newsLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [_tableHeadView addSubview:newsLabel];
        self.newsLabel = newsLabel;

        // 电话号码
        CGFloat phoneLH = 24;
        CGFloat phoneLX = CGRectGetMaxX(headImageView.frame) + margin;
        CGFloat phoneLY = CGRectGetMaxY(newsLabel.frame) + margin;
        CGFloat phoneLW = headW - newsLX - margin * 2;
        UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(phoneLX, phoneLY, phoneLW, phoneLH)];
        phoneLabel.textColor = [UIColor whiteColor];
        phoneLabel.textAlignment = NSTextAlignmentLeft;
        phoneLabel.adjustsFontSizeToFitWidth = YES;
        phoneLabel.font = [UIFont systemFontOfSize:16.0f];;
        [_tableHeadView addSubview:phoneLabel];
        self.phoneLabel = phoneLabel;
        
        if (user.count != 0) {
            NSString *name = [NSString stringWithFormat:@"%@", user[@"name"]];
            NSString *userName = [NSString stringWithFormat:@"%@", user[@"username"] ];
            self.newsLabel.text = name;
            self.phoneLabel.text = userName;
        }
        
        
        CGFloat viewY = 180.0f;
        CGFloat headLabelY = CGRectGetMaxY(headImageView.frame) + margin;
        CGFloat headLabelW = (headW - margin * 4)* 0.25;
        CGFloat headLabelH = imageH - viewY - margin;
        
        self.headLabelArray = [[NSMutableArray alloc] init];
        NSArray * headtitleArray = @[@"在线设备", @"离线设备", @"异常设备", @"水卡总数"];
        NSArray * headContentArray = @[@"0", @"0", @"0", @"0"];
        for (int i = 0; i < 4; i++) {
            CGFloat headLabelX = i * (headLabelW + margin);
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(headLabelX, headLabelY, headLabelW, headLabelH)];
            label.userInteractionEnabled = YES;
            label.textAlignment = NSTextAlignmentCenter;
            
            [label setTexts:@[headContentArray[i], headtitleArray[i]] colors:@[[UIColor whiteColor], [UIColor whiteColor]] fonts:@[[UIFont PFSemiboldSize:16.0f], [UIFont systemFontOfSize:12.0f]] warp:YES spacing:0.1f];
            UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeadLabel:)];
            [label addGestureRecognizer:TapGesture];
            [_tableHeadView addSubview:label];
            [self.headLabelArray addObject:label];
        }
        
        CGFloat viewH = 240;
        CGFloat viewW = UIScreenWidth - margin * 2;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, viewY + margin, viewW, viewH)];
        view.backgroundColor = [UIColor colorWithRed:222 / 255.0f green:235 / 255.0f blue:220 / 255.0f alpha:1.0f];
        view.layer.cornerRadius = 10.0f;
        [_tableHeadView addSubview:view];
        
        CGFloat walletX = viewW * 0.5;
        CGFloat walletY = -10;
        CGFloat walletW = viewW * 0.5;
        CGFloat walletH = viewH * 0.33;
        UIImageView *walletImageView = [[UIImageView alloc] initWithFrame:CGRectMake(walletX, walletY, walletW, walletH)];
        walletImageView.contentMode = UIViewContentModeScaleAspectFit; // 图片填充模式
        walletImageView.image = IMAGE(@"ic_wallet");
        [view addSubview:walletImageView];
        
        
        
        CGFloat totalMoneyLH = walletH -  margin;
        CGFloat totalMoneyLX = margin * 2;
        CGFloat totalMoneyLY = margin;
        CGFloat totalMoneyLW = viewW - walletW - margin;
        UILabel *totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(totalMoneyLX, totalMoneyLY, totalMoneyLW, totalMoneyLH)];
        [totalMoneyLabel setTexts:@[@"总资产(元)", @"1275824.06"] colors:@[[UIColor dx_333333Color], [UIColor colorWithRed:170 / 255.0f green:11 / 255.0f blue:25 / 255.0f alpha:1]] fonts:@[[UIFont PFSemiboldSize:18.0f], [UIFont systemFontOfSize:12.0f]] warp:YES spacing:5.0f];

//        totalMoneyLabel.textAlignment = NSTextAlignmentLeft;
        [view addSubview:totalMoneyLabel];
        self.totalMoneyLabel = totalMoneyLabel;
        
        
        CGFloat contentViewY = CGRectGetMaxY(walletImageView.frame)+ margin * 0.5;
        CGFloat contentViewW = UIScreenWidth - margin * 2;
        CGFloat contentViewX = 0;
        CGFloat contentViewH = viewH - contentViewY;
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH)];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 10.0f;
        [view addSubview:contentView];
        self.contentView = contentView;
        
        CGFloat midX = margin;
        CGFloat midY = contentViewH * 0.5;
        CGFloat midW = contentViewW - midX * 2;
        CGFloat midH = 1.0f;
        
        UIView *midLineView = [[UIView alloc] initWithFrame:CGRectMake(midX, midY, midW, midH)];
        midLineView.backgroundColor = [UIColor dx_D9D9D9Color];
        [contentView addSubview:midLineView];
        
        
        CGFloat contentLabelW = CGRectGetWidth(contentView.frame) / 3;
        CGFloat contentLabelH = midY - margin - 1.0f;
        CGFloat contentLabelY = margin;
        
        CGFloat lineY = margin;
        CGFloat lineW = 1;
        CGFloat lineH = contentLabelH - margin * 2;
        
        NSArray *contentTitleArray = @[@"今日收入(元)", @"今日充值(元)", @"今日扫码(元)"];
        NSArray *contentArray = @[@"0.00", @"0.00", @"0.00"];
        self.contentLabelArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < contentTitleArray.count; i++) {
            CGFloat contentLabelX = i * (contentLabelW - 1);
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(contentLabelX, contentLabelY, contentLabelW, contentLabelH)];
            label.userInteractionEnabled = YES;
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            label.adjustsFontSizeToFitWidth = YES;
            [label setTexts:@[contentArray[i], contentTitleArray[i]] colors:@[[UIColor colorWithRed:170 / 255.0f green:11 / 255.0f blue:25 / 255.0f alpha:1], [UIColor dx_666666Color]] fonts:@[[UIFont PFSemiboldSize:18.0f], [UIFont systemFontOfSize:12.0f]] warp:YES spacing:5.0f];
            UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContentLabel:)];
            [label addGestureRecognizer:TapGesture];
            [contentView addSubview:label];
            [self.contentLabelArray addObject:label];
            
            CGFloat lineX = i * contentLabelW;
            UIView *midLineView = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
            midLineView.backgroundColor = [UIColor dx_D9D9D9Color];
            [contentView addSubview:midLineView];
            
        }
        
        
        CGFloat HlineY = midY + margin;
        CGFloat HlineW = 1;
        CGFloat HlineH = contentViewH * 0.5 - margin * 2;
        CGFloat HLineX = contentViewW * 0.5;
        UIView *HLineView = [[UIView alloc] initWithFrame:CGRectMake(HLineX, HlineY, HlineW, HlineH)];
        HLineView.backgroundColor = [UIColor dx_D9D9D9Color];
        [contentView addSubview:HLineView];
        
        
        
        
        NSArray *todayTitleArray = @[@"今日收入(元)", @"今日扫码(元)", @"今日充值(元)", @"今日办卡(张)", @"今日打水(升)", @"水卡总余额(元)"];
        NSArray *todayArray = @[@"0.00", @"0.00", @"0.00", @"0", @"0", @"0.00"];
//        self.contentLabelArray = [[NSMutableArray alloc] init];
//
//        for (int i = 0; i < contentTitleArray.count; i++) {
//            //行
//            int row = i % 2;
//            //列
//            int column = i / 2;
//
//            CGFloat contentLabelX = column * contentLabelW;
//            CGFloat contentLabelY = row * contentLabelH + margin;
//
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(contentLabelX, contentLabelY, contentLabelW, contentLabelH)];
//            label.userInteractionEnabled = YES;
//            label.textAlignment = NSTextAlignmentCenter;
//            label.backgroundColor = [UIColor clearColor];
//            label.adjustsFontSizeToFitWidth = YES;
//            [label setTexts:@[contentArray[i], contentTitleArray[i]] colors:@[[UIColor redColor], [UIColor dx_666666Color]] fonts:@[[UIFont PFSemiboldSize:18.0f], [UIFont systemFontOfSize:12.0f]] warp:YES spacing:5.0f];
//            UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContentLabel:)];
//            [label addGestureRecognizer:TapGesture];
//
//            [view addSubview:label];
//            [self.contentLabelArray addObject:label];
//        }
        
        
    }
    return _tableHeadView;
}

- (void)requestNetWorkData
{
    WeakSelf(self);
    [KYRequest KYHomePageWithGetWithRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        if (isSuccess) {
            //在线设备
            NSString *onLine = [NSString stringWithFormat:@"%@", resultDic[@"online"]];
            //离线设备
            NSString *offLine = [NSString stringWithFormat:@"%@", resultDic[@"offline"]];
            //异常设备
            NSString *exception = [NSString stringWithFormat:@"%@", resultDic[@"exception"]];
            //水卡总数
            NSString *card = [NSString stringWithFormat:@"%@", resultDic[@"card"]];
            //会员数量
            NSString *memberCount = [NSString stringWithFormat:@"%@", resultDic[@"memberCount"]];
            
            NSArray * headtitleArray = @[@"在线设备", @"离线设备", @"异常设备", @"会员数量"];
            NSArray *headArray = @[onLine, offLine, exception, memberCount];

            for (int i = 0; i < weakself.headLabelArray.count; i++) {
                UILabel *label = weakself.headLabelArray[i];
                [label setTexts:@[headArray[i], headtitleArray[i]] colors:@[[UIColor whiteColor], [UIColor whiteColor]] fonts:@[[UIFont PFSemiboldSize:18.0f], [UIFont systemFontOfSize:12.0f]] warp:YES spacing:0.01f];

            }
            
            //今日收入
            int todayIncomeF = [resultDic[@"todayIncome"] intValue];
            NSString *todayIncome = [NSString stringWithFormat:@"%0.2f", todayIncomeF * 0.01];

            //今日充值
            int todayRechargeF = [resultDic[@"todayRecharge"] intValue];
            NSString *todayRecharge = [NSString stringWithFormat:@"%0.2f", todayRechargeF * 0.01];
            //今日打水
            int todayWaterF = [resultDic[@"todayWater"] intValue];
            NSString *todayWater = [NSString stringWithFormat:@"%0.0f", todayWaterF * 0.001];
            //今日扫码
            int todayScanF = [resultDic[@"todayScan"] intValue];
            NSString *todayScan = [NSString stringWithFormat:@"%0.2f", todayScanF * 0.01];
            //今日办卡
            int todayNewCardF = [resultDic[@"todayNewCard"] intValue];

            NSString *todayNewCard = [NSString stringWithFormat:@"%d", todayNewCardF];
            //水卡总余额
            int cardBalanceF = [resultDic[@"cardBalance"] intValue];
            NSString *cardBalance = [NSString stringWithFormat:@"%0.2f", cardBalanceF * 0.01];
            //今日体测
            int openDoorCountF = [resultDic[@"openDoorCount"] intValue];
            NSString *openDoorCount = [NSString stringWithFormat:@"%d", openDoorCountF];
            
            
            [self.totalMoneyLabel setTexts:@[@"总资产(元)", cardBalance] colors:@[[UIColor dx_333333Color], [UIColor colorWithRed:170 / 255.0f green:11 / 255.0f blue:25 / 255.0f alpha:1]] fonts:@[[UIFont PFSemiboldSize:18.0f], [UIFont PFSemiboldSize:18.0f]] warp:YES spacing:2.0f];
            
            
            
            NSArray *contentArray = @[todayIncome, openDoorCount, todayRecharge, todayNewCard, todayScan, cardBalance];
            NSArray *contentTitleArray = @[@"今日收入(元)", @"今日体测(次)", @"今日充值(元)", @"今日办卡(张)", @"今日扫码(元)", @"水卡总余额(元)"];
            
//            for (int i = 0; i < weakself.contentLabelArray.count; i++) {
//                UILabel *label = weakself.contentLabelArray[i];
//                [label setTexts:@[contentArray[i], contentTitleArray[i]] colors:@[[UIColor redColor], [UIColor dx_666666Color]] fonts:@[[UIFont PFSemiboldSize:18.0f], [UIFont systemFontOfSize:12.0f]] warp:YES spacing:5.0f];
//            }
            
            [weakself.tableView reloadData];
        }
    }];
}

#pragma mark - headLabel Tap Action
- (void)tapHeadLabel:(UIGestureRecognizer *)gesture
{
    UILabel *label = (UILabel *)gesture.view;
    NSLog(@"%@", label.text);
    //判断是否登录
    if ([KYRequest isLogin]) {
        
    } else {
        [self presentLoginVC];
    }
}

#pragma mark - contentLabel Tap Action
- (void)tapContentLabel:(UIGestureRecognizer *)gesture
{
    UILabel *label = (UILabel *)gesture.view;
    NSLog(@"%@", label.text);
    if ([KYRequest isLogin]) {
        
    } else {
        
        [self presentLoginVC];
    }
}

#pragma mark - item_view Tap Action
- (void)KY_HomePage_Items_CellTapAction:(NSString *)title
{
    
    //判断是否登录
    if ([KYRequest isLogin]) {
        if ([title isEqualToString:@"新办水卡"]) {
            KY_CreateNewCardVC *vc = [[KY_CreateNewCardVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if ([title isEqualToString:@"设备管理"]) {
            KY_DeviceManageVC *vc = [[KY_DeviceManageVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if ([title isEqualToString:@"用户管理"]) {
            KY_UserManageVC *vc = [[KY_UserManageVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if ([title isEqualToString:@"水卡充值"]) {
            KY_MemberRechargeVC *vc = [[KY_MemberRechargeVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } else {
        [self presentLoginVC];
    }
    
}

- (void)presentLoginVC
{
    LoginVC *vc = [[LoginVC alloc] init];
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.tabBarVC = (KYTabBarViewController *)self.tabBarController;
    [self presentViewController:na animated:YES completion:nil];
}




#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView spacingView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    kY_HomePage_Items_Cell *cell = [kY_HomePage_Items_Cell kY_HomePage_Items_CellWithTableView:self.tableView withIdentifier:@"kY_HomePage_Items_Cell"];
    cell.delegate = self;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//去掉系统自带的红点
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
