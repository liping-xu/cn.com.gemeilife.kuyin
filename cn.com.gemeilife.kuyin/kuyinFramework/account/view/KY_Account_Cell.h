//
//  KY_Acoount_Cell.h
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/9.
//

#import <UIKit/UIKit.h>
#import "KY_Account_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface KY_Account_Cell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString*)identifier;
- (void)addAllViews;

@end

@interface KY_Account_MySelf_Cell : KY_Account_Cell

+(instancetype)KY_Account_MySelf_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@property (nonatomic,strong) KY_Account_MySelf_Model *model;

@end

@interface KY_Account_Setting_Cell : KY_Account_Cell

+(instancetype)KY_Account_Setting_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@property (nonatomic,strong) KY_Account_Setting_Model *model;

@end

@interface KY_Account_AboutUs_Cell : KY_Account_Cell

+(instancetype)KY_Account_AboutUs_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@property (nonatomic,strong) KY_Account_AboutUs_Model *model;

@end

@class KY_Account_ChangePassWord_Cell;
@protocol KY_Account_ChangePassWord_CellActionDelegate <NSObject>
@optional
//第一行TextField的代理方法
- (void)KY_Account_ChangePassWord_CellTextFieldAction:(KY_Account_ChangePassWord_Cell *)cell;

@end

@interface KY_Account_ChangePassWord_Cell : KY_Account_Cell

+(instancetype)KY_Account_ChangePassWord_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@property (nonatomic,strong) KY_Account_ChangePassWord_Model *model;
@property (nonatomic,weak) id delegate;
@property (nonatomic,weak) UITextField *TextField;

@end

NS_ASSUME_NONNULL_END
