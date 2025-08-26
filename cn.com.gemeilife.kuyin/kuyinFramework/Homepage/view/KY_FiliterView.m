//
//  KY_FiliterView.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/16.
//

#import "KY_FiliterView.h"
#import "WXZPickDateView.h"
#import "WXZPickDateTimeView.h"


@interface KY_FiliterView () <UITextFieldDelegate, PickerDateViewDelegate,PickerDateTimeViewDelegate>


@property (nonatomic,assign) CGFloat typeViewH;

//开始时间
@property (nonatomic,weak) UIButton *dateBeginButton;
//结束时间
@property (nonatomic,weak) UIButton *dateEndButton;
//按月查询的button
@property (nonatomic,weak) UIButton *monthButton;

@property (nonatomic,weak) UITextField *minWaterTextField;
@property (nonatomic,weak) UITextField *maxWaterTextField;
@property (nonatomic,weak) UITextField *moneyMinWaterTextField;
@property (nonatomic,weak) UITextField *moneyMaxWaterTextField;

//type = 1的时候typeView的数组
@property (nonatomic,strong) NSMutableArray *waterButtonArray;
@property (nonatomic,strong) UIButton *selectWaterButton;

//type = 2的时候typeView的数组
@property (nonatomic,strong) NSMutableArray *tradeButtonArray;
@property (nonatomic,strong) UIButton *selectTradeButton;

@property (nonatomic,strong) NSMutableArray *payButtonArray;
@property (nonatomic,strong) UIButton *selectPayButton;

@property (nonatomic,weak) WXZPickDateView *pickDateView;

@end


@implementation KY_FiliterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:0xF3F3F3];
    }
    return self;
}

- (void)setType:(NSInteger)type
{
    _type = type;
    //0 不显示类型
    if (type == 0) {
        self.typeViewH = [UIDevice vg_statusBarHeight];
    }
    
    //0 打水类型
    if (type == 1) {
        self.typeViewH = 160.0f;
    }
    
    //0 交易类型
    if (type == 2) {
        self.typeViewH = 280.0f;
    }
    
    [self configUIWithType:self.type];
}


- (void)configUIWithType:(NSInteger)type
{
    [self createdTypeView:type];
    [self createdTimeAreaWithY:self.typeViewH];
}

- (void)createdTypeView:(NSInteger)type
{
    CGFloat typeX = 0.0f;
    CGFloat typeY = 0.0f;
    CGFloat typeW = self.frame.size.width;
    CGFloat typeH = self.typeViewH;
    UIView *typeView = [[UIView alloc] initWithFrame:CGRectMake(typeX, typeY, typeW, typeH)];
    typeView.backgroundColor = [UIColor whiteColor];
    [self addSubview:typeView];
    
    if (type == 0) {
        
    }

    if (type == 1) {
        [self waterTypebuttonViewWithTypeView:typeView];
    }
    
    if (type == 2) {
        [self tradeTypebuttonViewWithTypeView:typeView];
    }
    
}

- (void)waterTypebuttonViewWithTypeView:(UIView *)typeView
{
    CGFloat margin = 10.0f;
    CGFloat viewW = typeView.frame.size.width;
    CGFloat typeLabelX = margin;
    CGFloat typeLabelY = [UIDevice vg_statusBarHeight];
    CGFloat typeLabelW = viewW - margin * 2;
    CGFloat typeLabelH = 44.0f;
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(typeLabelX, typeLabelY, typeLabelW, typeLabelH)];
    typeLabel.text = @"打水类型";
    typeLabel.textColor = [UIColor dx_333333Color];
    typeLabel.textAlignment = NSTextAlignmentLeft;
    typeLabel.font = DFont(16);
    [typeView addSubview:typeLabel];
    
    CGFloat marginY = CGRectGetMaxY(typeLabel.frame);
    
    NSArray *buttonArray = @[@"全部", @"扫码打水", @"刷卡打水", @"电子水卡", @"投币打水", @"运营商打水"];
    CGFloat buttonW = (viewW - margin * 2) * 0.3;
    CGFloat buttonH = 24.0f;
    self.waterButtonArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < buttonArray.count; i++) {
        NSInteger row = i / 3;
        NSInteger low = i % 3;
        CGFloat buttonX = margin + low * (margin + buttonW);
        CGFloat buttonY = row * (buttonH + margin) + marginY;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.titleLabel.font = DFont(12);
        [button setTitle:buttonArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor dx_999999Color] forState:UIControlStateNormal];
        button.layer.borderWidth = 1.0f;
//        button.layer.borderColor = [[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] CGColor];
        
        if (i == 0) {
            button.selected = YES;
            button.layer.borderColor = [[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] CGColor];
            self.selectWaterButton = button;
        } else {
            button.layer.borderColor = [[UIColor dx_999999Color] CGColor];
        }
        
        button.layer.cornerRadius = buttonH * 0.5;
        button.layer.masksToBounds = YES;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        // 假设button是你想要修改的UIButton实例
//        button.titleLabel.font = [UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize];
        [button addTarget:self action:@selector(waterButtonViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [typeView addSubview:button];
        [self.waterButtonArray addObject:button];
    }
}

