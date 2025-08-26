//
//  KY_HomePage_Cell.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/7/30.
//

#import "KY_HomePage_Cell.h"
#import "KY_Homepage_Item_view.h"


@implementation KY_HomePage_Cell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString*)identifier
{
    KY_HomePage_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KY_HomePage_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

@interface kY_HomePage_Items_Cell () <KY_HomePage_ItemsTapActionDelegate>

@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UILabel *timeLabel;

//Items的Title
@property (nonatomic,strong) NSArray *titleArray;
//Items的image
@property (nonatomic,strong) NSArray *imageArray;

@end

@implementation kY_HomePage_Items_Cell

+(instancetype)kY_HomePage_Items_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    kY_HomePage_Items_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[kY_HomePage_Items_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)addAllViews
{
    CGFloat margin = 10.0f;
    CGFloat viewW = UIScreenWidth - margin * 2;
    CGFloat ViewH = 400;
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(margin, margin, viewW, ViewH)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10.0f;
    [self.contentView addSubview:view];
    
    self.titleArray = @[@"新办水卡", @"设备管理", @"用户管理",@"水卡充值",@"水卡管理",@"打水记录",@"收入记录",@"水卡挂失",@"水卡拉黑",@"水卡重置",@"系统设置",@"分组管理",@"补卡管理",@"退款管理"];
    
    self.imageArray = @[@"index_card_create", @"index_device_mgmt", @"accountManage", @"index_card_recharge", @"index_card_mgmt", @"index_water_record", @"index_income_statictics", @"index_card_dismiss", @"index_card_blacklist", @"index_card_reset", @"index_sys_setting", @"index_group_management", @"index_card_replace", @"index_drawback"];
    
    
    CGFloat itemsW = viewW * 0.25;
    CGFloat itemsH = ViewH * 0.25;
    for (int i = 0; i < self.titleArray.count; i++) {
        //行
        int row = i % 4;
        //列
        int column = i / 4;
        
        CGFloat itemsY = column * itemsH;
        CGFloat itemsX = row * itemsW;
        
        NSString *imageName = self.imageArray[i];
        NSString *titleName = self.titleArray[i];
        
        UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        KY_Homepage_Item_view *item = [[KY_Homepage_Item_view alloc] initWithFrame:CGRectMake(itemsX, itemsY, itemsW, itemsH) WithImage:image WithTitle:titleName];
        item.delegate = self;
        [view addSubview:item];
    }
    
}

- (void)itemsTapAction:(NSString *)title
{
    if (_delegate && [_delegate respondsToSelector:@selector(KY_HomePage_Items_CellTapAction:)]) {
        [_delegate KY_HomePage_Items_CellTapAction:title];
    }
    
}

@end

@interface kY_HomePage_CreatCard_Cell () <UITextFieldDelegate>

@property (nonatomic,weak) UIView  *detailView;
@property (nonatomic,weak) UILabel *barLabel;
@property (nonatomic,weak) UILabel *actualLabel;
@property (nonatomic,weak) UIImageView *iconImageView;
@property (nonatomic,weak) UIButton *selectTimeButton;
@property (nonatomic,weak) UILabel *scrollLabel;
//元 rightView
@property (nonatomic,strong) UIView *yuanView;
//身高 rightView
@property (nonatomic,strong) UIView *heightView;
//出生年月 Label
@property (nonatomic,weak) UILabel *birthLabel;

@property (nonatomic,strong) NSMutableArray *itemLabelArray;

@end

@implementation kY_HomePage_CreatCard_Cell

+(instancetype)kY_HomePage_CreatCard_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    kY_HomePage_CreatCard_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[kY_HomePage_CreatCard_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (UIView *)yuanView
{
    if (!_yuanView) {
        _yuanView = [self createdYuanView];
    }
    return _yuanView;
}
- (UIView *)heightView
{
    if (!_heightView) {
        _heightView = [self createdHeightView];
    }
    return _heightView;
}


//元 rightView
- (UIView *)createdYuanView
{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 40, 34.0f)];
    rightView.backgroundColor = [UIColor clearColor];
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 34.0f)];
    rightLabel.text = @"元";
    rightLabel.textColor = [UIColor colorWithRed:170.0f / 255.0f green:128.0f / 255.0f blue:70.0f / 255.0f alpha:1];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.font = DFont(14);
    [rightView addSubview:rightLabel];
    return rightView;
}

//身高cm rightView
- (UIView *)createdHeightView
{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 40, 34.0f)];
    rightView.backgroundColor = [UIColor clearColor];
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 34.0f)];
    rightLabel.text = @"cm";
    rightLabel.textColor = [UIColor colorWithRed:170.0f / 255.0f green:128.0f / 255.0f blue:70.0f / 255.0f alpha:1];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.font = DFont(14);
    [rightView addSubview:rightLabel];
    return rightView;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    //只有水卡编号的Textfield才进行以下操作
    if ([self.model.title isEqualToString:@"水卡编号"]) {
        
        if (textField == self.textField) {
            if(range.length == 1 && string.length == 0) {
                return YES;
            } else if (self.textField.text.length >= 10) {
                self.textField.text = [textField.text substringToIndex:10];
                return NO;
            }
        }
        return [self validateNumber:string];
    }
    return YES;
}

- (BOOL)validateNumber:(NSString *)number
{
    BOOL res = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0 ;
    while (i  < number.length) {
        NSString *string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


- (void)addAllViews
{
    CGFloat margin = 10.0f;
    CGFloat viewW = UIScreenWidth - margin * 2;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, margin, viewW, 64)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10.0f;
    [self.contentView addSubview:view];
    self.detailView = view;
    
    //标题
    CGFloat labelX = margin;
    CGFloat labelY = 0;
    CGFloat labelW = CGRectGetWidth(view.frame) - margin * 2;
    CGFloat labelH = 24;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    [label setTexts:@[@"*", @"水卡编号"] colors:@[[UIColor redColor], [UIColor dx_666666Color]] fonts:@[DFont(8), DFont(14)] warp:NO spacing:5.0f];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    self.barLabel = label;
    
    //图标的宽高 40.0f
    CGFloat iconFrame = 20.0f;
    
    //第一行 输入框
    CGFloat TextFieldX = margin;
    CGFloat TextFieldY = CGRectGetMaxY(label.frame);
    CGFloat TextFieldW = labelW - iconFrame;
    CGFloat TextFieldH = 34.0f;
    UITextField *TextField = [[UITextField alloc] initWithFrame:CGRectMake(TextFieldX, TextFieldY, TextFieldW, TextFieldH)];
    TextField.textColor = [UIColor dx_666666Color];
    TextField.backgroundColor = [UIColor clearColor];
    TextField.keyboardType = UIKeyboardTypeDefault;
    TextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, TextFieldH)];
    TextField.leftViewMode = UITextFieldViewModeAlways;
//    TextField.returnKeyType = UIReturnKeyDone;
    [TextField setValue:[UIColor dx_C7C7C7Color] forKeyPath:@"placeholderLabel.textColor"];
    [TextField setValue:DFont(14) forKeyPath:@"placeholderLabel.font"];
    
    [TextField addTarget:self action:@selector(textFieldWithText:)forControlEvents:UIControlEventEditingChanged];
    TextField.tag = 10001;
    TextField.delegate = self;
    TextField.rightView = self.yuanView;
    TextField.rightViewMode = UITextFieldViewModeNever;
    [view addSubview:TextField];
    self.textField = TextField;
    
    //第一行的 分组 button
    CGFloat groupX = margin;
    CGFloat groupY = CGRectGetMaxY(label.frame);
    CGFloat groupW = labelW - iconFrame;
    CGFloat groupH = 34.0f;
    
    UIButton * groupButton = [UIButton buttonWithType:UIButtonTypeCustom];
    groupButton.frame = CGRectMake(groupX, groupY, groupW, groupH);
    groupButton.backgroundColor = [UIColor clearColor];
//    [groupButton setImage:IMAGE(@"calc") forState:UIControlStateNormal];
//    [groupButton setTitle:@"默认分组" forState:UIControlStateNormal];
    groupButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    groupButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    groupButton.titleLabel.font = DFont(14);
    [groupButton setTitleColor:[UIColor dx_999999Color] forState:UIControlStateNormal];
    [groupButton addTarget:self action:@selector(groupButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:groupButton];
    groupButton.hidden = YES;
    self.groupButton = groupButton;
    
    //第一行输入框后的小图标
    CGFloat iconX = CGRectGetMaxX(TextField.frame);
    CGFloat iconY = TextFieldY + margin;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconFrame, iconFrame)];
    imageView.image = IMAGE(@"scan");
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    self.iconImageView = imageView;
    
    //第二行 输入框上的标题Lael
    CGFloat actualLabelX = margin;
    CGFloat actualLabelY = CGRectGetMaxY(TextField.frame) + margin;
    CGFloat actualLabelW = CGRectGetWidth(view.frame) - margin * 2;
    CGFloat actualLabelH = labelH;
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(actualLabelX, actualLabelY, actualLabelW, actualLabelH)];
    [aLabel setTexts:@[@"实收金额", @" (赠送:0.00元)"] colors:@[[UIColor dx_666666Color], [UIColor colorWithRed:125.0f / 255.0f green:60.0f / 255.0f blue:70.0f / 255.0f alpha:1.0f]] fonts:@[DFont(14), DFont(14)] warp:NO spacing:5.0f];
    aLabel.backgroundColor = [UIColor clearColor];
    [view addSubview:aLabel];
    self.actualLabel = aLabel;
    self.actualLabel.hidden = YES;
    
    
    //第二行 输入框
    CGFloat actualTextFieldX = margin;
    CGFloat actualTextFieldY = CGRectGetMaxY(aLabel.frame);
    CGFloat actualTextFieldW = labelW - iconFrame;
    CGFloat actualTextFieldH = 34.0f;
    UITextField *actualTextField = [[UITextField alloc] initWithFrame:CGRectMake(actualTextFieldX, actualTextFieldY, actualTextFieldW, actualTextFieldH)];
    actualTextField.textColor = [UIColor dx_666666Color];
    actualTextField.backgroundColor = [UIColor clearColor];
    actualTextField.keyboardType = UIKeyboardTypeDefault;
    actualTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, actualTextFieldH)];
    actualTextField.placeholder = @"请输入实际收款的金额，单位元";
    actualTextField.leftViewMode = UITextFieldViewModeAlways;
    [actualTextField setValue:[UIColor dx_C7C7C7Color] forKeyPath:@"placeholderLabel.textColor"];
    [actualTextField setValue:DFont(14) forKeyPath:@"placeholderLabel.font"];
    
    [actualTextField addTarget:self action:@selector(actualTextFieldWithText:)forControlEvents:UIControlEventEditingChanged];
    actualTextField.tag = 10002;
    
    
    //第二行 输入框后 的单位视图
    UIView *arightView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 40, 34.0f)];
    arightView.backgroundColor = [UIColor clearColor];
    UILabel *arightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 34.0f)];
    arightLabel.text = @"元";
    arightLabel.textColor = [UIColor colorWithRed:170.0f / 255.0f green:128.0f / 255.0f blue:70.0f / 255.0f alpha:1];
    arightLabel.textAlignment = NSTextAlignmentCenter;
    arightLabel.font = DFont(14);
    [arightView addSubview:arightLabel];
    
    actualTextField.rightView = arightView;
    actualTextField.rightViewMode = UITextFieldViewModeAlways;
    [view addSubview:actualTextField];
    self.actualTextField = actualTextField;
    self.actualTextField.hidden = YES;
    
    //第三行 滚动视图的标题
    CGFloat scrollLabelX = margin;
    CGFloat scrollLabelY = CGRectGetMaxY(actualTextField.frame) + margin;
    CGFloat scrollLabelW = UIScreenWidth - margin * 2;
    CGFloat scrollLabelH = 20.0f;
    UILabel *scrollLabel = [[UILabel alloc] initWithFrame:CGRectMake(scrollLabelX, scrollLabelY, scrollLabelW, scrollLabelH)];
