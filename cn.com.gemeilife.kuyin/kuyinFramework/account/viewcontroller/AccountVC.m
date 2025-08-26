//
//  AccountVC.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/7/23.
//

#import "AccountVC.h"
#import "KYRequest.h"

//可注销
#import "LoginVC.h"
#import "KYTabBarViewController.h"
#import "AppDelegate.h"
//end

#import "KY_Account_Cell.h"
#import "KY_Account_Model.h"
#import "KY_Account_SettingVC.h"
#import "KY_Account_ChangePassWordVC.h"
#import "KY_Account_AboutUsVC.h"
#import "KY_Account_OnlineRecordsVC.h"
#import <WebKit/WebKit.h>


@interface AccountVC ()

@property (nonatomic, strong) UIView *tableHeadView;
@property (nonatomic,strong) NSMutableArray *createModelArray;
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UILabel *newsLabel;

@end

@implementation AccountVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabBar];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureTableHeaderUI];
    [self createdDataArray];
    self.title = @"我的";
    
}

- (void)configureTableHeaderUI
{
    self.leftBtn.hidden = YES;
    [self rightButtonTitle:@"" rightButtonBackGroundImage:IMAGE(@"ic_setting")];
    CGFloat tableViewH = UIScreenHeight - [UIDevice vg_tabBarFullHeight];
    [self allocWithFrame:CGRectMake(0, 0, UIScreenWidth, tableViewH) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xF3F3F3];
    self.tableView.tableHeaderView = self.tableHeadView;
    [self.tableView reloadData];
}

- (UIView *)tableHeadView
{
    if (!_tableHeadView) {
        CGFloat margin = 10.0f;
        CGFloat headX = 0;
        CGFloat headY = 0;
        CGFloat headW = UIScreenWidth;
        CGFloat imageH = 150;
        CGFloat viewY = 90.0f;
        CGFloat viewH = 64.0f;
        CGFloat headH = viewY + viewH + margin * 3;
        _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(headX, headY, headW, headH)];
        _tableHeadView.backgroundColor = [UIColor clearColor];

        UIImage *image = [UIImage imageNamed:@"header_bg_long_bottom"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(headX, headY, headW, imageH)];
        imageView.image = image;
        [_tableHeadView addSubview:imageView];
        
        
        CGFloat IconimageW = 80.0f;
        CGFloat IconimageX = margin * 2;
        CGFloat IconimageY = viewY - IconimageW - margin;
        CGFloat IconimageH = IconimageW;
        UIImageView *IconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(IconimageX, IconimageY, IconimageW,IconimageH)];
        IconImageView.image = IMAGE(@"KY_Logo");
        IconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_tableHeadView addSubview:IconImageView];
        
        NSDictionary *dict = [KYRequest getAccountDict];
        NSDictionary *user = [NSDictionary dictionaryWithDictionary:dict[@"user"]];
        //title
        CGFloat newsLH = 24;
        CGFloat newsLX = CGRectGetMaxX(IconImageView.frame) + newsLH;
        CGFloat newsLY = CGRectGetMidY(IconImageView.frame) + margin;
        CGFloat newsLW = UIScreenWidth - CGRectGetWidth(IconImageView.frame) - margin * 2;
        UILabel *newsLabel = [[UILabel alloc] initWithFrame:CGRectMake(newsLX, newsLY, newsLW, newsLH)];
//        newsLabel.text = @"展厅｜18555512345";
//        [newsLabel setTexts:@[@"展厅｜", @"18555512345"] colors:@[[UIColor whiteColor],[UIColor whiteColor]] fonts:@[[UIFont boldSystemFontOfSize:16.0f], [UIFont systemFontOfSize:18.0f]] warp:NO spacing:0.0f];
        newsLabel.textColor = [UIColor whiteColor];
        newsLabel.textAlignment = NSTextAlignmentLeft;
        newsLabel.adjustsFontSizeToFitWidth = YES;
        newsLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [_tableHeadView addSubview:newsLabel];
        self.newsLabel = newsLabel;
        if (user.count != 0) {
            NSString *name = [NSString stringWithFormat:@"%@｜", user[@"name"]];
            NSString *userName = [NSString stringWithFormat:@"%@", user[@"username"] ];
            [self.newsLabel setTexts:@[name, userName] colors:@[[UIColor whiteColor],[UIColor whiteColor]] fonts:@[[UIFont boldSystemFontOfSize:16.0f], [UIFont systemFontOfSize:18.0f]] warp:NO spacing:0.0f];

        }
        
        CGFloat nameLH = 24;
        CGFloat nameLX = CGRectGetMaxX(IconImageView.frame) + nameLH;
        CGFloat nameLY = CGRectGetMidY(IconImageView.frame) - nameLH;
        CGFloat nameLW = UIScreenWidth - CGRectGetWidth(IconImageView.frame) - margin * 2;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLX, nameLY, nameLW, nameLH)];
