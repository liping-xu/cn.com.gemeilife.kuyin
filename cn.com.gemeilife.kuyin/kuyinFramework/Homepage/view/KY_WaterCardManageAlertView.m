//
//  KY_WaterCardManageAlertView.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/23.
//

#import "KY_WaterCardManageAlertView.h"

@interface KY_WaterCardManageAlertView()

@property (nonatomic,weak) UILabel *waterCardNumContentLabel;
@property (nonatomic,weak) UITextField *rechagreContentTextField;

@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *itemLabelArray;

@end

@implementation KY_WaterCardManageAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    CGFloat margin = 10.0f;
    CGFloat viewW = self.frame.size.width - margin * 2;
    
    CGFloat waterCardNumY = margin;
    CGFloat waterCardNumW = 70.0f;
    CGFloat waterCardNumX = viewW * 0.5 - waterCardNumW;
    CGFloat waterCardNumH = 44.0f;
    UILabel *waterCardNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(waterCardNumX, waterCardNumY, waterCardNumW, waterCardNumH)];
//    [waterCardNumLabel setTexts:@[@"卡号: ", @"13872003255"] warp:NO spacing:0.0f];
    waterCardNumLabel.text = @"水卡编号";
    waterCardNumLabel.textColor = [UIColor dx_666666Color];
    waterCardNumLabel.font = DFont(14);
    waterCardNumLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:waterCardNumLabel];
    
    
    CGFloat waterCardNumContentY = margin;
    CGFloat waterCardNumContentX = CGRectGetMaxX(waterCardNumLabel.frame);
    CGFloat waterCardNumContentW = viewW - waterCardNumContentX;
    CGFloat waterCardNumContentH = 44.0f;
    UILabel *waterCardNumContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(waterCardNumContentX, waterCardNumContentY, waterCardNumContentW, waterCardNumContentH)];
    waterCardNumContentLabel.adjustsFontSizeToFitWidth = YES;
    waterCardNumContentLabel.textColor = [UIColor dx_333333Color];
    waterCardNumContentLabel.font = DFont(14);
    waterCardNumContentLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:waterCardNumContentLabel];
    self.waterCardNumContentLabel = waterCardNumContentLabel;
    
    
    CGFloat rechagreY = CGRectGetMaxY(waterCardNumLabel.frame);
    CGFloat rechagreW = 70.0f;
    CGFloat rechagreX = viewW * 0.5 - waterCardNumW;
    CGFloat rechagreH = 44.0f;
    UILabel *rechagreLabel = [[UILabel alloc] initWithFrame:CGRectMake(rechagreX, rechagreY, rechagreW, rechagreH)];
//    [waterCardNumLabel setTexts:@[@"卡号: ", @"13872003255"] warp:NO spacing:0.0f];
    rechagreLabel.text = @"充值金额";
    rechagreLabel.textColor = [UIColor dx_666666Color];
    rechagreLabel.font = DFont(14);
    rechagreLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:rechagreLabel];
    
    CGFloat yuanW = 20.0f;
    
    CGFloat rechagreTextFieldX = CGRectGetMaxX(rechagreLabel.frame);
    CGFloat rechagreTextFieldY = rechagreY + margin;

    CGFloat rechagreTextFieldW = viewW -rechagreTextFieldX - yuanW;
    
    
    CGFloat rechagreTextFieldH = 24.0f;
    UITextField *rechagreContentTextField = [[UITextField alloc] initWithFrame:CGRectMake(rechagreTextFieldX, rechagreTextFieldY, rechagreTextFieldW, rechagreTextFieldH)];
    rechagreContentTextField.textColor = [UIColor dx_666666Color];
    rechagreContentTextField.backgroundColor = [UIColor clearColor];
    rechagreContentTextField.keyboardType = UIKeyboardTypeDefault;
    rechagreContentTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, margin)];
    rechagreContentTextField.leftViewMode = UITextFieldViewModeAlways;
//    TextField.returnKeyType = UIReturnKeyDone;
    [rechagreContentTextField setValue:[UIColor dx_C7C7C7Color] forKeyPath:@"placeholderLabel.textColor"];
    [rechagreContentTextField setValue:DFont(14) forKeyPath:@"placeholderLabel.font"];
    rechagreContentTextField.layer.borderWidth = 0.5f;
    rechagreContentTextField.layer.borderColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3f] CGColor];
    rechagreContentTextField.layer.cornerRadius = 4.0f;
    rechagreContentTextField.layer.masksToBounds = YES;
    [rechagreContentTextField addTarget:self action:@selector(rechagreContentTextFieldWithText:)forControlEvents:UIControlEventEditingChanged];
    rechagreContentTextField.tag = 30001;
    [self addSubview:rechagreContentTextField];
    self.rechagreContentTextField = rechagreContentTextField;
    
    CGFloat rechagreYuanY = CGRectGetMaxY(waterCardNumLabel.frame);
    CGFloat rechagreYuanX = CGRectGetMaxX(rechagreContentTextField.frame) + margin * 0.5;
    CGFloat rechagreYuanH = 44.0f;
    UILabel *rechagreYuanLabel = [[UILabel alloc] initWithFrame:CGRectMake(rechagreYuanX, rechagreYuanY, yuanW, rechagreYuanH)];
//    [waterCardNumLabel setTexts:@[@"卡号: ", @"13872003255"] warp:NO spacing:0.0f];
    rechagreYuanLabel.text = @"元";
    rechagreYuanLabel.textColor = [UIColor dx_666666Color];
    rechagreYuanLabel.font = DFont(14);
    rechagreYuanLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:rechagreYuanLabel];
    
    
    
    
    
    
    
    
    
    
    CGFloat moneyY = CGRectGetMaxY(rechagreLabel.frame);
    CGFloat moneyW = 70.0f;
    CGFloat moneyX = viewW * 0.5 - waterCardNumW;
    CGFloat moneyH = 44.0f;
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyX, moneyY, moneyW, moneyH)];
//    [waterCardNumLabel setTexts:@[@"卡号: ", @"13872003255"] warp:NO spacing:0.0f];
    moneyLabel.text = @"实收金额";
    moneyLabel.textColor = [UIColor dx_666666Color];
    moneyLabel.font = DFont(14);
    moneyLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:moneyLabel];
    
}

//自定义代理方法
-(void)rechagreContentTextFieldWithText:(UITextField *)textField
{
//    //设置 实收金额Label的文字
//    if ([self.model.title isEqualToString:@"充值金额"]) {
//        [self setActualLabelTextWithRecharge:textField.text WithGift:@"" withIsItem:NO];
//    }
    
//    if (_delegate && [_delegate respondsToSelector:@selector(kY_HomePage_CreatCard_CellTextFieldAction:)]) {
//        [_delegate kY_HomePage_CreatCard_CellTextFieldAction:self];
//    }
    
}

- (void)setCell:(KY_HomePage_waterCardManage_Cell *)cell
{
    NSString *waterCardNumberStr = [NSString stringWithFormat:@"%@", cell.model.cardNo];
    self.waterCardNumContentLabel.text = waterCardNumberStr;
//    [self.waterCardNumLabel setTexts:@[@"卡号: ", waterCardNumberStr] colors:@[[UIColor dx_666666Color], [UIColor dx_333333Color]] warp:NO spacing:0.01f];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
