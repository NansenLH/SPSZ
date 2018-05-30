//
//  SPSZ_suo_paiZhaoCollectionViewCell.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/27.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_suo_paiZhaoCollectionViewCell.h"

#import "UIImageView+WebCache.h"

@implementation SPSZ_suo_paiZhaoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 30)];
        [self.contentView addSubview:_picImageView];
        
        self.timelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 30)];
        self.timelabel.font = [UIFont systemFontOfSize:12];
        self.timelabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_timelabel];
            }
    return self;
}

- (void)setModel:(SPSZ_suo_paiZhaoOrderModel *)model
{
    _model = model;
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
    _timelabel.text = model.uploaddate;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImagePath,model.imgurl]]];

}




@end
