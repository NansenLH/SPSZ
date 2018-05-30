//
//  SPSZ_Help_ViewController.m
//  NanjingSPSZ
//
//  Created by 760 on 2018/5/30.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_Help_ViewController.h"

@interface SPSZ_Help_ViewController ()

@end

@implementation SPSZ_Help_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backToUpView)];
    self.navigationItem.leftBarButtonItem = item;
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, (MainScreenWidth - 20) / 2, 30)];
    nameLab.font = [UIFont systemFontOfSize:16];
    nameLab.text = @"客户服务电话:";
    [self.view addSubview:nameLab];
    
    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneBtn.frame = CGRectMake(MainScreenWidth / 2, 10, (MainScreenWidth - 20) / 2, 30);
    phoneBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [phoneBtn setTitle:@"400-168-3699" forState:UIControlStateNormal];
    [phoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    phoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [phoneBtn addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneBtn];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, MainScreenWidth - 10, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backToUpView
{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)callPhone
{
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",@"4001683699"];
    CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
    if (version >= 10.0) {
        /// 大于等于10.0系统使用此openURL方法
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}
@end
