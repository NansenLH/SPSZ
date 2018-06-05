//
//  SPSZ_chu_ChuZhengDetailViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/6/5.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_chu_ChuZhengDetailViewController.h"

#import "SPSZ_ShowTicketView.h"

#import "SPSZ_suo_orderNetTool.h"

#import "SPSZ_suoLoginModel.h"

#import "UIImage+Gradient.h"

@interface SPSZ_chu_ChuZhengDetailViewController ()

@property (nonatomic, strong)SPSZ_ShowTicketView *showView;

@property (nonatomic, strong)SPSZ_suo_shouDongRecordModel *model;

@end

@implementation SPSZ_chu_ChuZhengDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"出证记录";
    self.view.backgroundColor = [UIColor redColor];
    UIImage *naviBackImage = [[UIImage alloc] createImageWithSize:CGSizeMake([ProgramSize mainScreenWidth], [ProgramSize mainScreenHeight])
                                                   gradientColors:[ProgramColor blueGradientColors]
                                                       percentage:@[@(1), @(0)]
                                                     gradientType:GradientFromTopToBottom];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    [self.view addSubview:imageView];
    [imageView setImage:naviBackImage];
    imageView.userInteractionEnabled = YES;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backToUpView)];
    self.navigationItem.leftBarButtonItem = item;
    
    [self setUpView];
}

- (void)setUpView
{
    KRWeakSelf;
    weakSelf.showView = [[SPSZ_ShowTicketView alloc]init];
    weakSelf.showView.hasHuabian = YES;
    [weakSelf.view addSubview:weakSelf.showView];
    [weakSelf.showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.bottom.equalTo(-20);
    }];
    [SPSZ_suo_orderNetTool getDaYinDataWithPrintcode:weakSelf.printcode successBlock:^(SPSZ_suo_shouDongRecordModel *model) {
        weakSelf.showView.model = model;
        weakSelf.model = model;
        
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
         [KRAlertTool alertString:errorMessage];
    } failureBlock:^(NSString *failure) {
         [KRAlertTool alertString:failure];
    }];
}

- (void)backToUpView
{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
