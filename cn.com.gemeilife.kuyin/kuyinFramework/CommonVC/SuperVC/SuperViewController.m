//  父类
//  SuperViewController.m
//  Afanti
//
//  Created by JDY on 15/6/24.
//  Copyright (c) 2015年 52aft.com. All rights reserved.
//

#import "SuperViewController.h"

@interface SuperViewController ()
{
    UILabel *noMessageLabel;
}

@end

@implementation SuperViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.navIsHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.navIsHidden) {
        if ([self pushOrPopIsHidden] == NO) {
            [self.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
}

///监听push下一个或 pop 上一个，是否隐藏导航栏
- (BOOL)pushOrPopIsHidden {
    NSArray * viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count > 0) {
        SuperViewController * vc = viewcontrollers[viewcontrollers.count - 1];
        return vc.navIsHidden;
    }
    return NO;
}

- (void)setViewOrientation:(UIInterfaceOrientation )orientation
{
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        [[UIDevice currentDevice] performSelector:@selector(setOrientation:)withObject:(id)orientation];
//    }
//    [UIViewController attemptRotationToDeviceOrientation];//这句是关键
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation==UIInterfaceOrientationPortrait;
}

- (void)hiddenBottomBarWhenPushed{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"hiddenTabBarController" object:nil];
}

- (void)showsBottomBarWhenPoped{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"showTabBarController" object:nil];
}

- (void)allocWithMake:(CGFloat)height style:(UITableViewStyle)style
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, UIScreenWidth, height) style:style];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor dx_D9D9D9Color];
    self.tableView.backgroundColor = [UIColor dx_F2F2F2Color];
    // cell分割线左移
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.scrollEnabled = YES;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:self.tableView];
    self.tableView.scrollsToTop = YES;
    [self creatPullView];
}

- (void)allocNoInViewWithMake:(CGFloat)height style:(UITableViewStyle)style
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, UIScreenWidth, height) style:style];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor dx_D9D9D9Color];
    self.tableView.backgroundColor = [UIColor dx_F2F2F2Color];
    // cell分割线左移
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.scrollEnabled = YES;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.scrollsToTop = YES;
    [self creatPullView];
}

- (void)allocNoInViewWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    self.tableView = [[UITableView alloc]initWithFrame:frame style:style];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor dx_F2F2F2Color];
    self.tableView.backgroundColor = [UIColor dx_F2F2F2Color];
    // cell分割线左移
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.scrollEnabled = YES;
    self.tableView.scrollsToTop = YES;
    [self creatPullView];
}

- (void)allocWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    self.tableView = [[UITableView alloc]initWithFrame:frame style:style];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor dx_F2F2F2Color];
    self.tableView.backgroundColor = [UIColor dx_F2F2F2Color];
    // cell分割线左移
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.scrollEnabled = YES;
    [self.view addSubview:self.tableView];
    self.tableView.scrollsToTop = YES;
    
    if (!self.navIsHidden) {
        [self creatPullView];        
    }
}

// 没有数据
- (void)showNoMessageView:(BOOL)isShow message:(NSString*)message
{
//    _noMessageView.hidden = !isShow;
//    if (isShow) {
//        UIImageView *imageView = (UIImageView*)[self.view viewWithTag:8900];
//        if (![AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
//            imageView.image = IMAGE(@"wifi");
//            message = @"检测不到网络,快去设置网络吧!";
//        } else {
//            imageView.image = IMAGE(@"noMessage");
//        }
//        CGSize size = [message sizeWithFont:DFont(13) maxSize:CGSizeMake(UIScreenWidth - (AHeight(20)), MAXFLOAT)];
//        CGFloat height = size.height;
//        noMessageLabel.frame = CGRectMake(AHeight(10), ORIGIN_Y(noMessageLabel.frame), UIScreenWidth - (AHeight(20)), height);
//        noMessageLabel.text = message;
//        if (self.tableView.delegate && self.tableView.hidden == NO) {
//            [self.tableView insertSubview:_noMessageView aboveSubview:self.tableView];
//        } else {
//            _noMessageView.frame = CGRectMake(ORIGIN_X(_noMessageView.frame), (SUBHEIGHT - CGRectGetHeight(imageView.frame)) / 2 + 64, CGRectGetWidth(_noMessageView.frame), CGRectGetHeight(_noMessageView.frame));
//            _noMessageView.center = CGPointMake(UIScreenWidth / 2, UIScreenHeight / 2);
//        }
//    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
#if TARGET_IPHONE_SIMULATOR
    self.deviceToken = @"simulator_token";
#else
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSString *deviceToken = app.deviceToken;
//    self.deviceToken = deviceToken;
#endif
    
    [self setupUI];
    
//    // 登录监听事件
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginAction:) name:DXUserShouldLoginNotification object:nil];
//    // 交易事件
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tradeAction:) name:DXUserTradeNotification object:nil];
//    // 登录客户号监听事件
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginCusIDAction:) name:DXUserShouldLoginCusIDNotification object:nil];
}


