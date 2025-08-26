//
//  KY_CreateNewCardVC.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/1.
//

#import "KY_CreateNewCardVC.h"
#import "KY_HomePage_Cell.h"
#import "KY_HomePage_Model.h"
#import "KYRequest.h"
#import <FWPopupView/FWPopupView-Swift.h>


@interface KY_CreateNewCardVC () <kY_HomePage_CreatCard_CellActionDelegate>

//cell高度array
@property (nonatomic,strong) NSArray *heightArray;
//cell ModelArray
@property (nonatomic,strong) NSMutableArray *createNewCardModelArray;

//水卡编号
@property (nonatomic,copy) NSString *waterCardNumber;
//客户姓名
@property (nonatomic,copy) NSString *accountName;
//客户手机号
@property (nonatomic,copy) NSString *accountPhoneNum;
//分组
@property (nonatomic,copy) NSString *groupID;
//充值金额
@property (nonatomic,copy) NSString *totalMoney;
//实收金额
@property (nonatomic,copy) NSString *rechargeMoney;
//身高
@property (nonatomic,copy) NSString *accountHeight;
//性别
@property (nonatomic,copy) NSString *sex;
//出生年月
@property (nonatomic,copy) NSString *birth;
//备注
@property (nonatomic,copy) NSString *remark;
//分组 信息 groupList
@property (nonatomic,strong) NSMutableArray *groupListArray;
//点击分组后 充值Item ItemList
@property (nonatomic,strong) NSMutableArray *itemListArray;

//点击分组后 itemModel的属性
@property (nonatomic,copy) NSString *gID;

@property (nonatomic,copy) NSString *cID;

@end

@implementation KY_CreateNewCardVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hiddenTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    self.title = @"新办水卡";
    [self configureUI];
    [self createdDataArray];
    [self getGroupListNetWork];

}

//请求 新办卡 分组信息
- (void)getGroupListNetWork
{
    WeakSelf(self);
    self.groupListArray = [[NSMutableArray alloc] init];
    [KYRequest KYHomePage_CreateNewCardGroupListWithRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        if (isSuccess) {
            NSArray *dataArray = [NSArray arrayWithArray:resultDic[@"list"]];
//            for (NSDictionary *data in dataArray) {
//                KY_CreateNewCard_GroupList_Model *model = [KY_CreateNewCard_GroupList_Model KY_CreateNewCard_GroupList_ModelWithDictionary:data];
//                [weakself.groupListArray addObject:model];
//            }
            
            for (int i = 0; i < dataArray.count; i++) {
                NSDictionary *data = [NSDictionary dictionaryWithDictionary:dataArray[i]];
                KY_CreateNewCard_GroupList_Model *model = [KY_CreateNewCard_GroupList_Model KY_CreateNewCard_GroupList_ModelWithDictionary:data];
                [weakself.groupListArray addObject:model];
            }
            
            //开始 设置 默认分组数据
            NSIndexPath *groupIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];
            kY_HomePage_CreatCard_Cell *cell = [self.tableView cellForRowAtIndexPath:groupIndexPath];
            KY_CreateNewCard_GroupList_Model *firstModel = weakself.groupListArray[0];
            [cell.groupButton setTitle:firstModel.name forState:UIControlStateNormal];
            NSString *selectID = [NSString stringWithFormat:@"%d", firstModel.ID];
            [self getGroupItemListNetWork:selectID];
            
        }
    }];
}

//请求 该分组信息中 充值选项
- (void)getGroupItemListNetWork:(NSString *)ID
{
    WeakSelf(self);
    self.itemListArray = [[NSMutableArray alloc] init];
    [KYRequest KYHomePage_CreateNewCardItemListWith:ID WithRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        NSLog(@"%@", resultDic);
        if (isSuccess) {
            NSArray *dataArray = [NSArray arrayWithArray:resultDic[@"list"]];
            for (NSDictionary *data in dataArray) {
                KY_CreateNewCard_Group_ItemList_Model *model = [KY_CreateNewCard_Group_ItemList_Model KY_CreateNewCard_Group_ItemList_ModelWithDictionary:data];
                //选中的ID 赋值
                NSString *selectID = [NSString stringWithFormat:@"%d", model.gid];
                if ([selectID isEqualToString:ID]) {
                    self.gID = [NSString stringWithFormat:@"%d", model.gid];
                    self.cID = [NSString stringWithFormat:@"%d", model.ID];
                }
                
                [weakself.itemListArray addObject:model];
            }
            
            //
            NSIndexPath *groupIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
            kY_HomePage_CreatCard_Cell *cell = [self.tableView cellForRowAtIndexPath:groupIndexPath];
            cell.itemArray = [NSArray arrayWithArray:weakself.itemListArray];
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.tableView reloadData];
            });
            
            
        }
        
    }];
}


