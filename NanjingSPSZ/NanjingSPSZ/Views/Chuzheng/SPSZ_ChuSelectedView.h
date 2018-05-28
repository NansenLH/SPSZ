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
@property (nonatomic, strong) UIButton * clearButton;

@end