//    [aLabel setTexts:@[@"实收金额", @" (赠送:0.00元)"] colors:@[[UIColor dx_666666Color], [UIColor colorWithRed:125.0f / 255.0f green:60.0f / 255.0f blue:70.0f / 255.0f alpha:1.0f]] fonts:@[DFont(14), DFont(14)] warp:NO spacing:5.0f];
    scrollLabel.text = @"当前分组充值选项";
    scrollLabel.textColor = [UIColor dx_999999Color];
    scrollLabel.textAlignment = NSTextAlignmentLeft;
    scrollLabel.font = DFont(12);
    scrollLabel.backgroundColor = [UIColor clearColor];
    [view addSubview:scrollLabel];
    scrollLabel.hidden = YES;
    self.scrollLabel = scrollLabel;
    
    //第三行 滚动视图
    CGFloat scrollX = margin;
    CGFloat scrollY = CGRectGetMaxY(scrollLabel.frame);
    CGFloat scrollW = UIScreenWidth - margin * 2;
    CGFloat scrollH = 80.0f;
    CGFloat itemsW = scrollW * 0.33;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(scrollX, scrollY, scrollW, scrollH)];
    scrollView.contentSize = CGSizeMake(itemsW * 4, scrollH);
    scrollView.bounces = YES;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsHorizontalScrollIndicator = YES;
    [view addSubview:scrollView];
    scrollView.hidden = YES;
    self.scrollView = scrollView;
    
    //第三行 滚动视图中的Item
//    CGFloat itemsX = margin;
//    CGFloat itemsY = margin;
//    CGFloat itemsH = 50.0f;
//    UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(itemsX, itemsY, itemsW, itemsH)];
//    itemLabel.textAlignment = NSTextAlignmentCenter;
////    [itemLabel setTexts:@[@"充200.00元", @" 送300.00元"] colors:@[[UIColor dx_666666Color], [UIColor dx_999999Color]] fonts:@[DFont(14), DFont(12)] warp:YES spacing:0.0f];
//    [itemLabel setTexts:@[@"充 ", @"200.00", @" 元", @"送 ", @"300.00", @" 元"] colors:@[[UIColor dx_666666Color], [UIColor dx_666666Color], [UIColor dx_666666Color], [UIColor dx_999999Color], [UIColor dx_999999Color], [UIColor dx_999999Color]] fonts:@[DFont(14), DFont(14), DFont(14), DFont(12), DFont(14), DFont(14)] warps:@[@"0" ,@"0",@"1", @"0", @"0", @"0"] spacing:0.0f];
//    itemLabel.layer.borderWidth = 0.5f;
//    itemLabel.layer.borderColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3f] CGColor];
//    itemLabel.layer.cornerRadius = 8.0f;
//    itemLabel.layer.masksToBounds = YES;
//    
//    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItemLabel:)];
//    [itemLabel addGestureRecognizer:TapGesture];
//    itemLabel.userInteractionEnabled = YES;
//    [scrollView addSubview:itemLabel];
//    self.itemLabelArray = [[NSMutableArray alloc] init];
//    [self.itemLabelArray addObject:itemLabel];
    
    
    //第一行 设置选择日期的Button
    UIButton * selectTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat buttonW = (CGRectGetWidth(view.frame) - margin * 2) * 0.5;
    CGFloat buttonH = 26.0f;
    selectTimeButton.frame = CGRectMake(0, margin, buttonW, buttonH);
    selectTimeButton.backgroundColor = [UIColor clearColor];
    [selectTimeButton setImage:IMAGE(@"Unchecked") forState:UIControlStateNormal];
    [selectTimeButton setImage:IMAGE(@"Checked") forState:UIControlStateSelected];
    [selectTimeButton setTitle:@"设置水卡有效期" forState:UIControlStateNormal];
    selectTimeButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    selectTimeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    selectTimeButton.titleLabel.font = DFont(14);
    [selectTimeButton setTitleColor:[UIColor dx_666666Color] forState:UIControlStateNormal];
    selectTimeButton.selected = NO;
    [selectTimeButton addTarget:self action:@selector(selectTimeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:selectTimeButton];
    selectTimeButton.hidden = YES;
    self.selectTimeButton = selectTimeButton;
    
    //第一行 选择日期的Button
    UIButton * datePickerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat DPbuttonW = (CGRectGetWidth(view.frame) - margin * 2) * 0.5;
    CGFloat DPbuttonH = 26.0f;
    CGFloat DPButtonX = CGRectGetMaxX(view.frame) - margin - DPbuttonW;
    datePickerButton.frame = CGRectMake(DPButtonX, margin, DPbuttonW, DPbuttonH);
    datePickerButton.backgroundColor = [UIColor clearColor];
    [datePickerButton setImage:IMAGE(@"calc") forState:UIControlStateNormal];
    [datePickerButton setTitle:@"选择日期" forState:UIControlStateNormal];
    datePickerButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    datePickerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    datePickerButton.titleLabel.font = DFont(12);
    [datePickerButton setTitleColor:[UIColor dx_666666Color] forState:UIControlStateNormal];
    //左移图片，右移文字
    // 取出 titleLabel 的宽度
    CGFloat labelWidth02 = datePickerButton.titleLabel.bounds.size.width;
    // 取出 imageView 的宽度
    CGFloat imageWidth02 = datePickerButton.imageView.bounds.size.width;
    // 设置 titleLabel 的内边距
    datePickerButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth02 + DPbuttonW * 0.1, 0, imageWidth02);
    // 设置 imageView 的内边距
    datePickerButton.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth02 + DPbuttonW * 0.25, 0, -labelWidth02);
    
    [datePickerButton addTarget:self action:@selector(datePickerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:datePickerButton];
    datePickerButton.hidden = YES;
    self.datePickerButton = datePickerButton;
    self.datePickerButton.userInteractionEnabled = NO;
    self.datePickerButton.enabled = NO;
    
    //第二行 选择性别的Button
    
//    CGFloat actualTextFieldX = margin;
//    CGFloat actualTextFieldY = CGRectGetMaxY(aLabel.frame);
//    CGFloat actualTextFieldW = labelW - iconFrame;
//    CGFloat actualTextFieldH = 34.0f;
    UIButton *sexButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat sexButtonX = margin;
    CGFloat sexbuttonY = CGRectGetMaxY(aLabel.frame) + margin;
    CGFloat sexbuttonW = labelW;
    CGFloat sexbuttonH = 34.0f;
    sexButton.frame = CGRectMake(sexButtonX, sexbuttonY, sexbuttonW, sexbuttonH);
    sexButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    sexButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    sexButton.titleLabel.font = DFont(12);
    [sexButton setTitleColor:[UIColor dx_666666Color] forState:UIControlStateNormal];
    sexButton.backgroundColor = [UIColor dx_F2F2F2Color];
    
    [sexButton addTarget:self action:@selector(sexButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sexButton];
    sexButton.hidden = YES;
    self.sexButton = sexButton;
    
    //第二行的小图标
//    CGFloat twoIconX = CGRectGetMaxX(TextField.frame);
//    CGFloat twoIconY = TextFieldY + margin;
//    UIImageView *twoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(twoIconX, twoIconY, iconFrame, iconFrame)];
//    twoImageView.image = IMAGE(@"scan");
//    twoImageView.contentMode = UIViewContentModeScaleAspectFit;
//    [view addSubview:twoImageView];
    //第二行 输入框上的标题Lael
    CGFloat birthLabelX = margin;
    CGFloat birthLabelY = CGRectGetMaxY(sexButton.frame) + margin;
    CGFloat birthLabelW = CGRectGetWidth(view.frame) - margin * 2;
    CGFloat birthLabelH = labelH;
    UILabel *birthLabel = [[UILabel alloc] initWithFrame:CGRectMake(birthLabelX, birthLabelY, birthLabelW, birthLabelH)];
    birthLabel.text = @"出生年月(仅用于体测)";
    birthLabel.textColor = [UIColor dx_666666Color];
    birthLabel.font = DFont(14);
//    [birthLabel setTexts:@[@"实收金额", @" (赠送:0.00元)"] colors:@[[UIColor dx_666666Color], [UIColor colorWithRed:125.0f / 255.0f green:60.0f / 255.0f blue:70.0f / 255.0f alpha:1.0f]] fonts:@[DFont(14), DFont(14)] warp:NO spacing:5.0f];
    birthLabel.backgroundColor = [UIColor clearColor];
    [view addSubview:birthLabel];
    self.birthLabel = birthLabel;
    self.birthLabel.hidden = YES;
    
    
    
    UIButton *birthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat birthButtonX = margin;
    CGFloat birthButtonY = CGRectGetMaxY(birthLabel.frame) + margin;
    CGFloat birthButtonW = labelW;
    CGFloat birthButtonH = 34.0f;
    birthButton.frame = CGRectMake(birthButtonX, birthButtonY, birthButtonW, birthButtonH);
    birthButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    birthButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    birthButton.titleLabel.font = DFont(12);
    [birthButton setTitleColor:[UIColor dx_666666Color] forState:UIControlStateNormal];
    birthButton.backgroundColor = [UIColor dx_F2F2F2Color];
    
    [birthButton addTarget:self action:@selector(birthButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:birthButton];
    birthButton.hidden = YES;
    self.birthButton = birthButton;
    
}

- (void)setGroupArray:(NSArray *)groupArray
{
    _groupArray = groupArray;
}

- (void)setItemArray:(NSArray *)itemArray
{
    _itemArray = itemArray;
    //先移除所有子视图itemLabel
    for (UILabel *label in self.itemLabelArray) {
        [label removeFromSuperview];
    }

    for (int i = 0; i < itemArray.count; i++) {
        KY_CreateNewCard_Group_ItemList_Model *model = itemArray[i];
        NSString *money = [NSString stringWithFormat:@"%0.2f", model.money * 0.01];
        NSString *give = [NSString stringWithFormat:@"%0.2f", model.give * 0.01];
        UILabel *label = [self createdItemLabelViewWithMoney:money WithRecharge:give WithIndex:i];
        [self.scrollView addSubview:label];
        [self.itemLabelArray addObject:label];
    }
    
}

//创建 充值itemLabel
- (UILabel *)createdItemLabelViewWithMoney:(NSString *)money WithRecharge:(NSString *)recharge WithIndex:(int)index
{
    CGFloat margin = 10.0f;
    CGFloat scrollW = UIScreenWidth - margin * 2;
    CGFloat itemsW = scrollW * 0.33;
    
    CGFloat itemsX = (margin + itemsW) * index;
    CGFloat itemsY = margin;
    CGFloat itemsH = 50.0f;
    UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(itemsX, itemsY, itemsW, itemsH)];
    itemLabel.textAlignment = NSTextAlignmentCenter;
//    [itemLabel setTexts:@[@"充200.00元", @" 送300.00元"] colors:@[[UIColor dx_666666Color], [UIColor dx_999999Color]] fonts:@[DFont(14), DFont(12)] warp:YES spacing:0.0f];
    [itemLabel setTexts:@[@"充 ", money, @" 元", @"送 ", recharge, @" 元"] colors:@[[UIColor dx_666666Color], [UIColor dx_666666Color], [UIColor dx_666666Color], [UIColor dx_999999Color], [UIColor dx_999999Color], [UIColor dx_999999Color]] fonts:@[DFont(14), DFont(14), DFont(14), DFont(12), DFont(14), DFont(14)] warps:@[@"0" ,@"0",@"1", @"0", @"0", @"0"] spacing:0.0f];
    itemLabel.layer.borderWidth = 0.5f;
    itemLabel.layer.borderColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3f] CGColor];
    itemLabel.layer.cornerRadius = 8.0f;
    itemLabel.layer.masksToBounds = YES;
    itemLabel.tag = 30000 + index;
    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItemLabel:)];
    [itemLabel addGestureRecognizer:TapGesture];
    itemLabel.userInteractionEnabled = YES;
    return itemLabel;
}


