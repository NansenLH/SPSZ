//
//  SPSZ_ChooseConnectView.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/23.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPSZ_DeviceModel;

@protocol ChooseConnectViewDelegate <NSObject>

- (void)chooseDevice:(SPSZ_DeviceModel *)device;

@end


@interface SPSZ_ChooseConnectView : UIView

@property (nonatomic, strong) NSMutableArray<SPSZ_DeviceModel *> *dataArray;

@property (nonatomic, weak) id<ChooseConnectViewDelegate> delegate;

- (void)showInView:(UIView *)view;

- (void)hidden;



@end
