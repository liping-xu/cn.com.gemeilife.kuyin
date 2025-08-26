//
//  KY_DeviceDetailStatusVC.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/15.
//

#import "KY_DeviceDetailStatusVC.h"
#import "KYRequest.h"
#import "KY_HomePage_Cell.h"
#import "KY_HomePage_Model.h"

@interface KY_DeviceDetailStatusVC ()

//分区 titleLabel
@property (nonatomic,weak) UILabel *sectionLabel;

//数据表格式数组
@property (nonatomic,strong) NSMutableArray *dataArray;
//分区数组
@property (nonatomic,strong) NSArray *sectionDataArray;

@end

@implementation KY_DeviceDetailStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设备最新状态";
    [self configureUI];
//    [self createdDataArray];
    [self requestNetWorkData];
}

- (void)requestNetWorkData
{
    WeakSelf(self);
    [KYRequest KYDeviceDetailStatusWithGetWithID:self.deviceNumber withRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        NSLog(@"%@", resultDic);
        if (isSuccess) {
//            NSArray *valueArray1 = @[@"18635", @"98", @"93", @"0°C", @"缺水", @"非制水", @"正常", @"不满", @"无", @"2025-08-15 14:28:56"];
            //设备编号
            NSString *deviceNumber = weakself.deviceNumber;
            //原水TDS
            NSString *waterTDS0 = [NSString stringWithFormat:@"%d", [resultDic[@"tds0"] intValue]];
            //净水TDS
            NSString *waterTDS1 = [NSString stringWithFormat:@"%d", [resultDic[@"tds1"] intValue]];
            //温度
            NSString *temperature = [NSString stringWithFormat:@"%d°C",[resultDic[@"temperature"] intValue]];
            
            int status = [resultDic[@"status"] intValue];
            
            //低压缺水状态
            NSString *lowS = @"";
            ((status >> 11) % 2) == 1 ? (lowS = @"缺水"):(lowS = @"正常");
            //制水状态
            NSString *zwater = @"";
            ((status >> 12) % 2) == 1 ? (zwater = @"制水中"):(zwater = @"非制水");
            //水压低液位缺水状态
            NSString *zlwater = @"";
            ((status >> 13) % 2) == 1 ? (zlwater = @"缺水"):(zlwater = @"正常");
            //水满状态
            NSString *waterS = @"";
            ((status >> 14) % 2) == 1 ? (waterS = @"已满"):(waterS = @"不满");
            //连续制水故障
            NSString *swaterS = @"";
            ((status >> 15) % 2) == 1 ? (swaterS = @"故障"):(swaterS = @"无");
            
            //上报时间
            NSString *time = [NSString stringWithFormat:@"%@",resultDic[@"time"]];

            NSArray *titleArray1 = @[@"设备编号", @"原水TDS", @"净水TDS", @"温度", @"低压缺水状态", @"制水状态", @"水压低液位缺水状态", @"水满状态", @"连续制水故障", @"上报时间"];
            NSArray *valueArray1 = @[deviceNumber, waterTDS0, waterTDS1, temperature, lowS, zwater, zlwater, waterS, swaterS, time];

            NSMutableArray *dataArray1 = [[NSMutableArray alloc] init];
            for (int i = 0; i < titleArray1.count; i++) {
                NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
                [data setValue:titleArray1[i] forKey:@"title"];
                [data setValue:valueArray1[i] forKey:@"value"];
                KY_DeviceDetailStatus_Model *model = [KY_DeviceDetailStatus_Model KY_DeviceDetailStatus_ModelWithDictionary:data];
                [dataArray1 addObject:model];
            }
            
            
            NSString *filter = [NSString stringWithFormat:@"%@", resultDic[@"filter"]];

            filter = [filter stringByReplacingOccurrencesOfString:@"[" withString:@""];
            filter = [filter stringByReplacingOccurrencesOfString:@"]" withString:@""];
            NSArray *filterArray = [filter componentsSeparatedByString:@","];
            
//            NSArray *titleArray2 = @[@"1级", @"2级", @"3级", @"4级", @"5级", @"6级"];
//            NSArray *valueArray2 = @[@"0.00%", @"0.00%", @"0.00%", @"0.00%", @"0.00%", @"0.00%"];
            
            NSMutableArray *dataArray2 = [[NSMutableArray alloc] init];
            for (int i = 0; i < filterArray.count; i++) {
                NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
                NSString *title = [NSString stringWithFormat:@"%d级", i + 1];
                [data setValue:title forKey:@"title"];
                [data setValue:filterArray[i] forKey:@"value"];
//                [data setValue:titleArray2[i] forKey:@"title"];
//                [data setValue:valueArray2[i] forKey:@"value"];
                KY_DeviceDetailStatus_Model *model = [KY_DeviceDetailStatus_Model KY_DeviceDetailStatus_ModelWithDictionary:data];
                [dataArray2 addObject:model];
            }
            
            self.dataArray = @[dataArray1, dataArray2].mutableCopy;
            self.sectionDataArray = @[@"设备状态", @"滤芯状态"];
            [self.tableView reloadData];
            
            
        } else {
            [self showPopView:message];
        }
    }];
}


