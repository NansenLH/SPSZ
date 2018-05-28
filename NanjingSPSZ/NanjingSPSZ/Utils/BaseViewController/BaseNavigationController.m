//
//  BaseNavigationController.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/19.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIImage+Gradient.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) UIViewController *currentShowVC;

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UINavigationBar appearance] setTranslucent:NO];
    
    // 设置导航栏字体颜色,大小
    [self.navigationBar setTitleTextAttributes:@{
            NSForegroundColorAttributeName : [ProgramColor navigationTitleColor],
                       NSFontAttributeName : [UIFont systemFontOfSize:15]
                                                 }];
    
    UIImage *naviBackImage = [[UIImage alloc] createImageWithSize:CGSizeMake([ProgramSize mainScreenWidth], [ProgramSize statusBarAndNavigationBarHeight])
                                                   gradientColors:[ProgramColor blueGradientColors]
                                                       percentage:@[@(0), @(1)]
                                                     gradientType:GradientFromLeftToRight];
    [self.navigationBar setBackgroundImage:naviBackImage forBarMetrics:UIBarMetricsDefault];
    
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (BOOL)prefersStatusBarHidden
{
    return _statusBarHidden;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        
//        CGFloat naviHeight = self.navigationController.navigationBar.frame.size.height;
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.size = CGSizeMake(80, naviHeight);
//        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//        button.adjustsImageWhenHighlighted = NO;
//        button.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 40);
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//        [button addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
//        viewController.hidesBottomBarWhenPushed = YES;
//        self.navigationBar.barTintColor = [UIColor whiteColor];
        
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)addChildViewController:(UIViewController *)childController
{
    [super addChildViewController:childController];
    
    childController.navigationController.navigationBar.translucent = NO;
}


-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    BaseNavigationController *nav = [super initWithRootViewController:rootViewController];
    
    self.interactivePopGestureRecognizer.delegate = self;
    nav.delegate = self;
    return nav;
}



#pragma mark ---- UINavigationControllerDelegate ----
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count == 1) {
        self.currentShowVC = Nil;
    }
    else {
        self.currentShowVC = viewController;
    }
}

#pragma mark ---- UIGestureRecognizerDelegate ----
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.currentShowVC == self.topViewController);
    }
    return YES;
}


@end