- (void)setModel:(KY_CreateNewCard_Model *)model
{
    _model = model;
    CGFloat margin = 10.0f;
    CGFloat viewH = [model.height floatValue] - margin * 2;
    CGRect frame = self.backgroundView.frame;
    frame.size.height = viewH;
    frame.origin.x = margin;
    frame.origin.y = margin;
    frame.size.width = UIScreenWidth - margin * 2;
    self.detailView.frame = frame;
    
    if (model.isSelect) {
        [self.barLabel setTexts:@[@"*", model.title] colors:@[[UIColor redColor], [UIColor dx_666666Color]] fonts:@[DFont(10), DFont(14)] warp:NO spacing:5.0f];
    } else {
        [self.barLabel setTexts:@[@"", model.title] colors:@[[UIColor redColor], [UIColor dx_666666Color]] fonts:@[DFont(10), DFont(14)] warp:NO spacing:5.0f];
    }
    self.textField.placeholder = model.placeHolder;
    [self.textField setValue:DFont(14) forKeyPath:@"placeholderLabel.font"];
    
    NSString *iconName = model.isIcon;
    if ([iconName isEqualToString:@"0"]) {
        self.iconImageView.hidden = YES;
    } else {
        self.iconImageView.image = IMAGE(iconName);
    }
    
    if ([model.title isEqualToString:@"分组"]) {
        self.barLabel.hidden = NO;
        self.groupButton.hidden = NO;
        self.textField.hidden = YES;
        self.actualLabel.hidden = YES;
        self.actualTextField.hidden = YES;
        self.selectTimeButton.hidden = YES;
        self.datePickerButton.hidden = YES;
        self.scrollLabel.hidden = YES;
        self.scrollView.hidden = YES;
        
    }
    
    if ([model.title isEqualToString:@"充值金额"]) {
        CGRect frame = self.textField.frame;
        CGFloat textFieldX = margin;
        CGFloat textFieldY = CGRectGetMaxY(self.barLabel.frame);
        CGFloat textFieldW = CGRectGetWidth(self.detailView.frame) - margin * 2;
        CGFloat textFieldH = 34.0f;
        frame.size.height = textFieldH;
        frame.origin.x = textFieldX;
        frame.origin.y = textFieldY;
        frame.size.width = textFieldW;
        self.textField.frame = frame;
        self.textField.backgroundColor = [UIColor dx_F2F2F2Color];
        self.textField.rightView = self.yuanView;
        self.textField.rightViewMode = UITextFieldViewModeAlways;
        self.actualLabel.hidden = NO;
        
        CGRect  actualFrame = self.actualTextField.frame;
        CGFloat actualTextFieldX = margin;
        CGFloat actualTextFieldY = CGRectGetMaxY(self.actualLabel.frame);
        CGFloat actualTextFieldW = CGRectGetWidth(self.detailView.frame) - margin * 2;
        CGFloat actualTextFieldH = 34.0f;
        actualFrame.size.height = actualTextFieldH;
        actualFrame.origin.x = actualTextFieldX;
        actualFrame.origin.y = actualTextFieldY;
        actualFrame.size.width = actualTextFieldW;

        self.actualTextField.frame = actualFrame;
        self.actualTextField.backgroundColor = [UIColor dx_F2F2F2Color];
//        self.actualTextField.rightViewMode = UITextFieldViewModeAlways;
        self.actualTextField.hidden = NO;
        self.scrollLabel.hidden = NO;
        self.scrollView.hidden = NO;
    }
    
    if ([model.title isEqualToString:@"设置水卡有效期"]) {
//        CGRect frame = self.barLabel.frame;
//        CGFloat textFieldX = margin;
//        CGFloat textFieldY = CGRectGetMaxY(self.barLabel.frame);
//        CGFloat textFieldW = CGRectGetWidth(self.detailView.frame) - margin * 2;
//        CGFloat textFieldH = 34.0f;
        self.barLabel.hidden = YES;
        self.textField.hidden = YES;
        self.selectTimeButton.hidden = NO;
        self.datePickerButton.hidden = NO;
        
    }
    
    if ([model.title isEqualToString:@"身高(仅用于体测)"]) {
        CGRect frame = self.textField.frame;
        CGFloat textFieldX = margin;
        CGFloat textFieldY = CGRectGetMaxY(self.barLabel.frame);
        CGFloat textFieldW = CGRectGetWidth(self.detailView.frame) - margin * 2;
        CGFloat textFieldH = 34.0f;
        frame.size.height = textFieldH;
        frame.origin.x = textFieldX;
        frame.origin.y = textFieldY;
        frame.size.width = textFieldW;
        self.textField.frame = frame;
        self.textField.backgroundColor = [UIColor dx_F2F2F2Color];
        self.textField.rightView = self.heightView;
        self.textField.rightViewMode = UITextFieldViewModeAlways;
        
        self.actualLabel.hidden = NO;
        self.actualLabel.text = @"性别(仅用于体测)";
        self.actualLabel.textColor = [UIColor dx_666666Color];
        self.actualLabel.font = DFont(14);
        
        self.sexButton.hidden = NO;
        self.birthLabel.hidden = NO;
        self.birthButton.hidden = NO;
        
    }
    
    if ([model.title isEqualToString:@"备注"]) {
        self.textField.backgroundColor = [UIColor clearColor];
    }
    
    
}

- (void)groupButtonAction:(UIButton *)sender
{
    NSMutableArray *arrayData = [NSMutableArray arrayWithObjects:@"默认分组", nil];
    WXZCustomPickView *pickerSingle = [[WXZCustomPickView alloc]init];
//    [pickerSingle setDataArray:arrayData];
    pickerSingle.tag = 200002;
    if (_delegate && [_delegate respondsToSelector:@selector(kY_HomePage_CreatCard_CellGroupDataSourceButtonAction:)]) {
        [_delegate kY_HomePage_CreatCard_CellGroupDataSourceButtonAction:pickerSingle];
    }
    
    [pickerSingle setDelegate:self];
    [pickerSingle setDefalutSelectRowStr:arrayData[0]];
    [pickerSingle show];
}


- (void)sexButtonAction:(UIButton *)sender
{
    NSMutableArray *arrayData = [NSMutableArray arrayWithObjects:@"男", @"女",nil];
    WXZCustomPickView *pickerSingle = [[WXZCustomPickView alloc]init];
    [pickerSingle setDataArray:arrayData];
    [pickerSingle setDefalutSelectRowStr:arrayData[0]];
    [pickerSingle setDelegate:self];
    pickerSingle.tag = 200001;
    [pickerSingle show];
}

- (void)birthButtonAction:(UIButton *)sender
{
    WXZPickDateView *pickerDate = [[WXZPickDateView alloc]init];
    [pickerDate setIsAddYetSelect:NO];//是否显示至今选项
    [pickerDate setIsShowDay:YES];//是否显示日信息
    [pickerDate setDefaultTSelectYear:2025 defaultSelectMonth:8 defaultSelectDay:2];//设定默认显示的日期
    [pickerDate setDelegate:self];
    [pickerDate show];
}



- (void)selectTimeButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    self.datePickerButton.userInteractionEnabled = sender.selected;
    self.datePickerButton.enabled = sender.selected;
}

- (void)datePickerButtonAction:(UIButton *)sender
{
    WXZPickDateView *pickerDate = [[WXZPickDateView alloc]init];
    [pickerDate setIsAddYetSelect:NO];//是否显示至今选项
    [pickerDate setIsShowDay:YES];//是否显示日信息
    [pickerDate setDefaultTSelectYear:2025 defaultSelectMonth:8 defaultSelectDay:2];//设定默认显示的日期
    [pickerDate setDelegate:self];
    [pickerDate show];
}

#pragma mark - WXPickerViewDelegate
-(void)customPickView:(WXZCustomPickView *)customPickView selectedTitle:(NSString *)selectedTitle
{
    //性别
    if (customPickView.tag == 200001) {
        [self.sexButton setTitle:selectedTitle forState:UIControlStateNormal];
        if (_delegate && [_delegate respondsToSelector:@selector(kY_HomePage_CreatCard_CellSexButtonAction:)]) {
            [_delegate kY_HomePage_CreatCard_CellSexButtonAction:self];
        }
    }
    //分组
    if (customPickView.tag == 200002) {
        [self.groupButton setTitle:selectedTitle forState:UIControlStateNormal];
        if (_delegate && [_delegate respondsToSelector:@selector(kY_HomePage_CreatCard_CellGroupButtonAction:)]) {
            [_delegate kY_HomePage_CreatCard_CellGroupButtonAction:self];
        }
    }
    
}

-(void)pickerDateView:(WXZBasePickView *)pickerDateView selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day
{
//    NSLog(@"选择的日期是：%ld %ld %ld",year,month,day);
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 指定获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:dt];
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-M-d"];
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day];
    
    NSDate *date =[dateFormat dateFromString:dateStr];
    
    NSDateFormatter *TimeFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [TimeFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *title = [TimeFormat stringFromDate:date];
    [self.birthButton setTitle:title forState:UIControlStateNormal];
    if (_delegate && [_delegate respondsToSelector:@selector(kY_HomePage_CreatCard_CellBirthButtonAction:)]) {
        [_delegate kY_HomePage_CreatCard_CellBirthButtonAction:self];
    }
//    [self.datePickerButton setTitle:[NSString stringWithFormat:@"%ld年%ld月%ld日",year,month,day] forState:UIControlStateNormal];

//    BOOL isShowDay = YES;
//    if (isShowDay == YES) {
//        if (year>comp.year) {
//             [self.datePickerButton setTitle:@"至今" forState:UIControlStateNormal];
//        }else{
//        [self.datePickerButton setTitle:[NSString stringWithFormat:@"%ld年%ld月%ld日",year,month,day] forState:UIControlStateNormal];
//        }
//    }else{
//        if (year>comp.year) {
//            [self.datePickerButton setTitle:@"至今" forState:UIControlStateNormal];
//        }else{
//        [self.datePickerButton setTitle:[NSString stringWithFormat:@"%ld年 %ld月",year,month] forState:UIControlStateNormal];
//        }
//    }
    
}

