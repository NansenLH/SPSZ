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
                        SPSZ_suo_shouDongRecordModel *model = [SPSZ_suo_shouDongRecordModel yy_modelWithDictionary:dish];
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




/**
 出货录入
 */
+ (void)addJinHuoShouDongWithUserId:(NSString *)userId
                             amount:(NSString *)amount
                               unit:(NSString *)unit
                       successBlock:(void (^)(void))successBlcok
                         errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                       failureBlock:(void (^)(NSString *failure))failureBlock
{
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    NSMutableString *newPath = [NSMutableString stringWithFormat:@"%@%@", BasePath, @"uploadPrintConent"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionary];
    [dic setObject:userId forKey:@"userid"];
//    [jsonDic setObject:model.dishimgs forKey:@"dishimgs"];
//    if (model.carnumber) {
//        [jsonDic setObject:model.carnumber forKey:@"carnumber"];
//    }
//    if (model.addresssource) {
//        [jsonDic setObject:model.addresssource forKey:@"addresssource"];
//    }
//    [jsonDic setObject:model.cityid forKey:@"cityid"];
//    [jsonDic setObject:model.cityname forKey:@"cityname"];
//    [jsonDic setObject:model.dishamount forKey:@"dishamount"];
//    [jsonDic setObject:model.dishname forKey:@"dishname"];
    [jsonDic setObject:unit forKey:@"unit"];
    [jsonDic setObject:amount forKey:@"amount"];
    [jsonDic setObject:@"" forKey:@"dishid"];
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [dic setObject:jsonString forKey:@"dish"];
    
    [LUNetHelp lu_postWithPath:newPath andParams:dic andProgress:nil andComplete:^(BOOL success, id result) {
        if (success) {
            if ([result[@"respCode"] integerValue] == 1000000) {
                if (successBlcok) {
                    successBlcok();
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


/**
 获取打印票据
 */
+ (void)getDaYinDataWithPrintcode:(NSString *)printcode
                     successBlock:(void (^)(SPSZ_suo_shouDongRecordModel *model))successBlcok
                       errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                     failureBlock:(void (^)(NSString *failure))failureBlock
{
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    NSMutableString *newPath = [NSMutableString stringWithFormat:@"%@%@", BasePath, @"getprintinvoice"];

    [requestDic setObject:printcode forKey:@"printcode"];
    
    [LUNetHelp lu_postWithPath:newPath andParams:requestDic andProgress:nil andComplete:^(BOOL success, id result) {
        
        if (success) {
            
            if ([result[@"respCode"] integerValue] == 1000000) {
                NSDictionary *dic = result[@"result"];
                SPSZ_suo_shouDongRecordModel *model = [SPSZ_suo_shouDongRecordModel yy_modelWithDictionary:dic];
                
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
