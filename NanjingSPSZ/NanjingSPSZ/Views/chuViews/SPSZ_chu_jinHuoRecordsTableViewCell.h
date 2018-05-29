//
//  SPSZ_chu_jinHuoRecordsTableViewCell.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/28.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SPSZ_chu_jinHuoModel.h"

@interface SPSZ_chu_jinHuoRecordsTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel  *productNameLabel;

@property (nonatomic, strong) UILabel *weightLabel;

@property (nonatomic, strong) UILabel *laiYuanChanDiLabel;

@property (nonatomic, strong) SPSZ_chu_jinHuoModel *model;

@end
