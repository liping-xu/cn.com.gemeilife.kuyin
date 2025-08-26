//
//  KY_Account_OnlineRecordsVC.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/11.
//

#import "KY_Account_OnlineRecordsVC.h"

@interface KY_Account_OnlineRecordsVC ()

@end

@implementation KY_Account_OnlineRecordsVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hiddenTabBar];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"线上交易记录";
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
