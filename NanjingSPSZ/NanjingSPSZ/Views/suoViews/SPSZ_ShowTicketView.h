//
//  SPSZ_ShowTicketView.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/29.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPSZ_suo_shouDongRecordModel;

@interface SPSZ_ShowTicketView : UIView

@property (nonatomic, strong) SPSZ_suo_shouDongRecordModel *model;

/**
 上下是否有花边,默认没有
 */
@property (nonatomic, assign) BOOL hasHuabian;

@end
