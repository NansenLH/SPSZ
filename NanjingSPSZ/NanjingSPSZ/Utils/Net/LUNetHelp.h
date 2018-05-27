//
//  LUNetHelp.h
//
//  Created by nansen on 16/2/20.
//  Copyright © 2016年 NansenLu. All rights reserved.
//

//依赖于AFN 3.0版本以上

#import "AFHTTPSessionManager.h"

@interface LUNetHelp : AFHTTPSessionManager
/**
 *  POST请求
 *
 *  @param path     URL地址字符串
 *  @param params   参数字典
 *  @param progress 加载进度,一般可以用nil
 *  @param complete 根据success的YES/NO来判断请求成功或者失败, result是返回的数据或者错误信息
 */
+ (void)lu_postWithPath:(NSString *)path andParams:(NSDictionary *)params andProgress:(void (^)(NSProgress *))progress andComplete:(void(^)(BOOL success, id result))complete;

/**
 *  取消所有的网络请求.
 */
+ (void)cancelAll;

@end
