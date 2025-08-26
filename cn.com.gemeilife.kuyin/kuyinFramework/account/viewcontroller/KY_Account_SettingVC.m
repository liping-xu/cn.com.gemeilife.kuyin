//
//  KY_Account_SettingVC.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/11.
//

#import "KY_Account_SettingVC.h"
#import "KY_Account_Model.h"
#import "KY_Account_Cell.h"
#import <FWPopupView/FWPopupView-Swift.h>
#import <WebKit/WebKit.h>



@interface KY_Account_SettingVC ()

@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation KY_Account_SettingVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hiddenTabBar];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";

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
}

//创建列表数组
- (void)createdDataArray
{
    NSArray *titleArray1 = @[@"注销账号"];
    self.dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray1.count; i++) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setValue:titleArray1[i] forKey:@"title"];
        KY_Account_Setting_Model *model = [KY_Account_Setting_Model KY_Account_ModelWithDictionary:data];
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
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
    return 0.01f;
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
    KY_Account_Setting_Cell *cell = [KY_Account_Setting_Cell KY_Account_Setting_CellWithTableView:tableView withIdentifier:@"KY_Account_Setting_Cell"];
    KY_Account_Setting_Model *model = self.dataArray[indexPath.row];
    if (model) {
        cell.model = model;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id block = ^(FWPopupView *popupView, NSInteger index, NSString *title){
//        NSLog(@"AlertView：点击了第 %ld 个按钮，%@", (long)index,title);
        if ([title isEqualToString:@"拨打客服电话"]) {
            
            NSURL *url = [NSURL URLWithString:@"tel://4006999090"];
        //    UIWebView *callPhoneWebVw = [[UIWebView alloc] init];
            WKWebView *callPhoneWebVw = [[WKWebView alloc] init];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [callPhoneWebVw loadRequest:request];
            
        }
                
    };
    
    NSArray *items = @[[[FWPopupItem alloc] initWithTitle:@"取消" itemType:FWItemTypeNormal isCancel:YES canAutoHide:YES itemClickedBlock:block],
                       [[FWPopupItem alloc] initWithTitle:@"拨打客服电话" itemType:FWItemTypeNormal isCancel:NO canAutoHide:YES itemClickedBlock:block]];
    
    FWAlertView *alertView = [FWAlertView alertWithTitle:@"注销账号" detail:@"为维护设备运营商和已充值会员权益，请您拨打服务热线400-699-9090联系我司，在信息确认后我们回在7个工作日内完成账号注销" inputPlaceholder:nil keyboardType:UIKeyboardTypeDefault isSecureTextEntry:NO customView:nil items:items];
    [alertView show];
}

//去掉系统自带的红点
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
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
