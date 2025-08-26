//
//  KY_DeviceDetailVC.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/6.
//

#import "KY_DeviceDetailVC.h"
#import "KY_HomePage_Model.h"
#import "KY_HomePage_Cell.h"
#import "KY_DeviceDetailStatusVC.h"
#import "KY_WaterRecordVC.h"
#import "KY_IncomeVC.h"
#import "KY_ParameterSettingVC.h"
#import "WXZCustomPickView.h"
#import <FWPopupView/FWPopupView-Swift.h>
#import "KYRequest.h"


@interface KY_DeviceDetailVC () <CustomPickViewDelegate>

@property (nonatomic, strong) UIView *tableHeadView;
@property (nonatomic,weak) UILabel *deviceNumLabel;
@property (nonatomic,weak) UILabel *deviceNameLabel;
@property (nonatomic,weak) UILabel *deviceGroupLabel;
@property (nonatomic,weak) UILabel *deviceAddressLabel;
@property (nonatomic,weak) UILabel *deviceDateLabel;
//是否在线
@property (nonatomic,weak) UIButton *isOnlineButton;
//设置
@property (nonatomic,weak) UIButton *settingButton;
//转移
@property (nonatomic,weak) UIButton *transferButton;
//修改
@property (nonatomic,weak) UIButton *amendButton;
//headLabel数组
@property (nonatomic, strong) NSMutableArray *headLabelArray;
//二维码ImageView
@property (nonatomic, strong) FWAlertView *alertWithImageView;
//设备的UUID
@property (nonatomic,copy) NSString *deviceUUID;

@property (nonatomic,strong) NSMutableArray *dataArray;

//分组 信息 groupList
@property (nonatomic,strong) NSMutableArray *groupListArray;

//分组 ID
@property (nonatomic,copy) NSString *GID;
//设备 编号
@property (nonatomic,copy) NSString *deviceNumber;

@end

@implementation KY_DeviceDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设备详情";
    [self configureUI];
    [self createdDataArray];
    //获取 分组数据
    [self getGroupListNetWork];
    [self requestNetWork];
}

