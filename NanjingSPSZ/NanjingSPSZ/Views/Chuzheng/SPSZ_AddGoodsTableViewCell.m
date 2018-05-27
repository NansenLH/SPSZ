//
//  SPSZ_AddGoodsTableViewCell.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/25.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_AddGoodsTableViewCell.h"

#import "SPSZ_InputWeightView.h"

#import "SPSZ_GoodsModel.h"

@interface SPSZ_AddGoodsTableViewCell ()

@property (nonatomic, strong) UIButton *chooseButton;
@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) UILabel *goodsNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) SPSZ_InputWeightView *weightView;

@end

@implementation SPSZ_AddGoodsTableViewCell

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
    
    UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectedButton setImage:[UIImage imageNamed:@"un_select"] forState:UIControlStateNormal];
    [selectedButton setImage:[UIImage imageNamed:@"has_select"] forState:UIControlStateSelected];
    [self.contentView addSubview:selectedButton];
    [selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(40);
        make.centerY.equalTo(0);
        make.left.equalTo(0);
    }];
    self.chooseButton = selectedButton;
    [self.chooseButton addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.showImageView = [[UIImageView alloc] init];
    self.showImageView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.showImageView];
    [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(53);
        make.centerY.equalTo(0);
        make.left.mas_equalTo(40);
    }];
    self.showImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.goodsNameLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:14] text:nil textColor:[ProgramColor RGBColorWithRed:0 green:0 blue:0 alpha:0.86] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.goodsNameLabel];
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(5);
        make.left.mas_equalTo(self.showImageView.mas_right).offset(11);
        make.right.equalTo(-122);
    }];
    
    self.timeLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:11] text:nil textColor:[ProgramColor RGBColorWithRed:169 green:169 blue:169] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsNameLabel.mas_left);
        make.top.mas_equalTo(self.goodsNameLabel.mas_bottom).offset(3);
        make.right.equalTo(-122);
    }];
    
    self.addressLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:11] text:nil textColor:[ProgramColor RGBColorWithRed:169 green:169 blue:169] textAlignment:NSTextAlignmentLeft];
    self.addressLabel.numberOfLines = 2;
    [self.contentView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsNameLabel.mas_left);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(2);
        make.right.equalTo(-122);
    }];
    
    self.weightView = [[SPSZ_InputWeightView alloc] init];
    [self.contentView addSubview:self.weightView];
    self.weightView.backgroundColor = [UIColor grayColor];
    [self.weightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(0);
        make.width.equalTo(120);
    }];
    [self.weightView.button addTarget:self action:@selector(editWeight:) forControlEvents:UIControlEventTouchUpInside];
    self.weightView.button.userInteractionEnabled = NO;
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [ProgramColor RGBColorWithRed:41 green:41 blue:41 alpha:0.64];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(1);
    }];
}

- (void)setDishModel:(SPSZ_GoodsModel *)dishModel
{
    _dishModel = dishModel;
    
    self.contentView.backgroundColor = dishModel.isSelected ? [ProgramColor RGBColorWithRed:55 green:55 blue:55 alpha:0.07] : [UIColor whiteColor];
    self.chooseButton.selected = dishModel.isSelected;
    // TODO: 图片地址是什么?
    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:dishModel.dishimg1]];
    self.goodsNameLabel.text = dishModel.dishname;
    self.timeLabel.text = dishModel.dishdate;
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@", dishModel.cityname, dishModel.addresssource];
    self.weightView.backgroundColor = dishModel.isSelected ? [ProgramColor RGBColorWithRed:67 green:130 blue:255] : [UIColor grayColor];
    self.weightView.weight = dishModel.weight;
    self.weightView.button.userInteractionEnabled = dishModel.isSelected;
}

- (void)editWeight:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(editWeigthAction:model:)]) {
        [self.delegate editWeigthAction:self model:self.dishModel];
    }
}


- (void)selectClick:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectAction:model:)]) {
        [self.delegate selectAction:self model:self.dishModel];
    }
}


@end
