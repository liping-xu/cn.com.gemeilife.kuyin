//
//  KdTabBarViewController.m
//  KoodPower
//
//  Created by lipixu on 2023/7/24.
//

#import "KYTabBarViewController.h"
//#import "SuperViewController.h"
#import "HomePageVC.h"
#import "MessageVC.h"
#import "StatisticsVC.h"
#import "AccountVC.h"
#import "LoginVC.h"
#import "KYRequest.h"


@interface KYTabBarViewController () <UITabBarControllerDelegate>

@end

@implementation KYTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self tabBarControllerAddChildViewController];
}

# pragma mark - 添加子类的数据
- (void)tabBarControllerAddChildViewController
{
    NSArray *classControllers = [NSArray array];
        classControllers = @[@"HomePageVC",
                             @"MessageVC",
                             @"StatisticsVC",
                             @"AccountVC"];
        NSArray *titles = @[@"首页",
                            @"消息",
                            @"统计",
                            @"我的"];
        NSArray *normalImages = @[@"main_nav_index_normal",
                                  @"main_nav_msg_normal",
                                  @"main_nav_btn_statistics_normal",
                                  @"main_nav_mine_normal"];
    
        NSArray *selectImages = @[@"main_nav_index_selected",
                                  @"main_nav_msg_selected",
                                  @"main_nav_btn_statistics_selected",
                                  @"main_nav_mine_selected"];
        [self TabbarControllerAddSubViewsControllers:classControllers addTitleArray:titles addNormalImagesArray:normalImages addSelectImageArray:selectImages];

}


# pragma mark - 初始化Tabbar里面的元素
- (void)TabbarControllerAddSubViewsControllers:(NSArray *)classControllersArray addTitleArray:(NSArray *)titleArray addNormalImagesArray:(NSArray *)normalImagesArray addSelectImageArray:(NSArray *)selectImageArray
{
    NSMutableArray *conArr = [NSMutableArray array];
    
    for (int i = 0; i < classControllersArray.count; i++) {
        
        Class cts = NSClassFromString(classControllersArray[i]);
        UIViewController *vc = [[cts alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:vc];
        [conArr addObject:naVC];
        
        UIImage *normalImage = [[UIImage imageNamed:normalImagesArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectImage = [[UIImage imageNamed:selectImageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleArray[i] image:normalImage selectedImage:selectImage];
        
    }
    
    self.viewControllers = conArr;
    self.tabBar.tintColor = [UIColor colorWithRed:47.0/255 green:148.0/255 blue:237.0/255 alpha:1];
    self.tabBar.translucent = NO;
    
}

# pragma mark - UITabBarControllerDelegate
/**
 点击TabBar的时候调用
 */
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    //判断是否登录
    if ([KYRequest isLogin]) {
        
    } else {
        LoginVC *vc = [[LoginVC alloc] init];
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.tabBarVC = self;
        [self presentViewController:na animated:YES completion:nil];
    }

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
