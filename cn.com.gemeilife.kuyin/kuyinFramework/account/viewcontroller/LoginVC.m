//
//  LoginVC.m
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/8.
//

#import "LoginVC.h"
#import "PAWebView.h"
#import "AccountVC.h"
#import "HomePageVC.h"
#import "KYRequest.h"

#define LabelHeight 44.0f;
#define margin       5.0f;
#define marginH     15.0f;
#define marginW     20.0f;
#define ImageH     230.0f;
#define ButtonW    100.0f;
#define LabelMaxH (UIScreenHeight - ImageH) / 7;


@interface LoginVC () <UINavigationControllerDelegate, UITextFieldDelegate>

@property (nonatomic,strong) UIImageView *ImageView;
//手机号
@property (nonatomic,strong) UILabel *PhoneNumLabel;
@property (nonatomic,strong) UITextField *PhoneNumTextField;
@property (nonatomic,strong) UIView  *PhoneNumLine;

//密码
@property (nonatomic,strong) UITextField *PassWordTextField;
@property (nonatomic,strong) UIView  *PassWordLine;

//登陆
@property (nonatomic,strong) UIButton *LoginButton;

//同意协议 用户协议 隐私权协议
@property (nonatomic,strong) UIButton *AgreementButton;
@property (nonatomic,strong) UILabel  *TextLabel;
@property (nonatomic,strong) UIButton *UserButton;
@property (nonatomic,strong) UIButton *PrivacyButton;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.delegate = self;
    [self configurationUI];
}

- (void)configurationUI
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [view addSubview:self.ImageView];
    [view addSubview:self.PhoneNumLabel];
    [view addSubview:self.PhoneNumTextField];
    [view addSubview:self.PhoneNumLine];
    [view addSubview:self.PassWordTextField];
    [view addSubview:self.PassWordLine];
    [self.view addSubview:self.LoginButton];
    
//    [self.view addSubview:self.RegisterButton];
//    [self.view addSubview:self.VerifyButton];
//    [self.view addSubview:self.ForgotButton];
    [self.view addSubview:self.AgreementButton];
    [self.view addSubview:self.TextLabel];
    [self.view addSubview:self.UserButton];
    [self.view addSubview:self.PrivacyButton];
}

- (UIImageView *)ImageView
{
    if (!_ImageView) {
        CGFloat imageW = 100.0f;
        CGFloat imageX = (UIScreenWidth - imageW) * 0.5; 
        CGFloat imageY = [UIDevice vg_statusBarHeight];
        CGFloat imageH = 100.0f;
        _ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW,imageH)];
        _ImageView.image = IMAGE(@"KY_Logo");
        _ImageView.contentMode = UIViewContentModeScaleAspectFit;
     
    }
    return _ImageView;
}

- (UILabel *)PhoneNumLabel
{
    if (!_PhoneNumLabel) {
        CGFloat phoneNumX = 40.0f;
        CGFloat phoneNumY = CGRectGetMaxY(self.ImageView.frame) + marginH;
        CGFloat phoneNumW = UIScreenWidth - phoneNumX * 2;
        CGFloat phoneNumH = LabelHeight;
        _PhoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(phoneNumX, phoneNumY, phoneNumW, phoneNumH)];
        _PhoneNumLabel.text = @"手机号码";
        _PhoneNumLabel.textColor = [UIColor dx_666666Color];
        _PhoneNumLabel.textAlignment = NSTextAlignmentLeft;
        _PhoneNumLabel.font = DFont(15);
        
    }
    return _PhoneNumLabel;
}

