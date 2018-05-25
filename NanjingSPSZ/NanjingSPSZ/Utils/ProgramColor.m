//
//  ProgramColor.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/19.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "ProgramColor.h"

@implementation ProgramColor
/**
 随机色
 */
+ (UIColor *)RandomColor
{
    return [UIColor colorWithRed:(arc4random_uniform(256))/255.0 green:(arc4random_uniform(256))/255.0 blue:(arc4random_uniform(256))/255.0 alpha:(arc4random_uniform(256))/255.0];
}

/**
 RGB 颜色
 */
+ (UIColor *)RGBColorWithRed:(int)red green:(int)green blue:(int)blue
{
    return [self RGBColorWithRed:red green:green blue:blue alpha:1.0];
}

/**
 RGBA 颜色
 */
+ (UIColor *)RGBColorWithRed:(int)red green:(int)green blue:(int)blue alpha:(CGFloat)alpha
{
    red = red < 0 ? 0 : red;
    red = red > 255 ? 255 : red;
    CGFloat fRed = red / 255.0;
    
    green = green < 0 ? 0 : green;
    green = green > 255 ? 255 : green;
    CGFloat fGreen = green / 255.0;
    
    blue = blue < 0 ? 0 : blue;
    blue = blue > 255 ? 255 : blue;
    CGFloat fBlue = blue / 255.0;
    
    alpha = alpha < 0 ? 0 : alpha;
    alpha = alpha > 1 ? 1 : alpha;

    return [UIColor colorWithRed:fRed green:fGreen blue:fBlue alpha:alpha];
}

// 十六进制颜色
+ (UIColor *)RRGGBBColorWithString:(NSString *)hexString
{
    return [self RRGGBBColorWithString:hexString alpha:1.0f];
}

// 十六进制颜色
+ (UIColor *)RRGGBBColorWithString:(NSString *)hexString alpha:(CGFloat)alpha
{
    alpha = alpha < 0 ? 0.0 : alpha;
    alpha = alpha > 1.0 ? 1.0 : alpha;
    
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // 判断前缀
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}


+ (UIColor *)VCBackgroundColor
{
    return [UIColor whiteColor];
}



#pragma mark - ==== 出证部分的颜色 ====
/**
 导航栏标题颜色
 */
+ (UIColor *)navigationTitleColor
{
    return [UIColor whiteColor];
}
/**
 导航栏上按钮的文字颜色
 */
+ (UIColor *)navigationButtonTitleColor
{
    return [UIColor whiteColor];
}

/**
 蓝色渐变色
 */
+ (NSArray *)blueGradientColors
{
    return @[
             [self RGBColorWithRed:67 green:130 blue:255 alpha:0.94],
             [self RGBColorWithRed:33 green:211 blue:255 alpha:0.94],
             ];
}

/**
 蓝色渐变色: 上浅下深
 */
+ (NSArray *)blueMoreGradientColors
{
    return @[
             [self RGBColorWithRed:33 green:211 blue:255 alpha:0.94],
             [self RGBColorWithRed:67 green:130 blue:255 alpha:0.94],
             ];
}

/**
 灰色
 */
+ (UIColor *)huiseColor{
    return [self RGBColorWithRed:226 green:226 blue:226];
}

@end
