//
//  SPSZ_EditWightView.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/30.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPSZ_EditWightView : UIView

@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *weight;

@property (nonatomic, copy) void(^chooseWeightBlock)(NSString *weight, NSString *unit);


/**
 初始化之后不要加在任何 view 上,这个方法会将 view 加在 Window 上
 */
- (void)show;


/**
 清空当前的 unit 和 weight
 */
- (void)clear;

@end
