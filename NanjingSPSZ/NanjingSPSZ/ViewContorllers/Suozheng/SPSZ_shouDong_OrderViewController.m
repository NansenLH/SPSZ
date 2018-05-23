//
//  SPSZ_shouDong_OrderViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/23.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_shouDong_OrderViewController.h"

@interface SPSZ_shouDong_OrderViewController ()

@property (nonatomic, strong)UIView *topView;

@end

@implementation SPSZ_shouDong_OrderViewController

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 60)];
    }
    return _topView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor orangeColor];
    [self.view addSubview:self.topView];
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
