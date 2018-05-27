//
//  SPSZ_AddGoodsViewController.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/25.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "BaseViewController.h"

@class SPSZ_GoodsModel;

@interface SPSZ_AddGoodsViewController : BaseViewController

@property (nonatomic, copy) void(^addGoodsBlock)(NSMutableArray<SPSZ_GoodsModel *> *addGoodsArray);

@end
