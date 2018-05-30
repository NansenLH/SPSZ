//
//  SPSZ_suo_orderNetTool.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/28.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SPSZ_suo_shouDongRecordModel.h"


@interface SPSZ_suo_orderNetTool : NSObject
/**
 * 获取零售商进货记录列表(索证)
 type 1 拍照 type 2 手动   0 扫码
 date 格式 2018-05-27
 */
+ (void)getSuoRecordWithStall_id:(NSString *)stall_id
                          uploaddate:(NSString *)uploaddate
                            type:(NSString *)type
                 successBlock:(void (^)(NSMutableArray *modelArray))successBlcok
                   errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                 failureBlock:(void (^)(NSString *failure))failureBlock;


/**
 进货录入
 */
+ (void)addJinHuoShouDongWithUserId:(NSString *)userId
                             amount:(NSString *)amount
                               unit:(NSString *)unit
                       successBlock:(void (^)(void))successBlcok
                         errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                       failureBlock:(void (^)(NSString *failure))failureBlock;


/**
 获取打印票据
 */
+ (void)getDaYinDataWithPrintcode:(NSString *)printcode
     successBlock:(void (^)(SPSZ_suo_shouDongRecordModel *model))successBlcok
       errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
     failureBlock:(void (^)(NSString *failure))failureBlock;


@end
