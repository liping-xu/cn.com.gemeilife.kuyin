//
//  BBAlertViewTools.m
//  dongxingziguan
//
//  Created by 许文波 on 2017/6/7.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "BBAlertViewTools.h"

#define RootVC  [[UIApplication sharedApplication] keyWindow].rootViewController

@interface BBAlertViewTools ()

@property (nonatomic, copy) AlertViewBlock block;

@end

@implementation BBAlertViewTools

#pragma mark - 对外方法
+ (BBAlertViewTools *)shareInstance {
    static BBAlertViewTools *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[self alloc] init];
    });
    return tools;
}

/**
 *  创建提示框
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param titleArray   标题字符串数组(为nil,默认为"确定")
 *  @param vc           VC
 *  @param confirm      点击确认按钮的回调
 */
- (void)showAlert:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
       titleArray:(NSArray *)titleArray
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm {
    if (!vc) vc = RootVC;
    [self p_showAlertController:title message:message
                    cancelTitle:cancelTitle titleArray:titleArray
                 viewController:vc confirm:^(NSInteger buttonTag) {
                     if (confirm)confirm(buttonTag);
                 }];
}


/**
 *  创建提示框(可变参数版)
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param vc           VC
 *  @param confirm      点击按钮的回调
 *  @param buttonTitles 按钮(为nil,默认为"确定",传参数时必须以nil结尾，否则会崩溃)
 */
- (void)showAlert:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm
     buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    
    // 读取可变参数里面的titles数组
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    va_list list;
    if(buttonTitles) {
        //1.取得第一个参数的值(即是buttonTitles)
        [titleArray addObject:buttonTitles];
        //2.从第2个参数开始，依此取得所有参数的值
        NSString *otherTitle;
        va_start(list, buttonTitles);
        while ((otherTitle = va_arg(list, NSString*))) {
            [titleArray addObject:otherTitle];
        }
        va_end(list);
    }
    
    if (!vc) vc = RootVC;
    
    [self p_showAlertController:title message:message
                    cancelTitle:cancelTitle titleArray:titleArray
                 viewController:vc confirm:^(NSInteger buttonTag) {
                     if (confirm)confirm(buttonTag);
                 }];
    
}


/**
 *  创建菜单(Sheet)
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param titleArray   标题字符串数组(为nil,默认为"确定")
 *  @param vc           VC
 *  @param confirm      点击确认按钮的回调
 */
- (void)showSheet:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
       titleArray:(NSArray *)titleArray
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm {
    
    if (!vc) vc = RootVC;
    
    [self p_showSheetAlertController:title message:message cancelTitle:cancelTitle
                          titleArray:titleArray viewController:vc confirm:^(NSInteger buttonTag) {
                              if (confirm)confirm(buttonTag);
                          }];
}

/**
 *  创建菜单(Sheet 可变参数版)
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelTitle  取消按钮(无操作,为nil则只显示一个按钮)
 *  @param vc           VC iOS8及其以后会用到
 *  @param confirm      点击按钮的回调
 *  @param buttonTitles 按钮(为nil,默认为"确定",传参数时必须以nil结尾，否则会崩溃)
 */
- (void)showSheet:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm
     buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    // 读取可变参数里面的titles数组
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    va_list list;
    if(buttonTitles) {
        //1.取得第一个参数的值(即是buttonTitles)
        [titleArray addObject:buttonTitles];
        //2.从第2个参数开始，依此取得所有参数的值
        NSString *otherTitle;
        va_start(list, buttonTitles);
        while ((otherTitle= va_arg(list, NSString*))) {
            [titleArray addObject:otherTitle];
        }
        va_end(list);
    }
    
    if (!vc) vc = RootVC;
    
    // 显示菜单提示框
    [self p_showSheetAlertController:title message:message cancelTitle:cancelTitle
                          titleArray:titleArray viewController:vc confirm:^(NSInteger buttonTag) {
                              if (confirm)confirm(buttonTag);
                          }];
    
}


#pragma mark - ----------------内部方法------------------

//UIAlertController(iOS8及其以后)
- (void)p_showAlertController:(NSString *)title
                      message:(NSString *)message
                  cancelTitle:(NSString *)cancelTitle
                   titleArray:(NSArray *)titleArray
               viewController:(UIViewController *)vc
                      confirm:(AlertViewBlock)confirm {
    
    UIAlertController  *alert = [UIAlertController alertControllerWithTitle:title
                                                                    message:message
                                                             preferredStyle:UIAlertControllerStyleAlert];
    // 下面两行代码 是修改 title颜色和字体的代码
    //    NSAttributedString *attributedMessage = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f], NSForegroundColorAttributeName:UIColorFrom16RGB(0x334455)}];
    //    [alert setValue:attributedMessage forKey:@"attributedTitle"];
    if (cancelTitle) {
        // 取消
        UIAlertAction  *cancelAction = [UIAlertAction actionWithTitle:cancelTitle
                                                                style:UIAlertActionStyleCancel
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  if (confirm)confirm(cancelIndex);
                                                              }];
        [alert addAction:cancelAction];
    }
    // 确定操作
    if (!titleArray || titleArray.count == 0) {
        UIAlertAction  *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   if (confirm)confirm(0);
                                                               }];
        
        [alert addAction:confirmAction];
    } else {
        
        for (NSInteger i = 0; i<titleArray.count; i++) {
            UIAlertAction  *action = [UIAlertAction actionWithTitle:titleArray[i]
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                if (confirm)confirm(i);
                                                            }];
            // [action setValue:UIColorFrom16RGB(0x00AE08) forKey:@"titleTextColor"]; // 此代码 可以修改按钮颜色
            [alert addAction:action];
        }
    }
    
    [vc presentViewController:alert animated:YES completion:nil];
    
}


