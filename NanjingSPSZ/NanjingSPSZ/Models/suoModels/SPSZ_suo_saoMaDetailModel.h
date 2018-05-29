//
//  SPSZ_suo_saoMaDetailModel.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/29.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YYModel.h"

@interface SPSZ_suo_saoMaDetailModel : NSObject
/**
"amount": "0",
"addresssource": "天安门",
"unit": "公斤",
"objectName": "白菜",
"dishid": "145",
"cityname": "北京市辖区东城区"
*/

@property (nonatomic, strong)NSString *amount;

@property (nonatomic, strong)NSString *addresssource;

@property (nonatomic, strong)NSString *unit;

@property (nonatomic, strong)NSString *objectName;

@property (nonatomic, strong)NSString *dishid;

@property (nonatomic, strong)NSString *cityname;

@end
