//
//  ProgramConfig.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/20.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "ProgramConfig.h"

#pragma mark - ======== 配置开关 ========
// appStore 改为NO
const BOOL isDev            = YES;


// 测试服务器
// 运营服务器的时候注释掉这个宏
#define KRTestVersion 1

#ifdef KRTestVersion
#pragma mark - ======== 测试服务器 ========
// 服务器地址
NSString * const BasePath = @"http://192.168.125.246:5556/api/v2";

#else
#pragma mark - ======== 运营服务器 ========
// 服务器地址
NSString * const BasePath = @"https://api.house-keeper.cn/api/v2";

#endif



@implementation ProgramConfig

@end
