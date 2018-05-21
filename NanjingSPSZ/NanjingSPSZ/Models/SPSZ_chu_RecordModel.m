//
//  SPSZ_chu_RecordModel.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/21.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_chu_RecordModel.h"

@implementation SPSZ_chu_RecordModel

+ (NSDictionary *)modelCustomPropertyMapper {
    //前面是model中的名字,后面是json中的名字
    return @{@"answer_id" : @"id"};
}

- (NSString *)description {
    return [self yy_modelDescription];
}
@end
