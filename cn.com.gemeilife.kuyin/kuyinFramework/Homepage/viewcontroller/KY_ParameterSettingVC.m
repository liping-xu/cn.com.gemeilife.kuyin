//
//  KY_ParameterSettingVC.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/16.
//

#import "KY_ParameterSettingVC.h"
#import "KY_HomePage_Model.h"
#import "KY_HomePage_Cell.h"
#import "KYRequest.h"
#import <FWPopupView/FWPopupView-Swift.h>
#import "WXZPickTimeView.h"



@interface KY_ParameterSettingVC () <PickTimeViewDelegate>

//分区 titleLabel
@property (nonatomic,weak) UILabel *sectionLabel;

//数据表格式数组
@property (nonatomic,strong) NSMutableArray *dataArray;
//分区数组
@property (nonatomic,strong) NSArray *sectionDataArray;

@property (nonatomic,weak) KY_HomePage_DeviceDetail_ParamenterSetting_Cell *selectCell;

@end

@implementation KY_ParameterSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"设备参数(%@)", self.deviceNumber];
    [self configureUI];
    [self createdDataArray];
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
    NSArray *titleArray1 = @[@"售水单价", @"每升水所需时间", @"刷卡预扣金额"];
    NSArray *valueArray1 = @[@"0.27", @"7.0", @"2.00"];
    NSArray *unitArray1 = @[@"元/升", @"秒", @"元"];
    NSArray *placeholderArray1 = @[@"单位是元", @"单位是秒", @"单位是元"];
    
    NSArray *titleArray2 = @[@"臭氧杀菌时间", @"臭氧杀菌间隔", @"按键后出液体超时等待时间", @"取水结束等延迟关闭秒数", @"温控开启和关闭温度"];
    NSArray *valueArray2 = @[@"10", @"120", @"60", @"60", @""];
    NSArray *unitArray2 = @[@"秒", @"分钟", @"秒", @"秒", @"°C"];
    NSArray *placeholderArray2 = @[@"单位是秒,0表示", @"单位是分钟", @"单位是秒", @"单位是秒", @"格式:6-19"];

    NSArray *titleArray3 = @[@"广告灯开启时间", @"广告灯关闭时间"];
    NSArray *valueArray3 = @[@"请选择", @"请选择"];
    NSArray *unitArray3 = @[@"", @"", @""];
    NSArray *placeholderArray3 = @[@"", @""];
    
    NSMutableArray *dataArray1 = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray1.count; i++) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setValue:titleArray1[i] forKey:@"title"];
        [data setValue:valueArray1[i] forKey:@"value"];
        [data setValue:unitArray1[i] forKey:@"unit"];
        [data setValue:placeholderArray1[i] forKey:@"placeholder"];
        KY_DeviceDetail_parameterSetting_Model *model = [KY_DeviceDetail_parameterSetting_Model KY_DeviceDetail_parameterSetting_ModelWithDictionary:data];
        [dataArray1 addObject:model];
    }
    
    NSMutableArray *dataArray2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray2.count; i++) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setValue:titleArray2[i] forKey:@"title"];
        [data setValue:valueArray2[i] forKey:@"value"];
        [data setValue:unitArray2[i] forKey:@"unit"];
        [data setValue:placeholderArray2[i] forKey:@"placeholder"];

        KY_DeviceDetail_parameterSetting_Model *model = [KY_DeviceDetail_parameterSetting_Model KY_DeviceDetail_parameterSetting_ModelWithDictionary:data];
        [dataArray2 addObject:model];
    }
    
    NSMutableArray *dataArray3 = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray3.count; i++) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setValue:titleArray3[i] forKey:@"title"];
        [data setValue:valueArray3[i] forKey:@"value"];
        [data setValue:unitArray3[i] forKey:@"unit"];
        [data setValue:placeholderArray3[i] forKey:@"placeholder"];
        KY_DeviceDetail_parameterSetting_Model *model = [KY_DeviceDetail_parameterSetting_Model KY_DeviceDetail_parameterSetting_ModelWithDictionary:data];
        [dataArray3 addObject:model];
    }
    
    self.dataArray = @[dataArray1, dataArray2, dataArray3].mutableCopy;
    self.sectionDataArray = @[@"1号出水口价格设置", @"制水参数", @"灯箱控制"];
    [self.tableView reloadData];
}




