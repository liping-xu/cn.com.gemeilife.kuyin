//
//  POPView.m
//  财经天气预报
//
//  Created by 邓川江 on 14-10-22.
//  Copyright (c) 2014年 Chuanjiang.Deng. All rights reserved.
//

#import "POPView.h"

@implementation POPView
-(id)initWithAlertViewTitle:(NSString *)title placeholder:(NSString *)placeholder keyboardType:(UIKeyboardType)keyboardType  text:(NSString*)text buttonTitles:(NSArray *)titles cancelButton:(CancelButton)cancelButton confirmButton:(ConfirmButton)confirmButton{
    CGRect frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat alertWidth = 280;
        NSArray *arr = [self buildBackAndLabel:alertWidth];
        UIView  *back = arr[0];
        UILabel *titleLabel = arr[1];
        titleLabel.text = title;
        POPTextField *textField = [[POPTextField alloc]initWithFrame:CGRectMake(10, AHeight(titleLabel.frame.size.height+titleLabel.frame.origin.y+25), back.frame.size.width-20, AHeight(35))];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, AHeight(20))];
        textField.leftView = paddingView;
        textField.keyboardType = keyboardType;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.tag = 101;
        textField.text = text;
        textField.delegate = self;
        textField.placeholder = placeholder;
        textField.layer.cornerRadius = 3;
        textField.textColor = [UIColor dx_666666Color];
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = [[[UIColor grayColor] colorWithAlphaComponent:.7]CGColor];
        [textField becomeFirstResponder];
        [back addSubview:textField];
        
        [self buildButtons:titles lastView:textField back:back];
        _cancelButton = cancelButton;
        _confrimButton = confirmButton;
        [self POPView:1];
    }
    return self;
}
-(id)initWithAlertViewTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)titles cancelButton:(CancelButton)cancelButton confirmButton:(ConfirmButton)confirmButton{
    CGRect frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat alertWidth = 280;
        NSArray *arr = [self buildBackAndLabel:alertWidth];
        UIView  *back = arr[0];
        UILabel *titleLabel = arr[1];
        titleLabel.text = title;

        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [paragraphStyle setParagraphSpacing:0];
        paragraphStyle.alignment = NSTextAlignmentLeft;
        NSDictionary *attribs = @{NSFontAttributeName:DFont(15), NSParagraphStyleAttributeName:paragraphStyle};
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:message
                                                                                          attributes:attribs];
        NSTextAlignment textAlignment = NSTextAlignmentLeft;
        CGSize size = [attributedText boundingRectWithSize:CGSizeMake(alertWidth - (AHeight(20)), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        if (size.height < (AHeight(30))) {
            textAlignment = NSTextAlignmentCenter;
        }
        if (size.height < (AHeight(60))) {
            size.height = (AHeight(60));
        }
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(AHeight(10), titleLabel.frame.size.height, back.frame.size.width - (AHeight(20)), size.height + 10)];
        messageLabel.attributedText = attributedText;
        messageLabel.textColor = [UIColor dx_666666Color];
        messageLabel.numberOfLines = 0;
        messageLabel.font = DFont(15);
        messageLabel.textAlignment = textAlignment;
        messageLabel.backgroundColor = [UIColor clearColor];
        [back addSubview:messageLabel];
        
        [self buildTitleButtons:titles lastView:messageLabel back:back];
        [self POPView:1];
        
        _cancelButton = cancelButton;
        _confrimButton = confirmButton;
    }
    return self;
}

/*
 *创建俩按钮
 */
