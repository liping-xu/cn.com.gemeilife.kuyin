//
//  KY_Account_ChangePassWordVC.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/11.
//

#import "KY_Account_ChangePassWordVC.h"
#import "KY_Account_Model.h"
#import "KY_Account_Cell.h"
#import "KYRequest.h"

@interface KY_Account_ChangePassWordVC () <KY_Account_ChangePassWord_CellActionDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,copy) NSString *OldPassWord;
@property (nonatomic,copy) NSString *NewPassWord;
@property (nonatomic,copy) NSString *repetitionPassWord;

@end

@implementation KY_Account_ChangePassWordVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hiddenTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
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
    NSArray *placeHolderArray = @[@"请输入旧密码", @"请输入密码", @"请再次输入密码"];
    self.dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < placeHolderArray.count; i++) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setValue:placeHolderArray[i] forKey:@"placeHolder"];
        KY_Account_ChangePassWord_Model *model = [KY_Account_ChangePassWord_Model KY_Account_ChangePassWord_ModelWithDictionary:data];
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
    KY_Account_ChangePassWord_Cell *cell = [KY_Account_ChangePassWord_Cell KY_Account_ChangePassWord_CellWithTableView:tableView withIdentifier:@"KY_Account_ChangePassWord_Cell"];
    cell.delegate = self;
    KY_Account_ChangePassWord_Model *model = self.dataArray[indexPath.row];
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


- (UIView *)tableViewFooterView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 64.0f)];
    
    NSArray *buttonArray = @[@"确定"];
    CGFloat margin = 10.0f;
    CGFloat buttonY = margin * 2;
    CGFloat buttonW = (UIScreenWidth - margin * 4) * 0.8;
    CGFloat buttonH = 44.0f;
    CGFloat buttonX = (UIScreenWidth - buttonW) * 0.5;
    for (int i = 0; i < buttonArray.count; i++) {
//        CGFloat buttonX = margin + i * (margin + buttonW);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.backgroundColor = [UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f];
        button.titleLabel.font = DFont(16);
        button.layer.borderWidth = 0.01f;
        button.layer.borderColor = [UIColor colorWithRed:20.0f/255.0f green:80.0f/255.0f blue:200.0f/255.0f alpha:0.7f].CGColor;
        button.layer.cornerRadius = buttonH * 0.5;
        button.layer.masksToBounds = YES;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:buttonArray[i] forState:UIControlStateNormal];
        // 假设button是你想要修改的UIButton实例
//        button.titleLabel.font = [UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    return view;
}

- (void)KY_Account_ChangePassWord_CellTextFieldAction:(KY_Account_ChangePassWord_Cell *)cell
{
//    @[@"请输入旧密码", @"请输入密码", @"请再次输入密码"];
//    NSLog(@"%@", cell.TextField.text);
    if ([cell.model.placeHolder isEqualToString:@"请输入旧密码"]) {
        self.OldPassWord  = cell.TextField.text;
    }
    if ([cell.model.placeHolder isEqualToString:@"请输入密码"]) {
        self.NewPassWord  = cell.TextField.text;
    }
    if ([cell.model.placeHolder isEqualToString:@"请再次输入密码"]) {
        self.repetitionPassWord  = cell.TextField.text;
    }
}

- (void)buttonAction:(UIButton *)sender
{
    NSString *currentPassword =  [KYRequest getPassWord];
    
    if (![self.OldPassWord isEqualToString:currentPassword]) {
        [self showPopView:@"您的旧密码不正确"];
        return;
    }
    
    if (![self.NewPassWord isEqualToString:self.repetitionPassWord]) {
        [self showPopView:@"您前后输入的密码不一致"];
        return;
    }
    
    [KYRequest KYAccountChangePassWordWithPostWithOldPassWord:self.OldPassWord withNewPassWord:self.NewPassWord withRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        if (isSuccess) {
            [self showPopView:message];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self showPopView:message];
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