- (void)requestNetWork
{
    WeakSelf(self);
    [KYRequest KYHomePage_DeviceDetailWithGetWithID:self.ID WIthRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        
        NSLog(@"%@", resultDic);
        NSDictionary *deviceDict = [NSDictionary dictionaryWithDictionary:resultDic[@"device"]];
        //UUID
        NSString *uuid = [NSString stringWithFormat:@"%@", deviceDict[@"uuid"]];
        weakself.deviceUUID = uuid;
        
        //设备编号
        NSString *numStr = [NSString stringWithFormat:@"%@", deviceDict[@"ID"]];
        [weakself.deviceNumLabel setTexts:@[@"设备编号: ", numStr] warp:NO spacing:0.0f];
        weakself.deviceNumber = numStr;
        //是否在线
        BOOL isOnline = [deviceDict[@"status"] boolValue];
        if (isOnline) {
            [weakself.isOnlineButton setTitle:@"在线" forState:UIControlStateNormal];
            [weakself.isOnlineButton setTitleColor:[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
            
        } else {
            [weakself.isOnlineButton setTitle:@"离线" forState:UIControlStateNormal];
            [weakself.isOnlineButton setTitleColor:[UIColor dx_FD2500Color] forState:UIControlStateNormal];
            
        }

        //设备别名
        NSString *nickStr = [NSString stringWithFormat:@"%@", deviceDict[@"nick"]];
        [weakself.deviceNameLabel setTexts:@[@"设备别名: ", nickStr] warp:NO spacing:0.0f];
        
        //设备分组
        
        //安装地址
        NSString *locationStr = [NSString stringWithFormat:@" %@", deviceDict[@"location"]];
        [weakself.deviceAddressLabel setTexts:@[@"安装地址: ", locationStr] warp:NO spacing:0.0f];
        //到期时间
        NSString *expire = deviceDict[@"expire"];
        int expireDay = [deviceDict[@"expireDay"] intValue];
        NSString *time = [expire substringWithRange:NSMakeRange(0, 10)];
        NSString *date = [NSString stringWithFormat:@"%@(剩余%d天)", time, expireDay];
        [weakself.deviceDateLabel setTexts:@[@"到期时间: ", date] warp:NO spacing:0.0f];
        
        //给循环Label 赋值
        //今日打水量（升）
        int todayCapacity = [resultDic[@"todayCapacity"] intValue];
        CGFloat todayIncome = [resultDic[@"todayIncome"] floatValue];
        int yesterdayCapacity = [resultDic[@"yesterdayCapacity"] intValue];
        CGFloat yesterdayIncome = [resultDic[@"yesterdayIncome"] floatValue];
        NSString *todayCapacityStr = [NSString stringWithFormat:@"%d", todayCapacity];
        NSString *todayIncomeStr = [NSString stringWithFormat:@"%0.2f", todayIncome];
        NSString *yesterdayCapacityStr = [NSString stringWithFormat:@"%d", yesterdayCapacity];
        NSString *yesterdayIncomeStr = [NSString stringWithFormat:@"%0.2f", yesterdayIncome];
        NSArray * headtitleArray = @[@"今日打水量(升)", @"当日收入(元)", @"昨日打水量(升)", @"昨日收入(元)"];
        NSArray *headArray = @[todayCapacityStr, todayIncomeStr, yesterdayCapacityStr, yesterdayIncomeStr];
        for (int i = 0; i < self.headLabelArray.count; i++) {
            UILabel *label = self.headLabelArray[i];
            [label setTexts:@[headArray[i], headtitleArray[i]] colors:@[[UIColor colorWithRed:170.0f / 255.0f green:128.0f / 255.0f blue:70.0f / 255.0f alpha:1], [UIColor dx_666666Color]] fonts:@[[UIFont PFSemiboldSize:16.0f], [UIFont systemFontOfSize:12.0f]] warp:YES spacing:5.0f];
        }
        

    }];
}

//请求 新办卡 分组信息
- (void)getGroupListNetWork
{
    WeakSelf(self);
    self.groupListArray = [[NSMutableArray alloc] init];
    [KYRequest KYHomePage_CreateNewCardGroupListWithRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        if (isSuccess) {
            NSArray *dataArray = [NSArray arrayWithArray:resultDic[@"list"]];
            for (int i = 0; i < dataArray.count; i++) {
                NSDictionary *data = [NSDictionary dictionaryWithDictionary:dataArray[i]];
                KY_CreateNewCard_GroupList_Model *model = [KY_CreateNewCard_GroupList_Model KY_CreateNewCard_GroupList_ModelWithDictionary:data];
                [weakself.groupListArray addObject:model];
            }
                    
        }
    }];
}





