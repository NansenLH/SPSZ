//
//  SPSZ_chu_RecordTableViewCell.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/21.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_chu_RecordTableViewCell.h"

@implementation SPSZ_chu_RecordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupOriginal];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupOriginal{
    UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(20, 16, MainScreenWidth - 40, 94)];
    [self.contentView addSubview:bgView];
    _shopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 10, MainScreenWidth / 2, 26)];
    _shopNameLabel.backgroundColor =[UIColor redColor];
    [bgView addSubview:self.shopNameLabel];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(MainScreenWidth / 2, 10, MainScreenWidth / 2 - 40, 26)];
    _timeLabel.backgroundColor = [UIColor greenColor];
    [bgView addSubview:self.timeLabel];
    
    _orderNumberlabel = [[UILabel alloc]init];
    _orderNumberlabel.backgroundColor = [UIColor orangeColor];
    [bgView addSubview:self.orderNumberlabel];
    
    [_orderNumberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).equalTo(13);
        make.left.equalTo(10);
        make.height.equalTo(26);
        make.width.equalTo(MainScreenWidth - 180);
    }];
    
    _orderNameLabel = [[UILabel alloc]init];
    _orderNameLabel.backgroundColor = [UIColor blackColor];
    [bgView addSubview:self.orderNameLabel];
    [_orderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderNumberlabel.mas_bottom).equalTo(10);
        make.left.equalTo(10);
        make.height.equalTo(26);
        make.width.equalTo(80);
    }];
    
    _phoneNumberLabel = [[UILabel alloc]init];
    _phoneNumberLabel.backgroundColor = [UIColor blueColor];
    [bgView addSubview:self.phoneNumberLabel];
    [_phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderNumberlabel.mas_bottom).equalTo(10);
        make.left.mas_equalTo(self.orderNameLabel.mas_right).equalTo(10);
        make.height.equalTo(26);
        make.width.equalTo(140);
    }];
    
    _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _detailButton.backgroundColor = [UIColor redColor];
    [bgView addSubview:self.detailButton];
    [_detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).equalTo(13);
        make.right.equalTo(-10);
        make.height.width.equalTo(60);
    }];
    
}


- (void)setModel:(SPSZ_chu_RecordModel *)model{
    _model = model;
    //    _shopNameLabel.text = model.shopName;
    //    _timeLabel.text = model.timeString;
    //    _orderNameLabel.text = model.chuzhengName;
    //    [self.shopNameLabel setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor greenColor] string:@"出证单号：" string2:@"456798765349876543"]];
    
}



- (NSMutableAttributedString *)Color:(UIColor *)color
                         secondColor:(UIColor *)secondColor
                              string:(NSString *)string
                             string2:(NSString *)string2{
    NSString *str = [NSString stringWithFormat:@"%@%@",string,string2];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:string2].location, [[noteStr string] rangeOfString:string2].length);
    //需要设置的位置
    [noteStr addAttribute:NSForegroundColorAttributeName value:secondColor range:redRange];
    return noteStr;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
