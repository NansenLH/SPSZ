//
//  SPSZ_chu_chuZhengRecordsTableViewCell.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/28.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPSZ_chu_recordsModel.h"

@interface SPSZ_chu_chuZhengRecordsTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel  *danHaoLabel;

@property (nonatomic, strong) SPSZ_chu_recordsModel *model;

@end
