//
//  KY_FiliterView.h
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/16.
//

//#import <FWPopupView/FWPopupView-Swift.h>
#import <FWPopupBaseView.h>

NS_ASSUME_NONNULL_BEGIN

@interface KY_FiliterView : FWPopupBaseView

//0 不显示类型 1 打水类型  2 交易类型 
@property (nonatomic,assign) NSInteger type;


@end

NS_ASSUME_NONNULL_END
