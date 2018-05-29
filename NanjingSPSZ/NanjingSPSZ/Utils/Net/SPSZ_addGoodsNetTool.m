//
//  SPSZ_addGoodsNetTool.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/29.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_addGoodsNetTool.h"
#import "LUNetHelp.h"

@implementation SPSZ_addGoodsNetTool
/**
 货品添加
 */
+ (void)getSuoRecordWithdish:(NSString *)dish
                successBlock:(void (^)(NSMutableArray *modelArray))successBlcok
                  errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                failureBlock:(void (^)(NSString *failure))failureBlock
{
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    NSMutableString *newPath = [NSMutableString stringWithFormat:@"%@%@", BasePath, @"addSalerDish"];
    [requestDic setObject:dish forKey:@"dish"];

    [LUNetHelp lu_postWithPath:newPath andParams:requestDic andProgress:nil andComplete:^(BOOL success, id result) {
        
        if (success) {
            
            if ([result[@"respCode"] integerValue] == 1000000) {
                NSArray *resultList = result[@"resultList"];
                NSMutableArray *modelArray = [NSMutableArray array];
                for (NSDictionary *dish in resultList) {
//                    if ([type isEqualToString:@"1"]) {// 拍照账单
//                        SPSZ_suo_paiZhaoOrderModel *model = [SPSZ_suo_paiZhaoOrderModel yy_modelWithDictionary:dish];
//                        [modelArray addObject:model];
//                    }
//                    else if ([type isEqualToString:@"2"]){//手动账单
//                        SPSZ_suo_shouDongRecordModel *model = [SPSZ_suo_shouDongRecordModel yy_modelWithDictionary:dish];
//                        [modelArray addObject:model];
//                    }else
//                    {
//
//                    }
                    
                }
                if (successBlcok) {
                    successBlcok(modelArray);
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