- (void)configureUI
{
    CGFloat tableViewY = 0;
//    CGFloat tableViewH = UIScreenHeight - tableViewY - [UIDevice vg_tabBarFullHeight];
    CGFloat tableViewH = UIScreenHeight - tableViewY;
    [self allocWithFrame:CGRectMake(0, tableViewY, UIScreenWidth, tableViewH) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.scrollEnabled = NO;
//    self.tableView.backgroundColor = [UIColor colorWithHex:0xF3F3F3];
//    self.tableView.tableHeaderView = self.tableHeadView;
}

//创建列表数组
- (void)createdDataArray
{
//    NSArray *titleArray = @[@"水卡编号", @"客户姓名", @"客户手机号", @"分组", @"充值金额", @"备注", @"设置水卡有效期"];
//    self.heightArray = @[@"84", @"84", @"84", @"84", @"250", @"124", @"64"];
//    NSArray *isSelectArray = @[@"1", @"0", @"1", @"0", @"1", @"0", @"0"];
//    NSArray *placeHolderArray = @[@"扫码识别水卡编号", @"输入客户姓名(可选)", @"请输入客户手机号", @"默认分组", @"请输入需充到水卡上的金额，单位元", @"输入其他备注信息便于记录(可选)", @"选择日期"];
//    NSArray *isIconAraay = @[@"scan", @"0", @"0", @"right_arrow", @"0", @"0", @"0"];
    NSArray *titleArray = @[@"水卡编号", @"客户姓名", @"客户手机号", @"分组", @"充值金额", @"身高(仅用于体测)",@"备注"];
    self.heightArray = @[@"84", @"84", @"84", @"84", @"250", @"250", @"124"];
    NSArray *isSelectArray = @[@"1", @"0", @"1", @"0", @"1", @"0", @"0"];
    NSArray *placeHolderArray = @[@"扫码识别水卡编号", @"输入客户姓名(可选)", @"请输入客户手机号", @"默认分组", @"请输入需充到水卡上的金额，单位元", @"选填", @"输入其他备注信息便于记录(可选)"];
    NSArray *isIconAraay = @[@"scan", @"0", @"0", @"right_arrow", @"0", @"0", @"0"];
    self.createNewCardModelArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray.count ; i++) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setValue:titleArray[i] forKey:@"title"];
        [data setValue:self.heightArray[i] forKey:@"height"];
        [data setValue:isSelectArray[i] forKey:@"isSelect"];
        [data setValue:placeHolderArray[i] forKey:@"placeHolder"];
        [data setValue:isIconAraay[i] forKey:@"isIcon"];
        KY_CreateNewCard_Model *model = [KY_CreateNewCard_Model kd_CreateNewCardWithDictionary:data];        
        [self.createNewCardModelArray addObject:model];
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
    return self.createNewCardModelArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [self tableViewFooterView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 64.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *height = self.heightArray[indexPath.row];
    return [height floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    kY_HomePage_CreatCard_Cell *cell = [kY_HomePage_CreatCard_Cell kY_HomePage_CreatCard_CellWithTableView:self.tableView withIdentifier:@"ky_createCard_cell"];
    cell.delegate = self;
    KY_CreateNewCard_Model *model = self.createNewCardModelArray[indexPath.row];
    if (model) {
        cell.model = model;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    kY_HomePage_CreatCard_Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
}

//去掉系统自带的红点
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
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
    [button setTitle:@"确认开卡" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(createdCradButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    return view;
}

#pragma mark - kY_HomePage_CreatCard_CellActionDelegate
//只要第一行Textfield的内容都可以在这里面取得
- (void)kY_HomePage_CreatCard_CellTextFieldAction:(kY_HomePage_CreatCard_Cell *)cell
{
    //水卡编号
    if ([cell.model.title isEqualToString:@"水卡编号"]) {
        self.waterCardNumber = [NSString stringWithFormat:@"%@", cell.textField.text];
    }
    //客户姓名
    if ([cell.model.title isEqualToString:@"客户姓名"]) {
        self.accountName = [NSString stringWithFormat:@"%@", cell.textField.text];
    }
    //客户手机号
    if ([cell.model.title isEqualToString:@"客户手机号"]) {
        self.accountPhoneNum = [NSString stringWithFormat:@"%@", cell.textField.text];
    }
    //充值金额
    if ([cell.model.title isEqualToString:@"充值金额"]) {
        self.totalMoney = [NSString stringWithFormat:@"%@", cell.textField.text];
    }
    
    //身高
    if ([cell.model.title isEqualToString:@"身高(仅用于体测)"]) {
        self.accountHeight = [NSString stringWithFormat:@"%@", cell.textField.text];
    }
    
    //备注
    if ([cell.model.title isEqualToString:@"备注"]) {
        self.remark = [NSString stringWithFormat:@"%@", cell.textField.text];
    }
    
}

//点击滚动视图的Item后的两个textField内容可以在这里面取得
-(void)kY_HomePage_CreatCard_CellItemAction:(kY_HomePage_CreatCard_Cell *)cell WithIndex:(long)index
{
    if ([cell.model.title isEqualToString:@"充值金额"]) {
        self.totalMoney = [NSString stringWithFormat:@"%@", cell.textField.text];
        self.rechargeMoney = [NSString stringWithFormat:@"%@", cell.actualTextField.text];
        KY_CreateNewCard_Group_ItemList_Model *model = self.itemListArray[index];
        self.gID = [NSString stringWithFormat:@"%d", model.gid];
        self.cID = [NSString stringWithFormat:@"%d", model.ID];
    }
}
//获取分组按钮的title在这个方法里面取得
- (void)kY_HomePage_CreatCard_CellGroupButtonAction:(kY_HomePage_CreatCard_Cell *)cell
{
    //分组
    if ([cell.model.title isEqualToString:@"分组"]) {
        self.groupID = [NSString stringWithFormat:@"%@", cell.groupButton.titleLabel.text];
        
        //点击分组后 创建item视图
        KY_CreateNewCard_GroupList_Model *selectModel = [KY_CreateNewCard_GroupList_Model new];
        for (KY_CreateNewCard_GroupList_Model *model in self.groupListArray) {
            if ([model.name isEqualToString:self.groupID]) {
                selectModel = model;
            }
        }
        NSString *selectID = [NSString stringWithFormat:@"%d", selectModel.ID];
        [self getGroupItemListNetWork:selectID];
        
    }
}

//第二行actualTextField的代理方法
- (void)kY_HomePage_CreatCard_CellActualTextFieldAction:(kY_HomePage_CreatCard_Cell *)cell
{
    if ([cell.model.title isEqualToString:@"充值金额"]) {
        self.rechargeMoney = [NSString stringWithFormat:@"%@", cell.actualTextField.text];
    }
    
}

//第二行 性别按钮sexButton的代理方法
- (void)kY_HomePage_CreatCard_CellSexButtonAction:(kY_HomePage_CreatCard_Cell *)cell
{
    if ([cell.model.title isEqualToString:@"身高(仅用于体测)"]) {
        self.sex = [NSString stringWithFormat:@"%@", cell.sexButton.titleLabel.text];
    }
}

//第三行 出生年月按钮birthButton的代理方法
- (void)kY_HomePage_CreatCard_CellBirthButtonAction:(kY_HomePage_CreatCard_Cell *)cell
{

    if ([cell.model.title isEqualToString:@"身高(仅用于体测)"]) {
        self.birth = [NSString stringWithFormat:@"%@", cell.birthButton.titleLabel.text];
    }
}


#pragma mark - 设置pickView的dataSource
//设置分组的数据源
-(void)kY_HomePage_CreatCard_CellGroupDataSourceButtonAction:(WXZCustomPickView *)pickView
{
//    NSMutableArray *arrayData = [NSMutableArray arrayWithObjects:@"默认分组", nil];

    NSMutableArray *arrayData = [[NSMutableArray alloc] init];
    if (self.groupListArray.count != 0) {
        
        for (int i = 0; i < self.groupListArray.count; i++) {
            KY_CreateNewCard_GroupList_Model *model = self.groupListArray[i];
            [arrayData addObject:model.name];
        }
        [pickView setDataArray:arrayData];
    }
}

- (void)createdCradButtonAction:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (self.waterCardNumber.length < 9) {
        [self showPopView:@"水卡编号错误"];
        return;
    }
    
    if (self.groupID.length == 0) {
        [self showPopView:@"请选择分组"];
        return;
    }
    
    if ([self.totalMoney floatValue] <= 0) {
        [self showPopView:@"请输入充值金额"];
        return;
    }
    //如果不是手机号码
    if (![self isPhoneNumWithtext:self.accountPhoneNum]) {
        return;
    }
    
    WeakSelf(self);
    [KYRequest KYHomePageCreatedNewCardWithBirthDay:self.birth WithGID:self.gID WithMoney:self.rechargeMoney WithRecharge:self.totalMoney WithPhone:self.accountPhoneNum WithContact:self.accountName withSex:self.sex WithStature:self.accountHeight WithRemark:self.remark WithCardNo:self.waterCardNumber WithCID:self.cID withRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {
        if (isSuccess) {
            id block = ^(FWPopupView *popupView, NSInteger index, NSString *title){
//                NSLog(@"AlertView：点击了第 %ld 个按钮", (long)index);
                [self.navigationController popViewControllerAnimated:YES];
            };
            
            // 注意：此时“确定”按钮是不让按钮自己隐藏的

            NSArray *items = @[[[FWPopupItem alloc] initWithTitle:@"返回首页继续办卡" itemType:FWItemTypeNormal isCancel:YES canAutoHide:YES itemTitleColor:[UIColor dx_666666Color] itemBackgroundColor:nil itemClickedBlock:block]];
            
            FWAlertViewProperty *vProperty = [[FWAlertViewProperty alloc] init];
            vProperty.alertViewWidth = MAX([UIScreen mainScreen].bounds.size.width * 0.65, 275);
            vProperty.detailColor = [UIColor dx_666666Color];
            
            FWAlertView *alertView = [FWAlertView alertWithTitle:@"标题" detail:@"操作成功" inputPlaceholder:nil keyboardType:UIKeyboardTypeDefault isSecureTextEntry:NO customView:nil items:items vProperty:vProperty];
            [alertView show];
            
            
        } else {
            [weakself showPopView:message];
        }
        
    }];
//    {"birthday":"1972-08-14","gid":5531,"money":20000,"recharge":50000,"phone":"18555512345","contact":"测试","sex":"男","stature":185,"remark":"测试","cardNo":"1234567892","cid":19195}
    
}

//判断是不是正确的手机号格式
- (BOOL)isPhoneNumWithtext:(NSString *)Text
{
    NSString *text = Text;
    //只能输入数字
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
//    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
//    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
//            return NO;
//
//    }
//    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    // 如果是电话号码格式化，需要添加这三行代码
//    NSMutableString *temString = [NSMutableString stringWithString:text];[temString insertString:@" " atIndex:0];
//    text = temString;
    NSMutableString *temString = [NSMutableString stringWithString:text];
    [temString insertString:@" "atIndex:0];
    text = temString;
    
    NSString *newString =@"";
    while (text.length >0)
     {
         NSString *subString = [text substringToIndex:MIN(text.length,4)];
         newString = [newString stringByAppendingString:subString];
         if (subString.length ==4)
         {
             newString = [newString stringByAppendingString:@" "];
         }
         text = [text substringFromIndex:MIN(text.length,4)];
     }

     newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
//    NSLog(@"%@", newString);
//    [textField setText:newString];
    if (newString.length >= 14) {
        [self showPopView:@"请输入有效的手机号"];
        return NO;
    }
    if (newString.length == 13) {
        
        BOOL isPhoneNum = [newString isMobileNumber:newString];
        if (!isPhoneNum) {
//            self.nextButton.backgroundColor = [UIColor colorWithHex:0xC29A40];
//            self.nextButton.userInteractionEnabled = YES;
//            [self showPopView:@"有效的手机号"];
            return YES;
        } else {
            [self showPopView:@"请输入有效的手机号"];
            return NO;
        }
    }
    return NO;
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
