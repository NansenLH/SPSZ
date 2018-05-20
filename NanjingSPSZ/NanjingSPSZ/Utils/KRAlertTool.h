//
//  KRAlertTool.h
//  smartlife
//
//  Created by nansen on 16/7/29.
//  Copyright © 2016年 jingxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KRHomePersonModel;

@interface KRAlertTool : NSObject

/**
 *  2秒钟就消失的提醒 hud
 */
+ (void)alertString:(NSString *)string;

/**
 *  开发时显示. 用于测试. 2秒钟就消失的提醒 hud
 */
+ (void)testAlertString:(NSString *)string;

+ (void)homeAlert;

/**
 *  简单的系统提醒,可设置title和message, 取消按钮的标题.
 *  默认的是:title-提醒; message-nil; 按钮-知道了
 */
+ (void)alertTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle;


+ (MBProgressHUD *)hudAlert;



/**
 *  提醒绑定家庭
 */
+ (void)showJoinInFamily:(UIViewController *)viewControl;


/**
 *  提示被管理员禁止浏览生活圈和邻里墙
 */
+ (void)showBanLook:(UIViewController *)viewControl;



/**
 判断家庭是否游离
 */
//+ (BOOL)homeIsFree:(KRHomePersonModel *)home viewController:(UIViewController *)vc;

/**
 判断输入非法字符
 */
+ (BOOL)illegalCharacterAlert:(NSString *)string;

/**
 判断输入非法字符 (修改昵称)
 */
+ (BOOL)checkNickName:(NSString *)nickName;

/**
 判断手机正则表达式
 */

+ (BOOL)checkTelNumber:(NSString *)telNumber;

// 正则判断座机号
+ (BOOL)checkNumber:(NSString *) telNumber;

/**
 判断是否全为中文
 */
+ (BOOL)isAllChiese:(NSString *)string;

@end
