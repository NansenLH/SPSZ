//
//  NSObject+TNAHUD.h
//  Toon
//
//  Created by likuiliang on 15/6/17.
//  Copyright (c) 2015年 思源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (TNAHUD)

/**
 *  view:需要显示菊花的视图
 *  hint:显示的提示语
 */
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;
/**
 *  隐藏提示控件
 */
- (void)hideHud;
- (void)hideHudAnimated:(BOOL)animated;
/**
 *  显示不带菊花的基本信息提示框
 *  需要显示菊花的视图
 *  调用此方法不需要调用 hideHud方法
 */
- (void)showMessage:(NSString *)message inView:(UIView *)view;

- (void)showHint:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;


@end
