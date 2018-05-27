//
//  SPSZ_suo_paiZhaoCollectionViewCell.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/27.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPSZ_suo_paiZhaoOrderModel.h"

@interface SPSZ_suo_paiZhaoCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) UIImageView *picImageView;
@property(nonatomic, strong) UILabel *timelabel;
@property(nonatomic, strong) SPSZ_suo_paiZhaoOrderModel *model;
@end
