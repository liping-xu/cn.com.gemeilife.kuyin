//
//  KY_DeviceManageVC.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/4.
//

#import "KY_DeviceManageVC.h"
#import "KY_HomePage_Model.h"
#import "KY_HomePage_Cell.h"
#import "KY_DeviceDetailVC.h"
#import "KYRequest.h"

@interface KY_DeviceManageVC () <UITextFieldDelegate>

//@property (nonatomic, strong) UIView *tableHeadView;
@property (nonatomic,strong) NSMutableArray *deviceDataArray;
@property (nonatomic,strong) UIView *navigationSearchBarView;
@property (nonatomic,strong) UIView *tableTitleView;
@property (nonatomic,weak) UILabel *numberLabel;

@end

@implementation KY_DeviceManageVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hiddenTabBar];
    [self showDeviceListNaviagationSearchBarView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeDeviceListNavigationSearchView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureUI];
//    [self createdDataArray];
    [self RequestNetData];
    
}
- (void)showDeviceListNaviagationSearchBarView
{
    [self.navigationController.navigationBar addSubview:self.navigationSearchBarView];
}

- (void)removeDeviceListNavigationSearchView
{
    [self.navigationSearchBarView removeFromSuperview];
    
}


- (UIView *)configureNavigationSearchUI
{
    CGFloat margin = 10.0f;
    CGFloat viewH = 44.0f;
    CGFloat viewW = UIScreenWidth - CGRectGetMaxX(self.leftBtn.frame) - margin;
    CGFloat viewX = CGRectGetMaxX(self.leftBtn.frame);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewX, margin * 0.5, viewW, viewH)];
    //输入框
    CGFloat TextFieldX = 0;
    CGFloat TextFieldY = 0;
    CGFloat TextFieldW = viewW - margin;
    CGFloat TextFieldH = 34.0f;
    UITextField *TextField = [[UITextField alloc] initWithFrame:CGRectMake(TextFieldX, TextFieldY, TextFieldW, TextFieldH)];
    TextField.layer.borderWidth = 0.5f;
    TextField.layer.borderColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3f] CGColor];
    TextField.layer.cornerRadius = TextFieldH * 0.5;
    TextField.layer.masksToBounds = YES;
    TextField.delegate = self;
    TextField.textColor = [UIColor dx_333333Color];
    TextField.placeholder = @"支持设备号、别名、地址搜索";
    [TextField setValue:[UIColor dx_666666Color] forKeyPath:@"placeholderLabel.textColor"];
    [TextField setValue:DFont(14) forKeyPath:@"placeholderLabel.font"];
    TextField.backgroundColor = [UIColor whiteColor];
    TextField.keyboardType = UIKeyboardTypeWebSearch;
    
    CGFloat leftViewW = 30.0f;
    CGFloat leftViewH = 20.0f;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, leftViewW, leftViewH)];
    leftView.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, leftViewW, leftViewH)];
    
    imageView.image = IMAGE(@"search");
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [leftView addSubview:imageView];
    
    TextField.leftView = leftView;
    TextField.leftViewMode = UITextFieldViewModeAlways;
//    TextField.returnKeyType = UIReturnKeyDone;
    
    
    CGFloat rightViewW = 30.0f;
    CGFloat rightViewH = 20.0f;
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, rightViewW, rightViewH)];
    rightView.backgroundColor = [UIColor clearColor];
    rightView.userInteractionEnabled = YES;
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    rightButton.frame = CGRectMake(0, 0, 20, 20); // 设置按钮大小
//    [rightButton setImage:IMAGE(@"scan") forState:UIControlStateNormal];
//    rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    rightButton.userInteractionEnabled = YES;
//    [rightButton addTarget:self action:@selector(clearButtonClicked:) forControlEvents:UIControlEventTouchUpInside]; // 添加点击事件
//    [rightView addSubview:rightButton];
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20.0f, 20.0f)];
    rightImageView.image = IMAGE(@"scan");
    rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScanImageView:)];
    [rightImageView addGestureRecognizer:TapGesture];
    rightImageView.userInteractionEnabled = YES;
    
    [rightView addSubview:rightImageView];
    TextField.rightView = rightView;
    TextField.rightViewMode = UITextFieldViewModeAlways;
    [view addSubview:TextField];
    
    return view;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *keyword = [NSString stringWithFormat:@"%@", textField.text];
    WeakSelf(self)
    self.deviceDataArray = [[NSMutableArray alloc] init];
    [KYRequest KYHomePage_deviceListSearchWithGetWithKeyword:keyword WithRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        NSArray *listArray = [NSArray arrayWithArray:resultDic[@"list"]];
        for (int i = 0; i < listArray.count; i++) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:listArray[i]];
            KY_DeviceList_Model *model = [KY_DeviceList_Model KY_DeviceList_ModelWithDictionary:data];
            [weakself.deviceDataArray addObject:model];
        }
        self.numberLabel.text = [NSString stringWithFormat:@"%@台",resultDic[@"total"]];
        [weakself.tableView reloadData];
        
        
    }];
    
    return YES;
}


