//  父类
//  SuperViewController.h
//  Afanti
//
//  Created by JDY on 15/6/24.
//  Copyright (c) 2015年 52aft.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL            refresh;//YES需要刷新  NO不需要刷新
    NSString      *lastTime;
    BOOL      showTableView;//YES有tableview    NO没有tableview
    BOOL       showDropView;//YES有下拉刷新View  NO没有下拉刷新View
    BOOL         showTabBar;
}
@property (nonatomic,strong)UIButton      *rightBtn;
@property (nonatomic,strong)UIButton       *leftBtn;
@property (nonatomic,strong)UITableView  *tableView;
@property (nonatomic, strong) NSString *deviceToken;
@property (nonatomic, strong) UIView *noMessageView; // 没有数据页面
@property (nonatomic, strong) UIImageView *navigationBarImageView;
///是否隐藏导航栏 默认 NO 不隐藏
@property (nonatomic, assign) BOOL navIsHidden;
-(void)DropDownLoadData;//下拉加载数据
-(void)topMoreData;//上拉加载更多
-(void)removeTableView:(BOOL)removeTableView removeDropView:(BOOL)removeDropView;
-(void)superLeftButtonAction;
-(void)superRightButtonAction;
- (void)showNoMessageView:(BOOL)isShow message:(NSString*)message;
-(void)setViewOrientation:(UIInterfaceOrientation )orientation;
-(void)hiddenBottomBarWhenPushed;
-(void)showsBottomBarWhenPoped;
-(void)allocWithMake:(CGFloat)height style:(UITableViewStyle)style;
-(void)allocWithFrame:(CGRect)frame style:(UITableViewStyle)style;
- (void)allocNoInViewWithFrame:(CGRect)frame style:(UITableViewStyle)style;
- (void)allocNoInViewWithMake:(CGFloat)height style:(UITableViewStyle)style;
-(void)cancelDidSelectedState;
- (void)showPopView:(NSString*)string;
- (void)showActivityView:(NSString*)string;
- (void)cancelAcitvityView;
- (void)hiddenTabBar;
- (void)showTabBar;
- (void)rightButtonTitle:(NSString *)title rightButtonBackGroundImage:(UIImage *)image;


@end