- (void)tapItemLabel:(UIGestureRecognizer *)gesture
{
    UILabel *label = (UILabel *)gesture.view;
//    30000
    
    NSString *text = label.text;
    NSArray *array = [text componentsSeparatedByString:@" "];
    //充值
    NSString *rechargeStr = @"";
    //赠送
    NSString *giftStr = @"";
    if (array.count != 0) {
        rechargeStr = array[1];
        giftStr = array[3];
    }
    CGFloat  total = [rechargeStr floatValue] + [giftStr floatValue];
    self.textField.text = [NSString stringWithFormat:@"%.2f", total];
    self.actualTextField.text = rechargeStr;
    [self setActualLabelTextWithRecharge:rechargeStr WithGift:giftStr withIsItem:YES];
    long index = label.tag - 30000;
    if (_delegate && [_delegate respondsToSelector:@selector(kY_HomePage_CreatCard_CellItemAction:WithIndex:)]) {
        [_delegate kY_HomePage_CreatCard_CellItemAction:self WithIndex:index];
    }
    
}

- (void)setActualLabelTextWithRecharge:(NSString *)recharge WithGift:(NSString *)gift withIsItem:(BOOL)isItem
{
    if (isItem) {
        NSString *str = [NSString stringWithFormat:@" (赠送: %0.2f元)", [gift floatValue]];
        [self.actualLabel setTexts:@[@"实收金额", str] colors:@[[UIColor dx_666666Color], [UIColor colorWithRed:125.0f / 255.0f green:60.0f / 255.0f blue:70.0f / 255.0f alpha:1.0f]] fonts:@[DFont(14), DFont(14)] warp:NO spacing:5.0f];
        
    } else {
        NSString *str = [NSString stringWithFormat:@" (赠送: %0.2f元)", [recharge floatValue]];
        [self.actualLabel setTexts:@[@"实收金额", str] colors:@[[UIColor dx_666666Color], [UIColor colorWithRed:125.0f / 255.0f green:60.0f / 255.0f blue:70.0f / 255.0f alpha:1.0f]] fonts:@[DFont(14), DFont(14)] warp:NO spacing:5.0f];
    }
     
}

//自定义代理方法
-(void)textFieldWithText:(UITextField *)textField
{
    //设置 实收金额Label的文字
    if ([self.model.title isEqualToString:@"充值金额"]) {
        [self setActualLabelTextWithRecharge:textField.text WithGift:@"" withIsItem:NO];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(kY_HomePage_CreatCard_CellTextFieldAction:)]) {
        [_delegate kY_HomePage_CreatCard_CellTextFieldAction:self];
    }
    
}

- (void)actualTextFieldWithText:(UITextField *)textField
{
    NSString * rechargeStr = self.textField.text;
    NSString * giftStr = textField.text;
    NSString *showStr = [NSString stringWithFormat:@"%0.2f", [rechargeStr floatValue] - [giftStr floatValue]];
    NSString *str = [NSString stringWithFormat:@" (赠送: %0.2f元)", [showStr floatValue]];
    [self.actualLabel setTexts:@[@"实收金额", str] colors:@[[UIColor dx_666666Color], [UIColor colorWithRed:125.0f / 255.0f green:60.0f / 255.0f blue:70.0f / 255.0f alpha:1.0f]] fonts:@[DFont(14), DFont(14)] warp:NO spacing:5.0f];
    if (_delegate && [_delegate respondsToSelector:@selector(kY_HomePage_CreatCard_CellActualTextFieldAction:)]) {
        [_delegate kY_HomePage_CreatCard_CellActualTextFieldAction:self];
    }
}


@end


@interface KY_HomePage_DeviceManage_Cell ()

@property (nonatomic,weak) UIView *detailView;
@property (nonatomic,weak) UIImageView *ImageView;
@property (nonatomic,weak) UILabel *deviceNumLabel;
@property (nonatomic,weak) UILabel *deviceNameLabel;
@property (nonatomic,weak) UILabel *deviceAddressLabel;
@property (nonatomic,weak) UILabel *deviceDateLabel;
@property (nonatomic,weak) UIButton *isOnlineButton;

@end

@implementation KY_HomePage_DeviceManage_Cell

+(instancetype)KY_HomePage_DeviceManage_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    KY_HomePage_DeviceManage_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KY_HomePage_DeviceManage_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)addAllViews
{
    CGFloat margin = 10.0f;
    CGFloat viewW = UIScreenWidth - margin * 2;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, margin, viewW, 64)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10.0f;
    [self.contentView addSubview:view];
    self.detailView = view;
    
    CGFloat iconSize = 34.0f;
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconSize, iconSize)];
    imageView.image = IMAGE(@"device_close");
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    self.ImageView = imageView;
    
    CGFloat buttonW = 80.0f;
    CGFloat deviceNumX = CGRectGetMaxX(imageView.frame) + margin;
    CGFloat deviceNumY = margin;
    CGFloat deviceNumW = UIScreenWidth - deviceNumX - buttonW;
    CGFloat deviceNumH = 24.0f;
    UILabel *deviceNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(deviceNumX, deviceNumY, deviceNumW, deviceNumH)];
    [deviceNumLabel setTexts:@[@"设备编号: ", @"18601"] warp:NO spacing:0.0f];
    deviceNumLabel.textColor = [UIColor dx_333333Color];
    deviceNumLabel.font = DFont(14);
    [view addSubview:deviceNumLabel];
    self.deviceNumLabel = deviceNumLabel;
    
    CGFloat deviceNameX = CGRectGetMaxX(imageView.frame) + margin;
    CGFloat deviceNameY = CGRectGetMaxY(deviceNumLabel.frame);
    CGFloat deviceNameW = UIScreenWidth - deviceNumX - buttonW;
    CGFloat deviceNameH = 24.0f;
    UILabel *deviceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(deviceNameX, deviceNameY, deviceNameW, deviceNameH)];
    [deviceNameLabel setTexts:@[@"设备别名: ", @"我的设备"] warp:NO spacing:0.0f];
    deviceNameLabel.textColor = [UIColor dx_999999Color];
    deviceNameLabel.font = DFont(13);
    [view addSubview:deviceNameLabel];
    self.deviceNameLabel = deviceNameLabel;
    
    CGFloat deviceAddressX = CGRectGetMaxX(imageView.frame) + margin;
    CGFloat deviceAddressY = CGRectGetMaxY(deviceNameLabel.frame);
    CGFloat deviceAddressW = UIScreenWidth - deviceNumX - buttonW;
    CGFloat deviceAddressH = 24.0f;
    UILabel *deviceAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(deviceAddressX, deviceAddressY, deviceAddressW, deviceAddressH)];
    [deviceAddressLabel setTexts:@[@"安装地址: ", @"合肥市培恩电器1"] warp:NO spacing:0.0f];
    deviceAddressLabel.textColor = [UIColor dx_999999Color];
    deviceAddressLabel.font = DFont(13);
    [view addSubview:deviceAddressLabel];
    self.deviceAddressLabel = deviceAddressLabel;
    
    CGFloat deviceDateX = CGRectGetMaxX(imageView.frame) + margin;
    CGFloat deviceDateY = CGRectGetMaxY(deviceAddressLabel.frame);
    CGFloat deviceDateW = UIScreenWidth - deviceNumX - buttonW;
    CGFloat deviceDateH = 24.0f;
    UILabel *deviceDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(deviceDateX, deviceDateY, deviceDateW, deviceDateH)];
    [deviceDateLabel setTexts:@[@"到期时间: ", @"2026-06-06(剩余306天)"] warp:NO spacing:0.0f];
    deviceDateLabel.textColor = [UIColor dx_999999Color];
    deviceDateLabel.font = DFont(13);
    [view addSubview:deviceDateLabel];
    self.deviceDateLabel = deviceDateLabel;
    
    UIButton * isOnlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat DPbuttonH = 44.0f;
    CGFloat DPButtonX = CGRectGetMaxX(view.frame) - margin - buttonW;
    isOnlineButton.frame = CGRectMake(DPButtonX, margin, buttonW, DPbuttonH);
    isOnlineButton.backgroundColor = [UIColor clearColor];
    [isOnlineButton setImage:IMAGE(@"right_arrow") forState:UIControlStateNormal];
    [isOnlineButton setTitle:@"在线" forState:UIControlStateNormal];
    isOnlineButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    isOnlineButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    isOnlineButton.titleLabel.font = DFont(12);
    [isOnlineButton setTitleColor:[UIColor dx_666666Color] forState:UIControlStateNormal];
    //左移图片，右移文字
    // 取出 titleLabel 的宽度
    CGFloat labelWidth02 = isOnlineButton.titleLabel.bounds.size.width;
    // 取出 imageView 的宽度
    CGFloat imageWidth02 = isOnlineButton.imageView.bounds.size.width;
    // 设置 titleLabel 的内边距
    isOnlineButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth02 + buttonW * 0.1, 0, imageWidth02);

    // 设置 imageView 的内边距
    isOnlineButton.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth02, 0, -labelWidth02);
    [view addSubview:isOnlineButton];
    self.isOnlineButton = isOnlineButton;
    
    
}

