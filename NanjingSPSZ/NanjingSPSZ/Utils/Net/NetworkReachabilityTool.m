//
//  NetworkReachabilityTool.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/25.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "NetworkReachabilityTool.h"

#import "Reachability.h"

@interface NetworkReachabilityTool ()

@property (nonatomic, strong) Reachability *hostReach;

@end

@implementation NetworkReachabilityTool

+ (instancetype)defaultTool
{
    static NetworkReachabilityTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetworkReachabilityTool alloc] init];
    });
    return instance;
}

#pragma mark - ======== 网络监听 ========
- (void)start
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.isConnectNet = YES;
    self.hostReach = [Reachability reachabilityForInternetConnection];
    [self.hostReach startNotifier];
}

// 收到网络状态改变的通知
- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    [self updateInterfaceWithReachability:curReach];
}


- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    if (netStatus == NotReachable) {
        if (self.isConnectNet == YES) {
            self.isConnectNet = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:Notice_NoNetNow object:nil];
        }
    }
    else {
        if (self.isConnectNet == NO) {
            self.isConnectNet = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:Notice_GetNetNow object:nil];
        }
    }
}


@end
