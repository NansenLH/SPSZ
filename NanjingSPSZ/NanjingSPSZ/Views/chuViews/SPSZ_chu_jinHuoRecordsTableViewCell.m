//
//  SPSZ_chu_jinHuoRecordsTableViewCell.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/28.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_chu_jinHuoRecordsTableViewCell.h"
#import "UIImage+Gradient.h"

@implementation SPSZ_chu_jinHuoRecordsTableViewCell

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
    
    UIView *BGView =[[UIView alloc]initWithFrame:CGRectMake(18, 14,width + 4,130)];
    BGView.layer.cornerRadius = 5;
    BGView.backgroundColor = [ProgramColor huiseColor];
    [self.contentView addSubview:BGView];
    
    UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(2, 2,width, 126)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5;
    [BGView addSubview:bgView];
    
    UIImage *naviBackImage = [[UIImage alloc] createImageWithSize:CGSizeMake([ProgramSize mainScreenWidth], [ProgramSize mainScreenHeight])
                                                   gradientColors:[ProgramColor blueGradientColors]
                                                       percentage:@[@(0), @(1)]
                                                     gradientType:GradientFromLeftToRight];
    
    UIImageView *myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, 50)];
    myImageView.layer.cornerRadius = 5;
    myImageView.layer.masksToBounds = YES;
    [myImageView setImage:naviBackImage];
    [bgView addSubview:myImageView];
    
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 10, width - 20, 26)];
    [myImageView addSubview:self.timeLabel];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor whiteColor];
    

    
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, width, 35)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:whiteView];
    
    _productNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 10 , (width - 20)/2, 26)];
    [_productNameLabel adjustsFontSizeToFitWidth];
    _productNameLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [whiteView addSubview:self.productNameLabel];
    
    _weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(width / 2, 10, (width - 20)/2, 26)];
    [_weightLabel adjustsFontSizeToFitWidth];
    _weightLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [whiteView addSubview:self.weightLabel];
    
    _laiYuanChanDiLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, (10 + 26)*1+ 10,width - 10, 26)];
    [_laiYuanChanDiLabel adjustsFontSizeToFitWidth];
    _laiYuanChanDiLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [whiteView addSubview:self.laiYuanChanDiLabel];
    if (MainScreenWidth < 375) {
        _productNameLabel.font = [UIFont systemFontOfSize:14];
        _weightLabel.font = [UIFont systemFontOfSize:14];
        _laiYuanChanDiLabel.font = [UIFont systemFontOfSize:14];

    }
}



 - (void)setModel:(SPSZ_chu_jinHuoModel *)model{
     _model = model;

     _timeLabel.text = model.dishdate;
     
 
     [self.productNameLabel setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"货品名称:" string2:model.dishname]];
     if (!model.unit) {
         model.unit = @"公斤";
     }
     [self.weightLabel setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"数量/重量:" string2:[NSString stringWithFormat:@"%@%@",model.dishamount,model.unit]]];
 
     [self.laiYuanChanDiLabel setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"来源产地:" string2:model.cityname]];
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
@end
