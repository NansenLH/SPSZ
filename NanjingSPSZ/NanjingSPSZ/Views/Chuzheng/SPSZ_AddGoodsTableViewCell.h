//
//  SPSZ_AddGoodsTableViewCell.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/25.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPSZ_GoodsModel;
@class SPSZ_AddGoodsTableViewCell;

@protocol SPSZ_AddGoodsTableViewCellDelegate <NSObject>

- (void)selectAction:(SPSZ_AddGoodsTableViewCell *)cell model:(SPSZ_GoodsModel *)model;

- (void)editWeigthAction:(SPSZ_AddGoodsTableViewCell *)cell model:(SPSZ_GoodsModel *)model;

@end


@interface SPSZ_AddGoodsTableViewCell : UITableViewCell

@property (nonatomic, strong) SPSZ_GoodsModel *dishModel;

@property (nonatomic, weak) id<SPSZ_AddGoodsTableViewCellDelegate> delegate;

@end