- (void)configureUI
{
    CGFloat tableViewY = 0;
//    CGFloat tableViewH = UIScreenHeight - tableViewY - [UIDevice vg_tabBarFullHeight];
    CGFloat tableViewH = UIScreenHeight - tableViewY;
    [self allocWithFrame:CGRectMake(0, tableViewY, UIScreenWidth, tableViewH) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.scrollEnabled = NO;
//    self.tableView.backgroundColor = [UIColor colorWithHex:0xF3F3F3];
    self.tableView.tableHeaderView = self.tableHeadView;
    self.tableView.tableFooterView = [self tableViewFooterView];
}

-(UIView *)tableHeadView
{
    if (!_tableHeadView) {
        CGFloat margin = 10.0f;
        CGFloat headX = 0;
        CGFloat headY = 0;
        CGFloat headW = UIScreenWidth;
        CGFloat headH = 280;
        _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(headX, headY, headW, headH)];
        _tableHeadView.backgroundColor = [UIColor clearColor];

        CGFloat deviceViewX = 0.0f;
        CGFloat deviceViewY = 0.0f;
        CGFloat deviceViewW = headW;
        CGFloat deviceViewH = 180.0f;
        UIView *deviceView = [[UIView alloc] initWithFrame:CGRectMake(deviceViewX, deviceViewY, deviceViewW, deviceViewH)];
        deviceView.backgroundColor = [UIColor whiteColor];
        [_tableHeadView addSubview:deviceView];
        
        CGFloat buttonW = 80.0f;
        CGFloat deviceNumX = margin;
        CGFloat deviceNumY = margin;
        CGFloat deviceNumW = UIScreenWidth - deviceNumX - buttonW;
        CGFloat deviceNumH = 24.0f;
        UILabel *deviceNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(deviceNumX, deviceNumY, deviceNumW, deviceNumH)];
        [deviceNumLabel setTexts:@[@"设备编号: ", @"18601"] warp:NO spacing:0.0f];
        deviceNumLabel.textColor = [UIColor dx_333333Color];
        deviceNumLabel.font = DFont(16);
        [deviceView addSubview:deviceNumLabel];
        self.deviceNumLabel = deviceNumLabel;
        
        UIButton * isOnlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat buttonH = 24.0f;
        CGFloat DPbuttonY = deviceNumY;
        CGFloat DPButtonX = CGRectGetMaxX(deviceView.frame) - margin - buttonW;
        isOnlineButton.frame = CGRectMake(DPButtonX, DPbuttonY, buttonW, buttonH);
        isOnlineButton.backgroundColor = [UIColor clearColor];
        [isOnlineButton setTitle:@"离线" forState:UIControlStateNormal];
        isOnlineButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        isOnlineButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        isOnlineButton.titleLabel.font = DFont(12);
        [isOnlineButton setTitleColor:[UIColor dx_666666Color] forState:UIControlStateNormal];
        [deviceView addSubview:isOnlineButton];
        self.isOnlineButton = isOnlineButton;
        
        
        CGFloat deviceNameX = margin;
        CGFloat deviceNameY = CGRectGetMaxY(deviceNumLabel.frame) + margin;
        CGFloat deviceNameW = UIScreenWidth - deviceNumX - buttonW;
        CGFloat deviceNameH = 24.0f;
        UILabel *deviceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(deviceNameX, deviceNameY, deviceNameW, deviceNameH)];
        [deviceNameLabel setTexts:@[@"设备别名: ", @"我的设备"] warp:NO spacing:0.0f];
        deviceNameLabel.textColor = [UIColor dx_333333Color];
        deviceNameLabel.font = DFont(16);
        [deviceView addSubview:deviceNameLabel];
        self.deviceNameLabel = deviceNameLabel;
        
        CGFloat settingButtonX = CGRectGetMaxX(deviceView.frame) - margin - buttonW;;
        CGFloat settingButtonY = deviceNameY;
        UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        settingButton.frame = CGRectMake(settingButtonX, settingButtonY, buttonW, buttonH);
        settingButton.backgroundColor = [UIColor clearColor];
        settingButton.titleLabel.font = DFont(15);
        settingButton.layer.borderWidth = 0.5f;
        settingButton.layer.borderColor = [[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] CGColor];
        settingButton.layer.cornerRadius = buttonH * 0.5;
        settingButton.layer.masksToBounds = YES;
        settingButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [settingButton setTitleColor:[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
        [settingButton setTitle:@"设置" forState:UIControlStateNormal];
        [settingButton addTarget:self action:@selector(settingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [deviceView addSubview:settingButton];
        self.settingButton = settingButton;
        
        
        CGFloat deviceGroupX = margin;
        CGFloat deviceGroupY = CGRectGetMaxY(deviceNameLabel.frame) + margin;
        CGFloat deviceGroupW = UIScreenWidth - deviceNumX - buttonW;
        CGFloat deviceGroupH = 24.0f;
        UILabel *deviceGroupLabel = [[UILabel alloc] initWithFrame:CGRectMake(deviceGroupX, deviceGroupY, deviceGroupW, deviceGroupH)];
        [deviceGroupLabel setTexts:@[@"设备分组: ", @""] warp:NO spacing:0.0f];
        deviceGroupLabel.textColor = [UIColor dx_333333Color];
        deviceGroupLabel.font = DFont(16);
        [deviceView addSubview:deviceGroupLabel];
        self.deviceGroupLabel = deviceGroupLabel;
        
        CGFloat transferButtonX = CGRectGetMaxX(deviceView.frame) - margin - buttonW;;
        CGFloat transferButtonY = deviceGroupY;
        UIButton *transferButton = [UIButton buttonWithType:UIButtonTypeCustom];
        transferButton.frame = CGRectMake(transferButtonX, transferButtonY, buttonW, buttonH);
        transferButton.backgroundColor = [UIColor clearColor];
        transferButton.titleLabel.font = DFont(15);
        transferButton.layer.borderWidth = 0.5f;
        transferButton.layer.borderColor = [[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] CGColor];
        transferButton.layer.cornerRadius = buttonH * 0.5;
        transferButton.layer.masksToBounds = YES;
        transferButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [transferButton setTitleColor:[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
        [transferButton setTitle:@"转移" forState:UIControlStateNormal];
        [transferButton addTarget:self action:@selector(transferButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [deviceView addSubview:transferButton];
        self.transferButton = transferButton;
        
        CGFloat deviceAddressX = margin;
        CGFloat deviceAddressY = CGRectGetMaxY(deviceGroupLabel.frame) + margin;
        CGFloat deviceAddressW = UIScreenWidth - deviceNumX - buttonW;
        CGFloat deviceAddressH = 24.0f;
        UILabel *deviceAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(deviceAddressX, deviceAddressY, deviceAddressW, deviceAddressH)];
        [deviceAddressLabel setTexts:@[@"安装地址: ", @"合肥市培恩电器1"] warp:NO spacing:0.0f];
        deviceAddressLabel.textColor = [UIColor dx_333333Color];
        deviceAddressLabel.font = DFont(16);
        [deviceView addSubview:deviceAddressLabel];
        self.deviceAddressLabel = deviceAddressLabel;
        
        CGFloat amendButtonX = CGRectGetMaxX(deviceView.frame) - margin - buttonW;;
        CGFloat amendButtonY = deviceAddressY;
        UIButton *amendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        amendButton.frame = CGRectMake(amendButtonX, amendButtonY, buttonW, buttonH);
        amendButton.backgroundColor = [UIColor clearColor];
        amendButton.titleLabel.font = DFont(15);
        amendButton.layer.borderWidth = 0.5f;
        amendButton.layer.borderColor = [[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] CGColor];
        amendButton.layer.cornerRadius = buttonH * 0.5;
        amendButton.layer.masksToBounds = YES;
        amendButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [amendButton setTitleColor:[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
        [amendButton setTitle:@"修改" forState:UIControlStateNormal];
        [amendButton addTarget:self action:@selector(amendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [deviceView addSubview:amendButton];
        self.amendButton = amendButton;
        
        
        CGFloat deviceDateX = margin;
        CGFloat deviceDateY = CGRectGetMaxY(deviceAddressLabel.frame) + margin;
        CGFloat deviceDateW = UIScreenWidth - deviceNumX - buttonW;
        CGFloat deviceDateH = 24.0f;
        UILabel *deviceDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(deviceDateX, deviceDateY, deviceDateW, deviceDateH)];
        [deviceDateLabel setTexts:@[@"到期时间: ", @"2026-06-06(剩余306天)"] warp:NO spacing:0.0f];
        deviceDateLabel.textColor = [UIColor dx_333333Color];
        deviceDateLabel.font = DFont(16);
        [deviceView addSubview:deviceDateLabel];
        self.deviceDateLabel = deviceDateLabel;
        
        CGFloat detailViewX = margin;
        CGFloat detailViewY = CGRectGetMaxY(deviceView.frame) + margin;
        CGFloat detailViewW = UIScreenWidth - margin * 2;
        CGFloat detailViewH = headH - deviceViewH - margin * 2;
        UIView *detailView = [[UIView alloc] initWithFrame:CGRectMake(detailViewX, detailViewY, detailViewW, detailViewH)];
        detailView.backgroundColor = [UIColor whiteColor];
        detailView.layer.cornerRadius = 10.0f;
        [_tableHeadView addSubview:detailView];
        
        CGFloat headLabelY =  margin;
        CGFloat headLabelW = (detailViewW) / 4;
        CGFloat headLabelH = detailViewH - margin * 2;
        
        self.headLabelArray = [[NSMutableArray alloc] init];
        NSArray * headtitleArray = @[@"今日打水量(升)", @"当日收入(元)", @"昨日打水量(升)", @"昨日收入(元)"];
        NSArray * headContentArray = @[@"1", @"1.00", @"1", @"1.00"];
        for (int i = 0; i < 4; i++) {
            CGFloat headLabelX = i * headLabelW;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(headLabelX, headLabelY, headLabelW, headLabelH)];
            label.userInteractionEnabled = YES;
            label.textAlignment = NSTextAlignmentCenter;
            [label setTexts:@[headContentArray[i], headtitleArray[i]] colors:@[[UIColor colorWithRed:170.0f / 255.0f green:128.0f / 255.0f blue:70.0f / 255.0f alpha:1], [UIColor dx_666666Color]] fonts:@[[UIFont PFSemiboldSize:16.0f], [UIFont systemFontOfSize:12.0f]] warp:YES spacing:5.0f];
//            UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeadLabel:)];
//            [label addGestureRecognizer:TapGesture];
            [detailView addSubview:label];
            [self.headLabelArray addObject:label];
        }
        
    }
    return _tableHeadView;
}



//设置
- (void)settingButtonAction:(UIButton *)sender
{
    id block = ^(FWPopupView *popupView, NSInteger index, NSString *title){
//        NSLog(@"AlertView：点击了第 %ld 个按钮, title = %@", (long)index, title);
    };
    NSArray *items = @[[[FWPopupItem alloc] initWithTitle:@"取消" itemType:FWItemTypeNormal isCancel:YES canAutoHide:YES itemClickedBlock:block],
                       [[FWPopupItem alloc] initWithTitle:@"确定" itemType:FWItemTypeNormal isCancel:NO canAutoHide:YES itemClickedBlock:block]];
    
    FWAlertView *alertView = [FWAlertView alertWithTitle:@"修改设备别名" detail:nil inputPlaceholder:@"请输入设备别名" keyboardType:UIKeyboardTypeDefault isSecureTextEntry:NO customView:nil items:items];
    [alertView show];
    
    WeakSelf(self);
    alertView.inputBlock = ^(NSString * _Nonnull text) {
        if (text.length != 0) {
            [KYRequest KYDeviceDetailWithPostWithID:self.ID withNick:text withRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
                if (isSuccess) {
                    [weakself.deviceNameLabel setTexts:@[@"设备别名: ", text] warp:NO spacing:0.0f];
                    [weakself showPopView:message];
                } else {
                    [weakself showPopView:message];
                }
            }];
        }
    };
}
//转移
- (void)transferButtonAction:(UIButton *)sender
{

    WXZCustomPickView *pickerSingle = [[WXZCustomPickView alloc]init];
    NSMutableArray *arrayData = [[NSMutableArray alloc] init];
    if (self.groupListArray.count != 0) {
        for (int i = 0; i < self.groupListArray.count; i++) {
            KY_CreateNewCard_GroupList_Model *model = self.groupListArray[i];
            [arrayData addObject:model.name];
        }
        [pickerSingle setDataArray:arrayData];
        [pickerSingle setDefalutSelectRowStr:arrayData[0]];
    }
    [pickerSingle setDelegate:self];
    [pickerSingle show];
    
}

//wxzPickView的代理方法
- (void)customPickView:(WXZCustomPickView *)customPickView selectedTitle:(NSString *)selectedTitle
{
    if (self.groupListArray.count != 0) {
        for (int i = 0; i < self.groupListArray.count; i++) {
            KY_CreateNewCard_GroupList_Model *model = self.groupListArray[i];
            if ([selectedTitle isEqualToString:model.name]) {
                self.GID = [NSString stringWithFormat:@"%d",model.ID];

                WeakSelf(self);
                [KYRequest KYDeviceDetailUpdateDeviceFieldWithPostWithID:self.deviceNumber withGid:self.GID withRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
                    if (isSuccess) {
                        [weakself.deviceGroupLabel setTexts:@[@"设备分组: ", model.name] warp:NO spacing:0.0f];
                        [weakself showPopView:message];
                    } else {
                        [weakself showPopView:message];
                    }
                    
                }];
            }
        }
    }
    
}


//修改
- (void)amendButtonAction:(UIButton *)sender
{
    id block = ^(FWPopupView *popupView, NSInteger index, NSString *title){
        NSLog(@"AlertView：点击了第 %ld 个按钮", (long)index);
    };
    NSArray *items = @[[[FWPopupItem alloc] initWithTitle:@"取消" itemType:FWItemTypeNormal isCancel:YES canAutoHide:YES itemClickedBlock:block],
                       [[FWPopupItem alloc] initWithTitle:@"确定" itemType:FWItemTypeNormal isCancel:NO canAutoHide:YES itemClickedBlock:block]];
    
    FWAlertView *alertView = [FWAlertView alertWithTitle:@"修改安装地址" detail:nil inputPlaceholder:@"请输入安装地址" keyboardType:UIKeyboardTypeDefault isSecureTextEntry:NO customView:nil items:items];
    [alertView show];
    
    WeakSelf(self);
    alertView.inputBlock = ^(NSString * _Nonnull text) {
        if (text.length != 0) {
            [KYRequest KYDeviceDetailLocationWithPostWithID:self.deviceNumber withLocation:text withRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
                if (isSuccess) {
                    [weakself.deviceAddressLabel setTexts:@[@"安装地址: ", text] warp:NO spacing:0.0f];
                    [weakself showPopView:message];
                } else {
                    [weakself showPopView:message];
                }
                
            }];
        }
    };
    
    
}

//创建列表数组
- (void)createdDataArray
{
    NSArray *titleArray1 = @[@"设备最新状态", @"打水记录", @"收入记录", @"设备二维码"];
    NSArray *iconArray1 = @[@"device_status", @"order", @"income", @"qrcode"];
    
    NSArray *titleArray2 = @[@"参数设置"];
    NSArray *iconArray2 = @[@"setting"];
    
    NSMutableArray *dataArray1 = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray1.count; i++) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setValue:titleArray1[i] forKey:@"title"];
        [data setValue:iconArray1[i] forKey:@"icon"];
        KY_DeviceDetail_Model *model = [KY_DeviceDetail_Model KY_DeviceDetail_ModelWithDictionary:data];
        [dataArray1 addObject:model];
    }
    
    NSMutableArray *dataArray2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray2.count; i++) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setValue:titleArray2[i] forKey:@"title"];
        [data setValue:iconArray2[i] forKey:@"icon"];
        KY_DeviceDetail_Model *model = [KY_DeviceDetail_Model KY_DeviceDetail_ModelWithDictionary:data];
        [dataArray2 addObject:model];
    }
    
    self.dataArray = @[dataArray1, dataArray2].mutableCopy;
    [self.tableView reloadData];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArray[section] count];
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
    return 10.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 10.0f)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 64.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KY_HomePage_DeviceDetail_Cell *cell = [KY_HomePage_DeviceDetail_Cell KY_HomePage_DeviceDetail_CellWithTableView:self.tableView withIdentifier:@"KY_HomePage_DeviceDetail_Cell"];
    
    KY_DeviceDetail_Model *model = self.dataArray[indexPath.section][indexPath.row];
    if (model) {
        cell.model = model;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KY_HomePage_DeviceDetail_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //push 设备最新状态VC
    if ([cell.TitleLabel.text isEqualToString:@"设备最新状态"]) {
        KY_DeviceDetailStatusVC *vc = [[KY_DeviceDetailStatusVC alloc] init];
        vc.deviceNumber = self.deviceNumber;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    //push 打水记录VC
    if ([cell.TitleLabel.text isEqualToString:@"打水记录"]) {
        KY_WaterRecordVC *vc = [[KY_WaterRecordVC alloc] init];
        vc.deviceNumber = self.deviceNumber;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    //push 收入记录VC
    if ([cell.TitleLabel.text isEqualToString:@"收入记录"]) {
        KY_IncomeVC *vc = [[KY_IncomeVC alloc] init];
        vc.deviceNumber = self.deviceNumber;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
 
    //alertView 二维码页面
    if ([cell.TitleLabel.text isEqualToString:@"设备二维码"]) {
        __weak typeof(self) weakSelf = self;
        id block = ^(FWPopupView *popupView, NSInteger index, NSString *title){
            if (index == 1)
            {
                // 这边演示了如何手动去调用隐藏
                [weakSelf.alertWithImageView hide];
            }
        };
        
        // 注意：此时“确定”按钮是不让按钮自己隐藏的
        NSArray *items = @[[[FWPopupItem alloc] initWithTitle:@"取消" itemType:FWItemTypeNormal isCancel:YES canAutoHide:YES itemClickedBlock:block],
                           [[FWPopupItem alloc] initWithTitle:@"确定" itemType:FWItemTypeNormal isCancel:NO canAutoHide:NO itemClickedBlock:block]];
        UIImage *image = [self createQRCodeImageWithUUID:self.deviceUUID];
        UIImageView *customImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        customImageView.image = image;
        customImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        NSString *detail = [NSString stringWithFormat:@"设备号:%@", self.deviceNumber];
        self.alertWithImageView = [FWAlertView alertWithTitle:@"二维码" detail:detail inputPlaceholder:nil keyboardType:UIKeyboardTypeDefault isSecureTextEntry:NO customView:customImageView items:items];
        [self.alertWithImageView show];
    }
    
    
    //push 参数设置VC
    if ([cell.TitleLabel.text isEqualToString:@"参数设置"]) {
        KY_ParameterSettingVC *vc = [[KY_ParameterSettingVC alloc] init];
        vc.deviceNumber = self.deviceNumber;
        vc.deviceUUID = self.deviceUUID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

//去掉系统自带的红点
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (UIView *)tableViewFooterView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 64.0f)];
    
    NSArray *buttonArray = @[@"打水", @"开舱门"];
    CGFloat margin = 10.0f;
    CGFloat buttonY = margin * 2;
    CGFloat buttonW = (UIScreenWidth - margin * 4) * 0.3;
    CGFloat buttonH = 44.0f;
    for (int i = 0; i < buttonArray.count; i++) {
        CGFloat buttonX = margin + i * (margin + buttonW);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.backgroundColor = [UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f];
        button.titleLabel.font = DFont(15);
        button.layer.borderWidth = 0.01f;
        button.layer.borderColor = [UIColor colorWithRed:20.0f/255.0f green:80.0f/255.0f blue:200.0f/255.0f alpha:0.7f].CGColor;
        button.layer.cornerRadius = buttonH * 0.5;
        button.layer.masksToBounds = YES;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:buttonArray[i] forState:UIControlStateNormal];
        // 假设button是你想要修改的UIButton实例
        button.titleLabel.font = [UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    return view;
}


- (void)buttonAction:(UIButton *)sender
{
    NSLog(@"%@", sender.titleLabel.text);
    
    if ([sender.titleLabel.text isEqualToString:@"打水"]) {
        [self ThrashButtonAction];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"开舱门"]) {
        
        [KYRequest KYDeviceDetailOpenDoorWithPostWithUUID:self.deviceUUID withRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
            if (isSuccess) {
                [self showPopView:message];
            } else {
                [self showPopView:message];
            }
        }];
    }
    
}

//打水按钮
- (void)ThrashButtonAction
{
    id block = ^(FWPopupView *popupView, NSInteger index, NSString *title){
//        NSLog(@"AlertView：点击了第 %ld 个按钮", (long)index);
    };
    NSArray *items = @[[[FWPopupItem alloc] initWithTitle:@"取消" itemType:FWItemTypeNormal isCancel:YES canAutoHide:YES itemClickedBlock:block],
                       [[FWPopupItem alloc] initWithTitle:@"确定" itemType:FWItemTypeNormal isCancel:NO canAutoHide:YES itemClickedBlock:block]];
    
    FWAlertView *alertView = [FWAlertView alertWithTitle:@"打水" detail:nil inputPlaceholder:@"请输入金额(单位元)" keyboardType:UIKeyboardTypeDefault isSecureTextEntry:NO customView:nil items:items];
    [alertView show];
    
    WeakSelf(self);
    alertView.inputBlock = ^(NSString * _Nonnull text) {
        if (text.length != 0) {
            [KYRequest KYDeviceDetailThrashWithPostWithUUID:weakself.deviceUUID WithMoney:text withRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
                if (isSuccess) {
                    [self showPopView:message];
                } else {
                    [self showPopView:message];
                }
            }];
        }
    };
    
}