- (void)waterButtonViewAction:(UIButton *)sender
{
    self.selectWaterButton = sender;
    for (UIButton *button in self.waterButtonArray) {
        if (self.selectWaterButton != button) {
            button.selected = NO;
            button.layer.borderColor = [[UIColor dx_999999Color] CGColor];
        } else {
            button.selected = YES;
            button.layer.borderColor = [[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] CGColor];
        }
    }
}

- (void)tradeTypebuttonViewWithTypeView:(UIView *)typeView
{
    CGFloat margin = 10.0f;
    CGFloat viewW = typeView.frame.size.width;
    CGFloat typeLabelX = margin;
    CGFloat typeLabelY = [UIDevice vg_statusBarHeight];
    CGFloat typeLabelW = viewW - margin * 2;
    CGFloat typeLabelH = 44.0f;
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(typeLabelX, typeLabelY, typeLabelW, typeLabelH)];
    typeLabel.text = @"交易类型";
    typeLabel.textColor = [UIColor dx_333333Color];
    typeLabel.textAlignment = NSTextAlignmentLeft;
    typeLabel.font = DFont(16);
    [typeView addSubview:typeLabel];
    
    CGFloat marginY = CGRectGetMaxY(typeLabel.frame);
    
    NSArray *buttonArray = @[@"全部", @"实体卡充值", @"投币", @"扫码打水", @"电子水卡充值"];
    CGFloat buttonW = (viewW - margin * 2) * 0.3;
    CGFloat buttonH = 24.0f;
    self.tradeButtonArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < buttonArray.count; i++) {
        NSInteger row = i / 3;
        NSInteger low = i % 3;
        CGFloat buttonX = margin + low * (margin + buttonW);
        CGFloat buttonY = row * (buttonH + margin) + marginY;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.titleLabel.font = DFont(12);
        [button setTitle:buttonArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor dx_999999Color] forState:UIControlStateNormal];
        button.layer.borderWidth = 1.0f;
        if (i == 0) {
            button.selected = YES;
            button.layer.borderColor = [[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] CGColor];
            self.selectTradeButton = button;
        } else {
            button.layer.borderColor = [[UIColor dx_999999Color] CGColor];
        }
        
        button.layer.cornerRadius = buttonH * 0.5;
        button.layer.masksToBounds = YES;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        // 假设button是你想要修改的UIButton实例
//        button.titleLabel.font = [UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize];
        [button addTarget:self action:@selector(tradeButtonViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [typeView addSubview:button];
        [self.tradeButtonArray addObject:button];
    }
    
    CGFloat payLabelX = margin;
    CGFloat payLabelY = marginY + (buttonH + margin) * 2;
    CGFloat payLabelW = viewW - margin * 2;
    CGFloat payLabelH = 44.0f;
    
    UILabel *payLabel = [[UILabel alloc] initWithFrame:CGRectMake(payLabelX, payLabelY, payLabelW, payLabelH)];
    payLabel.text = @"支付方式";
    payLabel.textColor = [UIColor dx_333333Color];
    payLabel.textAlignment = NSTextAlignmentLeft;
    payLabel.font = DFont(16);
    [typeView addSubview:payLabel];
    
    
    CGFloat payMarginY = CGRectGetMaxY(payLabel.frame);
    NSArray *payButtonArray = @[@"全部", @"微信", @"支付宝", @"APP直充", @"投币", @"自动充值"];
    self.payButtonArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < payButtonArray.count; i++) {
        NSInteger row = i / 3;
        NSInteger low = i % 3;
        CGFloat buttonX = margin + low * (margin + buttonW);
        CGFloat buttonY = row * (buttonH + margin) + payMarginY;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.titleLabel.font = DFont(12);
        [button setTitle:payButtonArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor dx_999999Color] forState:UIControlStateNormal];
        button.layer.borderWidth = 1.0f;
        if (i == 0) {
            button.selected = YES;
            button.layer.borderColor = [[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] CGColor];
            self.selectPayButton = button;
        } else {
            button.layer.borderColor = [[UIColor dx_999999Color] CGColor];
        }
        
        button.layer.cornerRadius = buttonH * 0.5;
        button.layer.masksToBounds = YES;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        // 假设button是你想要修改的UIButton实例
//        button.titleLabel.font = [UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize];
        [button addTarget:self action:@selector(payButtonViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [typeView addSubview:button];
        [self.payButtonArray addObject:button];
    }
    
}

- (void)payButtonViewAction:(UIButton *)sender
{
    self.selectPayButton = sender;
    for (UIButton *button in self.payButtonArray) {
        if (self.selectPayButton != button) {
            button.selected = NO;
            button.layer.borderColor = [[UIColor dx_999999Color] CGColor];
        } else {
            button.selected = YES;
            button.layer.borderColor = [[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] CGColor];
        }
    }
}


- (void)tradeButtonViewAction:(UIButton *)sender
{
    self.selectTradeButton = sender;
    for (UIButton *button in self.tradeButtonArray) {
        if (self.selectTradeButton != button) {
            button.selected = NO;
            button.layer.borderColor = [[UIColor dx_999999Color] CGColor];
        } else {
            button.selected = YES;
            button.layer.borderColor = [[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] CGColor];
        }
    }
}




