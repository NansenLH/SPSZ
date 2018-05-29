//
//  SPSZ_chu_luRuCollectionViewCell.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/28.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_chu_luRuCollectionViewCell.h"

@implementation SPSZ_chu_luRuCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blueColor];
        self.picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 30)];
        self.picImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_picImageView];
        
    }
    return self;
}

@end
