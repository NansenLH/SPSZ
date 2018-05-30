//
//  SPSZ_suo_SaoMaOrderCollectionViewCell.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/29.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPSZ_suo_shouDongRecordModel.h"
#import "SPSZ_ShowTicketView.h"

@interface SPSZ_suo_SaoMaOrderCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) SPSZ_suo_shouDongRecordModel *model;

@property (nonatomic, strong) SPSZ_ShowTicketView *showView;

@end
