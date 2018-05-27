//
//  SPSZ_AddGoodsTableViewCell.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/25.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_AddGoodsTableViewCell.h"

#import "SPSZ_GoodsModel.h"


@interface SPSZ_AddGoodsTableViewCell ()

@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIButton *lessButton;
@property (nonatomic, strong) UIButton *countButton;
@property (nonatomic, strong) UIButton *moreButton;

@end

@implementation SPSZ_AddGoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

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
    [selectedButton addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    self.selectButton = selectedButton;
    
    
    self.goodsImageView = [[UIImageView alloc] init];
    self.goodsImageView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectedButton.mas_right).offset(15);
        make.top.equalTo(7);
        make.width.equalTo(53);
        make.height.equalTo(49);
    }];
    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.nameLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:14] text:nil textColor:[ProgramColor RGBColorWithRed:0 green:0 blue:0 alpha:0.86] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(7);
        make.left.equalTo(self.goodsImageView.mas_right).offset(11);
        make.right.equalTo(-70);
        make.bottom.equalTo(-35);
    }];
    
    self.timeLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:11] text:nil textColor:[ProgramColor RGBColorWithRed:169 green:169 blue:169] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(32);
        make.left.equalTo(-70);
    }];
    
    self.addressLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:11] text:nil textColor:[ProgramColor RGBColorWithRed:169 green:169 blue:169] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(4);
        make.left.equalTo(-70);
    }];
    
    
    self.lessButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.contentView addSubview:self.lessButton];
    
    
    
}


- (void)selectClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    self.contentView.backgroundColor = button.selected ? [ProgramColor RGBColorWithRed:55 green:55 blue:55 alpha:0.07] : [UIColor whiteColor];
    self.dishModel.isSelected = button.selected;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedGoods:goods:)]) {
        [self.delegate selectedGoods:button.selected goods:self.dishModel];
    }
}





@end
