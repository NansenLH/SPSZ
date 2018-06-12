//
//  SPSZ_IndexView.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/22.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_IndexView.h"
#import "UIButton+Gradient.h"

@interface SPSZ_IndexView ()

@property (nonatomic, strong) UIImageView * selectImageView;
@property (nonatomic, strong) UILabel * connectStateLabel;
@property (nonatomic, strong) UIImageView * printerImageView;
@property (nonatomic, strong) UILabel * descriptLabel;

@end

@implementation SPSZ_IndexView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configSubView];
    }
    return self;
}

- (void)configSubView
{
    self.backgroundColor = [UIColor whiteColor];
    
//    BOOL is480 = [ProgramSize mainScreenHeight] == 480;
//    CGFloat marginTop = is480 ? 10 : 30;
    self.connectStateLabel = [[UILabel alloc] init];
    [self addSubview:self.connectStateLabel];
    self.connectStateLabel.font = [UIFont systemFontOfSize:13];
    self.connectStateLabel.textColor = [ProgramColor RGBColorWithRed:51 green:51 blue:51 alpha:0.66];
    self.connectStateLabel.text = self.isConnect ? @"打印机已连接" : @"当前设备未连接";
    [self.connectStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0).offset(8);
        make.top.equalTo(8);
        make.height.equalTo(18);
    }];
    
    self.selectImageView = [[UIImageView alloc] init];
    [self addSubview:self.selectImageView];
    self.selectImageView.image = self.isConnect ? [UIImage imageNamed:@"icon_right_2"] : [UIImage imageNamed:@"icon_error_2"];
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(14);
        make.centerY.equalTo(self.connectStateLabel.mas_centerY);
        make.right.equalTo(self.connectStateLabel.mas_left).offset(-8);
    }];
    
    
    self.addGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addGoodsButton setTitle:@"添加货物" forState:UIControlStateNormal];
    [self.addGoodsButton setImage:[UIImage imageNamed:@"addMoreGoods"] forState:UIControlStateNormal];
    [self.addGoodsButton setTitleColor:[ProgramColor RGBColorWithRed:82 green:145 blue:242] forState:UIControlStateNormal];
    self.addGoodsButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.addGoodsButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
//    self.addGoodsButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    [self addSubview:self.addGoodsButton];
//    marginTop = is480 ? 12 : 36;
    [self.addGoodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.height.equalTo(50);
        make.top.mas_equalTo(self.connectStateLabel.mas_bottom).offset(8);
    }];
    self.addGoodsButton.hidden = !self.isConnect;
    
    self.printerImageView = [[UIImageView alloc] init];
    [self addSubview:self.printerImageView];
    self.printerImageView.image = self.isConnect ? [UIImage imageNamed:@"printer_on"] : [UIImage imageNamed:@"printer_no"];
    [self.printerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([ProgramSize fitSize:190]);
        make.height.equalTo([ProgramSize fitSize:170]);
        make.centerX.equalTo(0);
        make.top.equalTo(104);
    }];
    
    NSString *desciptString = self.isConnect ? @"当前蓝牙连接正常，\n快去添加货物进行打印吧。" : @"抱歉，当前未连打单机，\n是否通过蓝牙进行连接？";
    self.descriptLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:13]
                                                text:desciptString
                                           textColor:[ProgramColor RGBColorWithRed:94 green:94 blue:94]
                                       textAlignment:NSTextAlignmentCenter
                                       numberOfLines:2];
    [self addSubview:self.descriptLabel];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.printerImageView.mas_bottom).offset(20);
        make.centerX.equalTo(0);
    }];
    
    
}



- (void)setIsConnect:(BOOL)isConnect
{
    _isConnect = isConnect;
    
    self.connectStateLabel.text = self.isConnect ? @"打印机已连接" : @"当前设备未连接";
    self.selectImageView.image = self.isConnect ? [UIImage imageNamed:@"icon_right_2"] : [UIImage imageNamed:@"icon_error_2"];
    self.printerImageView.image = self.isConnect ? [UIImage imageNamed:@"printer_on"] : [UIImage imageNamed:@"printer_no"];
    self.descriptLabel.text = self.isConnect ? @"当前蓝牙连接正常，\n快去添加货物进行打印吧。" : @"抱歉，当前未连打单机,\n是否通过蓝牙进行连接?";
    
    self.addGoodsButton.hidden = !self.isConnect;
}


@end
