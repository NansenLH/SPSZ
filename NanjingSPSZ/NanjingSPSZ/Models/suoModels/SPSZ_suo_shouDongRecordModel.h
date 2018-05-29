//
//  SPSZ_suo_shouDongRecordModel.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/26.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPSZ_suo_saoMaDetailModel;

@interface SPSZ_suo_shouDongRecordModel : NSObject

/**
 "id": 10741,
 "address": "detail",
 "printcode": "",
 "dishes": [
 {
 "amount": "111",
 "addresssource": "detail",
 "unit": "公斤",
 "objectName": "ming",
 "dishid": "",
 "cityname": "江苏南京市玄武区"
 }
 ],
 "uploaddate": "2018-05-28 23:27:43",
 "cityname": "江苏南京市玄武区",
 "realname": "hahah",
 "companyname": "gongjin",
 "imgurl": "",
 "mobile": "186"
*/

@property (nonatomic, strong) NSString *suo_shouDongId;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *printcode;

@property (nonatomic, strong) NSArray<SPSZ_suo_saoMaDetailModel *> *dishes;

@property (nonatomic, strong) NSString *uploaddate;

@property (nonatomic, copy) NSString *cityname;

@property (nonatomic, strong) NSString *realname;

@property (nonatomic, strong) NSString *companyname;

@property (nonatomic, strong) NSString *imgurl;

@property (nonatomic, strong) NSString *mobile;

@end
