//
//  SPSZ_DeviceModel.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/23.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBPeripheral;

@interface SPSZ_DeviceModel : NSObject

/**
 蓝牙名称
 */
@property (nonatomic, strong) CBPeripheral *peripheral;

@end
