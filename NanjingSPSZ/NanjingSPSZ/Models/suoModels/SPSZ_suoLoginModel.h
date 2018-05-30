//
//  SPSZ_suoLoginModel.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/27.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface SPSZ_suoLoginModel : NSObject<NSCoding>
/**
 "img_qs": "",
 "img_entry": "",
 "bus_license": "",
 "stall_id": 12986,
 "img_save": "",
 "create_date": "2018-05-03",
 "stall_no": "B674",
 "address": "江苏省南京市白下区八宝前街64巷10号",
 "stall_tel": "18618435258",
 "cityname": "江苏南京市秦淮区",
 "stall_name": "马云",
 "deptname": "尚书巷市场",
 "bus_img": ""
 */

@property (nonatomic, strong)NSString *img_qs;//食品经营许可证
@property (nonatomic, strong)NSString *img_entry;//入场协议
@property (nonatomic, strong)NSString *bus_license;//社会信用码
@property (nonatomic, strong)NSString *stall_id;
@property (nonatomic, strong)NSString *img_save;
@property (nonatomic, strong)NSString *create_date;
@property (nonatomic, strong)NSString *stall_no;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *stall_tel;
@property (nonatomic, strong)NSString *cityname;
@property (nonatomic, strong)NSString *stall_name;
@property (nonatomic, strong)NSString *deptname;
@property (nonatomic, strong)NSString *bus_img; //营业执照图片




@end
