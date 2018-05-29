//
//  SPSZ_suo_paiZhaoOrderModel.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/27.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface SPSZ_suo_paiZhaoOrderModel : NSObject

/**
"id": 10326,
"address": "",
"printcode": "",
"dishes": null,
"uploaddate": "2018-05-27 19:28:28",
"cityname": "",
"realname": "",
"companyname": "",
"imgurl": "var/ticketimg/20180527/img_1527420498405.jpg",
"mobile": ""
*/

@property (nonatomic, strong)NSString *suo_PaiZhaoId;

@property (nonatomic, strong)NSString *address;

@property (nonatomic, strong)NSString *printcode;
@property (nonatomic, strong)NSString *dishes;
@property (nonatomic, strong)NSString *uploaddate;
@property (nonatomic, strong)NSString *cityname;
@property (nonatomic, strong)NSString *realname;
@property (nonatomic, strong)NSString *companyname;
@property (nonatomic, strong)NSString *imgurl;
@property (nonatomic, strong)NSString *mobile;

@end
