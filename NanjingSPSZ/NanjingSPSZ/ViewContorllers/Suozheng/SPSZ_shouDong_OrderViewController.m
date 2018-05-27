//
//  SPSZ_shouDong_OrderViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/23.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_shouDong_OrderViewController.h"
#import "SPSZ_suo_shouDongTableViewCell.h"
@interface SPSZ_shouDong_OrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSString *timeString;

@property (nonatomic, strong)NSString *numberString;

@property (nonatomic, strong)UIView *topView;

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation SPSZ_shouDong_OrderViewController

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
        lineView.backgroundColor = [UIColor blueColor];
        [_topView addSubview:lineView];
    }
    return _topView;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, MainScreenWidth,MainScreenHeight - 60 -64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[SPSZ_suo_shouDongTableViewCell class] forCellReuseIdentifier:@"RecordCell"];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.timeString = @"5月24日";
    self.numberString = @"222";

    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
}



#pragma mark ======== UITableViewDeleate, UITableViewDataSource ========

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    SPSZ_suo_shouDongRecordModel *model = [[SPSZ_suo_shouDongRecordModel alloc]init];

    SPSZ_suo_shouDongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordCell" forIndexPath:indexPath];
    
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
