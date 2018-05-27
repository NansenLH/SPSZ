//
//  ChuzhengNetworkTool.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/25.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "ChuzhengNetworkTool.h"

#import "LUNetHelp.h"
#import "YYModel.h"

#import "SPSZ_GoodsModel.h"


@implementation ChuzhengNetworkTool

/**
 *  添加货物,  获取数据源
 */
+ (void)addGoodsFromPageNumber:(int)pageNumber
                  successBlock:(void (^)(NSMutableArray *goodsArray))successBlcok
                    errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                  failureBlock:(void (^)(NSString *failure))failureBlock
{
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    NSMutableString *newPath = [NSMutableString stringWithFormat:@"%@%@", BasePath, @"getDishesByUserId"];
    [requestDic setObject:@(20) forKey:@"pageSize"];
    [requestDic setObject:@(pageNumber) forKey:@"pageNo"];
    [requestDic setObject:@"13156" forKey:@"userid"];
    
    [LUNetHelp lu_postWithPath:newPath andParams:requestDic andProgress:nil andComplete:^(BOOL success, id result) {
        if (success) {
            if ([result[@"respCode"] integerValue] == 1000000) {
                NSArray *resultList = result[@"resultList"];
                NSMutableArray *goodsArray = [NSMutableArray array];
                for (NSDictionary *dish in resultList) {
                    SPSZ_GoodsModel *model = [SPSZ_GoodsModel yy_modelWithDictionary:dish];
                    [goodsArray addObject:model];
                }
                if (successBlcok) {
                    successBlcok(goodsArray);
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
