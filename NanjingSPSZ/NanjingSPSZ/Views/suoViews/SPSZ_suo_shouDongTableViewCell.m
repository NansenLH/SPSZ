//
//  SPSZ_suo_shouDongTableViewCell.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/26.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_suo_shouDongTableViewCell.h"

@implementation SPSZ_suo_shouDongTableViewCell

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
    CGFloat width = MainScreenWidth - 40;
    
    UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(20, 16,width, 150)];
    bgView.backgroundColor = [UIColor darkGrayColor];
    [self.contentView addSubview:bgView];
    
    _shopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 10, (width - 20)/2, 26)];
    [bgView addSubview:self.shopNameLabel];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(width / 2, 10, (width - 20)/2, 26)];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:self.timeLabel];
    
    
    _productNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 10 +(10 + 26)*1 , (width - 20)/2, 26)];
    [bgView addSubview:self.productNameLabel];
    
    _weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(width / 2, 10 +(10 + 26)*1, (width - 20)/2, 26)];
    [bgView addSubview:self.weightLabel];
    
    _productLocationLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 10 +(10 + 26)*2, (width - 20), 26)];
    [bgView addSubview:self.productLocationLabel];
    
    
    
    _piFaNamelabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 10 +(10 + 26)*3, (width - 20)/2, 26)];
    [bgView addSubview:self.piFaNamelabel];
    
    _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(width / 2, 10 +(10 + 26)*3, (width - 20)/2, 26)];
    [bgView addSubview:self.phoneLabel];
    
}


- (void)setModel:(SPSZ_suo_shouDongRecordModel *)model{
    _model = model;
    model.shopName = @"22";
    model.timeString = @"22";
    model.productName = @"22";
    model.weightNumber = @"22";
    model.pifaName = @"22";
    model.phoneName = @"22";
    model.location = @"22";
    _shopNameLabel.text = model.shopName;
    _timeLabel.text = model.timeString;

    [self.productNameLabel setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor greenColor] string:@"产品名称：" string2:model.productName]];
    
    [self.weightLabel setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor greenColor] string:@"数量/重量：" string2:model.weightNumber]];
    
    [self.productLocationLabel setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor greenColor] string:@"产品产地：" string2:model.location]];
    
    [self.piFaNamelabel setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor greenColor] string:@"批发商姓名：" string2:model.pifaName]];

    
    [self.phoneLabel setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor greenColor] string:@"联系电话：" string2:model.phoneName]];

    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
