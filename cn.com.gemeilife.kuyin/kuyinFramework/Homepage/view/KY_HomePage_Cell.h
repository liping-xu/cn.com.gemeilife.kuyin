//
//  KY_HomePage_Cell.h
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/7/30.
//

#import <UIKit/UIKit.h>
#import "KY_HomePage_Model.h"
#import "WXZPickDateView.h"
#import "WXZCustomPickView.h"


NS_ASSUME_NONNULL_BEGIN

@interface KY_HomePage_Cell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString*)identifier;
- (void)addAllViews;

@end



@class kY_HomePage_Items_Cell;
@protocol Items_cell_TapActionDelegate <NSObject>
@optional
- (void)KY_HomePage_Items_CellTapAction:(NSString *)title;
@end

@interface kY_HomePage_Items_Cell : KY_HomePage_Cell

+(instancetype)kY_HomePage_Items_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@property (nonatomic,weak) id<Items_cell_TapActionDelegate> delegate;
@property (nonatomic,strong) NSArray *titleDataArray;
@property (nonatomic,strong) NSArray *imageDataArray;

@end

//新办水卡
@class kY_HomePage_CreatCard_Cell;
@class WXZCustomPickView;
@protocol kY_HomePage_CreatCard_CellActionDelegate <NSObject>
@optional
//第一行TextField的代理方法
- (void)kY_HomePage_CreatCard_CellTextFieldAction:(kY_HomePage_CreatCard_Cell *)cell;
//点击滚动视图中Item的代理方法
- (void)kY_HomePage_CreatCard_CellItemAction:(kY_HomePage_CreatCard_Cell *)cell WithIndex:(long)index;
//第一行分组 按钮groupButton的设置dataSource代理方法
- (void)kY_HomePage_CreatCard_CellGroupDataSourceButtonAction:(WXZCustomPickView *)pickView;
//第一行分组 按钮groupButton的代理方法
- (void)kY_HomePage_CreatCard_CellGroupButtonAction:(kY_HomePage_CreatCard_Cell *)cell;
//第二行actualTextField的代理方法
- (void)kY_HomePage_CreatCard_CellActualTextFieldAction:(kY_HomePage_CreatCard_Cell *)cell;
//第二行 性别按钮sexButton的代理方法
- (void)kY_HomePage_CreatCard_CellSexButtonAction:(kY_HomePage_CreatCard_Cell *)cell;
//第三行 出生年月按钮birthButton的代理方法
- (void)kY_HomePage_CreatCard_CellBirthButtonAction:(kY_HomePage_CreatCard_Cell *)cell;

@end


@interface kY_HomePage_CreatCard_Cell : KY_HomePage_Cell <PickerDateViewDelegate, CustomPickViewDelegate>

+(instancetype)kY_HomePage_CreatCard_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@property (nonatomic,strong) KY_CreateNewCard_Model *model;
//第一行输入框
@property (nonatomic,weak) UITextField *textField;
//实收金额的输入框
@property (nonatomic,weak) UITextField *actualTextField;
//分组按钮
@property (nonatomic,weak) UIButton *groupButton;
//日期选择器
@property (nonatomic,weak) UIButton *datePickerButton;
//性别 sexButton
@property (nonatomic,weak) UIButton *sexButton;
//出生年月 birthButton
@property (nonatomic,weak) UIButton *birthButton;

@property (nonatomic,weak) id delegate;

//滚动视图
@property (nonatomic,weak) UIScrollView *scrollView;

//item 数据Array 刷新 充值Item
@property (nonatomic,strong) NSArray *itemArray;

//分组 信息model 刷新分组model
@property (nonatomic,strong) NSArray *groupArray;


@end


@interface KY_HomePage_DeviceManage_Cell : KY_HomePage_Cell

+(instancetype)KY_HomePage_DeviceManage_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@property (nonatomic,strong) KY_DeviceList_Model *model;