-(void)buildTitleButtons:(NSArray *)titles lastView:(UIView *)view back:(UIView *)back{
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(back.frame.size.width/titles.count), AHeight(view.frame.size.height+view.frame.origin.y), back.frame.size.width/titles.count, AHeight(40));
        [btn setTitleColor:(i==0)?[UIColor grayColor]:[UIColor redColor] forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.tag = i+20;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [back addSubview:btn];
        if (i==0) {
            back.frame = CGRectMake((self.frame.size.width-back.frame.size.width)/2, (UIScreenHeight - (btn.frame.size.height+btn.frame.origin.y)) / 2, back.frame.size.width,btn.frame.size.height+btn.frame.origin.y);
        }
        CALayer *mask = [CALayer layer];
        [mask setBackgroundColor:[[UIColor blackColor] CGColor]];
        [[btn layer] setBorderWidth:.5];
        CGRect maskFrame = CGRectInset([btn bounds], 0, .5);
        maskFrame.origin.y = 0;
        maskFrame.origin.x = (i==0)?1:-1;//偏移CALayer,使其生成上/(左/右)边框
        [mask setFrame:maskFrame];
        [[btn layer] setMask:mask];
        btn.layer.borderColor = [UICOLORRGB(154, 154, 154) CGColor];
    }
}

/*
 *创建俩按钮
 */
-(void)buildButtons:(NSArray *)titles lastView:(UIView *)view back:(UIView *)back{
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(back.frame.size.width/titles.count), AHeight(view.frame.size.height+view.frame.origin.y+25), back.frame.size.width/titles.count, AHeight(40));
        [btn setTitleColor:(i==0)?[UIColor grayColor]:[UIColor redColor] forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.tag = i+20;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [back addSubview:btn];
        if (i==0) {
            back.frame = CGRectMake((self.frame.size.width-back.frame.size.width)/2, AHeight(90), back.frame.size.width,btn.frame.size.height+btn.frame.origin.y);
        }
        CALayer *mask = [CALayer layer];
        [mask setBackgroundColor:[[UIColor blackColor] CGColor]];
        [[btn layer] setBorderWidth:.5];
        CGRect maskFrame = CGRectInset([btn bounds], 0, .5);
        maskFrame.origin.y = 0;
        maskFrame.origin.x = (i==0)?1:-1;//偏移CALayer,使其生成上/(左/右)边框
        [mask setFrame:maskFrame];
        [[btn layer] setMask:mask];
        btn.layer.borderColor = [UICOLORRGB(154, 154, 154) CGColor];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
/*
 *创建标题\背景
 */
-(NSArray *)buildBackAndLabel:(CGFloat)alertWidth{
    self.alpha = 0;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3];

    UIView *back = [[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width-alertWidth)/2, self.frame.size.height/2-80, alertWidth, AHeight(220))];
    back.layer.cornerRadius = 3;
    back.tag = 100;
    back.backgroundColor = [UIColor whiteColor];
    back.layer.shadowColor = [UIColor blackColor].CGColor;
    back.layer.shadowOffset = CGSizeMake(1,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    back.layer.shadowOpacity = 0.6;// 透明度
    back.layer.shadowRadius = 4;// 半径
    [self addSubview:back];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, back.frame.size.width, AHeight(35))];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor colorWithPatternImage:IMAGE(@"titleBg")];
    
    UIRectCorner corners;
    corners =  UIRectCornerTopRight | UIRectCornerTopLeft;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:back.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(3, 3)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = back.bounds;
    maskLayer.path          = maskPath.CGPath;
    titleLabel.layer.mask   = maskLayer;
    [back addSubview:titleLabel];
    return @[back,titleLabel];
}
-(void)btnAction:(UIButton *)button{
    UIView *back = (UIView *)[self viewWithTag:100];
    POPTextField *textfield = (POPTextField *)[back viewWithTag:101];
    if (button.tag==20) {
        _cancelButton(button.tag);
    } else {
        _confrimButton(button.tag,textfield.text);
    }
    [self POPView:0];
}

-(void)POPView:(NSInteger)alpha{
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^(void){
        self.alpha = alpha;
    } completion:^(BOOL finished){
        if (!alpha) {
            [self removeFromSuperview];
        }
    }];
}
-(id)initWithBox:(NSString *)message{
    CGRect frame = [[UIScreen mainScreen]bounds];
    self = [super initWithFrame:frame];
    if (self) {
        CGSize size = [message sizeWithFont:DFont(15) maxSize:CGSizeMake(220, MAXFLOAT)];
        CGFloat height = size.height;
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 110, (UIScreenHeight - height - 84) / 2, 220, height + 20)];
        back.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
