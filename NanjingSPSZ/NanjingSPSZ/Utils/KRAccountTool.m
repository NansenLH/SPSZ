//
//  KRAccountTool.m
//  ZHSH-V1.0
//
//  Created by nansen on 16/4/27.
//  Copyright © 2016年 NansenLu. All rights reserved.
//

#import "KRAccountTool.h"
#import "SPSZ_suoLoginModel.h"
#import "SPSZ_chuLoginModel.h"

#import "YYModel.h"
#import <sys/utsname.h>

static NSString *const PhoneKey       = @"PhoneKey";

@implementation KRAccountTool

+ (KRAccountTool *)sharedAccountTool
{
    static KRAccountTool *accountTool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        accountTool = [[KRAccountTool alloc] init];
        
    });
    
    return accountTool;
}

- (instancetype)init
{
    if (self = [super init]) {
        // 初始化, 从文件读取数据
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        // User
        _currentPhoneNumber = [ud objectForKey:PhoneKey];
        
        if (_currentPhoneNumber != nil) {
            NSDictionary *userDict = [ud objectForKey:_currentPhoneNumber];
            if (userDict != nil) {
                _suoModel = [SPSZ_suoLoginModel yy_modelWithDictionary:userDict];
            }
        }
        
        if (_currentPhoneNumber != nil) {
            NSDictionary *userDict = [ud objectForKey:_currentPhoneNumber];
            if (userDict != nil) {
                _chuModel = [SPSZ_chuLoginModel yy_modelWithDictionary:userDict];
            }
        }
        
    }
    return self;
}


#pragma mark - ========== 保存 ==========
+ (void)saveSuoUserInfo:(SPSZ_suoLoginModel *)user
{
    [self sharedAccountTool].suoModel = user;
    [self sharedAccountTool].currentPhoneNumber = user.stall_tel;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSDictionary *userDict = [user yy_modelToJSONObject];
        NSString *key = user.stall_tel;
        [ud setObject:userDict forKey:key];
        [ud setObject:user.stall_tel forKey:PhoneKey];
        [ud synchronize];
    });
}


+(void)saveChuUserInfo:(SPSZ_chuLoginModel *)user
{
    [self sharedAccountTool].chuModel = user;
    [self sharedAccountTool].currentPhoneNumber = user.mobile;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSDictionary *userDict = [user yy_modelToJSONObject];
        NSString *key = user.mobile;
        [ud setObject:userDict forKey:key];
        [ud setObject:user.mobile forKey:PhoneKey];
        [ud synchronize];
    });
}


#pragma mark - ======== 读取 ========


+ (NSString *)getCurrentPhoneNumber
{
    return [self sharedAccountTool].currentPhoneNumber;
}



+ (SPSZ_suoLoginModel *)getSuoUserInfo
{
    return [self sharedAccountTool].suoModel;
}

+ (SPSZ_chuLoginModel *)getChuUserInfo
{
    return [self sharedAccountTool].chuModel;

}






#pragma mark ========= 退出登录 ==========
//+ (void)quit
//{
//    [AppDelegate shareInstance].userInfo = nil;
//    [AppDelegate shareInstance].needPushToAddVC = NO;
//    
//    NSString *mobile = [self sharedAccountTool].currentPhoneNumber;
//    
//    [self sharedAccountTool].currentUser = nil;
//    [self sharedAccountTool].currentChooseCommunityId = 0;
//    [self sharedAccountTool].currentTalkUnReadCount = 0;
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//        [ud removeObjectForKey:mobile];//移除User.
//        [ud removeObjectForKey:KRPhoneKey];
//        [ud removeObjectForKey:KRLoginTime];
//        [ud synchronize];
//    });
//}



@end
