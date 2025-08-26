//
//  KY_UserDetailVC.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/20.
//

#import "KY_UserDetailVC.h"
#import "KYRequest.h"
#import "KY_HomePage_Cell.h"
#import "KY_HomePage_Model.h"
#import "UIButton+Layout.h"
#import "UIButton+Extention.h"

#import <FWPopupView/FWPopupView-Swift.h>

#import "WXZPickDateView.h"

@interface KY_UserDetailVC () <kY_HomePage_UserDetail_CellActionDelegate, PickerDateViewDelegate>

@property (nonatomic,weak) KY_HomePage_UserDetail_Cell *selectCell;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation KY_UserDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户详情";
    [self configureUI];
//    [self createdDataArray];
    [self RequestNetData];
}

- (void)configureUI
{
    CGFloat tableViewY = 0;
    CGFloat tableViewH = UIScreenHeight - tableViewY;
    [self allocWithFrame:CGRectMake(0, tableViewY, UIScreenWidth, tableViewH) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xF3F3F3];
//    self.tableView.tableHeaderView = self.tableHeadView;
    self.tableView.tableFooterView = [self tableViewFooterView];
}

//创建列表数组
- (void)createdDataArray
{
    NSArray *titleArray1 = @[@"手机号", @"账户余额", @"体测权限", @"备注姓名", @"创建时间"];
    NSArray *valueArray1 = @[@"13872003255", @"400.00元", @"2026-08-20(有效期)", @"", @"2025-08-20"];
    NSArray *placeholderArray1 = @[@"", @"请输入金额(元)", @"", @"用户不可见该数据",@""];
    self.dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray1.count; i++) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setValue:titleArray1[i] forKey:@"title"];
        [data setValue:valueArray1[i] forKey:@"value"];
        [data setValue:placeholderArray1[i] forKey:@"placeholder"];
        KY_UserDetail_Model *model = [KY_UserDetail_Model KY_UserDetail_ModelWithDictionary:data];
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
}

//创建NetWorkData
- (void)RequestNetData
{
    WeakSelf(self);
    self.dataArray = [[NSMutableArray alloc] init];
    [KYRequest KYHomePage_UserDetailWithGetWithID:self.ID WithRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        
        NSString *mobile = [NSString stringWithFormat:@"%@", resultDic[@"mobile"]];
        NSString *balance = [NSString stringWithFormat:@"%0.2f元", [resultDic[@"balance"] intValue] * 0.01];
        NSString *medical = [NSString stringWithFormat:@"%@(有效期)", [resultDic[@"medical"] substringToIndex:10]];
        NSString *CreatedAt = [NSString stringWithFormat:@"%@", [resultDic[@"CreatedAt"] substringToIndex:10]];
        NSString *nickName = [NSString stringWithFormat:@"%@", resultDic[@"name"]];

        NSArray *titleArray1 = @[@"手机号", @"账号余额", @"体测权限", @"备注姓名", @"创建时间"];
        NSArray *valueArray1 = @[mobile, balance, medical, nickName, CreatedAt];
        NSArray *placeholderArray1 = @[@"", @"请输入金额(元)", @"", @"用户不可见该数据",@""];

        for (int i = 0; i < titleArray1.count; i++) {
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            [data setValue:titleArray1[i] forKey:@"title"];
            [data setValue:valueArray1[i] forKey:@"value"];
            [data setValue:placeholderArray1[i] forKey:@"placeholder"];
            KY_UserDetail_Model *model = [KY_UserDetail_Model KY_UserDetail_ModelWithDictionary:data];
            [weakself.dataArray addObject:model];
        }
        [self.tableView reloadData];
    }];
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
    return self.dataArray.count;
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
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView spacingView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 94.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KY_HomePage_UserDetail_Cell *cell = [KY_HomePage_UserDetail_Cell KY_HomePage_UserDetail_CellWithTableView:tableView withIdentifier:@"KY_HomePage_UserDetail_Cell"];
    cell.delegate = self;
    KY_UserDetail_Model *model = self.dataArray[indexPath.row];
    if (model) {
        cell.model = model;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
// delegateAction
-(void)kY_HomePage_UserDetail_CellLabelTapAction:(KY_HomePage_UserDetail_Cell *)cell
{
    self.selectCell = cell;
    if ([cell.model.title isEqualToString:@"账号余额"]) {
        
        id block = ^(FWPopupView *popupView, NSInteger index, NSString *title){
            NSLog(@"AlertView：点击了第 %ld 个按钮", (long)index);
        };
        NSArray *items = @[[[FWPopupItem alloc] initWithTitle:@"取消" itemType:FWItemTypeNormal isCancel:YES canAutoHide:YES itemClickedBlock:block],
                           [[FWPopupItem alloc] initWithTitle:@"确定" itemType:FWItemTypeNormal isCancel:NO canAutoHide:YES itemClickedBlock:block]];
        
        FWAlertView *alertView = [FWAlertView alertWithTitle:@"重置当前会员余额" detail:@"数据变动后会员可以看到修改记录，请谨慎操作避免纠纷" inputPlaceholder:@"请输入金额(元)" keyboardType:UIKeyboardTypeDefault isSecureTextEntry:NO customView:nil items:items];
        [alertView show];
        
        WeakSelf(self);
        alertView.inputBlock = ^(NSString * _Nonnull text) {
            if (text.length != 0) {
                NSUInteger moneyF = [text floatValue] * 100;
                NSString *balance = [NSString stringWithFormat:@"%ld", moneyF];
                [KYRequest KYUserDetailWithPostWithID:self.ID withBalance:balance withRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
                    if (isSuccess) {
                        weakself.selectCell.detailLabel.text = [NSString stringWithFormat:@"%0.2f", [balance floatValue] * 0.01];
                        [weakself showPopView:message];
                    } else {
                        [weakself showPopView:message];
                    }
                    
                }];
                                
            }
        };
        
    }
    
    if ([cell.model.title isEqualToString:@"体测权限"]) {
        WXZPickDateView *pickerDate = [[WXZPickDateView alloc]init];
        [pickerDate setIsAddYetSelect:NO];//是否显示至今选项
        [pickerDate setIsShowDay:YES];//是否显示日信息
        [pickerDate setDefaultTSelectYear:2025 defaultSelectMonth:8 defaultSelectDay:21];//设定默认显示的日期
        [pickerDate setDelegate:self];
        [pickerDate show];
    }
    
    if ([cell.model.title isEqualToString:@"备注姓名"]) {
        
        id block = ^(FWPopupView *popupView, NSInteger index, NSString *title){
            NSLog(@"AlertView：点击了第 %ld 个按钮", (long)index);
        };
        NSArray *items = @[[[FWPopupItem alloc] initWithTitle:@"取消" itemType:FWItemTypeNormal isCancel:YES canAutoHide:YES itemClickedBlock:block],
                           [[FWPopupItem alloc] initWithTitle:@"确定" itemType:FWItemTypeNormal isCancel:NO canAutoHide:YES itemClickedBlock:block]];
        
        FWAlertView *alertView = [FWAlertView alertWithTitle:@"备注用户姓名" detail:nil inputPlaceholder:@"用户不可见该数据" keyboardType:UIKeyboardTypeDefault isSecureTextEntry:NO customView:nil items:items];
        [alertView show];
        
        WeakSelf(self);
        alertView.inputBlock = ^(NSString * _Nonnull text) {
            if (text.length != 0) {
                
                NSString *name = [NSString stringWithFormat:@"%@", text];
                [KYRequest KYUserDetailWithPostWithID:self.ID withName:name withRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
                    if (isSuccess) {
                        weakself.selectCell.detailLabel.text = [NSString stringWithFormat:@"%@", name];
                        [weakself showPopView:message];
                    } else {
                        [weakself showPopView:message];
                    }
                    
                }];
                
            }
        };
        
    }
}

