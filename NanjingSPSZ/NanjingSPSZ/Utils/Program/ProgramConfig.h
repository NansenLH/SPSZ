//
//  ProgramConfig.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/20.
//  Copyright © 2018年 nansen. All rights reserved.
//

/*
 项目中的一些配置选项
 */

#import <Foundation/Foundation.h>


#pragma mark - ======== 配置开关 ========
// appStore 改为NO
UIKIT_EXTERN const BOOL isDev;


#pragma mark - ======== 网络接口 ========
// 运营服务器
UIKIT_EXTERN NSString * const BasePath;




@interface ProgramConfig : NSObject

@end
