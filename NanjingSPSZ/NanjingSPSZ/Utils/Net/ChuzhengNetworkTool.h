//
//  ChuzhengNetworkTool.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/25.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChuzhengNetworkTool : NSObject

/**
 *  添加货物,  获取数据源
 */
+ (void)addGoodsFromPageNumber:(int)pageNumber
                  successBlock:(void (^)(NSMutableArray *goodsArray))successBlcok
                    errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                  failureBlock:(void (^)(NSString *failure))failureBlock;


/**
 *  获取出证记录
 */
+ (void)geChuZhengRecordsPageSize:(NSInteger)pageSize
                           pageNo:(NSInteger)pageNo
                           userId:(NSString *)userId
                        printdate:(NSString *)printdate
                  successBlock:(void (^)(NSMutableArray *modelArray))successBlcok
                    errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                  failureBlock:(void (^)(NSString *failure))failureBlock;

/**
 *  获取批发商进货记录
 */
+ (void)geChuZhengJinHuoRecordsStall_id:(NSString *)stall_id
                        printdate:(NSString *)printdate
                     successBlock:(void (^)(NSMutableArray *modelArray))successBlcok
                       errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                     failureBlock:(void (^)(NSString *failure))failureBlock;





@end
