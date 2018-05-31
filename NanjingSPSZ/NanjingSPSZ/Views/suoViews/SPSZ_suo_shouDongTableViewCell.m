//
//  SPSZ_suo_shouDongTableViewCell.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/26.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_suo_shouDongTableViewCell.h"
#import "UIImage+Gradient.h"

#import "SPSZ_suo_saoMaDetailModel.h"

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
    
    UIView *BGView =[[UIView alloc]initWithFrame:CGRectMake(18, 14,width + 4,120)];
    BGView.layer.cornerRadius = 5;
    BGView.backgroundColor = [ProgramColor huiseColor];
    [self.contentView addSubview:BGView];
    
    UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(2, 2,width, 116)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5;
    [BGView addSubview:bgView];
    
    UIImage *naviBackImage = [[UIImage alloc] createImageWithSize:CGSizeMake([ProgramSize mainScreenWidth], [ProgramSize mainScreenHeight])
                                                   gradientColors:[ProgramColor blueGradientColors]
                                                       percentage:@[@(0), @(1)]
                                                     gradientType:GradientFromLeftToRight];
    
    UIImageView *myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, 40)];
    myImageView.layer.cornerRadius = 5;
    myImageView.layer.masksToBounds = YES;
    [myImageView setImage:naviBackImage];
    [bgView addSubview:myImageView];
    
    
    
    
    _shopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 10, (width - 20)/2-40, 16)];
    _shopNameLabel.textColor = [UIColor whiteColor];
    _shopNameLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:self.shopNameLabel];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(width / 2 - 40, 10, (width - 20)/2 + 40, 16)];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:self.timeLabel];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, width, 56)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:whiteView];
    _productNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 10 +(10 + 16)*1 , (width - 20)/2, 16)];
    _productNameLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:self.productNameLabel];
    
    _weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(width / 2, 10 +(10 + 16)*1, (width - 20)/2, 16)];
    _weightLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:self.weightLabel];
    
    _productLocationLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 10 +(10 + 16)*2, (width - 20), 16)];
    _productLocationLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:self.productLocationLabel];
    
    
    _piFaNamelabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 10 +(10 + 16)*3, (width - 20)/2, 16)];
    _piFaNamelabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:self.piFaNamelabel];
    
    _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(width / 2, 10 +(10 + 16)*3, (width - 20)/2, 16)];
    _phoneLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:self.phoneLabel];
    
}


- (void)setModel:(SPSZ_suo_shouDongRecordModel *)model{
    _model = model;
    
    SPSZ_suo_saoMaDetailModel *detailModel = model.dishes.firstObject;
    _shopNameLabel.text = model.companyname;
    _timeLabel.text = model.uploaddate;
    [self.productNameLabel setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"产品名称:" string2:detailModel.objectName]];
    
    [self.weightLabel setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"数量/重量:" string2:[NSString stringWithFormat:@"%@%@",detailModel.amount,detailModel.unit]]];
    
    [self.productLocationLabel setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"产品产地:" string2:detailModel.cityname]];
    
    [self.piFaNamelabel setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"批发商姓名:" string2:model.realname]];

    
    [self.phoneLabel setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"联系电话:" string2:model.mobile]];

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
