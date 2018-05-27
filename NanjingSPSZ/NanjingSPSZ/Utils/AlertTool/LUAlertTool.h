//
//  LUAlertTool.h
//  MyAlertTool
//
//  Created by nansen on 2016/12/7.
//  Copyright © 2016年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LUAlertTool : NSObject

+ (instancetype)defaultTool;

/**
 只有一个按钮的警告框
 */
- (void)Lu_alertInViewController:(UIViewController *)vc
                           title:(NSString *)title
                         message:(NSString *)message
               cancelButtonTitle:(NSString *)cancelTitle;

/**
 警告框带一个操作
 */
- (void)Lu_alertActionInViewController:(UIViewController *)vc
                                 title:(NSString *)title
                               message:(NSString *)message
                     cancelButtonTitle:(NSString *)cancelTitle
                     actionButtonTitle:(NSString *)actionTitle
                           actionBlock:(void(^)(void))actionBlock;

/**
 选择框Sheet: actionTitles数组和actionBlocks数组必须一一对应
 */
- (void)Lu_actionSheetInViewController:(UIViewController *)vc
                                 title:(NSString *)title
                    actionButtonTitles:(NSArray *)actionTitles
                          actionBlocks:(NSArray *)actionBlocks;

//有取消按钮的
+(UIAlertController *)alertTitle:(NSString *)title mesasge:(NSString *)message confirmHandler:(void(^)(UIAlertAction *))confirmHandler cancleHandler:(void(^)(UIAlertAction *))cancleHandler viewController:(UIViewController *)vc;


@end
