//
//  SPSZ_GoodsModel.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/25.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_GoodsModel.h"
#import "YYModel.h"

@implementation SPSZ_GoodsModel

- (NSString *)description {
    return [self yy_modelDescription];
}

- (id)copyWithZone:(NSZone *)zone
{
    return [self yy_modelCopy];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self yy_modelEncodeWithCoder:aCoder];
}

@end