- (void)setModel:(KY_DeviceList_Model *)model
{
    _model = model;
    
    CGFloat margin = 10.0f;
    CGFloat buttonW = 80.0f;
    if (model.location.length != 0) {
        _model.cellHeight = 124.0f;
        
        self.deviceAddressLabel.hidden = NO;
        CGFloat deviceDateX = CGRectGetMaxX(self.ImageView.frame) + margin;
        CGFloat deviceDateY = CGRectGetMaxY(self.deviceAddressLabel.frame);
        CGFloat deviceDateW = UIScreenWidth - deviceDateX - buttonW;
        CGFloat deviceDateH = 24.0f;
        CGRect frame = self.deviceDateLabel.frame;
        frame.size.height = deviceDateH;
        frame.origin.x = deviceDateX;
        frame.origin.y = deviceDateY;
        frame.size.width = deviceDateW;
        self.deviceDateLabel.frame = frame;
        
        //设置安装地址
        NSString *loaction = [NSString stringWithFormat:@"%@", model.location];
        [self.deviceAddressLabel setTexts:@[@"安装地址: ", loaction] warp:NO spacing:0.0f];        
    } else {
        _model.cellHeight = 104.0f;
        self.deviceAddressLabel.hidden = YES;

        //设置
        CGFloat deviceDateX = CGRectGetMaxX(self.ImageView.frame) + margin;
        CGFloat deviceDateY = CGRectGetMaxY(self.deviceNameLabel.frame);
        CGFloat deviceDateW = UIScreenWidth - deviceDateX - buttonW;
        CGFloat deviceDateH = 24.0f;
        CGRect frame = self.deviceDateLabel.frame;
        frame.size.height = deviceDateH;
        frame.origin.x = deviceDateX;
        frame.origin.y = deviceDateY;
        frame.size.width = deviceDateW;
        self.deviceDateLabel.frame = frame;
    }
    //设置 设备编号
    NSString *title = [NSString stringWithFormat:@"%@", model.Title];
    [self.deviceNumLabel setTexts:@[@"设备编号: ", title] warp:NO spacing:0.0f];
    
    //设置 设备别名
    NSString *nick = [NSString stringWithFormat:@"%@", model.nick];
    [self.deviceNameLabel setTexts:@[@"设备别名: ", nick] warp:NO spacing:0.0f];
    
    //设置 到期时间
    NSString *time = [model.expire substringWithRange:NSMakeRange(0, 10)];
    NSString *date = [NSString stringWithFormat:@"%@(剩余%d天)", time, model.expireDay];
    [self.deviceDateLabel setTexts:@[@"到期时间: ", date] warp:NO spacing:0.0f];

    
    //改变detailView的高度
    CGFloat viewH = _model.cellHeight - margin;
    CGRect frame = self.backgroundView.frame;
    frame.size.height = viewH;
    frame.origin.x = margin;
    frame.origin.y = margin;
    frame.size.width = UIScreenWidth - margin * 2;
    self.detailView.frame = frame;
    
    //设置图标对齐view的中心位置
    CGFloat imageX = margin;
    CGFloat imageSize = 34.0f;
    CGFloat imageY = (viewH - imageSize) * 0.5;
    self.ImageView.frame = CGRectMake(imageX, imageY, imageSize, imageSize);
    if (model.status == 1) {
        //在线
        self.ImageView.image = IMAGE(@"io");
    } else {
        //离线
        self.ImageView.image = IMAGE(@"device_close");

    }
    
    //设置button对齐view的中心位置
    CGFloat buttonH = 44.0f;
    CGFloat buttonX = CGRectGetMaxX(self.detailView.frame) - buttonW - margin;
    CGFloat buttonY = (viewH - buttonH) * 0.5;
    self.isOnlineButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    if (model.status == 1) {
        //在线
        [self.isOnlineButton setTitle:@"在线" forState:UIControlStateNormal];
    } else {
        //离线
        [self.isOnlineButton setTitle:@"离线" forState:UIControlStateNormal];
    }
    
    
    
}

@end

//设备详情
@interface KY_HomePage_DeviceDetail_Cell ()

@property (nonatomic,weak) UIView *detailView;
@property (nonatomic,weak) UIImageView *ImageView;
@property (nonatomic,weak) UIButton *isOnlineButton;

@end

@implementation KY_HomePage_DeviceDetail_Cell

+(instancetype)KY_HomePage_DeviceDetail_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    KY_HomePage_DeviceDetail_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KY_HomePage_DeviceDetail_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    
    
    CGFloat imageViewX = margin;
    CGFloat imageViewW = 30.0f;
    CGFloat imageViewH = 30.0f;
    CGFloat imageViewY = (viewH - imageViewH) * 0.5;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    self.ImageView = imageView;
    
    CGFloat buttonW = 40.0f;
    
    CGFloat labelX = CGRectGetMaxX(imageView.frame) + margin;
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
        
    CGFloat lineW = CGRectGetWidth(view.frame);
    CGFloat lineH = 1.0f;
    CGFloat lineY = CGRectGetMaxY(view.frame) - lineH;
    CGFloat lineX = 0.0f;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
    lineView.backgroundColor = [UIColor dx_D9D9D9Color];
    [view addSubview:lineView];
    
    
}

- (void)setModel:(KY_DeviceDetail_Model *)model
{
    _model = model;
    self.ImageView.image = IMAGE(model.icon);
    self.TitleLabel.text = model.title;
}

@end


//打水记录
@interface KY_HomePage_WaterRecord_Cell ()

@property (nonatomic,weak) UIView *detailView;
@property (nonatomic,weak) UILabel *deviceNumLabel;
@property (nonatomic,weak) UILabel *deviceNickLabel;
@property (nonatomic,weak) UILabel *waterNumLabel;
@property (nonatomic,weak) UILabel *waterTimeLabel;
@property (nonatomic,weak) UILabel *waterTypeLabel;
@property (nonatomic,weak) UILabel *amountLabel;

@end

@implementation KY_HomePage_WaterRecord_Cell

+(instancetype)KY_HomePage_WaterRecord_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    KY_HomePage_WaterRecord_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KY_HomePage_WaterRecord_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)addAllViews
{
    CGFloat margin = 10.0f;
    CGFloat viewW = UIScreenWidth - margin * 2;
    CGFloat viewH = 94.0f;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, margin, viewW, viewH)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10.0f;
    [self.contentView addSubview:view];
    self.detailView = view;
    
    //设备编号 deviceNumLabel
    CGFloat deviceNumX = margin;
    CGFloat deviceNumY = margin;
    CGFloat deviceNumW = CGRectGetWidth(view.frame) * 0.5 - margin * 2;
    CGFloat deviceNumH = 26.0f;
    UILabel *deviceNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(deviceNumX, deviceNumY, deviceNumW, deviceNumH)];
    [deviceNumLabel setTexts:@[@"设备编号: ", @"18601"] warp:NO spacing:0.0f];
    deviceNumLabel.textColor = [UIColor dx_333333Color];
    deviceNumLabel.font = DFont(16);
    [view addSubview:deviceNumLabel];
    self.deviceNumLabel = deviceNumLabel;
    
    //打水方式 waterTypeLabel
    CGFloat waterTypeLabelX = CGRectGetMaxX(deviceNumLabel.frame);
    CGFloat waterTypeLabelY = margin;
    CGFloat waterTypeLabelW = CGRectGetWidth(view.frame) * 0.5 - margin * 2;
    CGFloat waterTypeLabelH = 26.0f;
    UILabel *waterTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(waterTypeLabelX, waterTypeLabelY, waterTypeLabelW, waterTypeLabelH)];
    waterTypeLabel.text = @"刷卡打水";
    waterTypeLabel.textColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    waterTypeLabel.font = DFont(16);
    [view addSubview:waterTypeLabel];
    self.waterTypeLabel = waterTypeLabel;
    
    //设备别名 deviceNickLabel
//    CGFloat deviceNickX = margin;
//    CGFloat deviceNickY = CGRectGetMaxY(deviceNumLabel.frame);
//    CGFloat deviceNickW = CGRectGetWidth(view.frame) * 0.5 - margin * 2;
//    CGFloat deviceNickH = 26.0f;
//    UILabel *deviceNickLabel = [[UILabel alloc] initWithFrame:CGRectMake(deviceNickX, deviceNickY, deviceNickW, deviceNickH)];
//    [deviceNickLabel setTexts:@[@"设备别名: ", @"18601"] warp:NO spacing:0.0f];
//    deviceNickLabel.textColor = [UIColor dx_666666Color];
//    deviceNickLabel.font = DFont(12);
//    [view addSubview:deviceNickLabel];
//    self.deviceNickLabel = deviceNickLabel;
    
    //打水量 waterNumLabel
    CGFloat waterNumLabelX = margin;
    CGFloat waterNumLabelY = CGRectGetMaxY(waterTypeLabel.frame);
    CGFloat waterNumLabelW = CGRectGetWidth(view.frame) * 0.5 - margin * 2;
    CGFloat waterNumLabelH = 26.0f;
    UILabel *waterNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(waterNumLabelX, waterNumLabelY, waterNumLabelW, waterNumLabelH)];
    [waterNumLabel setTexts:@[@"打水量: ", @"0.000升"] warp:NO spacing:0.0f];
    waterNumLabel.textColor = [UIColor dx_666666Color];
    waterNumLabel.font = DFont(15);
    [view addSubview:waterNumLabel];
    self.waterNumLabel = waterNumLabel;
    
    //金额 amountLabel
    CGFloat amountLabelX = CGRectGetMaxX(waterNumLabel.frame);
    CGFloat amountLabelY = CGRectGetMinY(waterNumLabel.frame);
    CGFloat amountLabelW = CGRectGetWidth(view.frame) * 0.5 - margin * 2;
    CGFloat amountLabelH = 26.0f;
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(amountLabelX, amountLabelY, amountLabelW, amountLabelH)];
    [amountLabel setTexts:@[@"金额: ", @"0.00元"] warp:NO spacing:0.0f];
    amountLabel.textColor = [UIColor dx_333333Color];
    amountLabel.font = DFont(15);
    [view addSubview:amountLabel];
    self.amountLabel = amountLabel;
    
    
    //打水时间 waterTimeLabel
    CGFloat waterTimeLabelX = margin;
    CGFloat waterTimeLabelY = CGRectGetMaxY(waterNumLabel.frame);
    CGFloat waterTimeLabelW = CGRectGetWidth(view.frame) - margin * 2;
    CGFloat waterTimeLabelH = 26.0f;
    UILabel *waterTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(waterTimeLabelX, waterTimeLabelY, waterTimeLabelW, waterTimeLabelH)];
    [waterTimeLabel setTexts:@[@"交易时间: ", @"2025-08-16 01:58:12"] warp:NO spacing:0.0f];
    waterTimeLabel.textColor = [UIColor dx_666666Color];
    waterTimeLabel.font = DFont(14);
    [view addSubview:waterTimeLabel];
    self.waterTimeLabel = waterTimeLabel;
    
}



- (void)setModel:(KY_WaterRecord_Model *)model
{
    _model = model;
    self.waterTypeLabel.text = [self waterPayTypeByString:model.transactionType];
    CGFloat waterF = model.water * 0.001;
    NSString *water = [NSString stringWithFormat:@"%0.3f升", waterF];
    [self.waterNumLabel setTexts:@[@"打水量: ", water] warp:NO spacing:0.0f];

    CGFloat moneyF =model.money * 0.01;
    NSString *money = [NSString stringWithFormat:@"%0.2f元", moneyF];
    [self.amountLabel setTexts:@[@"金额: ", money] warp:NO spacing:0.0f];
    
//substringToIndex:10];
    NSString *timeStr = [model.payTime substringToIndex:19];
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    [self.waterTimeLabel setTexts:@[@"交易时间: ", timeStr] warp:NO spacing:0.0f];
    
    NSString * deviceNumber = [NSString stringWithFormat:@"%d", model.did];
    [self.deviceNumLabel setTexts:@[@"设备编号: ", deviceNumber] warp:NO spacing:0.0f];
}

- (NSString *)waterPayTypeByString:(int)paytype
{
        switch (paytype) {
            case 1:
                return @"扫码打水";
                break;
            case 2:
                return @"运营商打水";
                break;
            case 3:
                return @"投币打水";
                break;
            case 4:
                return @"刷卡打水";
                break;
            case 5:
                return @"电子水卡打水";
                break;
            case 6:
                return @"实体卡充值";
                break;
            case 7:
                return @"电子水卡充值";
                break;
            case 8:
                return @"开发接口打水";
                break;
            default:
                return @"";
                break;
        }
}



@end

//设备最新状态
@interface KY_HomePage_DeviceDetailStatus_Cell ()

