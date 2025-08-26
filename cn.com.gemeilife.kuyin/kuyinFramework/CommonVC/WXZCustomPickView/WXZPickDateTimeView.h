//
//  WXZPickDateTimeView.h
//  自定义选择器
//
//  Created by lipixu on 2025/8/19.
//  Copyright © 2025 WOSHIPM. All rights reserved.
//

#import "WXZBasePickView.h"
NS_ASSUME_NONNULL_BEGIN

@class WXZBasePickView;
@protocol  PickerDateTimeViewDelegate<NSObject>
- (void)pickerDateView:(WXZBasePickView *)pickerDateView selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day selectHour:(NSInteger)hour selectMinute:(NSInteger)Minute;

@end


@interface WXZPickDateTimeView : WXZBasePickView

@property(nonatomic, weak)id <PickerDateTimeViewDelegate>delegate ;

@property(nonatomic, assign)BOOL isAddYetSelect;//是否增加至今的选项

-(void)setDefaultTSelectYear:(NSInteger)defaultSelectYear defaultSelectMonth:(NSInteger)defaultSelectMonth defaultSelectDay:(NSInteger)defaultSelectDay defaultSelectHour:(NSInteger)defaultSelectHour defaultSelectMinute:(NSInteger)defaultSelectMinute;


@end

NS_ASSUME_NONNULL_END
