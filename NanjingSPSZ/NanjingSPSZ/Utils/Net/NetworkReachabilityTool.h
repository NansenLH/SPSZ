//
//  NetworkReachabilityTool.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/25.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkReachabilityTool : NSObject

@property (nonatomic, assign) BOOL isConnectNet;

+ (instancetype)defaultTool;

- (void)start;

@end
