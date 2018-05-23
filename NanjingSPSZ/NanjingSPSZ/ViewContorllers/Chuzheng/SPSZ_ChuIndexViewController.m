//
//  SPSZ_ChuIndexViewController.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/21.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_ChuIndexViewController.h"

#import "SPSZ_IndexView.h"
#import "UIButton+Gradient.h"
#import "UIButton+ImageTitleSpacing.h"


@interface SPSZ_ChuIndexViewController ()

@property (nonatomic, strong) SPSZ_IndexView *indexView;

@end

@implementation SPSZ_ChuIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configNavigation];
    
    [self configSubViews];
    
    [self configTabbar];
    
}

- (void)configNavigation
{
    self.navigationItem.title = @"出证打印";
    
    UIButton *logOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logOutButton setImage:[UIImage imageNamed:@"outlogin_white"] forState:UIControlStateNormal];
    [logOutButton setTitle:@"注销登录" forState:UIControlStateNormal];
    [logOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logOutButton.titleLabel.font = [UIFont systemFontOfSize:13];
    logOutButton.frame = CGRectMake(0, 0, 80, 44);
    logOutButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [logOutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logOutButton];
}

- (void)configSubViews
{
    self.indexView = [[SPSZ_IndexView alloc] init];
    [self.view addSubview:self.indexView];
    [self.indexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(0);
    }];
    [self.indexView.addGoodsButton addTarget:self action:@selector(addGoodsClick:) forControlEvents:UIControlEventTouchUpInside];
    self.indexView.isConnect = YES;
}

- (void)configTabbar
{
    // 阴影
    UIView *bottomShadowView = [[UIView alloc] init];
    bottomShadowView.backgroundColor = [UIColor whiteColor];
    bottomShadowView.layer.shadowColor = [ProgramColor RGBColorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    bottomShadowView.layer.shadowOpacity = 1;
    bottomShadowView.layer.shadowOffset = CGSizeMake(0, -4);
    [self.view addSubview:bottomShadowView];
    
    CGFloat bottomMargin = [ProgramSize isIPhoneX] ? 34 : 0;
    [bottomShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.height.equalTo(66);
        make.bottom.equalTo(0).offset(-bottomMargin);
    }];
    
    // 中间的 button
    UIButton *printButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:printButton];
    [printButton setImage:[UIImage imageNamed:@"printer_white"] forState:UIControlStateNormal];
    [printButton setTitle:@"打印票据" forState:UIControlStateNormal];
    [printButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    printButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [printButton gradientButtonWithSize:CGSizeMake(100, 100)
                             colorArray:[ProgramColor blueGradientColors]
                        percentageArray:@[@(0), @(1)]
                           gradientType:GradientFromTopToBottom];
    printButton.layer.cornerRadius = 50;
    printButton.layer.masksToBounds = YES;
    [self.view addSubview:printButton];
    [printButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.width.height.equalTo(100);
        make.bottom.equalTo(0).offset(-bottomMargin-12);
    }];
    [printButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [printButton addTarget:self action:@selector(printClick) forControlEvents:UIControlEventTouchUpInside];
    
}




#pragma mark - ==== 点击事件 ====
- (void)logoutAction
{
    // 注销登录
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)addGoodsClick:(UIButton *)addGoodsButton
{
    
}

- (void)printClick
{
    
}

- (void)editGoodsClick
{
    
}

- (void)personalCenterClick
{
    
}


@end