- (void)pickerDateView:(WXZBasePickView *)pickerDateView selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-M-d"];
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day];
    NSDate *date =[dateFormat dateFromString:dateStr];
    NSDateFormatter *TimeFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [TimeFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *title = [TimeFormat stringFromDate:date];
    
    
    NSString *medical = [NSString stringWithFormat:@"%@ 23:59:59", title];
    [KYRequest KYUserDetailWithPostWithID:self.ID withMedical:medical withRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        if (isSuccess) {
            NSString *str = [NSString stringWithFormat:@"%@(有效期)", title];
            self.selectCell.detailLabel.text = str;
            [self showPopView:message];
        } else {
            [self showPopView:message];
        }
    }];
    
    
}


//去掉系统自带的红点
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}



- (UIView *)tableViewFooterView
{
    CGFloat margin = 10.0f;
    CGFloat viewW = UIScreenWidth - margin * 2;
    CGFloat viewH = 64.0f;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, viewW, viewH)];
    view.backgroundColor = [UIColor whiteColor];
    NSArray *titleArray = @[@"水卡列表", @"充值记录", @"充值", @"打水记录"];
    NSArray *imageArray = @[@"calc", @"ic_pie", @"ic_recharge", @"loss"];
    
    CGFloat itemsW = viewW * 0.25;
    CGFloat itemsH = viewH - margin;
    for (int i = 0; i < titleArray.count; i++) {
        //行
        int row = i % 4;
        //列
        int column = i / 4;
        
        CGFloat itemsY = column * itemsH + margin * 0.5;
        CGFloat itemsX = row * itemsW;
        
        NSString *imageName = imageArray[i];
        NSString *titleName = titleArray[i];
        
        UIView *item = [self itemViewWithImageName:imageName WithTitleName:titleName WithFrame:CGRectMake(itemsX, itemsY, itemsW, itemsH) WithMaskViewTag:100+i];
        
        [view addSubview:item];
    }
    
    return view;
}

- (UIView *)itemViewWithImageName:(NSString *)imageName WithTitleName:(NSString *)titleName WithFrame:(CGRect)Frame WithMaskViewTag:(NSInteger)tag
{
    UIView *view = [[UIView alloc] initWithFrame:Frame];
    
    CGFloat iconX = 0;
    CGFloat iconH = Frame.size.height * 0.6;
    CGFloat iconW = Frame.size.width;
    CGFloat iconY = 0;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
    imageView.image = IMAGE(imageName);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];

    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetMaxY(imageView.frame);
    CGFloat titleW = Frame.size.width;
    CGFloat titleH = Frame.size.height - iconH;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
    titleLabel.text = titleName;
    titleLabel.textColor = [UIColor dx_333333Color];
    titleLabel.font = DFont(12);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLabel];
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Frame.size.width, Frame.size.height)];
    maskView.backgroundColor = [UIColor clearColor];
    maskView.userInteractionEnabled = YES;
    maskView.tag = tag;
    [view addSubview:maskView];
    
    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTapAction:)];
    [maskView addGestureRecognizer:TapGesture];
    
    return view;
}

- (void)maskViewTapAction:(UIGestureRecognizer *)gesture
{
    UIView *maskView = gesture.view;
    NSLog(@"%ld", maskView.tag);
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
