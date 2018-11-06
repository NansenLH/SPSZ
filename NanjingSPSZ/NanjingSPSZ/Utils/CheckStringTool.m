//
//  CheckStringTool.m
//  NanjingSPSZ
//
//  Created by yyx on 2018/8/3.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "CheckStringTool.h"

@implementation CheckStringTool
//判断对象是否为null或者nil
+ (BOOL)isCheckClass:(id)obj
{
    if ([obj isEqual:[NSNull null]]) {
        return true;
    }else{
        if (obj == nil) {
            return true;
        }else{
            if ([obj isKindOfClass:[NSString class]]) {
                if ([obj isEqualToString:@""]) {
                    return true;
                }
            }
        }
    }
    return false;
}
@end