// ActionSheet的封装
- (void)p_showSheetAlertController:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        titleArray:(NSArray *)titleArray
                    viewController:(UIViewController *)vc
                           confirm:(AlertViewBlock)confirm {
    
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    if (!cancelTitle) cancelTitle = @"取消";
    // 取消
    UIAlertAction  *cancelAction = [UIAlertAction actionWithTitle:cancelTitle
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              if (confirm)confirm(cancelIndex);
                                                          }];
    [sheet addAction:cancelAction];
    
    if (titleArray.count > 0) {
        for (NSInteger i = 0; i<titleArray.count; i++) {
            UIAlertAction  *action = [UIAlertAction actionWithTitle:titleArray[i]
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                if (confirm)confirm(i);
                                                            }];
            [sheet addAction:action];
        }
    }
    
    [vc presentViewController:sheet animated:YES completion:nil];
}

- (void)showAlertViewTitle:(NSString *)title
                   message:(NSString *)message
            oneBtnTitle:(NSString *)oneBtnTitle
            viewController:(UIViewController *)vc
{
    [self showAlertViewTitle:title
                     message:message
            messageTextAlign:NSTextAlignmentCenter
                 oneBtnTitle:oneBtnTitle
              viewController:vc];
}

- (void)showAlertViewTitle:(NSString *)title
                   message:(NSString *)message
          messageTextAlign:(NSTextAlignment)textAlign
               oneBtnTitle:(NSString *)oneBtnTitle
            viewController:(UIViewController *)vc
{
    [self showAlertViewTitle:title
                     message:message
            messageTextAlign:textAlign
              cancelBtnTitle:nil
                sureBtnTitle:oneBtnTitle
              viewController:vc
                     confirm:nil];
}

- (void)showAlertViewTitle:(NSString *)title
                   message:(NSString *)message
            cancelBtnTitle:(NSString *)cancelBtnTitle
              sureBtnTitle:(NSString *)sureBtntitle
            viewController:(UIViewController *)vc
                   confirm:(AlertViewBlock)confirm
{
    [self showAlertViewTitle:title
                     message:message
            messageTextAlign:NSTextAlignmentCenter
              cancelBtnTitle:cancelBtnTitle
                sureBtnTitle:sureBtntitle
              viewController:vc
                     confirm:confirm];
}

//- (void)showAlertViewTitle:(NSString *)title
//                   message:(NSString *)message
//          messageTextAlign:(NSTextAlignment)textAlign
//            cancelBtnTitle:(NSString *)cancelBtnTitle
//              sureBtnTitle:(NSString *)sureBtntitle
//            viewController:(UIViewController *)vc
//                   confirm:(AlertViewBlock)confirm
//{
//    @try
//    {
//        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//        NSString *str = @"{\"header\":{\"text\":\"\"},\"content\":{\"text\":\"\",\"css\":\"text-align:center\"},\"footer\":{\"buttons\":[{\"title\":\"\"},{\"title\":\"\"}]}}";
//        dict = [[str jsonToDictionary] mutableCopy];
//        if (title == nil) {
//            title = @"温馨提示";
//        }
//        if (title) {
//            [dict setObject:title atPath:@"header.text"];
//        }
//        if (message) {
//            [dict setObject:message atPath:@"content.text"];
//        }
//        [dict setObject:@(textAlign) atPath:@"content.textAlignment"];
//        
//        if (vc) {
//            [dict setObject:vc.view forKey:@"view"];
//        }
//        
//        NSMutableArray *buttonArray = [[NSMutableArray alloc] init];
//        if (cancelBtnTitle) {
//            
//            [buttonArray addObject:@{
//                                     @"title": [NSString stringWithFormat:@"<font color= \"#999999\" >%@</font>", cancelBtnTitle],
//                                     @"path": @"close"
//                                     }];
//        }
//        if (sureBtntitle || (!cancelBtnTitle && !sureBtntitle)) {
//            if (!sureBtntitle) {
//                sureBtntitle = @"确定";
//            }
//            [buttonArray addObject:@{
//                                     @"title": [NSString stringWithFormat:@"<font color= \"#FA3252\" >%@</font>", sureBtntitle],
//                                     @"path": @"sure"
//                                     }];
//        }
//        if (buttonArray.count > 0) {
//            [dict setObject:buttonArray atPath:@"footer.buttons"];
//        }
//        ObjectBlock callBack = ^(NSDictionary*data)
//        {
//            NSString *path = [data stringAtPath:@"clickButton.path"];
//            BOOL isRemove = NO;
//            if ([path equal:@"close"]) {
//                isRemove = YES;
//                if (confirm) confirm(cancelIndex);
//            }
//            
//            if ([path equal:@"sure"]) {
//                if (confirm) confirm(0);
//            }
//            
//            if (1 || isRemove) {
//                [[data objectAtPath:@"alert"] removeFromSuperview];
//            }
//        };
//        [dict setObject:callBack atPath:@"callBack"];
//        [[AlertBlock sharedInstance] showAlertWithParam:dict];
//    }
//    @catch (NSException *exception) {
//        
//    }
//}


@end
