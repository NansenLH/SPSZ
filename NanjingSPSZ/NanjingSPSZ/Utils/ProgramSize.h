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


@end