//生成二维码
- (UIImage *)createQRCodeImageWithUUID:(NSString *)uuid
{
    NSArray *filter = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
//    NSLog(@"%@", filter);
    // 二维码过滤器
    CIFilter *filterImage = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 将二位码过滤器设置为默认属性
    [filterImage setDefaults];
    // 将文字转化为二进制
    
//
//
    NSString *str = [NSString stringWithFormat:@"https://gm.hfljyx.com?d=%@", uuid];
    NSData *dataImage = [str dataUsingEncoding:NSUTF8StringEncoding];
    // 打印输入的属性
//    NSLog(@"%@", filterImage.inputKeys);
    // KVC 赋值
    [filterImage setValue:dataImage forKey:@"inputMessage"];
    // 取出输出图片
    CIImage *outputImage = [filterImage outputImage];
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    // 转化图片
    UIImage *image = [UIImage imageWithCIImage:outputImage];

    // 为二维码加自定义图片

    // 开启绘图, 获取图片 上下文<图片大小>
    UIGraphicsBeginImageContext(image.size);
    // 将二维码图片画上去
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    // 将小图片画上去
    UIImage *smallImage = [UIImage imageNamed:@"taskAddImg"];
    [smallImage drawInRect:CGRectMake((image.size.width - 100) / 2, (image.size.width - 100) / 2, 100, 100)];
    // 获取最终的图片
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    // 显示
    return finalImage;
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