- (void)createdTimeAreaWithY:(CGFloat)viewY
{
    CGFloat margin = 10.0f;
    CGFloat tradeViewX = 0.0f;
    CGFloat tradeiewY = viewY + margin;
    CGFloat tradeViewW = self.frame.size.width;
    CGFloat tradeViewH = 180.0;
    UIView *tradeView = [[UIView alloc] initWithFrame:CGRectMake(tradeViewX, tradeiewY, tradeViewW, tradeViewH)];
    tradeView.backgroundColor = [UIColor whiteColor];
    [self addSubview:tradeView];
    
    CGFloat tradeLabelX = margin;
    CGFloat tradeLabelY = margin;
    CGFloat tradeLabelW = tradeViewW - margin * 2;
    CGFloat tradeLabelH = 44.0f;
    UILabel *tradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(tradeLabelX, tradeLabelY, tradeLabelW, tradeLabelH)];
    tradeLabel.text = @"交易时间";
    tradeLabel.textColor = [UIColor dx_333333Color];
    tradeLabel.textAlignment = NSTextAlignmentLeft;
    tradeLabel.font = DFont(16);
    [tradeView addSubview:tradeLabel];
    
    CGFloat dateBeginLabelX = margin;
    CGFloat dateBeginLabelY = CGRectGetMaxY(tradeLabel.frame);
    CGFloat dateBeginLabelW = 60.0f;
    CGFloat dateBeginLabelH = 44.0f;
    UILabel *dateBeginLabel = [[UILabel alloc] initWithFrame:CGRectMake(dateBeginLabelX, dateBeginLabelY, dateBeginLabelW, dateBeginLabelH)];
    dateBeginLabel.text = @"开始时间";
    dateBeginLabel.textColor = [UIColor dx_333333Color];
    dateBeginLabel.textAlignment = NSTextAlignmentLeft;
    dateBeginLabel.font = DFont(14);
    [tradeView addSubview:dateBeginLabel];
    
    
    //第一行 开始日期的Button
    CGFloat dateBeginButtonX = CGRectGetMaxX(dateBeginLabel.frame);
    CGFloat dateBeginButtonH = 24.0f;
    CGFloat dateBeginButtonY = CGRectGetMidY(dateBeginLabel.frame) - dateBeginButtonH * 0.5;
    CGFloat dateBeginButtonW = tradeViewW - dateBeginButtonX - margin;
    UIButton * dateBeginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dateBeginButton.frame = CGRectMake(dateBeginButtonX, dateBeginButtonY, dateBeginButtonW, dateBeginButtonH);
    dateBeginButton.backgroundColor = [UIColor clearColor];
