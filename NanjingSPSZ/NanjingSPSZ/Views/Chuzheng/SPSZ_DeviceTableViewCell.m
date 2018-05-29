//
//  SPSZ_DeviceTableViewCell.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/24.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_DeviceTableViewCell.h"
#import "SPSZ_DeviceModel.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface SPSZ_DeviceTableViewCell ()

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation SPSZ_DeviceTableViewCell

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
    self.leftLabel = [[UILabel alloc] init];
    self.leftLabel.font = [UIFont systemFontOfSize:14];
    self.leftLabel.textColor = [ProgramColor RGBColorWithRed:89 green:89 blue:89 alpha:0.65];
    self.leftLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(0);
        make.width.equalTo([ProgramSize mainScreenWidth] * 0.4);
    }];
    
    self.rightLabel = [[UILabel alloc] init];
    self.rightLabel.font = [UIFont systemFontOfSize:14];
    self.rightLabel.textColor = [ProgramColor RGBColorWithRed:89 green:89 blue:89 alpha:0.65];
    self.rightLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.rightLabel];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(0);
        make.width.equalTo([ProgramSize mainScreenWidth] * 0.6);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:lineView];
    lineView.alpha = 0.24;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(1);
    }];
}

- (void)setDevice:(CBPeripheral *)device
{
    _device = device;
    
    self.leftLabel.text = device.name.length > 0 ? device.name : @"未知设备";
    self.rightLabel.text = device.identifier.UUIDString;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
