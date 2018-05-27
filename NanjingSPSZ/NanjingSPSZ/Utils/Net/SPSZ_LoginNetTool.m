//
//  SPSZ_LoginNetTool.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/27.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_LoginNetTool.h"

#import "LUNetHelp.h"

#import "YYModel.h"

@implementation SPSZ_LoginNetTool

/**
 *  批发商登录（出证）
 */
+ (void)pifashangLoginWithPwd:(NSString *)pwd
                          tel:(NSString *)tel
                 successBlock:(void (^)(SPSZ_chuLoginModel *model))successBlcok
                   errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                 failureBlock:(void (^)(NSString *failure))failureBlock
{
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    NSMutableString *newPath = [NSMutableString stringWithFormat:@"%@%@", BasePath, @"doLoginByPwd"];
    [requestDic setObject:pwd forKey:@"pwd"];
    [requestDic setObject:tel forKey:@"tel"];
    
    [LUNetHelp lu_postWithPath:newPath andParams:requestDic andProgress:nil andComplete:^(BOOL success, id result) {
        
        
        if (success) {
            if ([result[@"respCode"] integerValue] == 1000000) {
                NSDictionary *dic = result[@"result"];
                SPSZ_chuLoginModel *model = [SPSZ_chuLoginModel yy_modelWithDictionary:dic];

                if (successBlcok) {
                    successBlcok(model);
                }
            }
            else {
                if (errorBlock) {
                    errorBlock(result[@"respCode"], result[@"respMsg"]);
                }
            }
        }
        else {
            if (failureBlock) {
                failureBlock(result);
            }
        }
    }];
}


@end
