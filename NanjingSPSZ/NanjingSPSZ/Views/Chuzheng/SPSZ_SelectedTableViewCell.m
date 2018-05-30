//
//  SPSZ_SelectedTableViewCell.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/28.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_SelectedTableViewCell.h"

#import "SPSZ_GoodsModel.h"

#import "UIImageView+WebCache.h"

@interface SPSZ_SelectedTableViewCell ()

@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) UILabel *goodsNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation SPSZ_SelectedTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.showImageView = [[UIImageView alloc] init];
    self.showImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.showImageView];
    [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(50);
        make.centerY.equalTo(0);
        make.left.mas_equalTo(20);
    }];
    self.showImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.goodsNameLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:14] text:nil textColor:[ProgramColor RGBColorWithRed:0 green:0 blue:0 alpha:0.86] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.goodsNameLabel];
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(8);
        make.left.equalTo(90);
        make.right.equalTo(-60);
        make.height.equalTo(25);
    }];
    
    self.timeLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:11] text:nil textColor:[ProgramColor RGBColorWithRed:169 green:169 blue:169] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsNameLabel.mas_left);
        make.top.mas_equalTo(self.goodsNameLabel.mas_bottom);
        make.right.equalTo(-60);
    }];
    
    self.addressLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:11] text:nil textColor:[ProgramColor RGBColorWithRed:169 green:169 blue:169] textAlignment:NSTextAlignmentLeft];
    self.addressLabel.numberOfLines = 2;
    [self.contentView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsNameLabel.mas_left);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(1);
        make.right.equalTo(-60);
    }];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(60);
        make.centerY.equalTo(0);
        make.right.equalTo(0);
        make.height.equalTo(30);
    }];
}

- (void)setModel:(SPSZ_GoodsModel *)model
{
    _model = model;
    
    NSString *imageurlstring = [NSString stringWithFormat:@"%@%@", BaseImagePath, model.dishimg1];
    [self.showImageView sd_setImageWithURLString:imageurlstring];
    
    self.goodsNameLabel.text = [NSString stringWithFormat:@"%@    %@%@", model.dishname, model.weight, model.unit];
    self.timeLabel.text = model.dishdate;
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@", model.cityname, model.addresssource];
}

- (void)rightClick:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleModel:model:)]) {
        [self.delegate deleModel:self model:self.model];
    }
}

@end
