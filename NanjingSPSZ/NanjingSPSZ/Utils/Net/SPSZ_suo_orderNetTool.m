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

#import "SPSZ_suo_saoMaDetailModel.h"

#import "SPSZ_suoLoginModel.h"
#import "KRAccountTool.h"
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




+ (void)shangChuanWith:(NSString *)type
                 model:(SPSZ_suo_shouDongRecordModel *)model
          successBlock:(void (^)(NSString  *string))successBlcok
            errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
          failureBlock:(void (^)(NSString *failure))failureBlock
{
    if (!model) {
        if (errorBlock) {
            errorBlock(@"", @"参数错误");
        }
        return;
    }
    
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    NSMutableString *newPath = [NSMutableString stringWithFormat:@"%@%@", BasePath, @"uploadPrintInvoice"];
    NSMutableArray *dishesArray = [NSMutableArray array];
    
    
    for (SPSZ_suo_saoMaDetailModel *tmpModel in model.dishes) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [self setMyValueWith:tmpModel.dishid key:@"dishid" dic:dic];
        [self setMyValueWith:tmpModel.amount key:@"amount" dic:dic];
        [self setMyValueWith:tmpModel.unit key:@"unit" dic:dic];
        [self setMyValueWith:tmpModel.addresssource key:@"addresssource" dic:dic];
        [self setMyValueWith:tmpModel.objectName key:@"objectName" dic:dic];
        [self setMyValueWith:tmpModel.cityname key:@"cityname" dic:dic];
        [dishesArray addObject:dic];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dishesArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [self setMyValueWith:model.printcode key:@"printcode" dic:dic1];
    [self setMyValueWith:model.uploaddate key:@"printdate" dic:dic1];
    [self setMyValueWith:model.suo_shouDongId key:@"salerid" dic:dic1];
    [self setMyValueWith:model.realname key:@"realname" dic:dic1];
    [self setMyValueWith:model.mobile key:@"mobile" dic:dic1];
    [self setMyValueWith:model.companyname key:@"companyname" dic:dic1];
    [self setMyValueWith:model.cityname key:@"cityname" dic:dic1];
    [self setMyValueWith:model.address key:@"address" dic:dic1];
    [self setMyValueWith:jsonString key:@"dishes" dic:dic1];
    [self setMyValueWith:model.imgurl key:@"imgurl" dic:dic1];
    [self setMyValueWith:type key:@"type" dic:dic1];
    [self setMyValueWith:model.printdate key:@"printdate" dic:dic1];

    SPSZ_suoLoginModel *loginModel = [KRAccountTool getSuoUserInfo];

    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [self setMyValueWith:loginModel.stall_id key:@"stall_id" dic:dic2];
    [self setMyValueWith:loginModel.stall_no key:@"stall_no" dic:dic2];
    [self setMyValueWith:loginModel.stall_name key:@"stall_name" dic:dic2];
    [self setMyValueWith:loginModel.stall_tel key:@"stall_tel" dic:dic2];
    [self setMyValueWith:loginModel.deptname key:@"deptname" dic:dic2];
    [self setMyValueWith:loginModel.cityname key:@"cityname" dic:dic2];

    NSData *jsonData1 = [NSJSONSerialization dataWithJSONObject:dic1 options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString1 = [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
    [requestDic setObject:jsonString1 forKey:@"printinvoice"];

    
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:dic2 options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString2 = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    [requestDic setObject:jsonString2 forKey:@"stallman"];

    
    [LUNetHelp lu_postWithPath:newPath andParams:requestDic andProgress:nil andComplete:^(BOOL success, id result) {
        if (success) {
            if ([result[@"respCode"] integerValue] == 1000000) {
                if (successBlcok) {
                    successBlcok([result objectForKey:@"result"]);
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


+ (void)setMyValueWith:(NSString *)obj key:(NSString *)key dic:(NSMutableDictionary *)dic
{
    if (obj) {
        [dic setObject:obj forKey:key];
    }else
    {
        [dic setObject:@"" forKey:key];
    }
}

@end
