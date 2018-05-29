//
//  SPSZ_suo_orderNetTool.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/28.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_suo_orderNetTool.h"

#import "LUNetHelp.h"

#import "SPSZ_suo_paiZhaoOrderModel.h"
#import "SPSZ_suo_shouDongRecordModel.h"
#import "SPSZ_suo_saoMaoOrderModel.h"
@implementation SPSZ_suo_orderNetTool


/**
 * 获取零售商进货记录列表(索证)
 type 1 拍照 type 2 手动   那么 扫码 要么是0  要么是3
 date 格式 2018-05-27
 */
+ (void)getSuoRecordWithStall_id:(NSString *)stall_id
                      uploaddate:(NSString *)uploaddate
                            type:(NSString *)type
                    successBlock:(void (^)(NSMutableArray *modelArray))successBlcok
                      errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                    failureBlock:(void (^)(NSString *failure))failureBlock
{
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    NSMutableString *newPath = [NSMutableString stringWithFormat:@"%@%@", BasePath, @"getuploadprintinvoicedetaillist"];
    [requestDic setObject:stall_id forKey:@"stall_id"];
    [requestDic setObject:uploaddate forKey:@"uploaddate"];
    [requestDic setObject:type forKey:@"type"];
    
    [LUNetHelp lu_postWithPath:newPath andParams:requestDic andProgress:nil andComplete:^(BOOL success, id result) {
        
        if (success) {
            
            if ([result[@"respCode"] integerValue] == 1000000) {
                NSArray *resultList = result[@"resultList"];
                NSMutableArray *modelArray = [NSMutableArray array];
                for (NSDictionary *dish in resultList) {
                    if ([type isEqualToString:@"1"]) {// 拍照账单
                        SPSZ_suo_paiZhaoOrderModel *model = [SPSZ_suo_paiZhaoOrderModel yy_modelWithDictionary:dish];
                        [modelArray addObject:model];
                    }
                    else if ([type isEqualToString:@"2"]){//手动账单
                        SPSZ_suo_shouDongRecordModel *model = [SPSZ_suo_shouDongRecordModel yy_modelWithDictionary:dish];
                        [modelArray addObject:model];
                    }else
                    {
                        SPSZ_suo_saoMaoOrderModel *model = [SPSZ_suo_saoMaoOrderModel yy_modelWithDictionary:dish];
                        [modelArray addObject:model];
                    }
         
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
