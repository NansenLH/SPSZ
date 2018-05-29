//
//  SPSZ_chu_recordsModel.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/29.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface SPSZ_chu_recordsModel : NSObject
/**
 "printid": 324,
 "printcode": "10012977512447795200",
 "printdate": "2018-05-29 11:02:42"
 */

@property (nonatomic, assign)NSInteger printid;

@property (nonatomic, strong)NSString *printcode;

@property (nonatomic, strong)NSString *printdate;

@end
