//
//  ProgramFont.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/20.
//  Copyright © 2018年 nansen. All rights reserved.
//

/*
 项目中的字体配置
 */


#import <Foundation/Foundation.h>

@interface ProgramFont : NSObject

/**
 根据 iphone6 设计图换算的字体大小
 
 比如设计图中的字号是18, 对应320屏幕的话,需要缩放,那么字号应该是 15.36.
 */
+ (UIFont *)fitFont:(int)fontSize;

/**
 适配后的加粗字体,同上
 */
+ (UIFont *)fitBoldFont:(int)fontSize;

@end
