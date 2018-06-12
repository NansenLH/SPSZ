//
//  SPSZ_chu_jinHuoModel.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/29.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface SPSZ_chu_jinHuoModel : NSObject
/**
 "addresssource": "",
 "carnumber": "",
 "dishdate": "2018-05-18 08:53:19",
 "dishid": 146,
 "dishname": "白菜",
 "dishimg3": null,
 "salerid": "13156",
 "dishimg4": null,
 "dishimg1": "var/ticketimg/20180518/wsge_1526604788186.jpg",
 "dishimg2": null,
 "cityname": "宁夏银川市市辖区",
 "dishamount": "1600",
 "dishimg5": null
 unit
 */

/**
 "unit": "公斤",
 "addresssource": "",
 "dishdate": "2018-06-12 11:40:08",
 "dishid": 704,
 "dishname": "133",
 "dishimg1": "var/ticketimg/20180612/1528774804iosspsz.jpg",
 "dishamount": "5",
 "cityname": "江苏南京市玄武区"
 */

@property (nonatomic, strong) NSString *unit;

@property (nonatomic, strong) NSString *addresssource;

@property (nonatomic, strong) NSString *dishdate;

@property (nonatomic, assign) NSInteger dishid;

@property (nonatomic, strong) NSString *dishname;

@property (nonatomic, strong) NSString *dishimg1;

@property (nonatomic, strong) NSString *dishamount;

@property (nonatomic, strong) NSString *cityname;

@end
