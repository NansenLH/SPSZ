//
//  ProgramSize.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/19.
//  Copyright © 2018年 nansen. All rights reserved.
//

/*
 项目中的通用尺寸配置
 */

#import <Foundation/Foundation.h>

@interface ProgramSize : NSObject


/**
 判断是否是 iPhone X
 */
+ (BOOL)isIPhoneX;

/**
 屏幕Size
 */
+ (CGSize)mainScreenSize;

/**
 屏幕高度
 */
+ (CGFloat)mainScreenHeight;

/**
 屏幕宽度
 */
+ (CGFloat)mainScreenWidth;

/**
 状态栏高度
 */
+ (CGFloat)statusBarHeight;

/**
 导航栏和状态栏高度
 */
+ (CGFloat)statusBarAndNavigationBarHeight;

/**
 底部高度,适配 iPhone X
 */
+ (CGFloat)bottomHeight;


/**
 根据屏幕宽度进行等比缩放的尺寸.
 
 设计一般都是以 iphone6 的尺寸 375 * 667 进行设计的, 这个方法会计算出缩放后的尺寸.
 比如设计中图片是 200 * 200, 在 320 宽度下缩放后应该是 170.6, 414宽度下应该是 220.8.
 */
+ (CGFloat)fitSize:(CGFloat)designSize;


@end
