//
//  ProgramFont.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/20.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "ProgramFont.h"

@implementation ProgramFont

/**
 根据 iphone6 设计图换算的字体大小
 */
+ (UIFont *)fitFont:(int)fontSize
{
    CGFloat screenWidth = [ProgramSize mainScreenWidth];
    CGFloat fitFont = (fontSize * screenWidth / 375.0);
    return [UIFont systemFontOfSize:fitFont];
}

/**
 适配后的加粗字体,同上
 */
+ (UIFont *)fitBoldFont:(int)fontSize
{
    CGFloat screenWidth = [ProgramSize mainScreenWidth];
    CGFloat fitFont = (fontSize * screenWidth / 375.0);
    return [UIFont boldSystemFontOfSize:fitFont];
}

@end