@end

//设备详情
@interface KY_HomePage_DeviceDetail_Cell : KY_HomePage_Cell

+(instancetype)KY_HomePage_DeviceDetail_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@property (nonatomic,strong) KY_DeviceDetail_Model *model;
@property (nonatomic,weak) UILabel *TitleLabel;

@end

//打水记录

@interface KY_HomePage_WaterRecord_Cell : KY_HomePage_Cell

+(instancetype)KY_HomePage_WaterRecord_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@property (nonatomic,strong) KY_WaterRecord_Model *model;
@property (nonatomic,weak) UILabel *TitleLabel;

@end

//设备最新状态 设备状态
@interface KY_HomePage_DeviceDetailStatus_Cell : KY_HomePage_Cell

+(instancetype)KY_HomePage_DeviceDetailStatus_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@property (nonatomic,strong) KY_DeviceDetailStatus_Model *model;

@property (nonatomic,weak) UILabel *TitleLabel;
@property (nonatomic,weak) UILabel *DetailLabel;

@end


//设备最新状态 滤芯状态
@interface KY_HomePage_DeviceDetailFilterStatus_Cell : KY_HomePage_Cell

+(instancetype)KY_HomePage_DeviceDetailFilterStatus_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@property (nonatomic,strong) KY_DeviceDetailStatus_Model *model;

@property (nonatomic,weak) UILabel *TitleLabel;
@property (nonatomic,weak) UIButton *reSetButton;

@end

//收入记录
@interface KY_HomePage_DeviceDetail_Income_Cell : KY_HomePage_Cell

+(instancetype)KY_HomePage_DeviceDetail_Income_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@property (nonatomic,strong) KY_Income_Model *model;
@property (nonatomic,weak) UILabel *TitleLabel;

@end

//参数设置 设备参数
@interface KY_HomePage_DeviceDetail_ParamenterSetting_Cell : KY_HomePage_Cell

+(instancetype)KY_HomePage_DeviceDetail_ParamenterSetting_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@property (nonatomic,strong) KY_DeviceDetail_parameterSetting_Model *model;

@property (nonatomic,weak) UILabel *TitleLabel;
@property (nonatomic,weak) UILabel *DetailLabel;

@end

//用户管理
@interface KY_HomePage_UserManage_Cell : KY_HomePage_Cell

+(instancetype)KY_HomePage_UserManage_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@property (nonatomic,strong) KY_UserList_Model *model;

@end


//用户详情
@class KY_HomePage_UserDetail_Cell;
@protocol kY_HomePage_UserDetail_CellActionDelegate <NSObject>
@optional
- (void)kY_HomePage_UserDetail_CellLabelTapAction:(KY_HomePage_UserDetail_Cell *)cell;

@end

@interface KY_HomePage_UserDetail_Cell : KY_HomePage_Cell

+(instancetype)KY_HomePage_UserDetail_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@property (nonatomic,weak) id<kY_HomePage_UserDetail_CellActionDelegate> delegate;
@property (nonatomic,strong) KY_UserDetail_Model *model;
@property (nonatomic,weak) UILabel *detailLabel;

@end

//水卡列表

//用户详情
@class KY_HomePage_waterCardManage_Cell;
@protocol KY_HomePage_waterCardManage_CellActionDelegate <NSObject>
@optional
- (void)KY_HomePage_waterCardManage_CellRechargeButtonAction:(KY_HomePage_waterCardManage_Cell *)cell;

@end

@interface KY_HomePage_waterCardManage_Cell : KY_HomePage_Cell

+(instancetype)KY_HomePage_waterCardManage_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@property (nonatomic,weak) id<KY_HomePage_waterCardManage_CellActionDelegate> delegate;

@property (nonatomic,strong) KY_WaterCardList_Model *model;
@property (nonatomic,strong) NSArray *itemArray;

@end




NS_ASSUME_NONNULL_END
