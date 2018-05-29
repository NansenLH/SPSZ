//
//  SPSZ_LoginViewController.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/20.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_LoginViewController.h"

#import "SPSZ_EnterPasswordViewController.h"

#import "SPSZ_suo_MainViewController.h"
#import "SPSZ_ChuIndexViewController.h"

#import "FMDB.h"
#import "SPSZ_FMDBTool.h"

#define  FMDBManager  [SPSZ_FMDBTool SPSZ_FMDBTool]

@interface SPSZ_LoginViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic, strong)UIButton *button;

@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, strong)UIButton *chuButton;

@property (nonatomic, strong)UIButton *suoButton;

@property (nonatomic, strong) FMDatabase *dataBaseManager;

@end

@implementation SPSZ_LoginViewController

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _imageView.image = [UIImage imageNamed:@"bg_main"];
        _imageView.userInteractionEnabled = YES;

    }
    return _imageView;
}


- (UIButton *)chuButton
{
    if (!_chuButton) {
        _chuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _chuButton.frame = CGRectMake(MainScreenWidth/6, MainScreenHeight / 2 - 200, MainScreenWidth/3 *2, 150);
        [_chuButton setImage:[UIImage imageNamed:@"icon_wholesaler"] forState:UIControlStateNormal];
        _chuButton.imageEdgeInsets=UIEdgeInsetsMake(25, (MainScreenWidth/3*2-100)/2, 25, (MainScreenWidth/3*2-100)/2);
        [_chuButton addTarget:self action:@selector(chuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chuButton;
}

- (UIButton *)suoButton
{
    if (!_suoButton) {
        _suoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _suoButton.frame = CGRectMake(MainScreenWidth/6, MainScreenHeight / 2 + 50, MainScreenWidth/3*2, 150);
        [_suoButton setImage:[UIImage imageNamed:@"icon_retailer"] forState:UIControlStateNormal];
        _suoButton.imageEdgeInsets=UIEdgeInsetsMake(25, (MainScreenWidth/3*2-100)/2, 25, (MainScreenWidth/3*2-100)/2);
        [_suoButton addTarget:self action:@selector(suoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _suoButton;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 一般保存到cache目录里面
    NSString *dataPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    dataPath = [dataPath stringByAppendingPathComponent:@"MyDB.sqlite"];
    // 创建数据库
    [FMDBManager createDataBaseWithPath:dataPath];
    self.navigationController.navigationBar.hidden = YES;
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"])
    {
        NSLog(@"第一次运行程序");
        [self.view addSubview:self.scrollView];
        
    }
    else{
        
        [self setChooseLoginView];

        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *isLogin = [ user objectForKey:@"isLogin"];
        
        if ([isLogin isEqualToString:@"suo_login"]) {
            SPSZ_suo_MainViewController *mainVc = [[SPSZ_suo_MainViewController alloc]init];
            self.navigationController.navigationBar.hidden = NO;
            [self.navigationController pushViewController:mainVc animated:YES];

        }else if ([isLogin isEqualToString:@"chu_login"]){
            SPSZ_ChuIndexViewController *mainVc = [[SPSZ_ChuIndexViewController alloc]init];
            self.navigationController.navigationBar.hidden = NO;
            [self.navigationController pushViewController:mainVc animated:YES];
        }
        

    }
    
    [self setChooseLoginView];
}

- (void)setChooseLoginView{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    
    [self.imageView addSubview:self.chuButton];
    
    [self.imageView addSubview:self.suoButton];
}


- (void)chuButtonAction:(UIButton *)button
{
    SPSZ_EnterPasswordViewController *enterView = [[SPSZ_EnterPasswordViewController alloc]init];
    enterView.isType = NO;
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:enterView animated:YES];
}

- (void)suoButtonAction:(UIButton *)button
{
    SPSZ_EnterPasswordViewController *enterView = [[SPSZ_EnterPasswordViewController alloc]init];
    enterView.isType = YES;
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:enterView animated:YES];
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