@property (nonatomic,weak) UIView *detailView;


@end

@implementation KY_HomePage_DeviceDetailStatus_Cell

+(instancetype)KY_HomePage_DeviceDetailStatus_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    KY_HomePage_DeviceDetailStatus_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KY_HomePage_DeviceDetailStatus_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)addAllViews
{
    CGFloat margin = 10.0f;
    CGFloat viewW = UIScreenWidth - margin * 2;
    CGFloat viewH = 44.0f;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, viewW, viewH)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10.0f;
    [self.contentView addSubview:view];
    self.detailView = view;
        
    CGFloat labelX = margin;
    CGFloat labelY = margin;
    CGFloat labelW = viewW * 0.5;
    CGFloat labelH = 24.0f;
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
//    [TitleLabel setTexts:@[@"设备编号: ", @"18601"] warp:NO spacing:0.0f];
    TitleLabel.textColor = [UIColor dx_333333Color];
    TitleLabel.font = DFont(14);
    [view addSubview:TitleLabel];
    self.TitleLabel = TitleLabel;
    
    CGFloat detailLabelX = CGRectGetMaxX(TitleLabel.frame);
    CGFloat detailLabelY = margin;
    CGFloat detailLabelW = viewW - detailLabelX -margin;
    CGFloat detailLabelH = 24.0f;
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(detailLabelX, detailLabelY, detailLabelW, detailLabelH)];
//    [TitleLabel setTexts:@[@"设备编号: ", @"18601"] warp:NO spacing:0.0f];
    detailLabel.textColor = [UIColor dx_666666Color];
    detailLabel.textAlignment = NSTextAlignmentRight;
    detailLabel.font = DFont(14);
    [view addSubview:detailLabel];
    self.DetailLabel = detailLabel;
    
        
    CGFloat lineW = CGRectGetWidth(view.frame);
    CGFloat lineH = 1.0f;
    CGFloat lineY = CGRectGetMaxY(view.frame) - lineH;
    CGFloat lineX = 0.0f;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
    lineView.backgroundColor = [UIColor dx_D9D9D9Color];
    [view addSubview:lineView];
    
    
}

- (void)setModel:(KY_DeviceDetailStatus_Model *)model
{
    _model = model;
    self.TitleLabel.text = model.title;
    self.DetailLabel.text = model.value;
}

@end


//设备最新 滤芯 状态
@interface KY_HomePage_DeviceDetailFilterStatus_Cell ()

@property (nonatomic,weak) UIView *detailView;
@property (nonatomic,weak) UILabel *numLabel;
@property (nonatomic,weak) UIView *statusView;
@property (nonatomic,weak) UIView *percentView;
@end

@implementation KY_HomePage_DeviceDetailFilterStatus_Cell

+(instancetype)KY_HomePage_DeviceDetailFilterStatus_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    KY_HomePage_DeviceDetailFilterStatus_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KY_HomePage_DeviceDetailFilterStatus_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)addAllViews
{
    CGFloat margin = 10.0f;
    CGFloat viewW = UIScreenWidth - margin * 2;
    CGFloat viewH = 44.0f;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, viewW, viewH)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10.0f;
    [self.contentView addSubview:view];
    self.detailView = view;
        
    CGFloat labelX = margin;
    CGFloat labelY = margin;
    CGFloat labelW = 30.0f;
    CGFloat labelH = 24.0f;
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
//    [TitleLabel setTexts:@[@"设备编号: ", @"18601"] warp:NO spacing:0.0f];
    TitleLabel.textColor = [UIColor dx_333333Color];
    TitleLabel.font = DFont(14);
    [view addSubview:TitleLabel];
    self.TitleLabel = TitleLabel;
    
    CGFloat buttonW = 60.0f;
    
    CGFloat statusX = CGRectGetMaxX(TitleLabel.frame);
    CGFloat statusY = margin;
    CGFloat statusH = 24.0f;
    CGFloat statusW = viewW - labelW - buttonW - margin * 3;
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(statusX, statusY, statusW, statusH)];
    statusView.layer.borderWidth = 1.0f;
    statusView.layer.borderColor = [[[UIColor dx_0FC70FColor] colorWithAlphaComponent:0.3f] CGColor];
    statusView.layer.cornerRadius = statusH * 0.5;
    statusView.layer.masksToBounds = YES;
    statusView.backgroundColor = [UIColor dx_C7C7C7Color];
    [view addSubview:statusView];
    self.statusView = statusView;
    
    
    CGFloat percentX = 0;
    CGFloat percentY = 0;
    CGFloat percentH = 24.0f;
    CGFloat percentW = (viewW - labelW - buttonW - margin * 3) * 0.5;
    UIView *percentView = [[UIView alloc] initWithFrame:CGRectMake(percentX, percentY, percentW, percentH)];
//    percentView.layer.borderWidth = 1.0f;
//    percentView.layer.borderColor = [[[UIColor dx_0FC70FColor] colorWithAlphaComponent:0.3f] CGColor];
//    percentView.layer.cornerRadius = statusH * 0.5;
//    percentView.layer.masksToBounds = YES;
    percentView.backgroundColor = [UIColor dx_0FC70FColor];
    [statusView addSubview:percentView];
    self.percentView = percentView;
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, statusW, statusH)];
    numLabel.text = @"0.00%";
    numLabel.textColor = [UIColor whiteColor];
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.font = DFont(16);
    [statusView addSubview:numLabel];
    self.numLabel = numLabel;
    
    
    CGFloat buttonX = CGRectGetMaxX(view.frame) - margin * 2 - buttonW;
    CGFloat buttonY = margin;
    CGFloat buttonH = 24.0f;
    UIButton * reSetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reSetButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    reSetButton.backgroundColor = [UIColor clearColor];
//    [reSetButton setImage:IMAGE(@"right_arrow") forState:UIControlStateNormal];
    [reSetButton setTitle:@"重置" forState:UIControlStateNormal];
    reSetButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    reSetButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    reSetButton.titleLabel.font = DFont(12);
    [reSetButton setTitleColor:[UIColor dx_0FC70FColor] forState:UIControlStateNormal];
    reSetButton.layer.borderWidth = 1.0f;
    reSetButton.layer.borderColor = [[[UIColor dx_0FC70FColor] colorWithAlphaComponent:0.3f] CGColor];
    reSetButton.layer.cornerRadius = buttonH * 0.5;
    reSetButton.layer.masksToBounds = YES;
    [view addSubview:reSetButton];
    self.reSetButton = reSetButton;
    
        
    CGFloat lineW = CGRectGetWidth(view.frame);
    CGFloat lineH = 1.0f;
    CGFloat lineY = CGRectGetMaxY(view.frame) - lineH;
    CGFloat lineX = 0.0f;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
    lineView.backgroundColor = [UIColor dx_D9D9D9Color];
    [view addSubview:lineView];
    
    
}

- (void)setModel:(KY_DeviceDetailStatus_Model *)model
{
    _model = model;
    self.TitleLabel.text = model.title;
    self.numLabel.text = [NSString stringWithFormat:@"%0.2f%%", [model.value floatValue]];
    
    CGFloat margin = 10.0f;
    CGFloat viewW = UIScreenWidth - margin * 2;
    CGFloat labelW = 30.0f;
    CGFloat buttonW = 60.0f;

    
    CGFloat percentX = 0;
    CGFloat percentY = 0;
    CGFloat percentH = 24.0f;
    CGFloat percentF = [model.value floatValue] * 0.01;
    CGFloat percentW = (viewW - labelW - buttonW - margin * 3) * percentF;
    self.percentView.frame = CGRectMake(percentX, percentY, percentW, percentH);
    
    
}

@end


//收入记录
@interface KY_HomePage_DeviceDetail_Income_Cell ()

@property (nonatomic,weak) UIView *detailView;
@property (nonatomic,weak) UILabel *thrashLabel;
@property (nonatomic,weak) UILabel *deviceNickLabel;
@property (nonatomic,weak) UILabel *moneyLabel;
@property (nonatomic,weak) UILabel *waterTimeLabel;
@property (nonatomic,weak) UILabel *payTypeLabel;
@property (nonatomic,weak) UILabel *deviceNumberLabel;

@end

@implementation KY_HomePage_DeviceDetail_Income_Cell

+(instancetype)KY_HomePage_DeviceDetail_Income_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    KY_HomePage_DeviceDetail_Income_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KY_HomePage_DeviceDetail_Income_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)addAllViews
{
    CGFloat margin = 10.0f;
    CGFloat viewW = UIScreenWidth - margin * 2;
    CGFloat viewH = 94.0f;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, margin, viewW, viewH)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10.0f;
    [self.contentView addSubview:view];
    self.detailView = view;
    
    //打水方式 thrashLabel
    CGFloat deviceNumX = margin;
    CGFloat deviceNumY = margin;
    CGFloat deviceNumW = CGRectGetWidth(view.frame) * 0.5 - margin * 2;
    CGFloat deviceNumH = 26.0f;
    UILabel *thrashLabel = [[UILabel alloc] initWithFrame:CGRectMake(deviceNumX, deviceNumY, deviceNumW, deviceNumH)];
    thrashLabel.text = @"扫码打水";
    thrashLabel.textColor = [UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f];
    thrashLabel.font = DFont(16);
    [view addSubview:thrashLabel];
    self.thrashLabel = thrashLabel;
    
    //支付方式 payTypeLabel
    CGFloat waterTypeLabelX = CGRectGetMaxX(thrashLabel.frame);
    CGFloat waterTypeLabelY = margin;
    CGFloat waterTypeLabelW = CGRectGetWidth(view.frame) * 0.5 - margin * 2;
    CGFloat waterTypeLabelH = 26.0f;
    UILabel *payTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(waterTypeLabelX, waterTypeLabelY, waterTypeLabelW, waterTypeLabelH)];
    [payTypeLabel setTexts:@[@"支付方式: ", @" 微信"] colors:@[[UIColor dx_666666Color], [UIColor dx_0FC70FColor]] warp:NO spacing:0.1f];
//    payTypeLabel.textColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    payTypeLabel.font = DFont(16);
    payTypeLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:payTypeLabel];
    self.payTypeLabel = payTypeLabel;
    
    //设备别名 deviceNickLabel
