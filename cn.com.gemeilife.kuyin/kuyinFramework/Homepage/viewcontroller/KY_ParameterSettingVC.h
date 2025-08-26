//
//  KY_ParameterSettingVC.h
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/16.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KY_ParameterSettingVC : SuperViewController

//设备编号
@property (nonatomic,copy) NSString *deviceNumber;
//设备UUID
@property (nonatomic,copy) NSString *deviceUUID;

@end

NS_ASSUME_NONNULL_END
