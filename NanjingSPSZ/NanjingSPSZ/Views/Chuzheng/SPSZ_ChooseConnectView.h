//
//  SPSZ_ChooseConnectView.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/23.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPSZ_DeviceModel;
@class CBPeripheral;

@protocol ChooseConnectViewDelegate <NSObject>

- (void)chooseDevice:(CBPeripheral *)device;

@end


@interface SPSZ_ChooseConnectView : UIView

@property (nonatomic, strong) NSMutableArray<CBPeripheral *> *dataArray;

@property (nonatomic, weak) id<ChooseConnectViewDelegate> delegate;

- (void)showInView:(UIView *)view;

- (void)hidden;



@end
