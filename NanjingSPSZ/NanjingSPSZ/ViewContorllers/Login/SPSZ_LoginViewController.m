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


@interface SPSZ_LoginViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic, strong)UIButton *button;

@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, strong)UIButton *chuButton;

@property (nonatomic, strong)UIButton *suoButton;

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
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        for (int i = 1 ; i< 4; i++)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth * (i-1), 0, MainScreenWidth, MainScreenHeight)];
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_0%d",i]];
            [_scrollView addSubview:imageView];
            if (i == 3) {
                self.button = [UIButton buttonWithType:UIButtonTypeSystem];
                self.button.frame = CGRectMake(MainScreenWidth / 4, MainScreenHeight - 150, MainScreenWidth /2, 60);
                self.button.backgroundColor = [ProgramColor RGBColorWithRed:255 green:255 blue:255 alpha:0.15];
                self.button.layer.cornerRadius = 5;
                [self.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                [self.button setTitle:@"点击体验" forState:UIControlStateNormal];
                self.button.titleLabel.font = [UIFont systemFontOfSize:20];
                [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                imageView.userInteractionEnabled = YES;
                [imageView addSubview:_button];
            }
        }
        _scrollView.contentSize = CGSizeMake(MainScreenWidth *3, 0);
        _scrollView.contentOffset = CGPointMake(0, 0);
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"])
    {
        NSLog(@"第一次运行程序");
        [self.view addSubview:self.scrollView];

    }
    else{
        self.view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.imageView];
        
        [self.imageView addSubview:self.chuButton];
        
        [self.imageView addSubview:self.suoButton];
    }
    
}

- (void)buttonAction:(UIButton *)button{
    // 变化状态 把状态变成非第一次运行程序  提供给下一次使用
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"firstStart"];
    NSLog(@"第一次运行程序");

//    RootViewController *rootView = [[RootViewController alloc]init];
//    UINavigationController *rootNav = [[UINavigationController alloc]initWithRootViewController:rootView];
//    [UIApplication sharedApplication].delegate.window.rootViewController = rootNav;
}


- (void)chuButtonAction:(UIButton *)button
{
    SPSZ_EnterPasswordViewController *enterView = [[SPSZ_EnterPasswordViewController alloc]init];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:enterView animated:YES];
}

- (void)suoButtonAction:(UIButton *)button
{
//    SPSZ_EnterPasswordViewController *enterView = [[SPSZ_EnterPasswordViewController alloc]init];
//    self.navigationController.navigationBar.hidden = NO;
    SPSZ_suo_MainViewController *enterView = [[SPSZ_suo_MainViewController alloc]init];
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
