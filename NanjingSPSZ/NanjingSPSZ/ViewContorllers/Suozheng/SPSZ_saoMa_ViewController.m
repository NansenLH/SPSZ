//
//  SPSZ_saoMa_ViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/22.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_saoMa_ViewController.h"

@interface SPSZ_saoMa_ViewController ()
@property (nonatomic, strong)UIImageView *mainImageView;
@end

@implementation SPSZ_saoMa_ViewController

- (UIImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"retailer_scan"]];
        _mainImageView.frame = CGRectMake(30, 0, MainScreenWidth - 60, MainScreenHeight -264);
    }
    return _mainImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor   = [ UIColor clearColor];
    
    UIView *yy = [[UIView alloc]initWithFrame:CGRectMake(0, 30, MainScreenWidth, MainScreenHeight -236)];
    [yy addSubview:self.mainImageView];
    [self.view addSubview:yy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)reSaoMa{
    _mainImageView.image = [UIImage imageNamed:@"retailer_scan"];
}

- (void)sureUpload{
    
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