- (void)configureUI
{
    [self rightButtonTitle:@"刷新" rightButtonBackGroundImage:IMAGE(@"")];
    CGFloat tableViewY = 0;
    CGFloat tableViewH = UIScreenHeight - tableViewY;
    [self allocWithFrame:CGRectMake(0, tableViewY, UIScreenWidth, tableViewH) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xF3F3F3];
//    self.tableView.tableHeaderView = self.tableHeadView;
}


- (void)superRightButtonAction
{
    [self requestNetWorkData];
}

//创建列表数组
- (void)createdDataArray
{
    NSArray *titleArray1 = @[@"设备编号", @"原水TDS", @"净水TDS", @"温度", @"低压缺水状态", @"制水状态", @"水压低液位缺水状态", @"水满状态", @"连续制水故障", @"上报时间"];
    NSArray *valueArray1 = @[@"18635", @"98", @"93", @"0°C", @"缺水", @"非制水", @"正常", @"不满", @"无", @"2025-08-15 14:28:56"];
    
    NSArray *titleArray2 = @[@"1级", @"2级", @"3级", @"4级", @"5级", @"6级"];
    NSArray *valueArray2 = @[@"0.00%", @"0.00%", @"0.00%", @"0.00%", @"0.00%", @"0.00%"];
    
    NSMutableArray *dataArray1 = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray1.count; i++) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setValue:titleArray1[i] forKey:@"title"];
        [data setValue:valueArray1[i] forKey:@"value"];
        KY_DeviceDetailStatus_Model *model = [KY_DeviceDetailStatus_Model KY_DeviceDetailStatus_ModelWithDictionary:data];
        [dataArray1 addObject:model];
    }
    
    NSMutableArray *dataArray2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray2.count; i++) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setValue:titleArray2[i] forKey:@"title"];
        [data setValue:valueArray2[i] forKey:@"value"];
        KY_DeviceDetailStatus_Model *model = [KY_DeviceDetailStatus_Model KY_DeviceDetailStatus_ModelWithDictionary:data];
        [dataArray2 addObject:model];
    }
    
    self.dataArray = @[dataArray1, dataArray2].mutableCopy;
    self.sectionDataArray = @[@"设备状态", @"滤芯状态"];
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
//    KY_HomePage_WaterRecord_Cell *cell = [KY_HomePage_WaterRecord_Cell KY_HomePage_WaterRecord_CellWithTableView:tableView withIdentifier:@"KY_HomePage_WaterRecord_Cell"];
    
    if (indexPath.section == 0) {
        KY_HomePage_DeviceDetailStatus_Cell *cell = [KY_HomePage_DeviceDetailStatus_Cell KY_HomePage_DeviceDetailStatus_CellWithTableView:tableView withIdentifier:@"KY_HomePage_DeviceDetailStatus_Cell"];
        
        KY_DeviceDetailStatus_Model *model = self.dataArray[indexPath.section][indexPath.row];
        if (model) {
            cell.model = model;
        }
        return cell;
    } else {
        KY_HomePage_DeviceDetailFilterStatus_Cell *cell = [KY_HomePage_DeviceDetailFilterStatus_Cell KY_HomePage_DeviceDetailFilterStatus_CellWithTableView:tableView withIdentifier:@"KY_HomePage_DeviceDetailFilterStatus_Cell"];
        KY_DeviceDetailStatus_Model *model = self.dataArray[indexPath.section][indexPath.row];
        if (model) {
            cell.model = model;
        }
        return cell;
    }
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


- (UIView *)configtitleView
{
    CGFloat margin = 10.0f;
    CGFloat headX = 0;
    CGFloat headY = 0;
    CGFloat headW = UIScreenWidth;
    CGFloat headH = 44.0f;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(headX, headY, headW, headH)];
    view.backgroundColor = [UIColor colorWithHex:0xF3F3F3];

    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, margin, 100, 34.0f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor dx_666666Color];
    titleLabel.font = DFont(16);
//    [titleLabel setTexts:@[@"出水量: ", @"0升"] colors:@[[UIColor dx_666666Color], [UIColor colorWithRed:170.0f / 255.0f green:128.0f / 255.0f blue:70.0f / 255.0f alpha:1]] fonts:@[DFont(16), DFont(16)] warp:NO spacing:50.0f];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:titleLabel];
    self.sectionLabel = titleLabel;
    
    return view;
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
