//
//  SPSZ_suo_paiZhaoCollectionViewCell.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/27.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_suo_paiZhaoCollectionViewCell.h"

@implementation SPSZ_suo_paiZhaoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blueColor];
        self.picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 30)];
         self.picImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_picImageView];
        
        self.timelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 30)];
        [self.contentView addSubview:_timelabel];
        _timelabel.text  = @"sdada";
    }
    return self;
}




@end
