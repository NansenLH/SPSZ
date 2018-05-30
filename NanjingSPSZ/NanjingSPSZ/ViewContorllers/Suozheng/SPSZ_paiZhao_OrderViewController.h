//
//  SPSZ_paiZhao_OrderViewController.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/23.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "BaseViewController.h"

@interface SPSZ_paiZhao_OrderViewController : BaseViewController

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSString *timeString;


- (void)reloadDataWithDateWith:(NSString *)date;


@end
