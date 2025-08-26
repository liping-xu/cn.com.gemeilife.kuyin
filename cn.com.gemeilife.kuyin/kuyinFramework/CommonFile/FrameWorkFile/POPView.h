//
//  POPView.h
//  财经天气预报
//
//  Created by 邓川江 on 14-10-22.
//  Copyright (c) 2014年 Chuanjiang.Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class POPView;
typedef void(^CancelButton)(NSInteger buttion0);
typedef void(^ConfirmButton)(NSInteger buttion1,NSString *fieldlString);
typedef void(^ConfirmManageButton)(NSInteger buttion, NSString *level, NSString *credit);
typedef void(^TimeChoiceButton)(NSInteger button, NSString *startTime, NSString *endTime);
typedef void(^RentButton)(NSInteger button, NSString *wisdom);

@interface POPView : UIControl<UITextFieldDelegate>{
    CancelButton    _cancelButton;
    ConfirmButton  _confrimButton;
    UIActivityIndicatorView *indicator;
    NSTimer         *timer;
    UISlider *slider;
    ConfirmManageButton _confirmManageButton;
    TimeChoiceButton _timeChoiceButton;
    RentButton _rentButton;
    UILabel *popLabelView;
    NSString *_level;
    NSString *_rentCount; // 租赁数量
}
/*
 *含输入框弹出框
 */
-(id)initWithAlertViewTitle:(NSString *)title placeholder:(NSString *)placeholder keyboardType:(UIKeyboardType)keyboardType  text:(NSString*)text buttonTitles:(NSArray *)titles cancelButton:(CancelButton)cancelButton confirmButton:(ConfirmButton)confirmButton;
/*
 *信息展示,无输入框
 */
-(id)initWithAlertViewTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)titles cancelButton:(CancelButton)cancelButton confirmButton:(ConfirmButton)confirmButton;
/*
 *无按钮自动消失popview
 */
-(id)initWithBox:(NSString *)message;
-(void)removeSelf;

/*
 加载中
 */
-(id)initWithActivity:(NSString *)message;

+(void)WindowAddSubview:(POPView *)view;
@end
@class POPTextField;
@protocol TollbarTextFieldDelegate <NSObject>
/*
 *0上一个 1下一个 2确认 3取消
 */
-(void)TollbarTextFieldAction:(NSInteger)tag textFeild:(POPTextField *)textFeild;
@end

@interface POPTextField : UITextField{
    NSArray *textArray;

}
@property (nonatomic,assign)id<TollbarTextFieldDelegate>TollbarDelegate;
-(id)initWithToolbarFeild:(CGRect)frame;
-(void)textFieldArray:(NSArray *)array;

@end

@interface DIImage : UIImage
/*
 iamge:源图片 size:指定宽高
 */
+(UIImage*)OriginImage:(UIImage *)image scaleToWidth:(CGFloat)width height:(CGFloat)height;

@end
