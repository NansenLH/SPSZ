//
//  SPSZ_chuLoginModel.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/27.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_chuLoginModel.h"

@implementation SPSZ_chuLoginModel
+ (NSDictionary *)modelCustomPropertyMapper {
    //前面是model中的名字,后面是json中的名字
    return @{@"login_Id" : @"id"};
}

- (NSString *)description {
    return [self yy_modelDescription];
}
@end