#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.sectionDataArray.count;
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
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerIdentifier = @"HeaderSectionIdentifier";
    UIView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
        if (!headerView) {
            headerView = [self configtitleView];
        }
    self.sectionLabel.text = self.sectionDataArray[section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KY_HomePage_DeviceDetail_ParamenterSetting_Cell *cell = [KY_HomePage_DeviceDetail_ParamenterSetting_Cell KY_HomePage_DeviceDetail_ParamenterSetting_CellWithTableView:tableView withIdentifier:@"KY_HomePage_DeviceDetail_ParamenterSetting_Cell"];
    
    KY_DeviceDetail_parameterSetting_Model *model = self.dataArray[indexPath.section][indexPath.row];
    if (model) {
        cell.model = model;
    }
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KY_HomePage_DeviceDetail_ParamenterSetting_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectCell = cell;
    //显示输入框 pick
    if (indexPath.section != 2) {
        
        id block = ^(FWPopupView *popupView, NSInteger index, NSString *title){
            NSLog(@"AlertView：点击了第 %ld 个按钮", (long)index);
        };
        NSArray *items = @[[[FWPopupItem alloc] initWithTitle:@"取消" itemType:FWItemTypeNormal isCancel:YES canAutoHide:YES itemClickedBlock:block],
                           [[FWPopupItem alloc] initWithTitle:@"确定" itemType:FWItemTypeNormal isCancel:NO canAutoHide:YES itemClickedBlock:block]];
        
        NSString *str = [NSString stringWithFormat:@"%@", cell.model.title];
        NSString *placeholder = [NSString stringWithFormat:@"%@", cell.model.placeholder];
        FWAlertView *alertView = [FWAlertView alertWithTitle:str detail:nil inputPlaceholder:placeholder keyboardType:UIKeyboardTypeDefault isSecureTextEntry:NO customView:nil items:items];
        [alertView show];
        
        WeakSelf(self);
        alertView.inputBlock = ^(NSString * _Nonnull text) {
            if (text.length != 0) {
                
            }
        };
        
        
    } else {
        //显示datePick
        
        WXZPickTimeView *pickerArea = [[WXZPickTimeView alloc]init];
        [pickerArea setDelegate:self];
        [pickerArea setDefaultHour:14 defaultMinute:20];
        [pickerArea show];
    }
    
}
-(void)pickerTimeView:(WXZPickTimeView *)pickerTimeView selectHour:(NSInteger)hour selectMinute:(NSInteger)minute
{    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"H:m"];
    NSString *str =[NSString stringWithFormat:@"%ld:%ld",hour,minute];
    NSDate *date =[dateFormat dateFromString:str];
    
    NSDateFormatter *TimeFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [TimeFormat setDateFormat:@"HH:mm"];
    NSString *title = [TimeFormat stringFromDate:date];
    self.selectCell.DetailLabel.text = title;
}

//去掉系统自带的红点
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}


- (UIView *)configtitleView
{
    CGFloat margin = 10.0f;
    CGFloat headX = 0;
    CGFloat headY = 0;
    CGFloat headW = UIScreenWidth;
    CGFloat headH = 44.0f;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(headX, headY, headW, headH)];
    view.backgroundColor = [UIColor colorWithHex:0xF3F3F3];

    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, margin, UIScreenWidth - margin * 2, 34.0f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor dx_666666Color];
    titleLabel.font = DFont(16);
//    [titleLabel setTexts:@[@"出水量: ", @"0升"] colors:@[[UIColor dx_666666Color], [UIColor colorWithRed:170.0f / 255.0f green:128.0f / 255.0f blue:70.0f / 255.0f alpha:1]] fonts:@[DFont(16), DFont(16)] warp:NO spacing:50.0f];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:titleLabel];
    self.sectionLabel = titleLabel;
    
    return view;
}

- (UIView *)tableViewFooterView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 64.0f)];
    
    CGFloat margin = 10.0f;
    CGFloat buttonX = margin * 2;
    CGFloat buttonY = margin;
    CGFloat buttonW = UIScreenWidth - margin * 4;
    CGFloat buttonH = 44.0f;
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
    [button setTitle:@"确定修改" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    return view;
}

- (void)changeButtonAction:(UIButton *)sender
{
    
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
