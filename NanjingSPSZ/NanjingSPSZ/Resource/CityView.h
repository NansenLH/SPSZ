//
//  CityView.h
//  cityDemo
//
//  Created by yyx on 2018/5/28.
//  Copyright © 2018年 liren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityView : UIView
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSArray *cityList;
@property (nonatomic, copy) void(^getSelectCityBlock)(NSDictionary *dic);

- (void)showCityListViewInView:(UIView *)view;

@end
