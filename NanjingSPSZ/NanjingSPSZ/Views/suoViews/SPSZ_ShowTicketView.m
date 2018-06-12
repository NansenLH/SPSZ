//
//  SPSZ_ShowTicketView.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/29.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_ShowTicketView.h"
#import "SPSZ_suo_shouDongRecordModel.h"
#import "SPSZ_suo_saoMaDetailModel.h"
#import "UIImage+LXDCreateBarcode.h"


@interface SPSZ_ShowTicketView ()

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *dishesView;

@property (nonatomic, strong) UIImageView *qrcodeView;

@property (nonatomic, strong) UILabel *qrcodeLabel;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *companyLabel;

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *bottomImageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIView *bgView;

@end


@implementation SPSZ_ShowTicketView

- (instancetype)init
{
    if (self = [super init]) {
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews
{
    self.backgroundColor = [UIColor clearColor];
    
    self.topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ticket_top"]];
    self.topImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.topImageView];
    self.topImageView.clipsToBounds = YES;
    self.topImageView.hidden = !self.hasHuabian;
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(15);
    }];
    
    self.bottomImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ticket_bottom"]];
    self.bottomImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.bottomImageView];
    self.bottomImageView.hidden = !self.hasHuabian;
    self.bottomImageView.clipsToBounds = YES;
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(15);
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topImageView.mas_bottom);
        make.bottom.mas_equalTo(self.bottomImageView.mas_top);
        make.left.right.equalTo(0);
    }];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.userInteractionEnabled = YES;
    self.scrollView = scrollView;
    
    self.containerView = [[UIView alloc] init];
    self.containerView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        make.height.equalTo(325);
    }];
    
    UILabel *titleLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:16] text:@"南京市农产品销售流通凭证" textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
    [self.containerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(24);
    }];
    
    self.timeLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:12] text:@"" textColor:[ProgramColor RGBColorWithRed:107 green:107 blue:107 alpha:0.72] textAlignment:NSTextAlignmentCenter];
    [self.containerView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(54);
        make.centerX.equalTo(0);
    }];
    
    self.dishesView = [[UIView alloc] init];
    [self.containerView addSubview:self.dishesView];
    [self.dishesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(78);
        make.left.right.equalTo(0);
        make.height.equalTo(36);
    }];
    
    self.qrcodeView = [[UIImageView alloc] init];
    [self.containerView addSubview:self.qrcodeView];
    [self.qrcodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dishesView.mas_bottom).offset(12);
        make.centerX.equalTo(0);
        make.height.width.equalTo(80);
    }];
    
    self.qrcodeLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:12] text:@"" textColor:[ProgramColor RGBColorWithRed:107 green:107 blue:107] textAlignment:NSTextAlignmentCenter];
    [self.containerView addSubview:self.qrcodeLabel];
    [self.qrcodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.qrcodeView.mas_bottom);
        make.height.equalTo(32);
        make.centerX.equalTo(0);
    }];
    
    for (int i = 0; i < 3; i ++) {
        CGFloat y = i * 36;
        CGFloat height = 36.0;
        UIView *cellView = [[UIView alloc] init];
        [self.containerView addSubview:cellView];
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.mas_equalTo(self.qrcodeLabel.mas_bottom).offset(y);
            make.height.equalTo(height);
        }];
        
        UILabel *leftLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:13] text:@"" textColor:[ProgramColor RGBColorWithRed:59 green:59 blue:59 alpha:0.58] textAlignment:NSTextAlignmentLeft];
        [cellView addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.centerY.equalTo(0);
        }];
        
        UILabel *rightLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:13] text:@"" textColor:[ProgramColor RGBColorWithRed:59 green:59 blue:59] textAlignment:NSTextAlignmentRight];
        [cellView addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-15);
            make.centerY.equalTo(0);
            make.left.equalTo(100);
        }];
        if (i == 0) {
            leftLabel.text = @"供货单位";
            self.companyLabel = rightLabel;
        }
        else if (i == 1) {
            leftLabel.text = @"批发商姓名";
            self.nameLabel = rightLabel;
        }
        else {
            leftLabel.text = @"联系电话";
            self.numberLabel = rightLabel;
        }
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [cellView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.right.equalTo(-15);
            make.height.equalTo(0.5);
            make.bottom.equalTo(0);
        }];
    }
}


- (void)setHasHuabian:(BOOL)hasHuabian
{
    _hasHuabian = hasHuabian;
    
    self.topImageView.hidden = !hasHuabian;
    self.bottomImageView.hidden = !hasHuabian;
}

- (void)setModel:(SPSZ_suo_shouDongRecordModel *)model
{
    _model = model;
    
    self.timeLabel.text = model.printdate;
    self.qrcodeLabel.text = model.printcode;
    self.nameLabel.text = model.realname;
    self.companyLabel.text = model.companyname;
    self.numberLabel.text = model.mobile;
    
    // 显示二维码
    self.qrcodeView.image = [UIImage imageOfQRFromURL:model.printcode codeSize:80];
    
    // 布局中间
    for (UIView *subView in self.dishesView.subviews) {
        [subView removeFromSuperview];
    }
    for (int i = 0; i < (model.dishes.count + 1); i++) {
        CGFloat y = i * 36;
        CGFloat height = 36.0;
        UIView *cellView = [[UIView alloc] init];
        [self.dishesView addSubview:cellView];
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(y);
            make.height.equalTo(height);
        }];
        
        UIFont *font = [UIFont systemFontOfSize:13];
        UIColor *textColor = [ProgramColor RGBColorWithRed:59 green:59 blue:59 alpha:0.58];
        NSString *leftText = @"产品名称";
        NSString *centerText = @"产品产地";
        NSString *rightText = @"进货数量";
        if (i > 0) {
            SPSZ_suo_saoMaDetailModel *detailModel = model.dishes[(i-1)];
            font = [UIFont systemFontOfSize:13];
            textColor = [ProgramColor RGBColorWithRed:59 green:59 blue:59];
            leftText = detailModel.objectName;
            centerText = detailModel.cityname;
            rightText = [NSString stringWithFormat:@"%@%@", detailModel.amount, detailModel.unit];
        }
        UILabel *leftLabel = [UICreateTool labelWithFont:font text:leftText textColor:textColor textAlignment:NSTextAlignmentCenter];
        [cellView addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.width.equalTo(80);
            make.left.equalTo(0);
        }];
        
        UILabel *rightLabel = [UICreateTool labelWithFont:font text:rightText textColor:textColor textAlignment:NSTextAlignmentCenter];
        [cellView addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.width.equalTo(80);
            make.right.equalTo(0);
        }];
        
        UILabel *centerLabel = [UICreateTool labelWithFont:font text:centerText textColor:textColor textAlignment:NSTextAlignmentCenter];
        [cellView addSubview:centerLabel];
        [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.mas_equalTo(leftLabel.mas_right);
            make.right.mas_equalTo(rightLabel.mas_left);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [cellView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.right.equalTo(-15);
            make.height.equalTo(0.5);
            make.bottom.equalTo(0);
        }];
    }
    [self.dishesView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo((model.dishes.count+1) * 36);
    }];
    
    
    //78 + (model.dishes.count+1) * 36 + 12 + 80 + 32 + 15
    CGFloat sizeH = (model.dishes.count + 4) * 36 + 217;
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(sizeH);
    }];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat sizeH = 0;
    if (self.model) {
        sizeH = (self.model.dishes.count + 4) * 36 + 217;
    }
    else {
        sizeH = 325;
    }
    
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(sizeH);
    }];
}



@end