//    [datebeginButton setImage:IMAGE(@"calc") forState:UIControlStateNormal];
    [dateBeginButton setTitle:@"不限" forState:UIControlStateNormal];
    dateBeginButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    dateBeginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    dateBeginButton.titleLabel.font = DFont(14);
    [dateBeginButton setTitleColor:[UIColor dx_666666Color] forState:UIControlStateNormal];
    dateBeginButton.layer.borderWidth = 1.0f;
    dateBeginButton.layer.borderColor = [[UIColor dx_999999Color] CGColor];
    dateBeginButton.layer.cornerRadius = dateBeginButtonH * 0.5;
    dateBeginButton.layer.masksToBounds = YES;
    [dateBeginButton addTarget:self action:@selector(datebeginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [tradeView addSubview:dateBeginButton];
    self.dateBeginButton = dateBeginButton;
    
    
    CGFloat dateEndLabelX = margin;
    CGFloat dateEndLabelY = CGRectGetMaxY(dateBeginLabel.frame);
    CGFloat dateEndLabelW = 60.0f;
    CGFloat dateEndLabelH = 44.0f;
    UILabel *dateEndLabel = [[UILabel alloc] initWithFrame:CGRectMake(dateEndLabelX, dateEndLabelY, dateEndLabelW, dateEndLabelH)];
    dateEndLabel.text = @"结束时间";
    dateEndLabel.textColor = [UIColor dx_333333Color];
    dateEndLabel.textAlignment = NSTextAlignmentLeft;
    dateEndLabel.font = DFont(14);
    [tradeView addSubview:dateEndLabel];
    
    
    //第二行 结束日期的Button
    CGFloat dateEndButtonX = CGRectGetMaxX(dateEndLabel.frame);
    CGFloat dateEndButtonH = 24.0f;
    CGFloat dateEndButtonY = CGRectGetMidY(dateEndLabel.frame) - dateEndButtonH * 0.5;
    CGFloat dateEndButtonW = tradeViewW - dateBeginButtonX - margin;
    UIButton *dateEndButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dateEndButton.frame = CGRectMake(dateEndButtonX, dateEndButtonY, dateEndButtonW, dateEndButtonH);
    dateEndButton.backgroundColor = [UIColor clearColor];
//    [datebeginButton setImage:IMAGE(@"calc") forState:UIControlStateNormal];
    [dateEndButton setTitle:@"不限" forState:UIControlStateNormal];
    dateEndButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    dateEndButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    dateEndButton.titleLabel.font = DFont(14);
    [dateEndButton setTitleColor:[UIColor dx_666666Color] forState:UIControlStateNormal];
    dateEndButton.layer.borderWidth = 1.0f;
    dateEndButton.layer.borderColor = [[UIColor dx_999999Color] CGColor];
    dateEndButton.layer.cornerRadius = dateEndButtonH * 0.5;
    dateEndButton.layer.masksToBounds = YES;
    [dateEndButton addTarget:self action:@selector(dateEndButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [tradeView addSubview:dateEndButton];
    self.dateEndButton = dateEndButton;
    
    
    //第三行 按月查询的Button
    CGFloat monthButtonX = margin;
    CGFloat monthButtonY = CGRectGetMaxY(dateEndLabel.frame);
    CGFloat monthButtonW = tradeLabelW - margin;
    CGFloat monthButtonH = 44.0f;
    UIButton *monthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    monthButton.frame = CGRectMake(monthButtonX, monthButtonY, monthButtonW, monthButtonH);
    monthButton.backgroundColor = [UIColor clearColor];
//    [datebeginButton setImage:IMAGE(@"calc") forState:UIControlStateNormal];
    [monthButton setTitle:@"按月查询->选择月份" forState:UIControlStateNormal];
    monthButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    monthButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    monthButton.titleLabel.font = DFont(14);
    [monthButton setTitleColor:[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
    [monthButton addTarget:self action:@selector(monthButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [tradeView addSubview:monthButton];
    self.monthButton = monthButton;
    
    CGFloat waterY = tradeViewH + viewY + margin + margin;
    CGFloat waterX = 0.0f;
    CGFloat waterW = self.frame.size.width;
    CGFloat waterH = 180.0f;
    
    if (self.type == 2) {
        waterH = 90.0f;
    }
    
    UIView *waterView = [[UIView alloc] initWithFrame:CGRectMake(waterX, waterY, waterW, waterH)];
    waterView.backgroundColor = [UIColor whiteColor];
    [self addSubview:waterView];
    
    if (self.type == 2) {
        [self createdTradeTimeViewType2WithView:waterView];
    } else {
        [self createdTradeTimeViewWithView:waterView];
    }
    
    CGFloat buttonViewY = CGRectGetMaxY(waterView.frame);
    UIView *buttonView = [self buttonFooterViewWithY:buttonViewY];
    [self addSubview:buttonView];
}
//type = 2 时 tradeView
- (void)createdTradeTimeViewType2WithView:(UIView *)waterView
{
    CGFloat margin = 10.0f;
    CGFloat tradeViewW = self.frame.size.width -  margin * 2;
    
    CGFloat moneyLabelX = margin;
    CGFloat moneyLabelY = margin;
    CGFloat moneyLabelW = tradeViewW - margin * 2;
    CGFloat moneyLabelH = 44.0f;
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyLabelX, moneyLabelY, moneyLabelW, moneyLabelH)];
    moneyLabel.text = @"金额区间(单位元)";
    moneyLabel.textColor = [UIColor dx_333333Color];
    moneyLabel.textAlignment = NSTextAlignmentLeft;
    moneyLabel.font = DFont(16);
    [waterView addSubview:moneyLabel];
    
    
    CGFloat moneyLineW = margin;
    
    CGFloat moneyMinWaterTextFieldX = margin;
    CGFloat moneyMinWaterTextFieldY = CGRectGetMaxY(moneyLabel.frame);
    CGFloat moneyMinWaterTextFieldW = (tradeViewW - margin) * 0.5 - moneyLineW;
    CGFloat moneyMinWaterTextFieldH = 24.0f;
    UITextField *moneyMinWaterTextField = [[UITextField alloc] initWithFrame:CGRectMake(moneyMinWaterTextFieldX, moneyMinWaterTextFieldY, moneyMinWaterTextFieldW, moneyMinWaterTextFieldH)];
    moneyMinWaterTextField.textColor = [UIColor dx_333333Color];
    moneyMinWaterTextField.backgroundColor = [UIColor clearColor];
    moneyMinWaterTextField.keyboardType = UIKeyboardTypeDefault;
    //设置 placeHolder文本 居中
    NSMutableAttributedString *moneyMinWaterTextFieldAttributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"最低金额"];
    NSMutableParagraphStyle *moneyMinWaterTextFieldParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    moneyMinWaterTextFieldParagraphStyle.alignment = NSTextAlignmentCenter; // 设置对齐方式为居中
    [moneyMinWaterTextFieldAttributedPlaceholder addAttribute:NSParagraphStyleAttributeName value:moneyMinWaterTextFieldParagraphStyle range:NSMakeRange(0, moneyMinWaterTextFieldAttributedPlaceholder.length)];
    moneyMinWaterTextField.attributedPlaceholder = moneyMinWaterTextFieldAttributedPlaceholder;
    [moneyMinWaterTextField setValue:[UIColor dx_666666Color] forKeyPath:@"placeholderLabel.textColor"];
    [moneyMinWaterTextField setValue:DFont(12) forKeyPath:@"placeholderLabel.font"];
    moneyMinWaterTextField.layer.borderWidth = 1.0f;
    moneyMinWaterTextField.layer.borderColor = [[UIColor dx_999999Color] CGColor];
    moneyMinWaterTextField.layer.cornerRadius = 8.0f;
    moneyMinWaterTextField.layer.masksToBounds = YES;
    moneyMinWaterTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    moneyMinWaterTextField.leftViewMode = UITextFieldViewModeAlways;
    [moneyMinWaterTextField addTarget:self action:@selector(textFieldWithText:)forControlEvents:UIControlEventEditingChanged];
    moneyMinWaterTextField.tag = 50003;
    moneyMinWaterTextField.delegate = self;
    [waterView addSubview:moneyMinWaterTextField];
    self.moneyMinWaterTextField = moneyMinWaterTextField;
    
    CGFloat moneyLineX = CGRectGetMaxX(moneyMinWaterTextField.frame) + margin;
    CGFloat moneyLineY = CGRectGetMidY(moneyMinWaterTextField.frame);
    CGFloat moneyLineH = 1.0f;
    UIView *moneyLineView = [[UIView alloc] initWithFrame:CGRectMake(moneyLineX, moneyLineY, moneyLineW, moneyLineH)];
    moneyLineView.backgroundColor = [UIColor dx_333333Color];
    [waterView addSubview:moneyLineView];
    
    
    CGFloat moneyMaxWaterTextFieldX = CGRectGetMaxX(moneyLineView.frame) + margin;
    CGFloat moneyMaxWaterTextFieldY = moneyMinWaterTextFieldY;
    CGFloat moneyMaxWaterTextFieldW = (tradeViewW - margin) * 0.5 - moneyLineW;
    CGFloat moneyMaxWaterTextFieldH = 24.0f;
    UITextField *moneyMaxWaterTextField = [[UITextField alloc] initWithFrame:CGRectMake(moneyMaxWaterTextFieldX, moneyMaxWaterTextFieldY, moneyMaxWaterTextFieldW, moneyMaxWaterTextFieldH)];
    moneyMaxWaterTextField.textColor = [UIColor dx_333333Color];
    moneyMaxWaterTextField.backgroundColor = [UIColor clearColor];
    moneyMaxWaterTextField.keyboardType = UIKeyboardTypeDefault;
    
    NSMutableAttributedString *moneyMaxAttributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"最高金额"];
    NSMutableParagraphStyle *moneyMaxParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    moneyMaxParagraphStyle.alignment = NSTextAlignmentCenter; // 设置对齐方式为居中
    [moneyMaxAttributedPlaceholder addAttribute:NSParagraphStyleAttributeName value:moneyMaxParagraphStyle range:NSMakeRange(0, moneyMaxAttributedPlaceholder.length)];
    
    moneyMaxWaterTextField.attributedPlaceholder = moneyMaxAttributedPlaceholder;
    [moneyMaxWaterTextField setValue:[UIColor dx_666666Color] forKeyPath:@"placeholderLabel.textColor"];
    [moneyMaxWaterTextField setValue:DFont(12) forKeyPath:@"placeholderLabel.font"];
    moneyMaxWaterTextField.layer.borderWidth = 1.0f;
    moneyMaxWaterTextField.layer.borderColor = [[UIColor dx_999999Color] CGColor];
    moneyMaxWaterTextField.layer.cornerRadius = 8.0f;
    moneyMaxWaterTextField.layer.masksToBounds = YES;
    moneyMaxWaterTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    moneyMaxWaterTextField.leftViewMode = UITextFieldViewModeAlways;
    [moneyMaxWaterTextField addTarget:self action:@selector(textFieldWithText:)forControlEvents:UIControlEventEditingChanged];
    moneyMaxWaterTextField.tag = 50004;
    moneyMaxWaterTextField.delegate = self;
    [waterView addSubview:moneyMaxWaterTextField];
    self.moneyMaxWaterTextField = moneyMaxWaterTextField;
    
}

//type != 2 时 tradeView
- (void)createdTradeTimeViewWithView:(UIView *)waterView
{

    CGFloat margin = 10.0f;
    CGFloat tradeViewW = self.frame.size.width;
    CGFloat waterLabelX = margin;
    CGFloat waterLabelY = margin;
    CGFloat waterLabelW = tradeViewW - margin * 2;
    CGFloat waterLabelH = 44.0f;
    UILabel *waterLabel = [[UILabel alloc] initWithFrame:CGRectMake(waterLabelX, waterLabelY, waterLabelW, waterLabelH)];
    waterLabel.text = @"打水量区间(单位升)";
    waterLabel.textColor = [UIColor dx_333333Color];
    waterLabel.textAlignment = NSTextAlignmentLeft;
    waterLabel.font = DFont(16);
    [waterView addSubview:waterLabel];
    
    CGFloat lineW = margin;
    
    CGFloat minWaterTextFieldX = margin;
    CGFloat minWaterTextFieldY = CGRectGetMaxY(waterLabel.frame);
    CGFloat minWaterTextFieldW = (waterLabelW - margin) * 0.5 - lineW;
    CGFloat minWaterTextFieldH = 24.0f;
    UITextField *minWaterTextField = [[UITextField alloc] initWithFrame:CGRectMake(minWaterTextFieldX, minWaterTextFieldY, minWaterTextFieldW, minWaterTextFieldH)];
    minWaterTextField.textColor = [UIColor dx_333333Color];
    minWaterTextField.backgroundColor = [UIColor clearColor];
    minWaterTextField.keyboardType = UIKeyboardTypeDefault;
    //设置 placeHolder文本 居中
    NSMutableAttributedString *attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"最低打水量"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter; // 设置对齐方式为居中
    [attributedPlaceholder addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedPlaceholder.length)];
    minWaterTextField.attributedPlaceholder = attributedPlaceholder;
    [minWaterTextField setValue:[UIColor dx_666666Color] forKeyPath:@"placeholderLabel.textColor"];
    [minWaterTextField setValue:DFont(12) forKeyPath:@"placeholderLabel.font"];
    minWaterTextField.layer.borderWidth = 1.0f;
    minWaterTextField.layer.borderColor = [[UIColor dx_999999Color] CGColor];
    minWaterTextField.layer.cornerRadius = 8.0f;
    minWaterTextField.layer.masksToBounds = YES;
    minWaterTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    minWaterTextField.leftViewMode = UITextFieldViewModeAlways;
    [minWaterTextField addTarget:self action:@selector(textFieldWithText:)forControlEvents:UIControlEventEditingChanged];
    minWaterTextField.tag = 50001;
    minWaterTextField.delegate = self;
    [waterView addSubview:minWaterTextField];
    self.minWaterTextField = minWaterTextField;
    
    CGFloat lineX = CGRectGetMaxX(minWaterTextField.frame) + margin;
    CGFloat lineY = CGRectGetMidY(minWaterTextField.frame);
    CGFloat lineH = 1.0f;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
    lineView.backgroundColor = [UIColor dx_333333Color];
    [waterView addSubview:lineView];
    
    CGFloat maxWaterTextFieldX = CGRectGetMaxX(lineView.frame) + margin;
    CGFloat maxWaterTextFieldY = minWaterTextFieldY;
    CGFloat maxWaterTextFieldW = (waterLabelW - margin) * 0.5 - lineW;
    CGFloat maxWaterTextFieldH = 24.0f;
    UITextField *maxWaterTextField = [[UITextField alloc] initWithFrame:CGRectMake(maxWaterTextFieldX, maxWaterTextFieldY, maxWaterTextFieldW, maxWaterTextFieldH)];
    maxWaterTextField.textColor = [UIColor dx_333333Color];
    maxWaterTextField.backgroundColor = [UIColor clearColor];
    maxWaterTextField.keyboardType = UIKeyboardTypeDefault;
    
    NSMutableAttributedString *maxAttributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"最高打水量"];
    NSMutableParagraphStyle *maxParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    maxParagraphStyle.alignment = NSTextAlignmentCenter; // 设置对齐方式为居中
    [maxAttributedPlaceholder addAttribute:NSParagraphStyleAttributeName value:maxParagraphStyle range:NSMakeRange(0, maxAttributedPlaceholder.length)];
    maxWaterTextField.attributedPlaceholder = maxAttributedPlaceholder;
    [maxWaterTextField setValue:[UIColor dx_666666Color] forKeyPath:@"placeholderLabel.textColor"];
    [maxWaterTextField setValue:DFont(12) forKeyPath:@"placeholderLabel.font"];
    maxWaterTextField.layer.borderWidth = 1.0f;
    maxWaterTextField.layer.borderColor = [[UIColor dx_999999Color] CGColor];
    maxWaterTextField.layer.cornerRadius = 8.0f;
    maxWaterTextField.layer.masksToBounds = YES;
    maxWaterTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    maxWaterTextField.leftViewMode = UITextFieldViewModeAlways;
    [maxWaterTextField addTarget:self action:@selector(textFieldWithText:)forControlEvents:UIControlEventEditingChanged];
    maxWaterTextField.tag = 50002;
    maxWaterTextField.delegate = self;
    [waterView addSubview:maxWaterTextField];
    self.maxWaterTextField = maxWaterTextField;
    
    
    CGFloat moneyLabelX = margin;
    CGFloat moneyLabelY = CGRectGetMaxY(minWaterTextField.frame) + margin;
    CGFloat moneyLabelW = tradeViewW - margin * 2;
    CGFloat moneyLabelH = 44.0f;
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyLabelX, moneyLabelY, moneyLabelW, moneyLabelH)];
    moneyLabel.text = @"金额区间(单位元)";
    moneyLabel.textColor = [UIColor dx_333333Color];
    moneyLabel.textAlignment = NSTextAlignmentLeft;
    moneyLabel.font = DFont(16);
    [waterView addSubview:moneyLabel];
    
    
    CGFloat moneyLineW = margin;
    
    CGFloat moneyMinWaterTextFieldX = margin;
    CGFloat moneyMinWaterTextFieldY = CGRectGetMaxY(moneyLabel.frame);
    CGFloat moneyMinWaterTextFieldW = (waterLabelW - margin) * 0.5 - lineW;
    CGFloat moneyMinWaterTextFieldH = 24.0f;
    UITextField *moneyMinWaterTextField = [[UITextField alloc] initWithFrame:CGRectMake(moneyMinWaterTextFieldX, moneyMinWaterTextFieldY, moneyMinWaterTextFieldW, moneyMinWaterTextFieldH)];
    moneyMinWaterTextField.textColor = [UIColor dx_333333Color];
    moneyMinWaterTextField.backgroundColor = [UIColor clearColor];
    moneyMinWaterTextField.keyboardType = UIKeyboardTypeDefault;
    //设置 placeHolder文本 居中
    NSMutableAttributedString *moneyMinWaterTextFieldAttributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"最低金额"];
    NSMutableParagraphStyle *moneyMinWaterTextFieldParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    moneyMinWaterTextFieldParagraphStyle.alignment = NSTextAlignmentCenter; // 设置对齐方式为居中
    [moneyMinWaterTextFieldAttributedPlaceholder addAttribute:NSParagraphStyleAttributeName value:moneyMinWaterTextFieldParagraphStyle range:NSMakeRange(0, moneyMinWaterTextFieldAttributedPlaceholder.length)];
    moneyMinWaterTextField.attributedPlaceholder = moneyMinWaterTextFieldAttributedPlaceholder;
    [moneyMinWaterTextField setValue:[UIColor dx_666666Color] forKeyPath:@"placeholderLabel.textColor"];
    [moneyMinWaterTextField setValue:DFont(12) forKeyPath:@"placeholderLabel.font"];
    moneyMinWaterTextField.layer.borderWidth = 1.0f;
    moneyMinWaterTextField.layer.borderColor = [[UIColor dx_999999Color] CGColor];
    moneyMinWaterTextField.layer.cornerRadius = 8.0f;
    moneyMinWaterTextField.layer.masksToBounds = YES;
    moneyMinWaterTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    moneyMinWaterTextField.leftViewMode = UITextFieldViewModeAlways;
    [moneyMinWaterTextField addTarget:self action:@selector(textFieldWithText:)forControlEvents:UIControlEventEditingChanged];
    moneyMinWaterTextField.tag = 50003;
    moneyMinWaterTextField.delegate = self;
    [waterView addSubview:moneyMinWaterTextField];
    self.moneyMinWaterTextField = moneyMinWaterTextField;
    
    CGFloat moneyLineX = CGRectGetMaxX(moneyMinWaterTextField.frame) + margin;
    CGFloat moneyLineY = CGRectGetMidY(moneyMinWaterTextField.frame);
    CGFloat moneyLineH = 1.0f;
    UIView *moneyLineView = [[UIView alloc] initWithFrame:CGRectMake(moneyLineX, moneyLineY, moneyLineW, moneyLineH)];
    moneyLineView.backgroundColor = [UIColor dx_333333Color];
    [waterView addSubview:moneyLineView];
    
    
    CGFloat moneyMaxWaterTextFieldX = CGRectGetMaxX(moneyLineView.frame) + margin;
    CGFloat moneyMaxWaterTextFieldY = moneyMinWaterTextFieldY;
    CGFloat moneyMaxWaterTextFieldW = (waterLabelW - margin) * 0.5 - lineW;
    CGFloat moneyMaxWaterTextFieldH = 24.0f;
    UITextField *moneyMaxWaterTextField = [[UITextField alloc] initWithFrame:CGRectMake(moneyMaxWaterTextFieldX, moneyMaxWaterTextFieldY, moneyMaxWaterTextFieldW, moneyMaxWaterTextFieldH)];
    moneyMaxWaterTextField.textColor = [UIColor dx_333333Color];
    moneyMaxWaterTextField.backgroundColor = [UIColor clearColor];
    moneyMaxWaterTextField.keyboardType = UIKeyboardTypeDefault;
    
    NSMutableAttributedString *moneyMaxAttributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"最高金额"];
    NSMutableParagraphStyle *moneyMaxParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    moneyMaxParagraphStyle.alignment = NSTextAlignmentCenter; // 设置对齐方式为居中
    [moneyMaxAttributedPlaceholder addAttribute:NSParagraphStyleAttributeName value:moneyMaxParagraphStyle range:NSMakeRange(0, moneyMaxAttributedPlaceholder.length)];
    
    moneyMaxWaterTextField.attributedPlaceholder = moneyMaxAttributedPlaceholder;
    [moneyMaxWaterTextField setValue:[UIColor dx_666666Color] forKeyPath:@"placeholderLabel.textColor"];
    [moneyMaxWaterTextField setValue:DFont(12) forKeyPath:@"placeholderLabel.font"];
    moneyMaxWaterTextField.layer.borderWidth = 1.0f;
    moneyMaxWaterTextField.layer.borderColor = [[UIColor dx_999999Color] CGColor];
    moneyMaxWaterTextField.layer.cornerRadius = 8.0f;
    moneyMaxWaterTextField.layer.masksToBounds = YES;
    moneyMaxWaterTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    moneyMaxWaterTextField.leftViewMode = UITextFieldViewModeAlways;
    [moneyMaxWaterTextField addTarget:self action:@selector(textFieldWithText:)forControlEvents:UIControlEventEditingChanged];
    moneyMaxWaterTextField.tag = 50004;
    moneyMaxWaterTextField.delegate = self;
    [waterView addSubview:moneyMaxWaterTextField];
    self.moneyMaxWaterTextField = moneyMaxWaterTextField;
}


