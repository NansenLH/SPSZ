//
//  KRTagBar.h
//  smartlife
//
//  Created by Chensai on 2016/12/30.
//  Copyright © 2016年 jingxi. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol KRTagBarDelegate <NSObject>

-(void)tagBarDidClickBtn:(UIButton *)btn atIndex:(NSInteger)index;

@end

@interface KRTagBar : UIScrollView


// 标签栏的数据
@property (nonatomic, strong) NSArray *itemArray;

//点击代理
@property (nonatomic,weak)  id<KRTagBarDelegate> tagBarDelegate;

//当前选中的标签序号
@property (nonatomic,readonly) NSInteger     selectedIndex;

-(void)selectIndex:(NSInteger)index;

-(void)updateContentOffSet:(CGPoint)offSet;

@end
