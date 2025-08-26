//
//  KY_IncomeVC.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/16.
//

#import "KY_IncomeVC.h"
#import "KYRequest.h"
#import "KY_HomePage_Cell.h"
#import "KY_HomePage_Model.h"
#import "KY_FiliterView.h"



@interface KY_IncomeVC ()

@property (nonatomic,strong) UIView *tableTitleView;
// 金额Label
@property (nonatomic,weak) UILabel *numberLabel;

@property (nonatomic,strong) NSMutableArray *dataSourceArray;

@property (nonatomic,assign) int page;

@end

@implementation KY_IncomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"打水记录(18614)";
    self.page = 1;
    self.title = [NSString stringWithFormat:@"收入记录(%@)", self.deviceNumber];
    [self configureUI];
    [self requestNetWork];

}

- (void)configureUI
{
    [self rightButtonTitle:@"筛选" rightButtonBackGroundImage:IMAGE(@"")];
    CGFloat tableViewY = 0;
    CGFloat tableViewH = UIScreenHeight - tableViewY;
    [self allocWithFrame:CGRectMake(0, tableViewY, UIScreenWidth, tableViewH) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xF3F3F3];
//    self.tableView.tableHeaderView = self.tableHeadView;
}
- (void)requestNetWork
{
    WeakSelf(self);
    [KYRequest KYDeviceDetailWaterIncomeWithGetWithID:self.deviceNumber WithPage:self.page WithRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        if (isSuccess) {
            weakself.dataSourceArray = [[NSMutableArray alloc] init];
            NSArray *array = [NSArray arrayWithArray:resultDic[@"list"]];
            if (array.count > 0) {
                
                for (int i = 0; i < array.count; i++) {
                    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:array[i]];
                    KY_Income_Model *model = [KY_Income_Model KY_Income_ModelWithDictionary:dict];
                    [weakself.dataSourceArray addObject:model];
                }
                [weakself.tableView reloadData];
                
            }
        }
        
    }];
    
}

- (void)superRightButtonAction
{
    KY_FiliterView *customView = [[KY_FiliterView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.8, [UIScreen mainScreen].bounds.size.height)];
    customView.type = 2;
    FWPopupBaseViewProperty *property = [FWPopupBaseViewProperty manager];
    property.popupAlignment = FWPopupAlignmentRightCenter;
    property.popupAnimationStyle = FWPopupAnimationStylePosition;
    property.maskViewColor = [UIColor colorWithWhite:0 alpha:0.5];
    property.touchWildToHide = @"1";
    property.popupEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    property.animationDuration = 0.3;
    customView.vProperty = property;
    [customView show];
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
    return self.dataSourceArray.count;
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
    return self.tableTitleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 104.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KY_HomePage_DeviceDetail_Income_Cell *cell = [KY_HomePage_DeviceDetail_Income_Cell KY_HomePage_DeviceDetail_Income_CellWithTableView:tableView withIdentifier:@"KY_HomePage_DeviceDetail_Income_Cell"];
    
    KY_Income_Model *model = self.dataSourceArray[indexPath.row];
    if (model) {
        cell.model = model;
    }
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


- (UIView *)tableTitleView
{
    if (!_tableTitleView) {
        _tableTitleView = [self configtitleView];
    }
    return _tableTitleView;
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
    
    CGFloat numW = 200.0f;
    CGFloat numX = margin;
    CGFloat numH = 34.0f;
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(numX, margin, numW, numH)];
    numLabel.backgroundColor = [UIColor clearColor];
    [numLabel setTexts:@[@"金额: ", @"0.00元"] colors:@[[UIColor dx_666666Color], [UIColor colorWithRed:170.0f / 255.0f green:128.0f / 255.0f blue:70.0f / 255.0f alpha:1]] fonts:@[DFont(16), DFont(16)] warp:NO spacing:5.0f];
    numLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:numLabel];
    self.numberLabel = numLabel;
    
    return view;
}

- (void)topMoreData
{
    self.page = self.page + 1;
    WeakSelf(self);
    [KYRequest KYDeviceDetailWaterIncomeWithGetWithID:self.deviceNumber WithPage:self.page WithRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        if (isSuccess) {
            NSArray *array = [NSArray arrayWithArray:resultDic[@"list"]];
            if (array.count > 0) {
                for (int i = 0; i < array.count; i++) {
                    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:array[i]];
                    KY_Income_Model *model = [KY_Income_Model KY_Income_ModelWithDictionary:dict];
                    [weakself.dataSourceArray addObject:model];
                }
                [weakself.tableView reloadData];
            } else {
                [weakself showPopView:@"没有更多数据了"];
            }
        }
        
    }];
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
