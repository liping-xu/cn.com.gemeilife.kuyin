//
//  KY_Account_AboutUsVC.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/11.
//

#import "KY_Account_AboutUsVC.h"
#import "KY_Account_Model.h"
#import "KY_Account_Cell.h"
#import <WebKit/WebKit.h>
#import "PAWebView.h"


@interface KY_Account_AboutUsVC ()

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation KY_Account_AboutUsVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hiddenTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于我们";
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
    NSArray *titleArray1 = @[@"当前版本", @"用户协议", @"隐私政策"];
    NSArray *valueArray = @[@"1.1.3", @"", @""];
    self.dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray1.count; i++) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setValue:titleArray1[i] forKey:@"title"];
        [data setValue:valueArray[i] forKey:@"value"];
        KY_Account_AboutUs_Model *model = [KY_Account_AboutUs_Model KY_Account_ModelWithDictionary:data];
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
    return 64.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KY_Account_AboutUs_Cell *cell = [KY_Account_AboutUs_Cell KY_Account_AboutUs_CellWithTableView:tableView withIdentifier:@"KY_Account_AboutUs_Cell"];
    KY_Account_AboutUs_Model *model = self.dataArray[indexPath.row];
    if (model) {
        cell.model = model;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KY_Account_AboutUs_Cell *cell = (KY_Account_AboutUs_Cell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.model.title isEqualToString:@"用户协议"]) {
        PAWebView *webView = [PAWebView shareInstance];
        //加载网页
        NSString *url = @"https://oss.hfljyx.com/water/user_agree.html";
        [webView loadRequestURL:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0f]];//    [webView loadLocalHTMLWithFileName:url];
        webView.title = @"用户协议";
        [self.navigationController pushViewController:webView animated:YES];
    }
    
    if ([cell.model.title isEqualToString:@"隐私政策"]) {
        PAWebView *webView = [PAWebView shareInstance];
        //加载网页
        NSString *url = @"https://oss.hfljyx.com/water/private.html";
        [webView loadRequestURL:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0f]];
        webView.title = @"隐私政策";
        [self.navigationController pushViewController:webView animated:YES];
    }
    
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
