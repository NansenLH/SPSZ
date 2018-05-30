//
//  SPSZ_suo_SaoMaOrderCollectionViewCell.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/29.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_suo_SaoMaOrderCollectionViewCell.h"

@implementation SPSZ_suo_SaoMaOrderCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.showView = [[SPSZ_ShowTicketView alloc]init];
        self.showView.hasHuabian = YES;
        [self.contentView addSubview:self.showView];
        [_showView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(20);
            make.left.equalTo(20);
            make.right.equalTo(-20);
            make.bottom.equalTo(-60);
        }];
                
    }
    return self;
}

- (void)setModel:(SPSZ_suo_shouDongRecordModel *)model{
    _model = model;
    self.showView.model = model;
}
@end
