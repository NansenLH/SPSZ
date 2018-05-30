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
NSString * const BasePath = @"http://sy.zrodo.com/nanjing/mobile/";

NSString * const BaseImagePath = @"http://www.zrodo.com:8080/njsyDetectList/";

#else
#pragma mark - ======== 运营服务器 ========
// 服务器地址
NSString * const BasePath = @"https://api.house-keeper.cn/api/v2";

#endif


const int Pagesize = 20;

@implementation ProgramConfig

+ (NSArray *)unitArray
{
    NSArray *array = @[
                       @{
                           @"unit" : @"公斤",
                           @"unitType" : @"重量",
                           },
                       @{
                           @"unit" : @"斤",
                           @"unitType" : @"重量",
                           },
                       @{
                           @"unit" : @"吨",
                           @"unitType" : @"重量",
                           },
                       @{
                           @"unit" : @"Kg",
                           @"unitType" : @"重量",
                           },
                       @{
                           @"unit" : @"g",
                           @"unitType" : @"重量",
                           },
                       @{
                           @"unit" : @"箱",
                           @"unitType" : @"数量",
                           },
                       @{
                           @"unit" : @"盒",
                           @"unitType" : @"数量",
                           },
                       @{
                           @"unit" : @"袋",
                           @"unitType" : @"数量",
                           },
                       ];
    return array;
}

+ (NSString *)getUnitTypeFromUnit:(NSString *)unit
{
    NSString *type = @"重量";
    if (
        [unit isEqualToString:@"箱"] ||
        [unit isEqualToString:@"盒"] ||
        [unit isEqualToString:@"袋"]
        ) {
        type = @"数量";
    }
    return type;
}


@end