//    CGFloat deviceNickX = margin;
//    CGFloat deviceNickY = CGRectGetMaxY(deviceNumLabel.frame);
//    CGFloat deviceNickW = CGRectGetWidth(view.frame) * 0.5 - margin * 2;
//    CGFloat deviceNickH = 26.0f;
//    UILabel *deviceNickLabel = [[UILabel alloc] initWithFrame:CGRectMake(deviceNickX, deviceNickY, deviceNickW, deviceNickH)];
//    [deviceNickLabel setTexts:@[@"设备别名: ", @"18601"] warp:NO spacing:0.0f];
//    deviceNickLabel.textColor = [UIColor dx_666666Color];
//    deviceNickLabel.font = DFont(12);
//    [view addSubview:deviceNickLabel];
//    self.deviceNickLabel = deviceNickLabel;
    
    //金额 moneyLabel
    CGFloat moneyLabelX = margin;
    CGFloat moneyLabelY = CGRectGetMaxY(thrashLabel.frame);
    CGFloat moneyLabelW = CGRectGetWidth(view.frame) * 0.5 - margin * 2;
    CGFloat moneyLabelH = 26.0f;
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyLabelX, moneyLabelY, moneyLabelW, moneyLabelH)];
    [moneyLabel setTexts:@[@"金额: ", @"0.27元"] warp:NO spacing:0.0f];
    moneyLabel.textColor = [UIColor dx_666666Color];
    moneyLabel.font = DFont(15);
    [view addSubview:moneyLabel];
    self.moneyLabel = moneyLabel;
    
    //设备 deviceNumberLabel
    CGFloat deviceNumberLabelX = CGRectGetMaxX(moneyLabel.frame);
    CGFloat deviceNumberLabelY = CGRectGetMinY(moneyLabel.frame);
    CGFloat deviceNumberLabelW = CGRectGetWidth(view.frame) * 0.5 - margin * 2;
    CGFloat deviceNumberLabelH = 26.0f;
    UILabel *deviceNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(deviceNumberLabelX, deviceNumberLabelY, deviceNumberLabelW, deviceNumberLabelH)];
    [deviceNumberLabel setTexts:@[@"设备: ", @"18602"] warp:NO spacing:0.0f];
    deviceNumberLabel.textColor = [UIColor dx_333333Color];
    deviceNumberLabel.font = DFont(15);
    deviceNumberLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:deviceNumberLabel];
    self.deviceNumberLabel = deviceNumberLabel;
    
    
    //打水时间 waterTimeLabel
    CGFloat waterTimeLabelX = margin;
    CGFloat waterTimeLabelY = CGRectGetMaxY(moneyLabel.frame);
    CGFloat waterTimeLabelW = CGRectGetWidth(view.frame) - margin * 2;
    CGFloat waterTimeLabelH = 26.0f;
    UILabel *waterTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(waterTimeLabelX, waterTimeLabelY, waterTimeLabelW, waterTimeLabelH)];
    [waterTimeLabel setTexts:@[@"交易时间: ", @"2025-08-16 01:58:12"] warp:NO spacing:0.0f];
    waterTimeLabel.textColor = [UIColor dx_666666Color];
    waterTimeLabel.font = DFont(14);
    [view addSubview:waterTimeLabel];
    self.waterTimeLabel = waterTimeLabel;
    
}

- (void)setModel:(KY_Income_Model *)model
{
    _model = model;
    self.thrashLabel.text = [self waterTransactionTypeByString:model.transactionType];
    NSString *payStr = [NSString stringWithFormat:@" %@", [self waterPayTypeByString:model.payType]];
    [self.payTypeLabel setTexts:@[@"支付方式: ", payStr] colors:@[[UIColor dx_666666Color], [UIColor dx_0FC70FColor]] warp:NO spacing:0.1f];
    CGFloat moneyF = model.money * 0.01;
    NSString *money = [NSString stringWithFormat:@"%0.2f元", moneyF];
    [self.moneyLabel setTexts:@[@"金额: ", money] warp:NO spacing:0.0f];
    
    NSString *timeStr = [model.payTime substringToIndex:19];
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    [self.waterTimeLabel setTexts:@[@"交易时间: ", timeStr] warp:NO spacing:0.0f];
    
    NSString *number = [NSString stringWithFormat:@"%d", model.did];

    [self.deviceNumberLabel setTexts:@[@"设备编号: ", number] warp:NO spacing:0.0f];

}

//- (void)setDeviceNumber:(NSString *)deviceNumber
//{
//    _deviceNumber = deviceNumber;
//    [self.deviceNumberLabel setTexts:@[@"设备编号: ", deviceNumber] warp:NO spacing:0.0f];
//}

- (NSString *)waterPayTypeByString:(int)type
{
//    1微信 2支付宝 3投币 4实体水卡 5扫码余额 6线下直冲 7无需支付 8自动充值;
        switch (type) {
            case 1:
                return @"微信";
                break;
            case 2:
                return @"支付宝";
                break;
            case 3:
                return @"投币";
                break;
            case 4:
                return @"实体水卡";
                break;
            case 5:
                return @"扫码余额";
                break;
            case 6:
                return @"线下直冲";
                break;
            case 7:
                return @"无需支付";
                break;
            case 8:
                return @"自动充值";
                break;
            default:
                return @"";
                break;
        }
}



- (NSString *)waterTransactionTypeByString:(int)type
{
        switch (type) {
            case 1:
                return @"扫码打水";
                break;
            case 2:
                return @"运营商打水";
                break;
            case 3:
                return @"投币打水";
                break;
            case 4:
                return @"刷卡打水";
                break;
            case 5:
                return @"电子水卡打水";
                break;
            case 6:
                return @"实体卡充值";
                break;
            case 7:
                return @"电子水卡充值";
                break;
            case 8:
                return @"开发接口打水";
                break;
            default:
                return @"";
                break;
        }
}





@end


//设备最新状态
@interface KY_HomePage_DeviceDetail_ParamenterSetting_Cell ()

@property (nonatomic,weak) UIView *detailView;


@end

@implementation KY_HomePage_DeviceDetail_ParamenterSetting_Cell

+(instancetype)KY_HomePage_DeviceDetail_ParamenterSetting_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    KY_HomePage_DeviceDetail_ParamenterSetting_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KY_HomePage_DeviceDetail_ParamenterSetting_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)addAllViews
{
    CGFloat margin = 10.0f;
    CGFloat viewW = UIScreenWidth - margin * 2;
    CGFloat viewH = 44.0f;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, viewW, viewH)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10.0f;
    [self.contentView addSubview:view];
    self.detailView = view;
        
    CGFloat labelX = margin;
    CGFloat labelY = margin;
    CGFloat labelW = viewW * 0.5;
    CGFloat labelH = 24.0f;
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    [TitleLabel setTexts:@[@"售水单价", @""] warp:NO spacing:0.0f];
    TitleLabel.textColor = [UIColor dx_333333Color];
    TitleLabel.font = DFont(14);
    [view addSubview:TitleLabel];
    self.TitleLabel = TitleLabel;
    
    CGFloat iconFrame = 20.0f;
    
    CGFloat detailLabelX = CGRectGetMaxX(TitleLabel.frame);
    CGFloat detailLabelY = margin;
    CGFloat detailLabelW = viewW - detailLabelX - margin - iconFrame;
    CGFloat detailLabelH = 24.0f;
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(detailLabelX, detailLabelY, detailLabelW, detailLabelH)];
    [detailLabel setTexts:@[@"0.27", @"元/升"] colors:@[[UIColor dx_333333Color], [UIColor dx_666666Color]] warp:NO spacing:0.0f];
    detailLabel.textAlignment = NSTextAlignmentRight;
    detailLabel.font = DFont(14);
    [view addSubview:detailLabel];
    self.DetailLabel = detailLabel;
    
    
    //第一行输入框后的小图标
    CGFloat iconX = CGRectGetMaxX(detailLabel.frame);
    CGFloat iconY = margin;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconFrame, iconFrame)];
    imageView.image = IMAGE(@"right_arrow");
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
//    self.iconImageView = imageView;
        
    CGFloat lineW = CGRectGetWidth(view.frame);
    CGFloat lineH = 1.0f;
    CGFloat lineY = CGRectGetMaxY(view.frame) - lineH;
    CGFloat lineX = 0.0f;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
    lineView.backgroundColor = [UIColor dx_D9D9D9Color];
    [view addSubview:lineView];
    
    
}

- (void)setModel:(KY_DeviceDetail_parameterSetting_Model *)model
{
    _model = model;
    self.TitleLabel.text = model.title;
    [self.DetailLabel setTexts:@[model.value, model.unit] colors:@[[UIColor dx_333333Color], [UIColor dx_999999Color]] warp:NO spacing:0.1f];
}

@end


@interface KY_HomePage_UserManage_Cell ()

@property (nonatomic,weak) UIView *detailView;
@property (nonatomic,weak) UILabel *userPhoneLabel;
@property (nonatomic,weak) UILabel *moneyLabel;
@property (nonatomic,weak) UILabel *indateLabel;
@property (nonatomic,weak) UILabel *createTimeLabel;
@end

@implementation KY_HomePage_UserManage_Cell

+(instancetype)KY_HomePage_UserManage_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    KY_HomePage_UserManage_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KY_HomePage_UserManage_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)addAllViews
{
    CGFloat margin = 10.0f;
    CGFloat viewW = UIScreenWidth - margin * 2;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, margin, viewW, 84)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10.0f;
    [self.contentView addSubview:view];
    self.detailView = view;
    
    CGFloat userPhoneX = margin;
    CGFloat userPhoneY = margin;
    CGFloat userPhoneW = viewW - margin * 2;
    CGFloat userPhoneH = 24.0f;
    UILabel *userPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(userPhoneX, userPhoneY, userPhoneW, userPhoneH)];
    [userPhoneLabel setTexts:@[@"手机号: ", @"13872003255"] warp:NO spacing:0.0f];
    userPhoneLabel.textColor = [UIColor dx_333333Color];
    userPhoneLabel.font = DFont(14);
    [view addSubview:userPhoneLabel];
    self.userPhoneLabel = userPhoneLabel;
    
    CGFloat iconSize = 20.0f;
    CGFloat iconX = viewW - margin - iconSize;
    CGFloat iconY = CGRectGetMidY(view.frame) - iconSize;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconSize, iconSize)];
    imageView.image = IMAGE(@"right_arrow");
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    
    CGFloat moneyX = margin;
    CGFloat moneyY = CGRectGetMaxY(userPhoneLabel.frame);
    CGFloat moneyW = (iconX - margin) * 0.5;
    CGFloat moneyH = 24.0f;
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyX, moneyY, moneyW, moneyH)];
    [moneyLabel setTexts:@[@"余额: ", @"400.00元"] warp:NO spacing:0.0f];
    moneyLabel.textColor = [UIColor dx_666666Color];
    moneyLabel.font = DFont(12);
    [view addSubview:moneyLabel];
    self.moneyLabel = moneyLabel;
    
    CGFloat indateX = CGRectGetMaxX(moneyLabel.frame);
    CGFloat indateY = moneyY;
    CGFloat indateW = (iconX - margin) * 0.5;
    CGFloat indateH = 24.0f;
    UILabel *indateLabel = [[UILabel alloc] initWithFrame:CGRectMake(indateX, indateY, indateW, indateH)];
    [indateLabel setTexts:@[@"体测有效期: ", @"2026-08-20"] warp:NO spacing:0.0f];
    indateLabel.textColor = [UIColor dx_666666Color];
    indateLabel.font = DFont(12);
    [view addSubview:indateLabel];
    self.indateLabel = indateLabel;
    

    CGFloat createTimeX = margin;
    CGFloat createTimeY = CGRectGetMaxY(moneyLabel.frame);
    CGFloat createTimeW = viewW - margin * 2 - iconSize;
    CGFloat createTimeH = 24.0f;
    UILabel *createTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(createTimeX, createTimeY, createTimeW, createTimeH)];
    [createTimeLabel setTexts:@[@"创建时间: ", @"2025-08-20"] warp:NO spacing:0.0f];
    createTimeLabel.textColor = [UIColor dx_666666Color];
    createTimeLabel.font = DFont(12);
    [view addSubview:createTimeLabel];
    self.createTimeLabel = createTimeLabel;
    
    
}

