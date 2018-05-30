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
    
    
    UIView *BGView =[[UIView alloc]initWithFrame:CGRectMake(18, 14,width + 4,150)];
    BGView.layer.cornerRadius = 5;
    BGView.backgroundColor = [ProgramColor huiseColor];
    [self.contentView addSubview:BGView];
    
    UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(2, 2,width, 146)];
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
    
    
    
    
    _shopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 10, (width - 20)/2-80, 26)];
    _shopNameLabel.textColor = [UIColor whiteColor];
    [bgView addSubview:self.shopNameLabel];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(width / 2 - 80, 10, (width - 20)/2 + 80, 26)];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = [UIColor whiteColor];
    [bgView addSubview:self.timeLabel];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, width, 96)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:whiteView];
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

    /**
     "id": 10741,
     "address": "detail",
     "printcode": "",
     "dishes": [
     {
     "amount": "111",
     "addresssource": "detail",
     "unit": "公斤",
     "objectName": "ming",
     "dishid": "",
     "cityname": "江苏南京市玄武区"
     }
     ],
     "uploaddate": "2018-05-28 23:27:43",
     "cityname": "江苏南京市玄武区",
     "realname": "hahah",
     "companyname": "gongjin",
     "imgurl": "",
     "mobile": "186"
     */
    
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
