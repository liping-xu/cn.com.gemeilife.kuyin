//
//  KY_Acoount_Cell.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/9.
//

#import "KY_Account_Cell.h"
@implementation KY_Account_Cell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString*)identifier
{
    KY_Account_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KY_Account_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addAllViews];
    }
    return self;
}
- (void)addAllViews
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@interface KY_Account_MySelf_Cell ()

@property (nonatomic,weak) UIView *detailView;
@property (nonatomic,weak) UILabel *TitleLabel;
@property (nonatomic,weak) UIButton *isOnlineButton;

@end

@implementation KY_Account_MySelf_Cell

+(instancetype)KY_Account_MySelf_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    KY_Account_MySelf_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KY_Account_MySelf_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)addAllViews
{
    CGFloat margin = 10.0f;
    CGFloat viewW = UIScreenWidth - margin * 2;
    CGFloat viewH = 64.0f;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, viewW, viewH)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10.0f;
    [self.contentView addSubview:view];
    self.detailView = view;
    
    
    CGFloat buttonW = 40.0f;
    
    CGFloat labelX = margin;
    CGFloat labelY = margin;
    CGFloat labelW = UIScreenWidth - labelX - buttonW;
    CGFloat labelH = 44.0f;
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
//    [TitleLabel setTexts:@[@"设备编号: ", @"18601"] warp:NO spacing:0.0f];
    TitleLabel.textColor = [UIColor dx_333333Color];
    TitleLabel.font = DFont(14);
    [view addSubview:TitleLabel];
    self.TitleLabel = TitleLabel;
    
    UIButton * isOnlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat DPbuttonH = 44.0f;
    CGFloat DPButtonX = CGRectGetMaxX(view.frame) - margin - buttonW;
    isOnlineButton.frame = CGRectMake(DPButtonX, margin, buttonW, DPbuttonH);
    isOnlineButton.backgroundColor = [UIColor clearColor];
    [isOnlineButton setImage:IMAGE(@"right_arrow") forState:UIControlStateNormal];
    isOnlineButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    isOnlineButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    isOnlineButton.titleLabel.font = DFont(12);
//    [isOnlineButton setTitleColor:[UIColor dx_666666Color] forState:UIControlStateNormal];
    [view addSubview:isOnlineButton];
    self.isOnlineButton = isOnlineButton;
}

- (void)setModel:(KY_Account_MySelf_Model *)model
{
    _model = model;
    self.TitleLabel.text = model.title;
    if (model.icon.length != 0) {
        [self.isOnlineButton setImage:IMAGE(model.icon) forState:UIControlStateNormal];
    } else {
        [self.isOnlineButton setImage:IMAGE(@"") forState:UIControlStateNormal];
    }
    
    if ([model.title isEqualToString:@"修改密码"]) {
        self.TitleLabel.textColor = [UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f];
        
    } else if ([model.title isEqualToString:@"退出登录"]) {
        
        self.TitleLabel.textColor = [UIColor colorWithRed:170.0f / 255.0f green:128.0f / 255.0f blue:70.0f / 255.0f alpha:1];
        
    } else {
        self.TitleLabel.textColor = [UIColor dx_333333Color];
    }
    
}

@end


@interface KY_Account_Setting_Cell ()

@property (nonatomic,weak) UIView *detailView;
@property (nonatomic,weak) UILabel *TitleLabel;
@property (nonatomic,weak) UIImageView *rightIcon;


@end

@implementation KY_Account_Setting_Cell

+(instancetype)KY_Account_Setting_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    KY_Account_Setting_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KY_Account_Setting_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)addAllViews
{
    CGFloat margin = 10.0f;
    CGFloat viewW = UIScreenWidth - margin * 2;
    CGFloat viewH = 64.0f;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, viewW, viewH)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10.0f;
    [self.contentView addSubview:view];
    self.detailView = view;
    
    CGFloat iconSize = 20.0f;
    CGFloat iconX = viewW - margin - iconSize;
    
    CGFloat iconY = CGRectGetMidY(view.frame) - iconSize * 0.5;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconSize, iconSize)];
    imageView.image = IMAGE(@"right_arrow");
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    self.rightIcon = imageView;
    
    CGFloat labelX = margin;
    CGFloat labelY = margin;
    CGFloat labelW = iconX;
    CGFloat labelH = 44.0f;
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
//    [TitleLabel setTexts:@[@"设备编号: ", @"18601"] warp:NO spacing:0.0f];
    TitleLabel.textColor = [UIColor dx_333333Color];
    TitleLabel.font = DFont(16);
    [view addSubview:TitleLabel];
    self.TitleLabel = TitleLabel;
    
    

}

- (void)setModel:(KY_Account_Setting_Model *)model
{
    _model = model;
    self.TitleLabel.text = model.title;
}

@end


@interface KY_Account_AboutUs_Cell ()

@property (nonatomic,weak) UIView *detailView;
@property (nonatomic,weak) UILabel *TitleLabel;
@property (nonatomic,weak) UIImageView *rightIcon;
@property (nonatomic,weak) UILabel *tagLabel;

@end

@implementation KY_Account_AboutUs_Cell

