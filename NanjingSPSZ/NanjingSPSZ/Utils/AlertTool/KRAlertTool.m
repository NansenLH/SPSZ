//
//  KRAlertTool.m
//  smartlife
//
//  Created by nansen on 16/7/29.
//  Copyright © 2016年 jingxi. All rights reserved.
//

#import "KRAlertTool.h"

@implementation KRAlertTool

+ (void)alertString:(NSString *)string
{
    if (!string || string.length == 0) {
        return;
    }
    
    NSLog(@"string = %@", string);
    UIWindow *window              = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD* hud            = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode                      = MBProgressHUDModeText;
    hud.detailsLabel.text         = string;
    hud.detailsLabel.font         = [UIFont systemFontOfSize:16];
    [hud hideAnimated:YES afterDelay:3.0];
}

+ (void)homeAlert
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homeX"]];
    hud.label.text = @"暂未加入社区,";
    hud.label.font = [UIFont boldSystemFontOfSize:12];
    hud.label.textColor = [UIColor whiteColor];
    hud.detailsLabel.text = @"无法查看具体内容";
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont boldSystemFontOfSize:12];
    hud.bezelView.color = [UIColor blackColor];
    hud.bezelView.alpha = 0.7;
    
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:3.0];
}




/**
 *  开发时显示. 用于测试. 2秒钟就消失的提醒 hud
 */
+ (void)testAlertString:(NSString *)string
{
    if (!string || string.length == 0) {
        return;
    }
    
    NSLog(@"alert = %@", string);
    if (isDev) {
        UIWindow *window              = [[UIApplication sharedApplication].delegate window];
        MBProgressHUD* hud            = [MBProgressHUD showHUDAddedTo:window animated:YES];
        hud.mode                      = MBProgressHUDModeText;
        hud.detailsLabel.text         = [NSString stringWithFormat:@"TEST:%@", string];
        hud.detailsLabel.font         = [UIFont systemFontOfSize:16];
        [hud hideAnimated:YES afterDelay:5.0];
    }
}


+ (MBProgressHUD *)hudAlert;
{
    UIWindow *window              = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD* hud            = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode                      = MBProgressHUDModeIndeterminate;
    return hud;
}


/**
 *  简单的系统提醒,可设置title和message, 取消按钮的标题.
 *  默认的是:title-提醒; message-nil; 按钮-知道了
 */
+ (void)alertTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle
{
    NSString *titleString = title == nil ? @"提醒" : title;
    NSString *cancelString = cancelTitle == nil ? @"知道了" : cancelTitle;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleString message:message delegate:nil cancelButtonTitle:cancelString otherButtonTitles:nil, nil];
    [alert show];
}



+(void)showJoinInFamily:(UIViewController *)viewControl{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"欢迎使用智慧家庭APP" message:@"请尽快绑定您的门禁室内终端，体验更智慧的社区生活。" delegate:viewControl cancelButtonTitle:@"稍后" otherButtonTitles:@"立刻绑定", nil];
    alertView.tag = 925;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertView show];
    });
}


+ (void)showBanLook:(UIViewController *)viewControl{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"您已被业主关闭浏览权限，请联系业主开启。" delegate:viewControl cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertView show];
    });
}


+ (BOOL)illegalCharacterAlert:(NSString *)string{
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"@／/;:：；！!?,，。.？（）¥「」＂、[]{}#%-*+=_\\|~…＜＞$€^•'@#$%^&*()_+'\""];
    NSString * str  = [[string componentsSeparatedByCharactersInSet:doNotWant] componentsJoinedByString:@""];
    
    if (![str isEqualToString:string]) {
        return YES;
    }else{
        return NO;
    }
}

/**
 判断输入非法字符 (修改昵称)
 */
+ (BOOL)checkNickName:(NSString *)nickName{
    NSString *pattern = @"^[a-zA-Z0-9\u4e00-\u9fa5\\s]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:nickName];
    return isMatch;
}

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *)telNumber
{
//    NSString *pattern = @"(?:^(?:\\+86)?1(?:33|53|7[37]|8[019])\\d{8}$)|(?:^(?:\\+86)?1700\\d{7}$)|(?:^(?:\\+86)?1(?:3[0-2]|4[5]|5[56]|7[56]|8[56])\\d{8}$)|(?:^(?:\\+86)?170[7-9]\\d{7}$)|(?:^(?:\\+86)?1(?:3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(?:^(?:\\+86)?1705\\d{7}$)";

//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    BOOL isMatch = [pred evaluateWithObject:telNumber];
//    return isMatch;

    if (telNumber.length == 11) {
        NSString *firstNum =[telNumber substringToIndex:1];
        if ([firstNum isEqualToString:@"1"]) {
            return YES;
        }
    }
    return NO;
    
//    return isMatch;
}


// 正则判断座机号
+ (BOOL)checkNumber:(NSString *) telNumber{
    //验证输入的固话中不带 "-"符号
    
    NSString * strNum = @"^(0[0-9]{2,3})?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";
    
    //验证输入的固话中带 "-"符号
    
    //NSString * strNum = @"^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";
    
    NSPredicate *checktest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum];
    
    return [checktest evaluateWithObject:telNumber];
}

#pragma  判断是否全为中文
+ (BOOL)isAllChiese:(NSString *)userName
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:userName];
}

@end
