//
//  KY_Homepage_Item_view.h
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/7/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KY_HomePage_ItemsTapActionDelegate <NSObject>
@optional
- (void)itemsTapAction:(NSString *)title;
@end


@interface KY_Homepage_Item_view : UIView

- (instancetype)initWithFrame:(CGRect)frame WithImage:(UIImage *)image WithTitle:(NSString *)title;

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSString *title;
@property(nonatomic,weak) id<KY_HomePage_ItemsTapActionDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