//        back.alpha = 0;
//        [self backShowAtAnimtaiton:back];
        [self addSubview:back];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, back.frame.size.width, back.frame.size.height)];
        label.backgroundColor = [UIColor clearColor];
        label.text = message;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
//        label.adjustsFontSizeToFitWidth = YES;
//        label.numberOfLines = 0;
        label.font = DFontWithTile(15);
        label.textColor = [UIColor whiteColor];
        [back addSubview:label];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(removeSelf) userInfo:nil repeats:NO];
    }
    return self;
    
}
-(void)removeSelf{
    [timer invalidate];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

-(void)backShowAtAnimtaiton:(UIView *)back{
    [UIView animateWithDuration:0.2 animations:^{
        back.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finished) {
        
    }];
}


-(id)initWithActivity:(NSString *)message;
{
    CGRect frame = [[UIScreen mainScreen]bounds];
    self = [super initWithFrame:frame];
    if (self) {
        CGSize size = [message sizeWithFont:DFont(13) maxSize:CGSizeMake(220, MAXFLOAT)];
        CGFloat wi = size.width;
        CGFloat height = AHeight(50);
        if (message && ![message isEqualToString:@""]) {
            if (wi < 80) {
                wi = AHeight(50);
            }
            height = AHeight(50);
        } else {
            wi = AHeight(50);
        }
        indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, wi, height)];
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [indicator setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)];
        indicator.backgroundColor = [UIColor blackColor];
        indicator.alpha = 0.9;
        indicator.layer.cornerRadius = 3;
        indicator.layer.masksToBounds = YES;
        [indicator startAnimating];
        [self addSubview:indicator];
        if (message && ![message isEqualToString:@""]) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, indicator.frame.size.width, 30)];
            lab.font = [UIFont systemFontOfSize:13];
            lab.text = message;
            lab.textColor = [UIColor whiteColor];
            lab.backgroundColor = [UIColor clearColor];
            lab.textAlignment = NSTextAlignmentCenter;
            [indicator addSubview:lab];
        }
        
    }
    return self;
}


+(void)WindowAddSubview:(POPView *)view{
    UIWindow *Window = [[[UIApplication sharedApplication]windows]objectAtIndex:0];
    [Window addSubview:view];
}
@end


@implementation POPTextField
-(id)initWithToolbarFeild:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
        toolbar.backgroundColor = [UIColor grayColor];
        [self setInputAccessoryView:toolbar];
        
        NSArray *title = @[@"上一个",@"下一个",@"确认",@"取消"];
        for (int i = 0; i < title.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i<=1?(i*50):(toolbar.frame.size.width - 200)+i*50, 0, 50, 35);
            [btn setTitle:title[i] forState:UIControlStateNormal];
            btn.titleLabel.font = DFont(13);
            btn.backgroundColor = [UIColor grayColor];
            [toolbar addSubview:btn];
            btn.tag = 100+i;
            [btn addTarget:self action:@selector(changeInputView:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}
-(void)changeInputView:(UIButton *)button{
    switch (button.tag) {
        case 100:{
            [self.TollbarDelegate TollbarTextFieldAction:0 textFeild:self];
        }break;
        case 101:{
            [self.TollbarDelegate TollbarTextFieldAction:1 textFeild:self];
        }break;
        case 102:{
            [self.TollbarDelegate TollbarTextFieldAction:2 textFeild:self];
        }break;
        case 103:{
            [self.TollbarDelegate TollbarTextFieldAction:3 textFeild:self];
        }break;
        default:
            break;
    }
}
-(void)textFieldArray:(NSArray *)array{
    textArray = array;
}

//placeholder位置
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x+10, AHeight(bounds.origin.y+10), bounds.size.width -10, bounds.size.height);
    return inset;
}
//placeHolder颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect
{
    [UICOLORRGB(154, 154, 154) setFill];
    [[self placeholder]drawInRect:rect withAttributes:@{NSFontAttributeName:DFont(13),NSForegroundColorAttributeName:[[UIColor grayColor] colorWithAlphaComponent:.7]}];
}
@end

@implementation DIImage

+(UIImage*)OriginImage:(UIImage *)image scaleToWidth:(CGFloat)width height:(CGFloat)height
{
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