- (void)tapScanImageView:(UIGestureRecognizer *)gesture
{
    NSLog(@"click");
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
//    self.tableView.tableHeaderView = self.tableHeadView;
}

//创建列表数组
- (void)createdDataArray
{
    NSArray *titleArray = @[@"18607", @"18600", @"1000"];
    NSArray *deviceName = @[@"测试设别", @"我的设备", @"我的设备"];
    NSArray *dateArray = @[@"2026-08-02(剩余363天)", @"2026-06-23(剩余323天)", @"2026-06-06(剩余306天)"];
    NSArray *locationArray = @[@"", @"佩恩电器", @"合肥市佩恩电器1"];
    self.deviceDataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray.count ; i++) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setValue:titleArray[i] forKey:@"title"];
        [data setValue:deviceName[i] forKey:@"deviceName"];
        [data setValue:dateArray[i] forKey:@"date"];
        [data setValue:locationArray[i] forKey:@"location"];
        KY_DeviceList_Model *model = [KY_DeviceList_Model KY_DeviceList_ModelWithDictionary:data];
        [self.deviceDataArray addObject:model];
//        [data setValue:titleArray[i] forKey:@"title"];
//        [data setValue:self.heightArray[i] forKey:@"height"];
//        [data setValue:isSelectArray[i] forKey:@"isSelect"];
//        [data setValue:placeHolderArray[i] forKey:@"placeHolder"];
//        [data setValue:isIconAraay[i] forKey:@"isIcon"];
//        KY_CreateNewCard_Model *model = [KY_CreateNewCard_Model kd_CreateNewCardWithDictionary:data];
//        [self.createNewCardModelArray addObject:model];
    }
    [self.tableView reloadData];
}

//创建NetWorkData
- (void)RequestNetData
{
    WeakSelf(self);
    self.deviceDataArray = [[NSMutableArray alloc] init];
    [KYRequest KYHomePage_DeviceManageWithGetWithRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        NSLog(@"%@", resultDic);
        
        StrongSelf(self);
        NSArray *listArray = [NSArray arrayWithArray:resultDic[@"list"]];
        for (int i = 0; i < listArray.count; i++) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:listArray[i]];
            KY_DeviceList_Model *model = [KY_DeviceList_Model KY_DeviceList_ModelWithDictionary:data];
            [weakself.deviceDataArray addObject:model];
        }
        self.numberLabel.text = [NSString stringWithFormat:@"%@台",resultDic[@"total"]];
        [weakself.tableView reloadData];

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
    return self.deviceDataArray.count;
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
    KY_DeviceList_Model *model = self.deviceDataArray[indexPath.row];
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KY_HomePage_DeviceManage_Cell *cell = [KY_HomePage_DeviceManage_Cell KY_HomePage_DeviceManage_CellWithTableView:self.tableView withIdentifier:@"ky_createCard_cell"];
    
    KY_DeviceList_Model *model = self.deviceDataArray[indexPath.row];
    if (model) {
        cell.model = model;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KY_DeviceList_Model *model = self.deviceDataArray[indexPath.row];
    KY_DeviceDetailVC *vc = [[KY_DeviceDetailVC alloc] init];
    vc.ID = [NSString stringWithFormat:@"%@", model.Title];
    [self.navigationController pushViewController:vc animated:YES];
}

//去掉系统自带的红点
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}


//-(UIView *)tableHeadView
//{
//    if (!_tableHeadView) {
//
//    }
//    return _tableHeadView;
//}

- (UIView *)configtitleView
{
    CGFloat margin = 10.0f;
    CGFloat headX = 0;
    CGFloat headY = 0;
    CGFloat headW = UIScreenWidth;
    CGFloat headH = 44.0f;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(headX, headY, headW, headH)];
    view.backgroundColor = [UIColor colorWithHex:0xF3F3F3];

    
    UILabel *deviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, margin, 100, 34.0f)];
    deviceLabel.backgroundColor = [UIColor clearColor];
    deviceLabel.text = @"设备列表";
    deviceLabel.textAlignment = NSTextAlignmentLeft;
    deviceLabel.textColor = [UIColor dx_666666Color];
    deviceLabel.font = DFont(16);
    [view addSubview:deviceLabel];
    
    CGFloat numW = 100.0f;
    CGFloat numX = UIScreenWidth - margin - numW;
    CGFloat numH = 34.0f;
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(numX, margin, numW, numH)];
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.text = @"9台";
    numLabel.textAlignment = NSTextAlignmentRight;
    numLabel.textColor = [UIColor colorWithRed:170.0f / 255.0f green:128.0f / 255.0f blue:70.0f / 255.0f alpha:1];
    numLabel.font = DFont(16);
    [view addSubview:numLabel];
    self.numberLabel = numLabel;
    
    return view;
}

- (UIView *)tableTitleView
{
    if (!_tableTitleView) {
        _tableTitleView = [self configtitleView];
    }
    return _tableTitleView;
}

- (UIView *)navigationSearchBarView
{
    if (!_navigationSearchBarView) {
        
        _navigationSearchBarView = [self configureNavigationSearchUI];
    }
    return _navigationSearchBarView;
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
