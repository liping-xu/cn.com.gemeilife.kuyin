//
//  KY_UserManageVC.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/20.
//

#import "KY_UserManageVC.h"
#import "KYRequest.h"
#import "KY_HomePage_Cell.h"
#import "KY_HomePage_Model.h"
#import "KY_UserDetailVC.h"

@interface KY_UserManageVC () <UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray *userDataArray;
@property (nonatomic,strong) UIView *navigationSearchBarView;
@property (nonatomic,strong) UIView *tableTitleView;
@property (nonatomic,weak) UILabel *numberLabel;
@property (nonatomic,assign) int page;

@end

@implementation KY_UserManageVC

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
    self.page = 1;
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
    TextField.placeholder = @"支持手机号、姓名搜索";
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
    
    [view addSubview:TextField];
    return view;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *keyword = [NSString stringWithFormat:@"%@", textField.text];
    WeakSelf(self);
    self.userDataArray = [[NSMutableArray alloc] init];
    [KYRequest KYHomePage_UserListSearchWithGetWithKeyword:keyword WithRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        NSArray *listArray = [NSArray arrayWithArray:resultDic[@"list"]];
        for (int i = 0; i < listArray.count; i++) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:listArray[i]];
            KY_UserList_Model *model = [KY_UserList_Model KY_UserList_ModelWithDictionary:data];
            [weakself.userDataArray addObject:model];
        }
        self.numberLabel.text = [NSString stringWithFormat:@"%@人",resultDic[@"total"]];
        [weakself.tableView reloadData];
        
    }];
    
    return YES;
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

//创建NetWorkData
- (void)RequestNetData
{
    WeakSelf(self);
    self.userDataArray = [[NSMutableArray alloc] init];
    [KYRequest KYHomePage_UserManageWithGetWithPage:self.page WithRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        NSArray *listArray = [NSArray arrayWithArray:resultDic[@"list"]];
        for (int i = 0; i < listArray.count; i++) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:listArray[i]];
            KY_UserList_Model *model = [KY_UserList_Model KY_UserList_ModelWithDictionary:data];
            [weakself.userDataArray addObject:model];
        }
        self.numberLabel.text = [NSString stringWithFormat:@"%@人",resultDic[@"total"]];
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
    return self.userDataArray.count;
//    return 3;
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
    
    return 94;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KY_HomePage_UserManage_Cell *cell = [KY_HomePage_UserManage_Cell KY_HomePage_UserManage_CellWithTableView:tableView withIdentifier:@"KY_HomePage_UserManage_Cell"];
    
    KY_UserList_Model *model = self.userDataArray[indexPath.row];
    if (model) {
        cell.model = model;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KY_UserList_Model *model = self.userDataArray[indexPath.row];

    KY_UserDetailVC *vc = [[KY_UserDetailVC alloc] init];
    vc.ID = model.ID;
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
    deviceLabel.text = @"用户数量";
    deviceLabel.textAlignment = NSTextAlignmentLeft;
    deviceLabel.textColor = [UIColor dx_666666Color];
    deviceLabel.font = DFont(16);
    [view addSubview:deviceLabel];
    
    CGFloat numW = 100.0f;
    CGFloat numX = UIScreenWidth - margin - numW;
    CGFloat numH = 34.0f;
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(numX, margin, numW, numH)];
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.text = @"199人";
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



- (void)topMoreData
{
    self.page = self.page + 1;
    WeakSelf(self);
    [KYRequest KYHomePage_UserManageWithGetWithPage:self.page WithRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        NSArray *listArray = [NSArray arrayWithArray:resultDic[@"list"]];
        for (int i = 0; i < listArray.count; i++) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:listArray[i]];
            KY_UserList_Model *model = [KY_UserList_Model KY_UserList_ModelWithDictionary:data];
            [weakself.userDataArray addObject:model];
        }
        [weakself.tableView reloadData];
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
