//
//  SPSZ_SelectedTableViewCell.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/28.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPSZ_GoodsModel;
@class SPSZ_SelectedTableViewCell;

@protocol SPSZ_SelectedTableViewCellDelegate <NSObject>

- (void)deleModel:(SPSZ_SelectedTableViewCell *)cell model:(SPSZ_GoodsModel *)model;

@end

@interface SPSZ_SelectedTableViewCell : UITableViewCell

@property (nonatomic, strong) SPSZ_GoodsModel *model;
@property (nonatomic, weak) id<SPSZ_SelectedTableViewCellDelegate> delegate;

@end