//        nameLabel.text = @"展厅";
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.adjustsFontSizeToFitWidth = YES;
        nameLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [_tableHeadView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        if (user.count != 0) {
            NSString *name = [NSString stringWithFormat:@"%@", user[@"name"]];
            self.nameLabel.text = name;
        }
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, viewY + margin, UIScreenWidth - 20, viewH)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 10.0f;
        [_tableHeadView addSubview:view];

        CGFloat headLabelY = margin;
        CGFloat headLabelW = CGRectGetWidth(view.frame) * 0.5 - margin * 2;
        CGFloat headLabelH = viewH - margin * 2;
        CGFloat headLabelX = margin;
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(headLabelX, headLabelY, headLabelW, headLabelH)];
        headLabel.text = @"服务热线";
        headLabel.textColor = [UIColor dx_333333Color];
        headLabel.textAlignment = NSTextAlignmentLeft;
        headLabel.adjustsFontSizeToFitWidth = YES;
        headLabel.font = [UIFont systemFontOfSize:16.0f];
        [view addSubview:headLabel];
        
        UIButton * callButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat callButtonW = CGRectGetWidth(view.frame) * 0.5 - margin * 2;
        CGFloat callButtonH = headLabelH;
        CGFloat callButtonX = CGRectGetMaxX(view.frame) - margin * 2 - callButtonW;
        callButton.frame = CGRectMake(callButtonX, margin, callButtonW, callButtonH);
        callButton.backgroundColor = [UIColor clearColor];
        [callButton setImage:IMAGE(@"server_tel") forState:UIControlStateNormal];
        [callButton setTitle:@"400-699-9090" forState:UIControlStateNormal];
        callButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        callButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        callButton.titleLabel.font = DFont(16);
        [callButton setTitleColor:[UIColor dx_333333Color] forState:UIControlStateNormal];
        //左移图片，右移文字
        // 取出 titleLabel 的宽度
        CGFloat labelWidth02 = callButton.titleLabel.bounds.size.width;
        // 取出 imageView 的宽度
        CGFloat imageWidth02 = callButton.imageView.bounds.size.width;
        // 设置 titleLabel 的内边距
        callButton.titleEdgeInsets = UIEdgeInsetsMake(10, -imageWidth02, 10, imageWidth02);
        // 设置 imageView 的内边距
        callButton.imageEdgeInsets = UIEdgeInsetsMake(10, labelWidth02, 10, -labelWidth02);
        [callButton addTarget:self action:@selector(callButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:callButton];
    }
    return _tableHeadView;
}




//创建列表数组
- (void)createdDataArray
{
    NSArray *titleArray = @[@"线上交易记录", @"关于我们", @"修改密码", @"退出登录"];
    NSArray *isIconAraay = @[@"right_arrow", @"right_arrow", @"right_arrow", @"0"];
    self.createModelArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray.count ; i++) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setValue:titleArray[i] forKey:@"title"];
        [data setValue:isIconAraay[i] forKey:@"icon"];
        KY_Account_MySelf_Model *model = [KY_Account_MySelf_Model KY_Account_ModelWithDictionary:data];
        [self.createModelArray addObject:model];
    }
    [self.tableView reloadData];
}

- (void)superRightButtonAction
{
    KY_Account_SettingVC *vc = [[KY_Account_SettingVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
    return self.createModelArray.count;
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
    return 84.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    KY_HomePage_DeviceManage_Cell *cell = [KY_HomePage_DeviceManage_Cell KY_HomePage_DeviceManage_CellWithTableView:self.tableView withIdentifier:@"ky_createCard_cell"];
//
//    KY_DeviceList_Model *model = self.deviceDataArray[indexPath.row];
//    if (model) {
//        cell.model = model;
//    }
    KY_Account_MySelf_Cell *cell = [KY_Account_MySelf_Cell KY_Account_MySelf_CellWithTableView:self.tableView withIdentifier:@"KY_Account_MySelf_Cell"];
    KY_Account_MySelf_Model *model = self.createModelArray[indexPath.row];
    if (model) {
        cell.model = model;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KY_Account_MySelf_Model *model = self.createModelArray[indexPath.row];
    
    if ([model.title isEqualToString:@"退出登录"]) {
        [KYRequest removeAccountDict];
        self.tabBarController.selectedIndex = 0;
    }
    if ([model.title isEqualToString:@"修改密码"]) {
        KY_Account_ChangePassWordVC *vc = [[KY_Account_ChangePassWordVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([model.title isEqualToString:@"关于我们"]) {
        KY_Account_AboutUsVC *vc = [[KY_Account_AboutUsVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([model.title isEqualToString:@"线上交易记录"]) {
        KY_Account_OnlineRecordsVC *vc = [[KY_Account_OnlineRecordsVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//去掉系统自带的红点
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}


- (void)callButtonAction:(UIButton *)sender
{
    NSURL *url = [NSURL URLWithString:@"tel://1008611"];
//    UIWebView *callPhoneWebVw = [[UIWebView alloc] init];
    WKWebView *callPhoneWebVw = [[WKWebView alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [callPhoneWebVw loadRequest:request];
}



//测试登录功能按钮
- (void)LoginButtonAction:(UIButton *)sender
{
    
//    [self.tabBarController setSelectedIndex:0];

    
    LoginVC *vc = [[LoginVC alloc] init];
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.tabBarVC = (KYTabBarViewController *)self.tabBarController;
    [self presentViewController:na animated:YES completion:nil];
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
