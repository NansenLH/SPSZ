//
//  SPSZ_LoginNetTool.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/27.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPSZ_chuLoginModel.h"

#import "SPSZ_suoLoginModel.h"

@interface SPSZ_LoginNetTool : NSObject


/**
 *  批发商登录（出证）
 */
+ (void)pifashangLoginWithPwd:(NSString *)pwd
                          tel:(NSString *)tel
                 successBlock:(void (^)(SPSZ_chuLoginModel *model))successBlcok
                   errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                 failureBlock:(void (^)(NSString *failure))failureBlock;

/**
 *  零售商登录（索证）
 */
+ (void)lingshoushangLoginWithPwd:(NSString *)pwd
                          tel:(NSString *)tel
                 successBlock:(void (^)(SPSZ_suoLoginModel *model))successBlcok
                   errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                 failureBlock:(void (^)(NSString *failure))failureBlock;

@end
