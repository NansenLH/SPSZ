//
//  SPSZ_chu_jinHuoModel.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/29.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_chu_jinHuoModel.h"

@implementation SPSZ_chu_jinHuoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    //前面是model中的名字,后面是json中的名字
    return @{@"ss" : @"id"};
}

- (NSString *)description {
    return [self yy_modelDescription];
}

@end
