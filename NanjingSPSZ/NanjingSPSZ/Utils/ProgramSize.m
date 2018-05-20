//
//  ProgramSize.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/19.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "ProgramSize.h"

@implementation ProgramSize

+ (CGSize)mainScreenSize
{
    return [UIScreen mainScreen].bounds.size;
}

+ (CGFloat)mainScreenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)mainScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)statusBarHeight
{
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

+ (CGFloat)statusBarAndNavigationBarHeight
{
    return (44 + [[UIApplication sharedApplication] statusBarFrame].size.height);
}

/**
 底部高度,适配 iPhone X
 */
+ (CGFloat)bottomHeight
{
    return [self mainScreenHeight] == 812 ? 34 : 0;
}

@end
