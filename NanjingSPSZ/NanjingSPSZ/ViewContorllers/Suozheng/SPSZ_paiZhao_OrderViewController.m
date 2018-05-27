//
//  SPSZ_paiZhao_OrderViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/23.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_paiZhao_OrderViewController.h"

@interface SPSZ_paiZhao_OrderViewController ()

@property (nonatomic, strong)NSString *timeString;

@property (nonatomic, strong)NSString *numberString;

@property (nonatomic, strong)UIView *topView;

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation SPSZ_paiZhao_OrderViewController

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 60)];
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, (MainScreenWidth - 30)/2 +80,60)];
        leftLabel.font = [UIFont systemFontOfSize:25];
        leftLabel.textColor = [UIColor blueColor];
        leftLabel.text = [NSString stringWithFormat:@"%@进货订单",self.timeString];
        [_topView addSubview:leftLabel];
        
        UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + (MainScreenWidth - 30)/2 +80, 0, (MainScreenWidth - 30)/2-80,60)];
        rightLabel.font = [UIFont systemFontOfSize:25];
        rightLabel.textColor = [UIColor blueColor];
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.text = [NSString stringWithFormat:@"%@条",self.numberString];
        [_topView addSubview:rightLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 59, MainScreenWidth - 30, 1)];
        lineView.backgroundColor = [UIColor whiteColor];
        [_topView addSubview:lineView];
    }
    return _topView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
