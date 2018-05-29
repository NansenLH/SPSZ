//
//  SPSZ_addGoodsNetTool.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/29.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPSZ_addGoodsNetTool : NSObject

/**
 货品添加  
 */
+ (void)getSuoRecordWithdish:(NSString *)dish
                    successBlock:(void (^)(NSMutableArray *modelArray))successBlcok
                      errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                    failureBlock:(void (^)(NSString *failure))failureBlock;
@end
