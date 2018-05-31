//
//  AppDelegate.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/19.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "AppDelegate.h"

#import "SPSZ_LoginViewController.h"

#import "BaseNavigationController.h"
#import "SPSZ_ChuIndexViewController.h"

#import "SPSZ_suo_MainViewController.h"
#import "SPSZ_ChuIndexViewController.h"
#import "NetworkReachabilityTool.h"

#import "SPSZ_EditWightView.h"

@interface AppDelegate ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation AppDelegate

+ (AppDelegate*)shareInstance
{
    return (id)[[UIApplication sharedApplication] delegate];
}

#pragma mark - ======== lifeCycle ========
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //状态栏高亮
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    [self.window makeKeyAndVisible];
    SPSZ_LoginViewController *login = [[SPSZ_LoginViewController alloc]init];
    
    BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = navi;
    
    [[UIView appearance] setExclusiveTouch:YES];
    
    // 监听网络状态
    [[NetworkReachabilityTool defaultTool] start];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        [self.window addSubview:self.scrollView];
    }else{
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *isLogin = [ user objectForKey:@"isLogin"];
        
        if ([isLogin isEqualToString:@"suo_login"]) {
            SPSZ_suo_MainViewController *mainVc = [[SPSZ_suo_MainViewController alloc]init];
            BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:mainVc];
            self.window.rootViewController = navi;
            
        }else if ([isLogin isEqualToString:@"chu_login"]){
            SPSZ_ChuIndexViewController *mainVc = [[SPSZ_ChuIndexViewController alloc]init];
            BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:mainVc];
            self.window.rootViewController = navi;
        }
    }
    
    return YES;
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDWebImageManager sharedManager] cancelAll];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark ---- 将进入前台 ----
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    for (UIView *tmp in self.window.subviews) {
        if ([tmp isKindOfClass:[MBProgressHUD class]] ||
            [tmp isKindOfClass:[SPSZ_EditWightView class]]
            ) {
            [tmp removeFromSuperview];
        }
        
        // TODO: 相关加在 window 上的 view 必须移除掉
    }
    
}

#pragma mark ---- 已经进入前台 ----
- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

#pragma mark ---- 程序即将退出 ----
- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

#pragma mark ---- 请求用户允许通知后执行 ----
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
}

#pragma mark ---- 程序将要挂起,设置角标 ----
- (void)applicationWillResignActive:(UIApplication *)application
{

}

#pragma mark ---- 已经进入后台 ----
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        for (int i = 1 ; i< 4; i++)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth * (i-1), 0, MainScreenWidth, MainScreenHeight)];
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_0%d",i]];
            [_scrollView addSubview:imageView];
            if (i == 3) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
                btn.frame = CGRectMake(MainScreenWidth / 4, MainScreenHeight - 150, MainScreenWidth /2, 60);
                btn.backgroundColor = [ProgramColor RGBColorWithRed:255 green:255 blue:255 alpha:0.15];
                btn.layer.cornerRadius = 5;
                [btn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitle:@"点击体验" forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:20];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                imageView.userInteractionEnabled = YES;
                [imageView addSubview:btn];
            }
        }
        _scrollView.contentSize = CGSizeMake(MainScreenWidth *3, 0);
        _scrollView.contentOffset = CGPointMake(0, 0);
    }
    return _scrollView;
}

- (void)buttonAction
{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"firstStart"];
    [UIView animateWithDuration:0.3
                    animations:^{
                        self.scrollView.alpha = 0;
                    }completion:^(BOOL finished){
                        [self.scrollView removeFromSuperview];
                    }];
}
@end