// 交易
- (void)tradeAction:(NSNotification *)notification
{
    NSLog(@"n %@", notification.object);
}

// 客户号
- (void)loginCusIDAction:(NSNotification *)notification
{
    
}


- (void)DropDownLoadData
{
    DLog(@"下拉刷新-----子类重写");
}

- (void)topMoreData
{
    DLog(@"上啦加载更多----子类重写");
}

- (void)rightButtonTitle:(NSString *)title rightButtonBackGroundImage:(UIImage *)image
{
    _rightBtn.hidden = NO;
    if (title.length > 0) {
        _rightBtn.frame = CGRectMake(0, 20, 55, 25);
    }
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_rightBtn setTitle:title forState:UIControlStateNormal];
    _rightBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_rightBtn setImage:image forState:UIControlStateNormal];
//    [_rightBtn setBackgroundImage:image forState:UIControlStateNormal];

}

- (void)creatPullView
{
    UIView *refView = [[UIView alloc]initWithFrame:CGRectMake(0, -50, UIScreenWidth, 50)];
    refView.backgroundColor = [UIColor clearColor];
    refView.tag = 100;
    [self.tableView addSubview:refView];
    
    UILabel *lastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, UIScreenWidth, 20)];
    lastLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    lastLabel.backgroundColor = [UIColor clearColor];
    //    lastLabel.text = lastTime;
    lastLabel.tag = 101;
    lastLabel.font = [UIFont systemFontOfSize:12.0f];
    lastLabel.textAlignment = NSTextAlignmentCenter;
    lastLabel.textColor = [UIColor dx_FB5D5FColor];
    [refView addSubview:lastLabel];
    
    UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 25, UIScreenWidth, 20)];
    stateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    stateLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    stateLabel.backgroundColor = [UIColor clearColor];
    stateLabel.textColor = [UIColor dx_FB5D5FColor];
    stateLabel.textAlignment = NSTextAlignmentCenter;
    stateLabel.text = @"松开刷新";
    [refView addSubview:stateLabel];
    
    UIImageView *refImage = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth/3, 20, 15, 25)];
    refImage.image = [UIImage imageNamed:@"ref"];
    refImage.transform = CGAffineTransformMakeRotation(M_PI);
    refImage.tag = 102;
    [refView addSubview:refImage];
    
    showTableView = YES;
    showDropView = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSString *nowTime = [NSDate sinceNow];
    if (refresh) {
        lastTime = nowTime;
        UILabel *label = (UILabel *)[self.tableView viewWithTag:101];
        label.text = lastTime;
        if (showDropView && showTableView) {
            [self DropDownLoadData];
        } else {
            if (showDropView&&!showTableView) {
                [self DropDownLoadData];
            }
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = self.tableView.contentOffset.y;
    UIView *tempView = (UIView *)[self.tableView viewWithTag:100];
    UIImageView *tempImage = (UIImageView *)[tempView viewWithTag:102];
    if (y < -40) {
        [UIView animateWithDuration:0.5 animations:^{
            tempImage.transform = CGAffineTransformMakeRotation(M_PI*2);
            refresh = YES;
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            tempImage.transform = CGAffineTransformMakeRotation(M_PI);
            refresh = NO;
        }];
    }
}

- (void)cancelDidSelectedState
{
    NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
    if (selected)[self.tableView deselectRowAtIndexPath:selected animated:YES];
}

- (void)superLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)superRightButtonAction
{
    DLog(@"重写右按钮方法");
}

- (void)removeTableView:(BOOL)removeTableView removeDropView:(BOOL)removeDropView
{
    UIView *view = (UIView *)[self.tableView viewWithTag:100];
    showTableView  = removeTableView;
    showDropView   = removeDropView;
    if (removeDropView) {
        [view removeFromSuperview];
    }if (removeTableView) {
        [self.tableView removeFromSuperview];
    }
}

- (void)showPopView:(NSString*)string
{
    POPView *popView = [[POPView alloc] initWithBox:string];
    [POPView WindowAddSubview:popView];
}

- (void)showActivityView:(NSString*)string
{
//    POPView *popView = [[POPView alloc] initWithActivity:string];
//    popView.tag = 9666;
//    [self.view addSubview:popView];
}