+(instancetype)KY_Account_AboutUs_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
{
    KY_Account_AboutUs_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KY_Account_AboutUs_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)addAllViews
{
    CGFloat margin = 10.0f;
    CGFloat viewW = UIScreenWidth - margin * 2;
    CGFloat viewH = 64.0f;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, viewW, viewH)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10.0f;
    [self.contentView addSubview:view];
    self.detailView = view;
    
    CGFloat iconSize = 20.0f;
    CGFloat iconX = viewW - margin - iconSize;
    
    CGFloat iconY = CGRectGetMidY(view.frame) - iconSize * 0.5;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconSize, iconSize)];
    imageView.image = IMAGE(@"right_arrow");
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    self.rightIcon = imageView;
    
    CGFloat labelX = margin;
    CGFloat labelY = margin;
    CGFloat labelW = iconX;
    CGFloat labelH = 44.0f;
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
//    [TitleLabel setTexts:@[@"设备编号: ", @"18601"] warp:NO spacing:0.0f];
    TitleLabel.textColor = [UIColor dx_333333Color];
    TitleLabel.font = DFont(16);
    [view addSubview:TitleLabel];
    self.TitleLabel = TitleLabel;
    
    CGFloat tagLabelW = 80;
    CGFloat tagLabelX = viewW - margin - tagLabelW;
    CGFloat tagLabelY = margin;
    CGFloat tagLabelH = 44.0f;
    UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(tagLabelX, tagLabelY, tagLabelW, tagLabelH)];
//    [TitleLabel setTexts:@[@"设备编号: ", @"18601"] warp:NO spacing:0.0f];
    tagLabel.textColor = [UIColor dx_666666Color];
    tagLabel.font = DFont(16);
    tagLabel.hidden = YES;
    [view addSubview:tagLabel];
    self.tagLabel = tagLabel;
    
    
    
    CGFloat lineW = CGRectGetWidth(view.frame);
    CGFloat lineH = 1.0f;
    CGFloat lineY = CGRectGetMaxY(view.frame) - lineH;
    CGFloat lineX = 0.0f;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
    lineView.backgroundColor = [UIColor dx_D9D9D9Color];
    [view addSubview:lineView];
    
}

- (void)setModel:(KY_Account_AboutUs_Model *)model
{
    _model = model;
    self.TitleLabel.text = model.title;
    if ([model.title isEqualToString:@"当前版本"]) {
        self.rightIcon.hidden = YES;
        self.tagLabel.hidden = NO;
        self.tagLabel.text = model.value;
    } else {
        self.rightIcon.hidden = NO;
        self.tagLabel.hidden = YES;
    }
    
}

@end


@interface KY_Account_ChangePassWord_Cell () <UITextFieldDelegate>

@property (nonatomic,weak) UIView *detailView;

@end

@implementation KY_Account_ChangePassWord_Cell

+(instancetype)KY_Account_ChangePassWord_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    KY_Account_ChangePassWord_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KY_Account_ChangePassWord_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)addAllViews
{
    CGFloat margin = 10.0f;
    CGFloat viewW = UIScreenWidth - margin * 2;
    CGFloat viewH = 64.0f;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, viewW, viewH)];
    view.backgroundColor = [UIColor clearColor];
    view.layer.cornerRadius = 10.0f;
    [self.contentView addSubview:view];
    self.detailView = view;
    
    //第一行 输入框
    CGFloat TextFieldX = margin * 2;
    CGFloat TextFieldY = margin;
    CGFloat TextFieldW = viewW - TextFieldX * 2;
    CGFloat TextFieldH = 34.0f;
    UITextField *TextField = [[UITextField alloc] initWithFrame:CGRectMake(TextFieldX, TextFieldY, TextFieldW, TextFieldH)];
    TextField.textColor = [UIColor dx_666666Color];
    TextField.backgroundColor = [UIColor clearColor];
    TextField.keyboardType = UIKeyboardTypeDefault;
    TextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, margin, TextFieldH)];
    TextField.secureTextEntry = YES;
    TextField.leftViewMode = UITextFieldViewModeAlways;
//    TextField.returnKeyType = UIReturnKeyDone;
    [TextField setValue:[UIColor dx_C7C7C7Color] forKeyPath:@"placeholderLabel.textColor"];
    [TextField setValue:DFont(14) forKeyPath:@"placeholderLabel.font"];
    TextField.layer.borderWidth = 1.0f;
    TextField.layer.borderColor = [[[UIColor grayColor] colorWithAlphaComponent:0.8f] CGColor];
    TextField.layer.cornerRadius = 8.0f;
    TextField.layer.masksToBounds = YES;
    
    
    [TextField addTarget:self action:@selector(textFieldWithText:)forControlEvents:UIControlEventEditingChanged];
    TextField.tag = 10001;
    TextField.delegate = self;
    [view addSubview:TextField];
    self.TextField = TextField;
    
}

- (void)setModel:(KY_Account_ChangePassWord_Model *)model
{
    _model = model;
    self.TextField.placeholder = model.placeHolder;
}

- (void)textFieldWithText:(UITextField *)textField
{
    if (_delegate && [_delegate respondsToSelector:@selector(KY_Account_ChangePassWord_CellTextFieldAction:)]) {
        [_delegate KY_Account_ChangePassWord_CellTextFieldAction:self];
    }
}

@end
