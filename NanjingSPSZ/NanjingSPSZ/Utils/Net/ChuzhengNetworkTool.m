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

#import "SPSZ_chu_recordsModel.h"
#import "SPSZ_chu_jinHuoModel.h"

#import "KRAccountTool.h"

#import "SPSZ_GoodsModel.h"
#import "SPSZ_chuLoginModel.h"
#import "SPSZ_ChuhuoModel.h"

@implementation ChuzhengNetworkTool

/**
 *  添加货物,  获取数据源
 */
+ (void)addGoodsFromPageNumber:(int)pageNumber
                  successBlock:(void (^)(NSMutableArray *goodsArray))successBlcok
                    errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                  failureBlock:(void (^)(NSString *failure))failureBlock
{
    SPSZ_chuLoginModel *chuUser = [KRAccountTool getChuUserInfo];
    
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    NSMutableString *newPath = [NSMutableString stringWithFormat:@"%@%@", BasePath, @"getDishesByUserId"];
    [requestDic setObject:@(Pagesize) forKey:@"pageSize"];
    [requestDic setObject:@(pageNumber) forKey:@"pageNo"];
    [requestDic setObject:chuUser.login_Id forKey:@"userid"];
    
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



/**
 *  获取出证记录
 */
+ (void)geChuZhengRecordsPageSize:(NSInteger)pageSize
                           pageNo:(NSInteger)pageNo
                           userId:(NSString *)userId
                        printdate:(NSString *)printdate
                     successBlock:(void (^)(NSMutableArray *modelArray))successBlcok
                       errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                     failureBlock:(void (^)(NSString *failure))failureBlock
{
    SPSZ_chuLoginModel *chuUser = [KRAccountTool getChuUserInfo];
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    NSMutableString *newPath = [NSMutableString stringWithFormat:@"%@%@", BasePath, @"getPrintinvoiceByUserId"];
    [requestDic setObject:@(pageSize) forKey:@"pageSize"];
    [requestDic setObject:@(pageNo) forKey:@"pageNo"];
    [requestDic setObject:chuUser.login_Id forKey:@"userid"];
    if (printdate) {
        [requestDic setObject:printdate forKey:@"printdate"];
    }
    
    [LUNetHelp lu_postWithPath:newPath andParams:requestDic andProgress:nil andComplete:^(BOOL success, id result) {
        if (success) {
            if ([result[@"respCode"] integerValue] == 1000000) {
                NSArray *resultList = result[@"resultList"];
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *dish in resultList) {
                    SPSZ_chu_recordsModel *model = [SPSZ_chu_recordsModel yy_modelWithDictionary:dish];
                    [array addObject:model];
                }
                if (successBlcok) {
                    successBlcok(array);
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
 *  获取批发商进货记录
 */
+ (void)geChuZhengJinHuoRecordsStall_id:(NSString *)stall_id
                              printdate:(NSString *)printdate
                           successBlock:(void (^)(NSMutableArray *modelArray))successBlcok
                             errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                           failureBlock:(void (^)(NSString *failure))failureBlock
{
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    NSMutableString *newPath = [NSMutableString stringWithFormat:@"%@%@", BasePath, @"getdishesdetaillist"];

    SPSZ_chuLoginModel *chuUser = [KRAccountTool getChuUserInfo];
    [requestDic setObject:chuUser.login_Id forKey:@"stall_id"];
//    if (printdate) {
    [requestDic setObject:printdate forKey:@"uploaddate"];
//    }
    
    [LUNetHelp lu_postWithPath:newPath andParams:requestDic andProgress:nil andComplete:^(BOOL success, id result) {
        if (success) {
            if ([result[@"respCode"] integerValue] == 1000000) {
                NSArray *resultList = result[@"resultList"];
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *dish in resultList) {
                    SPSZ_chu_jinHuoModel *model = [SPSZ_chu_jinHuoModel yy_modelWithDictionary:dish];
                    [array addObject:model];
                }
                if (successBlcok) {
                    successBlcok(array);
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
+ (void)addGoods:(SPSZ_ChuhuoModel *)model
    successBlock:(void (^)(void))successBlcok
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
    NSMutableString *newPath = [NSMutableString stringWithFormat:@"%@%@", BasePath, @"addSalerDish"];
//    NSString *jsonString = [model yy_modelToJSONString];

    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionary];
    [jsonDic setObject:model.salerid forKey:@"salerid"];
    [jsonDic setObject:model.dishimgs forKey:@"dishimgs"];
    if (model.carnumber) {
        [jsonDic setObject:model.carnumber forKey:@"carnumber"];
    }
    if (model.addresssource) {
        [jsonDic setObject:model.addresssource forKey:@"addresssource"];
    }
    [jsonDic setObject:model.cityid forKey:@"cityid"];
    [jsonDic setObject:model.cityname forKey:@"cityname"];
    [jsonDic setObject:model.dishamount forKey:@"dishamount"];
    [jsonDic setObject:model.dishname forKey:@"dishname"];
    [jsonDic setObject:@"" forKey:@"dishid"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [requestDic setObject:jsonString forKey:@"dish"];
    
    [LUNetHelp lu_postWithPath:newPath andParams:requestDic andProgress:nil andComplete:^(BOOL success, id result) {
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
 上传打印内容
 */
+ (void)uploadPrintContent:(NSArray<SPSZ_GoodsModel *> *)dishes
              successBlock:(void (^)(NSString *qrCodeString))successBlcok
                errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
              failureBlock:(void (^)(NSString *failure))failureBlock
{
    if (!dishes || dishes.count == 0) {
        if (errorBlock) {
            errorBlock(@"", @"参数错误");
        }
        return;
    }
    
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    NSMutableString *newPath = [NSMutableString stringWithFormat:@"%@%@", BasePath, @"uploadPrintConent"];
    
    NSMutableArray *dishesArray = [NSMutableArray array];
    for (SPSZ_GoodsModel *tmpModel in dishes) {
        NSDictionary *dic = @{
                              @"dishid" : [NSString stringWithFormat:@"%d", tmpModel.dishid],
                              @"amount" : tmpModel.weight,
                              @"unit"   : tmpModel.unit,
                              };
        [dishesArray addObject:dic];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dishesArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [requestDic setObject:jsonString forKey:@"dish"];
    
    SPSZ_chuLoginModel *chuUser = [KRAccountTool getChuUserInfo];
    [requestDic setObject:chuUser.login_Id forKey:@"userid"];
    
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







@end
