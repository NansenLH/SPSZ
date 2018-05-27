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

@end
