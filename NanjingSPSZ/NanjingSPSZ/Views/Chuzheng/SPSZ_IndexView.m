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
    
    BOOL is480 = [ProgramSize mainScreenHeight] == 480;
    CGFloat marginTop = is480 ? 10 : 30;
    self.connectStateLabel = [[UILabel alloc] init];
    [self addSubview:self.connectStateLabel];
    self.connectStateLabel.font = [UIFont systemFontOfSize:13];
    self.connectStateLabel.textColor = [ProgramColor RGBColorWithRed:51 green:51 blue:51 alpha:0.66];
    self.connectStateLabel.text = self.isConnect ? @"当前设备连接正常" : @"当前设备未连接";
    [self.connectStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0).offset(4);
        make.top.equalTo(marginTop);
    }];
    
    self.selectImageView = [[UIImageView alloc] init];
    [self addSubview:self.selectImageView];
    self.selectImageView.image = self.isConnect ? [UIImage imageNamed:@"icon_right_2"] : [UIImage imageNamed:@"icon_error_2"];
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(14);
        make.centerY.equalTo(self.connectStateLabel.mas_centerY);
        make.right.equalTo(self.connectStateLabel.mas_left).offset(-8);
    }];
    
    self.printerImageView = [[UIImageView alloc] init];
    [self addSubview:self.printerImageView];
    self.printerImageView.image = self.isConnect ? [UIImage imageNamed:@"printer_on"] : [UIImage imageNamed:@"printer_no"];
    marginTop = is480 ? 10 : 70;
    [self.printerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([ProgramSize fitSize:190]);
        make.height.equalTo([ProgramSize fitSize:170]);
        make.centerX.equalTo(0);
        make.top.equalTo(self.selectImageView.mas_bottom).offset(marginTop);
    }];
    
    NSString *desciptString = self.isConnect ? @"当前蓝牙连接正常，\n快去添加货物进行打印吧。" : @"抱歉，当前未连打单机，\n是否通过蓝牙进行连接？";
    self.descriptLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:13]
                                                text:desciptString
                                           textColor:[ProgramColor RGBColorWithRed:94 green:94 blue:94]
                                       textAlignment:NSTextAlignmentCenter
                                       numberOfLines:2];
    [self addSubview:self.descriptLabel];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.printerImageView.mas_bottom).offset(20);
        make.centerX.equalTo(0);
    }];
    
    
    self.addGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addGoodsButton setTitle:@"添 加 货 物" forState:UIControlStateNormal];
    self.addGoodsButton.layer.cornerRadius = 17;
    self.addGoodsButton.layer.masksToBounds = YES;
    [self.addGoodsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.addGoodsButton gradientButtonWithSize:CGSizeMake(165, 36)
                                     colorArray:[ProgramColor blueMoreGradientColors]
                                percentageArray:@[@(0), @(1)]
                                   gradientType:GradientFromTopToBottom];
    self.addGoodsButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.addGoodsButton];
    marginTop = is480 ? 12 : 36;
    [self.addGoodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.width.equalTo(165);
        make.height.equalTo(36);
        make.top.equalTo(self.descriptLabel.mas_bottom).offset(marginTop);
    }];
    self.addGoodsButton.hidden = !self.isConnect;
    
}



- (void)setIsConnect:(BOOL)isConnect
{
    _isConnect = isConnect;
    
    self.connectStateLabel.text = self.isConnect ? @"当前设备连接正常" : @"当前设备未连接";
    self.selectImageView.image = self.isConnect ? [UIImage imageNamed:@"icon_right_2"] : [UIImage imageNamed:@"icon_error_2"];
    self.printerImageView.image = self.isConnect ? [UIImage imageNamed:@"printer_on"] : [UIImage imageNamed:@"printer_no"];
    self.descriptLabel.text = self.isConnect ? @"当前蓝牙连接正常，\n快去添加货物进行打印吧。" : @"抱歉，当前未连打单机,\n是否通过蓝牙进行连接?";
    self.addGoodsButton.hidden = !self.isConnect;
}


@end
