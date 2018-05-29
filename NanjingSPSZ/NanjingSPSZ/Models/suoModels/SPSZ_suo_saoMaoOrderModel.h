//
//  SPSZ_suo_saoMaoOrderModel.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/29.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface SPSZ_suo_saoMaoOrderModel : NSObject
/**
 "id": 11138,
 "address": "",
 "printcode": "10012949758109081600",
 "dishes": [
 {
 "amount": "50",
 "addresssource": "",
 "unit": "公斤",
 "objectName": "白菜",
 "dishid": "146",
 "cityname": "宁夏银川市市辖区"
 },
 ],
 "uploaddate": "2018-05-29 15:12:30",
 "cityname": "江苏南京市六合区",
 "realname": "冒星星",
 "companyname": "大生冷链",
 "imgurl": "",
 "mobile": "18118673613"
 },
 */

@property (nonatomic, assign) NSInteger suo_saoMaId;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *printcode;

@property (nonatomic, strong) NSArray<NSDictionary *>  *dishes;

@property (nonatomic, strong) NSString *uploaddate;

@property (nonatomic, strong) NSString *cityname;

@property (nonatomic, strong) NSString *realname;

@property (nonatomic, strong) NSString *companyname;

@property (nonatomic, strong) NSString *imgurl;

@property (nonatomic, strong) NSString *mobile;

@end