- (UITextField *)PhoneNumTextField
{
    if (!_PhoneNumTextField) {
        CGFloat phoneNumTextFieldX = marginW;
        CGFloat phoneNumTextFieldY = CGRectGetMaxY(self.PhoneNumLabel.frame);
        CGFloat phoneNumTextFieldW = UIScreenWidth - phoneNumTextFieldX * 2;
        CGFloat phoneNumTextFieldH = LabelHeight;
        _PhoneNumTextField = [[UITextField alloc] initWithFrame:CGRectMake(phoneNumTextFieldX, phoneNumTextFieldY, phoneNumTextFieldW, phoneNumTextFieldH)];
        _PhoneNumTextField.backgroundColor = [UIColor clearColor];
        _PhoneNumTextField.placeholder = @" 请输入手机号码";
        _PhoneNumTextField.keyboardType = UIKeyboardTypeDefault;
//        _PhoneNumTextField.layer.borderWidth = 1.0f;
//        _PhoneNumTextField.layer.borderColor = [[UIColor blackColor] CGColor];
//        _PhoneNumTextField.layer.cornerRadius = phoneNumTextFieldH * 0.5;
//        _PhoneNumTextField.layer.masksToBounds = YES;
        _PhoneNumTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, phoneNumTextFieldH)];
        _PhoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
        [_PhoneNumTextField setValue:[UIColor colorWithHex:0xCCCCCC] forKeyPath:@"placeholderLabel.textColor"];
        [_PhoneNumTextField setValue:[UIFont systemFontOfSize:17] forKeyPath:@"placeholderLabel.font"];
        _PhoneNumTextField.delegate = self;
        
    }
    return _PhoneNumTextField;
}

- (UIView *)PhoneNumLine
{
    if (!_PhoneNumLine) {
        CGFloat lineX = marginW;
        CGFloat lineY = CGRectGetMaxY(self.PhoneNumTextField.frame);
        CGFloat lineW = UIScreenWidth - lineX * 2;
        CGFloat lineH = 1.0f;
        _PhoneNumLine = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        _PhoneNumLine.backgroundColor = [UIColor dx_D9D9D9Color];
    }
    return _PhoneNumLine;
}





- (UITextField *)PassWordTextField
{
    if (!_PassWordTextField) {
        CGFloat PassWordTextFieldX = marginW;
        CGFloat PassWordTextFieldY = CGRectGetMaxY(self.PhoneNumTextField.frame) + marginH;
        CGFloat PassWordTextFieldW = UIScreenWidth - PassWordTextFieldX * 2;
        CGFloat PassWordTextFieldH = LabelHeight;
        _PassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(PassWordTextFieldX, PassWordTextFieldY, PassWordTextFieldW, PassWordTextFieldH)];
        _PassWordTextField.backgroundColor = [UIColor clearColor];
        _PassWordTextField.placeholder = @" 请输入密码";
        _PassWordTextField.keyboardType = UIKeyboardTypeDefault;
//        _PassWordTextField.layer.borderWidth = 1.0f;
//        _PassWordTextField.layer.borderColor = [[UIColor blackColor] CGColor];
//        _PassWordTextField.layer.cornerRadius = PassWordTextFieldH * 0.5;
//        _PassWordTextField.layer.masksToBounds = YES;
        _PassWordTextField.secureTextEntry = YES;
        _PassWordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, PassWordTextFieldH)];
        _PassWordTextField.leftViewMode = UITextFieldViewModeAlways;
        [_PassWordTextField setValue:[UIColor colorWithHex:0xCCCCCC] forKeyPath:@"placeholderLabel.textColor"];
        [_PassWordTextField setValue:[UIFont systemFontOfSize:17] forKeyPath:@"placeholderLabel.font"];
        _PassWordTextField.delegate = self;
    
    }
    return _PassWordTextField;
}

- (UIView *)PassWordLine
{
    if (!_PassWordLine) {
        CGFloat lineX = marginW;
        CGFloat lineY = CGRectGetMaxY(self.PassWordTextField.frame);
        CGFloat lineW = UIScreenWidth - lineX * 2;
        CGFloat lineH = 1.0f;
        _PassWordLine = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        _PassWordLine.backgroundColor = [UIColor dx_D9D9D9Color];
    }
    return _PassWordLine;
}

