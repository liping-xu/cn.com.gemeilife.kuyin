//
//  KY_WaterCardManageAlertView.h
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/23.
//

#import <UIKit/UIKit.h>
#import "KY_HomePage_Cell.h"
#import "KY_HomePage_Model.h"
#import <FWPopupView/FWPopupView-Swift.h>


NS_ASSUME_NONNULL_BEGIN

@interface KY_WaterCardManageAlertView : UIView

@property (nonatomic,strong) KY_HomePage_waterCardManage_Cell *cell;
@property (nonatomic,strong) NSArray *itemArray;
@end

NS_ASSUME_NONNULL_END
