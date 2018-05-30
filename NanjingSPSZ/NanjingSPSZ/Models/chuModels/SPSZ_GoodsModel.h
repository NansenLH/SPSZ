//
//  SPSZ_GoodsModel.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/25.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPSZ_GoodsModel : NSObject

/**
 具体地址
 */
@property (nonatomic, copy) NSString *addresssource;

/**
 时间戳
 */
@property (nonatomic, copy) NSString *dishdate;

/**
 商品 id
 */
@property (nonatomic, assign) int dishid;

/**
 商品名
 */
@property (nonatomic, copy) NSString *dishname;

/**
 图片
 */
@property (nonatomic, copy) NSString *dishimg1;

/**
 数量
 */
@property (nonatomic, copy) NSString *dishamount;

/**
 市县区
 */
@property (nonatomic, copy) NSString *cityname;


/**
 自己添加-货品录入的时候用来存放图片的地址,用,分割多个
 */
@property (nonatomic, copy) NSString *dishimgs;

/**
 自己添加-是否选中
 */
@property (nonatomic, assign) BOOL isSelected;

/**
 手动添加-输入的重量
 */
@property (nonatomic, copy) NSString *weight;

/**
 手动添加-单位
 */
@property (nonatomic, copy) NSString *unit;


@end