- (UIButton *)LoginButton
{
    if (!_LoginButton) {
        
        CGFloat LoginButtonX = marginW;
        CGFloat LoginButtonW = UIScreenWidth - LoginButtonX * 2;
        CGFloat LoginButtonY = CGRectGetMaxY(self.PassWordLine.frame) + marginH;
        CGFloat LoginButtonH = LabelHeight;
        _LoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _LoginButton.frame = CGRectMake(LoginButtonX, LoginButtonY, LoginButtonW, LoginButtonH);
        _LoginButton.backgroundColor = [UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f];
        _LoginButton.layer.borderWidth = 0.01f;
        _LoginButton.layer.borderColor = [UIColor colorWithRed:20.0f/255.0f green:80.0f/255.0f blue:200.0f/255.0f alpha:0.7f].CGColor;
        _LoginButton.layer.cornerRadius = LoginButtonH * 0.5;
        _LoginButton.layer.masksToBounds = YES;
        _LoginButton.titleLabel.font = DFont(15);
        _LoginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_LoginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_LoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIColor *normalColor = [UIColor colorWithRed:46.0f / 255.0f green:146.0f / 255.0f blue:243.0f / 255.0f alpha:1.0f];;
        [_LoginButton setBackgroundImage:[GSTools imageWithColor:normalColor] forState:UIControlStateNormal];
        UIColor *disableColor = [UIColor grayColor];
        [_LoginButton setBackgroundImage:[GSTools imageWithColor:disableColor] forState:UIControlStateDisabled];
//        _LoginButton.selected = NO;
        _LoginButton.enabled = NO;
        [_LoginButton addTarget:self action:@selector(LoginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LoginButton;
}

- (UIButton *)AgreementButton
{
    if (!_AgreementButton) {
        CGFloat AgreementButtonX = marginW;
        CGFloat AgreementButtonW = 26.0f;
        CGFloat AgreementButtonY = CGRectGetMaxY(self.LoginButton.frame) + marginH;
        CGFloat AgreementButtonH = AgreementButtonW;
        _AgreementButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _AgreementButton.frame = CGRectMake(AgreementButtonX, AgreementButtonY, AgreementButtonW, AgreementButtonH);
        _AgreementButton.backgroundColor = [UIColor clearColor];
        [_AgreementButton setImage:IMAGE(@"Unchecked") forState:UIControlStateNormal];
        [_AgreementButton setImage:IMAGE(@"Checked") forState:UIControlStateSelected];
        _AgreementButton.selected = NO;
        [_AgreementButton addTarget:self action:@selector(AgreementButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _AgreementButton;
}

- (UILabel *)TextLabel
{
    if (!_TextLabel) {
        CGFloat TextLabelH = LabelHeight;
        CGFloat TextLabelX = CGRectGetMaxX(self.AgreementButton.frame);
        CGFloat TextLabelY =
        CGRectGetMidY(self.AgreementButton.frame) - (TextLabelH * 0.5);
        CGFloat TextLabelW = 100.0f;
        _TextLabel = [[UILabel alloc] initWithFrame:CGRectMake(TextLabelX, TextLabelY, TextLabelW, TextLabelH)];
        _TextLabel.text = @"我已阅读并同意";
        _TextLabel.textColor = [UIColor dx_333333Color];
        _TextLabel.textAlignment = NSTextAlignmentLeft;
        _TextLabel.font = DFont(14);
    }
    return _TextLabel;
}

- (UIButton *)UserButton
{
    if (!_UserButton) {
        CGFloat AgreementButtonX = CGRectGetMaxX(self.TextLabel.frame);
        CGFloat AgreementButtonW = 80.0f;
        CGFloat AgreementButtonH = LabelHeight;
        CGFloat AgreementButtonY = CGRectGetMidY(self.AgreementButton.frame) - (AgreementButtonH * 0.5);
        _UserButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _UserButton.frame = CGRectMake(AgreementButtonX, AgreementButtonY, AgreementButtonW, AgreementButtonH);
        _UserButton.backgroundColor = [UIColor clearColor];
        _UserButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_UserButton setTitle:@"《用户协议》" forState:UIControlStateNormal];
        _UserButton.titleLabel.font = DFont(13);
        [_UserButton setTitleColor:[UIColor colorWithRed:20.0f/255.0f green:80.0f/255.0f blue:200.0f/255.0f alpha:0.7f] forState:UIControlStateNormal];
        [_UserButton addTarget:self action:@selector(UserButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _UserButton;
}

- (UIButton *)PrivacyButton
{
    if (!_PrivacyButton) {
        CGFloat PrivacyButtonX = CGRectGetMaxX(self.UserButton.frame);
        CGFloat PrivacyButtonW = 100.0f;
        CGFloat PrivacyButtonH = LabelHeight;
        CGFloat PrivacyButtonY = CGRectGetMidY(self.AgreementButton.frame) - (PrivacyButtonH * 0.5);
        _PrivacyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _PrivacyButton.frame = CGRectMake(PrivacyButtonX, PrivacyButtonY, PrivacyButtonW, PrivacyButtonH);
        _PrivacyButton.backgroundColor = [UIColor clearColor];
        _PrivacyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_PrivacyButton setTitle:@"《隐私政策》" forState:UIControlStateNormal];
        _PrivacyButton.titleLabel.font = DFont(13);
        [_PrivacyButton setTitleColor:[UIColor colorWithRed:20.0f/255.0f green:80.0f/255.0f blue:200.0f/255.0f alpha:0.7f] forState:UIControlStateNormal];
        [_PrivacyButton addTarget:self action:@selector(PrivacyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _PrivacyButton;
}

//登录Action
- (void)LoginButtonAction:(UIButton *)sender
{
    //去掉手机号码中的空格
    NSString *phoneNum = [self.PhoneNumTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSString *phoneNum = self.PhoneNumTextField.text;
    NSString *passWord = self.PassWordTextField.text;
    [KYRequest KYLoginWithPostWithAccount:phoneNum withPassWord:passWord withRequest:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSString * _Nonnull message) {        
        if (isSuccess) {
            //返回上级页面
            
            [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DataNeedsRefresh" object:self];
            }];
            //跳转到HomePage页面
            if (self.tabBarVC.selectedIndex != 0) {
                [self.tabBarVC setSelectedIndex:0];
            }            
        } else {
            [self showPopView:message];
        }
    }];
}

//同意协议
- (void)AgreementButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    self.LoginButton.userInteractionEnabled = sender.selected;
    self.LoginButton.enabled = sender.selected;
}

//用户协议
- (void)UserButtonAction:(UIButton *)sender
{
    PAWebView *webView = [PAWebView shareInstance];
    //加载网页
    NSString *url = @"https://oss.hfljyx.com/water/user_agree.html";
    [webView loadRequestURL:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0f]];//    [webView loadLocalHTMLWithFileName:url];
    webView.title = @"用户协议";
    [self.navigationController pushViewController:webView animated:YES];
}
//隐私权协议
- (void)PrivacyButtonAction:(UIButton *)sender
{
    PAWebView *webView = [PAWebView shareInstance];
    //添加与JS交互事件
//    [self addMessageHandleName];
    
    //加载网页
    NSString *url = @"https://oss.hfljyx.com/water/private.html";
    [webView loadRequestURL:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0f]];
    webView.title = @"隐私政策";
    [self.navigationController pushViewController:webView animated:YES];

}
#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.PhoneNumTextField) {
        self.PassWordTextField.text = @"";
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL isPhoneNum = 0;
    if (textField == self.PhoneNumTextField) {
        isPhoneNum = [self isPhoneNumWithtextField:textField shouldChangeCharactersInRange:range replacementString:string];
        return NO;
    } else {
        return  YES;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

//判断是不是正确的手机号格式
- (BOOL)isPhoneNumWithtextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString*text = [textField text];
    //只能输入数字
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        
    }
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    // 如果是电话号码格式化，需要添加这三行代码
//    NSMutableString *temString = [NSMutableString stringWithString:text];[temString insertString:@" " atIndex:0];
//    text = temString;
    NSMutableString *temString = [NSMutableString stringWithString:text];
    [temString insertString:@" "atIndex:0];
    text = temString;
    
    NSString *newString =@"";
    while (text.length >0)
     {
         NSString *subString = [text substringToIndex:MIN(text.length,4)];
         newString = [newString stringByAppendingString:subString];
         if (subString.length ==4)
         {
             newString = [newString stringByAppendingString:@" "];
         }
         text = [text substringFromIndex:MIN(text.length,4)];
     }

     newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
//    NSLog(@"%@", newString);
    [textField setText:newString];
    if (newString.length >= 14) {
        [self showPopView:@"请输入有效的手机号"];
        return NO;
    }
    if (newString.length == 13) {
        
        BOOL isPhoneNum = [newString isMobileNumber:newString];
        if (!isPhoneNum) {
//            self.nextButton.backgroundColor = [UIColor colorWithHex:0xC29A40];
//            self.nextButton.userInteractionEnabled = YES;
//            [self showPopView:@"有效的手机号"];
        } else {
            [self showPopView:@"请输入有效的手机号"];
            return NO;
        }
    }
    return NO;
}

#pragma mark NavigationDelegate
// 将要显示控制器 隐藏首页导航栏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
 // 判断要显示的控制器是否是自己
 BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
 [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
