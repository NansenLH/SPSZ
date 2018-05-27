//
//  SPSZ_AddGoodsTableViewCell.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/25.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPSZ_GoodsModel;

@protocol SPSZ_AddGoodsTableViewCellDelegate <NSObject>

- (void)selectedGoods:(BOOL)selected goods:(SPSZ_GoodsModel *)dish;

@end


@interface SPSZ_AddGoodsTableViewCell : UITableViewCell

@property (nonatomic, strong) SPSZ_GoodsModel *dishModel;
@property (nonatomic, weak) id<SPSZ_AddGoodsTableViewCellDelegate> delegate;

@end
