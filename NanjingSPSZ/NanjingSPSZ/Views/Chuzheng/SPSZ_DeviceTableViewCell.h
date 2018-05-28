//
//  SPSZ_DeviceTableViewCell.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/24.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBPeripheral;

@interface SPSZ_DeviceTableViewCell : UITableViewCell

@property (nonatomic, strong) CBPeripheral *device;

@end
