//
//  SPSZ_chuLoginModel.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/27.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface SPSZ_chuLoginModel : NSObject<NSCoding>

/**
 "img_qs": "",
 "socialcode": "",
 "companyname": "大生冷链",
 "bus_img": "",
 "cityid": "320116",
 "id": 13156,
 "img_entry": "",
 "img_save": "",
 "stall_no": "B8762",
 "address": null,
 "salertype": "1",
 "cityname": "江苏南京市六合区",
 "realname": "冒星星",
 "mobile": "18118673613"
 */

@property (nonatomic, strong)NSString *img_qs;
@property (nonatomic, strong)NSString *socialcode;
@property (nonatomic, strong)NSString *companyname;
@property (nonatomic, strong)NSString *bus_img;
@property (nonatomic, strong)NSString *cityid;
@property (nonatomic, strong)NSString *login_Id;
@property (nonatomic, strong)NSString *img_entry;
@property (nonatomic, strong)NSString *img_save;
@property (nonatomic, strong)NSString *stall_no;
@property (nonatomic, strong)NSString *salertype;
@property (nonatomic, strong)NSString *cityname;
@property (nonatomic, strong)NSString *realname;
@property (nonatomic, strong)NSString *mobile;
@property (nonatomic, copy) NSString *pronames;

@end
