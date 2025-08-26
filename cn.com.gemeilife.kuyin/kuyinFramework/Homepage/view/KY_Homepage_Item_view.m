//
//  KY_Homepage_Item_view.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/7/31.
//

#import "KY_Homepage_Item_view.h"

@implementation KY_Homepage_Item_view

- (instancetype)initWithFrame:(CGRect)frame WithImage:(UIImage *)image WithTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = image;
        self.title = title;
        [self setItemUI];
    }
    return self;
}

- (void)setItemUI
{
    
    CGFloat imageViewX = 30;
    CGFloat imageViewY = 30;
    CGFloat imageViewW = self.bounds.size.width - 60;
    CGFloat imageViewH = self.bounds.size.height * 0.3;
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)];
    imageview.image = self.image;
    imageview.contentMode = UIViewContentModeScaleAspectFit;

    [self addSubview:imageview];
    
    CGFloat labelX = 0;
    CGFloat labelY = CGRectGetMaxY(imageview.frame);
    CGFloat labelW = self.bounds.size.width;
    CGFloat labelH = self.bounds.size.height * 0.3;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor dx_666666Color];
    titleLabel.font = DFont(12);
    titleLabel.text = self.title;
    [self addSubview:titleLabel];
    
    
    CGFloat lineX = CGRectGetMaxX(self.bounds) - 1.0f;
    CGFloat lineY = 0;
    CGFloat lineW = 0.5f;
    CGFloat lineH = CGRectGetHeight(self.bounds);
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
    line.backgroundColor = [[UIColor dx_C7C7C7Color] colorWithAlphaComponent:0.5];
    [self addSubview:line];
    
    CGFloat HlineX = 0;
    CGFloat HlineY = CGRectGetMaxY(self.bounds);
    CGFloat HlineW = CGRectGetWidth(self.bounds);
    CGFloat HlineH = 0.5f;
    UIView *Hline = [[UIView alloc] initWithFrame:CGRectMake(HlineX, HlineY, HlineW, HlineH)];
    Hline.backgroundColor = [[UIColor dx_C7C7C7Color] colorWithAlphaComponent:0.5];
    [self addSubview:Hline];
    
    UIView *tapView = [[UIView alloc] initWithFrame:self.bounds];
    tapView.backgroundColor = [UIColor clearColor];
    tapView.userInteractionEnabled = YES;
    [self addSubview:tapView];
    
    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItems)];
    [tapView addGestureRecognizer:TapGesture];
}

- (void)tapItems
{
    if (_delegate && [_delegate respondsToSelector:@selector(itemsTapAction:)]) {
        [_delegate itemsTapAction:self.title];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