- (UIView *)buttonFooterViewWithY:(CGFloat)buttonViewY
{
    CGFloat margin = 10.0f;
    CGFloat viewW = self.frame.size.width;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, buttonViewY, viewW, 44.0f)];
    view.backgroundColor = [UIColor clearColor];
    
    NSArray *buttonArray = @[@"重置", @"查询"];
    CGFloat buttonY = margin * 2;
    CGFloat buttonW = viewW * 0.5 - margin * 2;
    CGFloat buttonH = 24.0f;
    for (int i = 0; i < buttonArray.count; i++) {
        CGFloat buttonX = margin + i * (margin + buttonW);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.titleLabel.font = DFont(15);
        [button setTitle:buttonArray[i] forState:UIControlStateNormal];
        if (i == 0) {
            button.backgroundColor = [UIColor clearColor];
            [button setTitleColor:[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
            
        } else {
            button.backgroundColor = [UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        }
       
        button.layer.borderWidth = 1.0f;
        button.layer.borderColor = [[UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f] CGColor];
        button.layer.cornerRadius = buttonH * 0.5;
        button.layer.masksToBounds = YES;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        // 假设button是你想要修改的UIButton实例
//        button.titleLabel.font = [UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize];
        [button addTarget:self action:@selector(buttonFooterViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    return view;
}

- (void)buttonFooterViewAction:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"重置"]) {
        [self hide];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"查询"]) {
//        NSLog(@"maxWaterTextField=%@", self.maxWaterTextField.text);
//        NSLog(@"minWaterTextField=%@", self.minWaterTextField.text);
//        NSLog(@"moneyMinWaterTextField=%@", self.moneyMinWaterTextField.text);
//        NSLog(@"moneyMaxWaterTextField=%@", self.moneyMaxWaterTextField.text);

    }
    
}

//开始日期的Button
- (void)datebeginButtonAction:(UIButton *)sender
{
    WXZPickDateTimeView *pickView = [[WXZPickDateTimeView alloc] init];
    [pickView setIsAddYetSelect:NO];//是否显示至今选项
    [pickView setDefaultTSelectYear:2025 defaultSelectMonth:8 defaultSelectDay:19 defaultSelectHour:14 defaultSelectMinute:9];//设定默认显示的日期
    [pickView setDelegate:self];
    pickView.tag = 5000001;
    [pickView show];
}

//结束日期的Button
- (void)dateEndButtonAction:(UIButton *)sender
{
    WXZPickDateTimeView *pickView = [[WXZPickDateTimeView alloc] init];
    [pickView setIsAddYetSelect:NO];//是否显示至今选项
    [pickView setDefaultTSelectYear:2025 defaultSelectMonth:8 defaultSelectDay:19 defaultSelectHour:14 defaultSelectMinute:9];//设定默认显示的日期
    [pickView setDelegate:self];
    pickView.tag = 5000002;
    [pickView show];
}
// 按月查询的Button
- (void)monthButtonAction:(UIButton *)sender
{
    WXZPickDateView *pickerDate = [[WXZPickDateView alloc]init];
    [pickerDate setIsAddYetSelect:NO];//是否显示至今选项
    [pickerDate setIsShowDay:NO];//是否显示日信息
    [pickerDate setDefaultTSelectYear:2025 defaultSelectMonth:8 defaultSelectDay:19];//设定默认显示的日期
    [pickerDate setDelegate:self];
    [pickerDate show];
    self.pickDateView = pickerDate;
    
}

//自定义代理方法
-(void)textFieldWithText:(UITextField *)textField
{
    //设置 实收金额Label的文字
//    if ([self.model.title isEqualToString:@"充值金额"]) {
//        [self setActualLabelTextWithRecharge:textField.text WithGift:@"" withIsItem:NO];
//    }
//
//    if (_delegate && [_delegate respondsToSelector:@selector(kY_HomePage_CreatCard_CellTextFieldAction:)]) {
//        [_delegate kY_HomePage_CreatCard_CellTextFieldAction:self];
//    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return  [textField resignFirstResponder];
}

- (void)pickerDateView:(WXZBasePickView *)pickerDateView selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day selectHour:(NSInteger)hour selectMinute:(NSInteger)Minute
{
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-M-d HH:mm"];
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld",year,month,day,hour,Minute];
    
    NSDate *date =[dateFormat dateFromString:dateStr];
    NSDateFormatter *TimeFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [TimeFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *title = [TimeFormat stringFromDate:date];
    if (pickerDateView.tag == 5000002) {
        [self.dateEndButton setTitle:title forState:UIControlStateNormal];
    }
    if (pickerDateView.tag == 5000001) {
        [self.dateBeginButton setTitle:title forState:UIControlStateNormal];
    }
    
}

-(void)pickerDateView:(WXZBasePickView *)pickerDateView selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day
{
//    [self getDaysWithYear:yearSelected month:monthSelected]
    NSInteger maxDayinMonth = [self.pickDateView getDaysWithYear:year month:month];
    NSString *monthStr = @"";
    if (month < 10) {
        monthStr = [NSString stringWithFormat:@"0%ld", month];
    } else {
        monthStr = [NSString stringWithFormat:@"%ld", month];
    }
    
    NSString *beginMonth = [NSString stringWithFormat:@"%ld-%@-01 00:00",year,monthStr];
    NSString *endMonth = [NSString stringWithFormat:@"%ld-%@-%ld 00:00",year, monthStr, maxDayinMonth];
    [self.dateBeginButton setTitle:beginMonth forState:UIControlStateNormal];
    [self.dateEndButton setTitle:endMonth forState:UIControlStateNormal];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
