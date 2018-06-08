//
//  SPSZ_ChuSelectedView.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/27.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPSZ_GoodsModel;

@interface SPSZ_ChuSelectedView : UIView

@property (nonatomic, strong) NSMutableArray<SPSZ_GoodsModel *> *selectedArray;

@property (nonatomic, assign) BOOL isConnect;
@property (nonatomic, strong) UIButton * addMoreGoodsButton;

// 老设计公开,新设计无
//@property (nonatomic, strong) UIButton * clearButton;


/**
 删掉最后一个 cell
 */
@property (nonatomic, copy) void(^deleteLastCellBlock)(void);


@end
