//
//  SPSZ_ChuhuoModel.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/29.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPSZ_ChuhuoModel : NSObject

/**
 商品 id
 */
@property (nonatomic, copy) NSString *dishid;

/**
 商品名
 */
@property (nonatomic, copy) NSString *dishname;

/**
 数量
 */
@property (nonatomic, copy) NSString *dishamount;

/**
 市县区
 */
@property (nonatomic, copy) NSString *cityname;

@property (nonatomic, copy) NSString *cityid;


/**
 具体地址
 */
@property (nonatomic, copy) NSString *addresssource;





/**
 车牌号
 */
@property (nonatomic, copy) NSString *carnumber;

/**
 货品录入的时候用来存放图片的地址,用,分割多个
 */
@property (nonatomic, copy) NSString *dishimgs;

@property (nonatomic, copy) NSString *salerid;



@end
