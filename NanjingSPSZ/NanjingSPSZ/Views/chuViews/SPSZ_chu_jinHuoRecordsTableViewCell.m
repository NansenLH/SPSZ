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
    _productNameLabel.backgroundColor = [UIColor greenColor];
    [whiteView addSubview:self.productNameLabel];
    
    _weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(width / 2, 10, (width - 20)/2, 26)];
    _weightLabel.backgroundColor = [UIColor redColor];
   
    [whiteView addSubview:self.weightLabel];
    
    _laiYuanChanDiLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, (10 + 26)*1+ 10,width - 20, 26)];
    _laiYuanChanDiLabel.backgroundColor = [UIColor greenColor];
    [whiteView addSubview:self.laiYuanChanDiLabel];
}


/*
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
 
 */

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