- (void)setModel:(KY_UserList_Model *)model
{
    _model = model;
    NSString *mobile = [NSString stringWithFormat:@"%@", model.mobile];
    [self.userPhoneLabel setTexts:@[@"手机号: ", mobile] warp:NO spacing:0.0f];
    
    NSString *balance = [NSString stringWithFormat:@"%0.2f", model.balance * 0.01];
    [self.moneyLabel setTexts:@[@"余额: ", balance] warp:NO spacing:0.0f];

    NSString *medical = [NSString stringWithFormat:@"%@", [model.medical substringToIndex:10]];
    [self.indateLabel setTexts:@[@"体测有效期: ", medical] warp:NO spacing:0.0f];
    
    NSString *CreatedAt = [NSString stringWithFormat:@"%@", [model.CreatedAt substringToIndex:10]];
    [self.createTimeLabel setTexts:@[@"创建时间: ", CreatedAt] warp:NO spacing:0.0f];

}

@end

//用户详情
@interface KY_HomePage_UserDetail_Cell ()

@property (nonatomic,weak) UIView *detailView;
@property (nonatomic,weak) UILabel *userPhoneLabel;
@property (nonatomic,weak) UIImageView *rightIcon;

@end

@implementation KY_HomePage_UserDetail_Cell

+(instancetype)KY_HomePage_UserDetail_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    KY_HomePage_UserDetail_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KY_HomePage_UserDetail_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)addAllViews
{
    CGFloat margin = 10.0f;
    CGFloat viewW = UIScreenWidth - margin * 2;
    CGFloat viewH = 74.0f;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, viewW, viewH)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10.0f;
    [self.contentView addSubview:view];
    self.detailView = view;
    
    CGFloat userPhoneX = margin;
    CGFloat userPhoneY = margin;
    CGFloat userPhoneW = viewW - margin * 2;
    CGFloat userPhoneH = 24.0f;
    UILabel *userPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(userPhoneX, userPhoneY, userPhoneW, userPhoneH)];
    [userPhoneLabel setTexts:@[@"手机号: ", @"13872003255"] warp:NO spacing:0.0f];
    userPhoneLabel.textColor = [UIColor dx_333333Color];
    userPhoneLabel.font = DFont(14);
    [view addSubview:userPhoneLabel];
    self.userPhoneLabel = userPhoneLabel;
    
    CGFloat iconSize = 20.0f;
    CGFloat iconX = viewW - margin - iconSize;
    
    CGFloat detailLabelW = iconX;
    CGFloat detailLabelX = margin;
    CGFloat detailLabelY = CGRectGetMaxY(userPhoneLabel.frame);
    CGFloat detailLabelH = 34.0f;
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(detailLabelX, detailLabelY, detailLabelW, detailLabelH)];
    detailLabel.text = @"13872003255";
    detailLabel.textColor = [UIColor dx_333333Color];
    detailLabel.font = DFont(14);
    detailLabel.userInteractionEnabled = YES;
    [view addSubview:detailLabel];
    self.detailLabel = detailLabel;
    
    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailLabelTapAction:)];
    [detailLabel addGestureRecognizer:TapGesture];
    

    
    CGFloat iconY = CGRectGetMidY(detailLabel.frame) - iconSize;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconSize, iconSize)];
    imageView.image = IMAGE(@"right_arrow");
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    self.rightIcon = imageView;
    
}

- (void)setModel:(KY_UserDetail_Model *)model
{
    _model = model;
    
    self.userPhoneLabel.text = model.title;
    self.detailLabel.text = model.value;
    
    if (([model.title isEqualToString:@"手机号"]) || ([model.title isEqualToString:@"创建时间"])) {
        self.rightIcon.hidden = YES;
        
    } else {
        self.rightIcon.hidden = NO;
    }
    
    if (([model.title isEqualToString:@"账号余额"]) || ([model.title isEqualToString:@"体测权限"])) {
        self.detailLabel.textColor = [UIColor colorWithRed:170.0f / 255.0f green:128.0f / 255.0f blue:70.0f / 255.0f alpha:1];
    } else{
        self.detailLabel.textColor = [UIColor dx_333333Color];
    }
    
}

- (void)detailLabelTapAction:(UIGestureRecognizer *)gesture
{
    if (_delegate && [_delegate respondsToSelector:@selector(kY_HomePage_UserDetail_CellLabelTapAction:)]) {
        [_delegate kY_HomePage_UserDetail_CellLabelTapAction:self];
    }
}

@end


//水卡列表 cell
@interface KY_HomePage_waterCardManage_Cell ()

@property (nonatomic,weak) UIView *detailView;
@property (nonatomic,weak) UILabel *waterCardNumLabel;
@property (nonatomic,weak) UILabel *balanceLabel;
@property (nonatomic,weak) UIButton *rechargeButton;
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *itemLabelArray;

@end

@implementation KY_HomePage_waterCardManage_Cell

+(instancetype)KY_HomePage_waterCardManage_CellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    KY_HomePage_waterCardManage_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KY_HomePage_waterCardManage_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    
    CGFloat waterCardNumX = margin;
    CGFloat waterCardNumY = margin;
    CGFloat waterCardNumW = viewW - margin * 2;
    CGFloat waterCardNumH = 24.0f;
    UILabel *waterCardNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(waterCardNumX, waterCardNumY, waterCardNumW, waterCardNumH)];
    [waterCardNumLabel setTexts:@[@"卡号: ", @"13872003255"] warp:NO spacing:0.0f];
    waterCardNumLabel.textColor = [UIColor dx_333333Color];
    waterCardNumLabel.font = DFont(14);
    [view addSubview:waterCardNumLabel];
    self.waterCardNumLabel = waterCardNumLabel;
    
    
    CGFloat rechargeButtonW = 80.0f;
    CGFloat rechargeButtonH = 34.0f;
    CGFloat rechargeButtonX = viewW - margin - rechargeButtonW;
    CGFloat rechargeButtonY = (viewH - rechargeButtonH) * 0.5;
    
    UIButton *rechargeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rechargeButton.frame = CGRectMake(rechargeButtonX, rechargeButtonY, rechargeButtonW, rechargeButtonH);
    
    rechargeButton.backgroundColor = [UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f];
    rechargeButton.titleLabel.font = DFont(15);
    rechargeButton.layer.borderWidth = 0.01f;
    rechargeButton.layer.borderColor = [UIColor colorWithRed:20.0f/255.0f green:80.0f/255.0f blue:200.0f/255.0f alpha:0.7f].CGColor;
    rechargeButton.layer.cornerRadius = rechargeButtonH * 0.5;
    rechargeButton.layer.masksToBounds = YES;
    rechargeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [rechargeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rechargeButton setTitle:@"充值" forState:UIControlStateNormal];
    [rechargeButton addTarget:self action:@selector(rechargeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:rechargeButton];
    
    CGFloat balanceLabelW = rechargeButtonX;
    CGFloat balanceLabelX = margin;
    CGFloat balanceLabelY = CGRectGetMaxY(waterCardNumLabel.frame);
    CGFloat balanceLabelH = 24.0f;
    UILabel *balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(balanceLabelX, balanceLabelY, balanceLabelW, balanceLabelH)];
//    [balanceLabel setTexts:@[@"卡号: ", @"13872003255"] warp:NO spacing:0.0f];
    
    balanceLabel.textColor = [UIColor dx_333333Color];
    balanceLabel.font = DFont(14);
    balanceLabel.userInteractionEnabled = YES;
    [view addSubview:balanceLabel];
    self.balanceLabel = balanceLabel;
    
}

- (void)setModel:(KY_WaterCardList_Model *)model
{
    _model = model;
    
    NSString *waterCardNumStr = [NSString stringWithFormat:@"%@", model.cardNo];
    [self.waterCardNumLabel setTexts:@[@"卡号: ", waterCardNumStr] warp:NO spacing:0.0f];

    CGFloat balanceF = model.balance * 0.01;
    NSString *balanceStr = [NSString stringWithFormat:@"%0.2f元", balanceF];
    [self.balanceLabel setTexts:@[@"余额: ", balanceStr] colors:@[[UIColor dx_666666Color], [UIColor colorWithRed:170.0f / 255.0f green:128.0f / 255.0f blue:70.0f / 255.0f alpha:1]] warp:NO spacing:0.1f];
    
}

- (void)rechargeButtonAction:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(KY_HomePage_waterCardManage_CellRechargeButtonAction:)]) {
        [_delegate KY_HomePage_waterCardManage_CellRechargeButtonAction:self];
    }
}


- (void)setItemArray:(NSArray *)itemArray
{
    _itemArray = itemArray;
    //先移除所有子视图itemLabel
    for (UILabel *label in self.itemLabelArray) {
        [label removeFromSuperview];
    }

    for (int i = 0; i < itemArray.count; i++) {
        KY_CreateNewCard_Group_ItemList_Model *model = itemArray[i];
        NSString *money = [NSString stringWithFormat:@"%0.2f", model.money * 0.01];
        NSString *give = [NSString stringWithFormat:@"%0.2f", model.give * 0.01];
        UILabel *label = [self createdItemLabelViewWithMoney:money WithRecharge:give WithIndex:i];
        [self.scrollView addSubview:label];
        [self.itemLabelArray addObject:label];
    }
    
}


//创建 充值itemLabel
- (UILabel *)createdItemLabelViewWithMoney:(NSString *)money WithRecharge:(NSString *)recharge WithIndex:(int)index
{
    CGFloat margin = 10.0f;
    CGFloat scrollW = UIScreenWidth - margin * 2;
    CGFloat itemsW = scrollW * 0.33;
    
    CGFloat itemsX = (margin + itemsW) * index;
    CGFloat itemsY = margin;
    CGFloat itemsH = 50.0f;
    UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(itemsX, itemsY, itemsW, itemsH)];
    itemLabel.textAlignment = NSTextAlignmentCenter;
//    [itemLabel setTexts:@[@"充200.00元", @" 送300.00元"] colors:@[[UIColor dx_666666Color], [UIColor dx_999999Color]] fonts:@[DFont(14), DFont(12)] warp:YES spacing:0.0f];
    [itemLabel setTexts:@[@"充 ", money, @" 元", @"送 ", recharge, @" 元"] colors:@[[UIColor dx_666666Color], [UIColor dx_666666Color], [UIColor dx_666666Color], [UIColor dx_999999Color], [UIColor dx_999999Color], [UIColor dx_999999Color]] fonts:@[DFont(14), DFont(14), DFont(14), DFont(12), DFont(14), DFont(14)] warps:@[@"0" ,@"0",@"1", @"0", @"0", @"0"] spacing:0.0f];
    itemLabel.layer.borderWidth = 0.5f;
    itemLabel.layer.borderColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3f] CGColor];
    itemLabel.layer.cornerRadius = 8.0f;
    itemLabel.layer.masksToBounds = YES;
    itemLabel.tag = 30000 + index;
    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItemLabel:)];
    [itemLabel addGestureRecognizer:TapGesture];
    itemLabel.userInteractionEnabled = YES;
    return itemLabel;
}




@end
