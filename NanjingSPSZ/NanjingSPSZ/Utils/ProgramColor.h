//
//  ProgramColor.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/19.
//  Copyright © 2018年 nansen. All rights reserved.
//

/*
 项目中的颜色配置
 */

#import <Foundation/Foundation.h>

@interface ProgramColor : NSObject

/**
 随机色
 */
+ (UIColor *)RandomColor;

/**
 RGB 颜色

 @param red 0-255
 @param green 0-255
 @param blue 0-255
 */
+ (UIColor *)RGBColorWithRed:(int)red green:(int)green blue:(int)blue;

/**
 RGBA 颜色

 @param red 0-255
 @param green 0-255
 @param blue 0-255
 @param alpha 0.0-1.0
 */
+ (UIColor *)RGBColorWithRed:(int)red green:(int)green blue:(int)blue alpha:(CGFloat)alpha;

/**
 十六进制颜色

 @param hexString 支持"#", "0X", "0x" 开头的颜色表示方法,例如: #30344d, 0x30344d, 0X30344d
 */
+ (UIColor *)RRGGBBColorWithString:(NSString *)hexString;


/**
 十六进制颜色

 @param hexString 支持"#", "0X", "0x" 开头的颜色表示方法,例如: #30344d, 0x30344d, 0X30344d
 @param alpha 0.0-1.0
 */
+ (UIColor *)RRGGBBColorWithString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)VCBackgroundColor;

@end