- (void)cancelAcitvityView
{
//    POPView *pop = (POPView*)[self.view viewWithTag:9666];
//    [pop removeFromSuperview];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor colorWithHex:0x05020F];
    
//    self.navigationBarImageView = [[UIImageView alloc] initWithImage:IMAGE(@"")];
//    self.navigationBarImageView.frame = CGRectMake(0, 0, UIScreenWidth, 64);
//    [self.view addSubview:self.navigationBarImageView];
    
    
    UIImage *backgroundImage = [UIImage imageNamed:@"titleBg"];
    backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    

    
//    CGFloat statusY = [UIDevice vg_statusBarHeight];
//    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -statusY, self.view.bounds.size.width, statusY)];
//    //设置成绿色
//    statusBarView.backgroundColor = [UIColor redColor];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newHeader_bg_bottom"]];
//    imageView.backgroundColor = [UIColor clearColor];
//    imageView.frame = statusBarView.bounds;
//    imageView.contentMode = UIViewContentModeScaleAspectFill; // 图片填充模式
//    [statusBarView addSubview:imageView];
    // 添加到 navigationBar 上
//    [self.navigationController.navigationBar addSubview:statusBarView];
    
        self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    NSDictionary *dic = @{NSFontAttributeName: DFont(19),NSForegroundColorAttributeName: [UIColor whiteColor]};
        self.navigationController.navigationBar.titleTextAttributes = dic;
//    UINavigationBar *bar = self.navigationController.navigationBar;
//    UIImage *barImage = [self getNvaImageWithImage:IMAGE(@"img_bg_xh")];
    self.extendedLayoutIncludesOpaqueBars = YES;
//    [bar setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
//    [bar setBarStyle:UIBarStyleBlackTranslucent];
//    [bar setTintColor:[UIColor clearColor]];
//    [bar setShadowImage:[UIImage new]];
//    bar.titleTextAttributes = dic;

    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn addTarget:self action:@selector(superLeftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    _leftBtn.frame = CGRectMake(0 ,0 ,AHeight(65) ,44);
    _leftBtn.backgroundColor = [UIColor clearColor];
    _leftBtn.titleLabel.font = DFontWithTile(18);
    _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, AHeight(-40), 0, 0);
    [_leftBtn setImage:[UIImage imageNamed:@"icon_left"] forState:UIControlStateNormal];
    [_leftBtn setImage:[UIImage imageNamed:@"icon_left"] forState:UIControlStateHighlighted];
    [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *btn_left = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
    UIBarButtonItem *leftNegativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
    leftNegativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftNegativeSpacer, btn_left, nil];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn addTarget:self action:@selector(superRightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn.frame = CGRectMake(0, 0, AHeight(65), 44);
    _rightBtn.backgroundColor = [UIColor clearColor];
    _rightBtn.titleLabel.font = DFont(14);
    _rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
    _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];

    // 改变输入框光标颜色
    [[UITextField appearance] setTintColor:[UIColor dx_FB5D5FColor]];
    
    UIImageView *noMessageImageView = [[UIImageView alloc] initWithImage:IMAGE(@"wifi")];
    noMessageImageView.tag = 8900;
    noMessageImageView.contentMode = UIViewContentModeCenter;
    CGRect frame = CGRectMake((UIScreenWidth - CGRectGetWidth(noMessageImageView.frame)) / 2, 0, CGRectGetWidth(noMessageImageView.frame), CGRectGetHeight(noMessageImageView.frame));
    _noMessageView = [[UIView alloc] initWithFrame:CGRectMake(0, (SUBHEIGHT - CGRectGetHeight(noMessageImageView.frame)) / 2, UIScreenWidth, CGRectGetHeight(noMessageImageView.frame) + 50)];
    noMessageImageView.frame = frame;
    noMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(AHeight(10), CGRectGetMaxY(noMessageImageView.frame) + 10, UIScreenWidth - (AHeight(20)), AHeight(60))];
    noMessageLabel.numberOfLines = 0;
    noMessageLabel.font = DFont(13);
    noMessageLabel.textColor = [UIColor dx_999999Color];
    noMessageLabel.textAlignment = NSTextAlignmentCenter;
    [_noMessageView addSubview:noMessageLabel];
    _noMessageView.center = CGPointMake(UIScreenWidth / 2, (UIScreenHeight - 64) / 2);
    
    [_noMessageView addSubview:noMessageImageView];
    _noMessageView.hidden = YES;
    
    if (self.tableView.delegate) {
        [self.tableView addSubview:_noMessageView];
    } else [self.view addSubview:_noMessageView];
    

}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height&& scrollView.contentOffset.y > 0 ){
        [self topMoreData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (UIImage *)getNvaImageWithImage:(UIImage *)image
{
    CGSize imageSize = CGSizeMake(self.view.frame.size.width, kNavBarHeaderHeight);
    UIGraphicsBeginImageContext(imageSize);
    [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (void)hiddenTabBar
{
    [UIView animateWithDuration:0.5 animations:^{
        self.tabBarController.tabBar.frame = CGRectMake(self.tabBarController.tabBar.frame.origin.x, UIScreenHeight + self.tabBarController.tabBar.frame.size.height, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
        
//        self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x, 0 - self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
    }];
}

- (void)showTabBar
{
    [UIView animateWithDuration:0.2 animations:^{
        self.tabBarController.tabBar.frame = CGRectMake(self.tabBarController.tabBar.frame.origin.x, UIScreenHeight - self.tabBarController.tabBar.frame.size.height, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
        
//        self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x, 0 - self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
    }];
}


@end

