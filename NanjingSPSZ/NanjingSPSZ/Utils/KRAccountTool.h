//
//  KRAccountTool.h
//  ZHSH-V1.0
//
//  Created by nansen on 16/4/27.
//  Copyright © 2016年 NansenLu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPSZ_suoLoginModel;
@class SPSZ_chuLoginModel;

@interface KRAccountTool : NSObject



/**
 当前登录的手机号码
 */
@property (nonatomic, copy) NSString *currentPhoneNumber;

/**
 suo model
 */
@property (nonatomic, strong) SPSZ_suoLoginModel *suoModel;


/**
 chu model
 */
@property (nonatomic, strong) SPSZ_chuLoginModel *chuModel;



#pragma mark - ========== 保存 ==========

/**
 *  保存当前账户的手机号码和密码
 */
+ (void)saveCurrentPhoneNumber:(NSString *)phoneNumber password:(NSString *)password;

/**
 *  保存用户模型信息,以mobile作为key
 */
+ (void)saveSuoUserInfo:(SPSZ_suoLoginModel *)user;

+ (void)saveChuUserInfo:(SPSZ_chuLoginModel *)user;


#pragma mark - ========== 读取 ==========

/**
 *  获得当前登录账户的手机号码
 */
+ (NSString *)getCurrentPhoneNumber;

/**
 *  获得当前登录账户的信息
 */
+ (SPSZ_suoLoginModel *)getSuoUserInfo;

+ (SPSZ_chuLoginModel *)getChuUserInfo;


@end
