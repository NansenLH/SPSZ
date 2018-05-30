//
//  SPSZ_shouDong_OrderViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/23.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_shouDong_OrderViewController.h"

#import "SPSZ_suo_shouDongTableViewCell.h"

#import "SPSZ_suo_orderNetTool.h"

#import "SPSZ_suo_shouDongRecordModel.h"

#import "SPSZ_suoLoginModel.h"
#import "KRAccountTool.h"


@interface SPSZ_shouDong_OrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSString *todayString;

@property (nonatomic, strong)UIView *topView;

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)UILabel *rightLabel;

@property (nonatomic, strong)UILabel *leftLabel;

@end

@implementation SPSZ_shouDong_OrderViewController

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 60)];
        _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, (MainScreenWidth - 30)/2 +80,60)];
        _leftLabel.font = [UIFont systemFontOfSize:25];
        _leftLabel.textColor = [ProgramColor RGBColorWithRed:32 green:107 blue:225];
        _leftLabel.text = [NSString stringWithFormat:@"%@进货订单",self.timeString];
        [_topView addSubview:self.leftLabel];
        
        _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + (MainScreenWidth - 30)/2 +80, 0, (MainScreenWidth - 30)/2-80,60)];
        _rightLabel.font = [UIFont systemFontOfSize:25];
        _rightLabel.textColor = [ProgramColor RGBColorWithRed:32 green:107 blue:225];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.text = [NSString stringWithFormat:@"%ld条",self.dataArray.count];
        [_topView addSubview:self.rightLabel];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 59, MainScreenWidth - 30, 1)];
        lineView.backgroundColor = [ProgramColor RGBColorWithRed:32 green:107 blue:225];
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SPSZ_suo_shouDongTableViewCell class] forCellReuseIdentifier:@"SPSZ_suo_shouDongTableViewCell"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    [self.view addSubview:self.topView];
    
    [self.view addSubview:self.tableView];
    
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];
    [formatter setDateFormat:@"dd"];
    NSInteger currentDay=[[formatter stringFromDate:date] integerValue];
    
    self.todayString = [NSString stringWithFormat:@"%ld-%02ld-%ld",currentYear,currentMonth,currentDay];
    
    [self loadDataWith:self.todayString newDate:nil];
}





- (void)loadDataWith:(NSString *)date newDate:(NSString *)newDate
{
    SPSZ_suoLoginModel *model = [KRAccountTool getSuoUserInfo];
    
    [SPSZ_suo_orderNetTool getSuoRecordWithStall_id:model.stall_id uploaddate:date type:@"2" successBlock:^(NSMutableArray *modelArray) {

        [self setDateLabelWith:newDate];
        self.dataArray = modelArray;
        self.rightLabel.text = [NSString stringWithFormat:@"%ld条",self.dataArray.count];
        [self.tableView reloadData];
        
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        [self setDateLabelWith:newDate];
        self.rightLabel.text = [NSString stringWithFormat:@"%ld条",self.dataArray.count];

        [self.tableView reloadData];

    } failureBlock:^(NSString *failure) {
        
    }];
}

- (void)setDateLabelWith:(NSString *)newDate
{
    [self.dataArray removeAllObjects];
    if (!self.timeString) {
        self.leftLabel.text = @"今日进货订单";
    }else
    {
        if ([self.todayString isEqualToString:self.timeString]) {
            self.leftLabel.text = @"今日进货订单";
        }else{
            self.leftLabel.text = [NSString stringWithFormat:@"%@进货订单",newDate];
        }
    }
}


#pragma mark ======== UITableViewDeleate, UITableViewDataSource ========

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    SPSZ_suo_shouDongRecordModel *model = self.dataArray[indexPath.row];
    
    SPSZ_suo_shouDongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SPSZ_suo_shouDongTableViewCell" forIndexPath:indexPath];
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

- (void)reloadDataWithDateWith:(NSString *)date{
    [self loadDataWith:self.timeString newDate:date];
}



@end
