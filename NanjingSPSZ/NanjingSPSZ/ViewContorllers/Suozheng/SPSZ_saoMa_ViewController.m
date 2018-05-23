//
//  SPSZ_saoMa_ViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/22.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_saoMa_ViewController.h"

@interface SPSZ_saoMa_ViewController ()

@end

@implementation SPSZ_saoMa_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor   = [ UIColor redColor];
    
    UIView *yy = [[UIView alloc]initWithFrame:CGRectMake(0, 30, MainScreenWidth, MainScreenHeight -204)];
    yy.backgroundColor = [UIColor greenColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"retailer_scan"]];
    imageView.frame = CGRectMake(30, 0, MainScreenWidth - 60, MainScreenHeight -264);
    [yy addSubview:imageView];
    [self.view addSubview:yy];
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
