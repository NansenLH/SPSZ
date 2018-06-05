//
//  SPSZ_chu_chuZhengRecordsViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/28.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_chu_chuZhengRecordsViewController.h"
#import "SPSZ_chu_ChuZhengDetailViewController.h"

#import "ChuzhengNetworkTool.h"
#import "KRAccountTool.h"
#import "MJRefresh.h"

#import "PGDatePickManager.h"
#import "SPSZ_chu_chuZhengRecordsTableViewCell.h"

#import "SPSZ_chu_recordsModel.h"
#import "SPSZ_chuLoginModel.h"

#import "PGDatePickManager.h"


@interface SPSZ_chu_chuZhengRecordsViewController ()<UITableViewDataSource,UITableViewDelegate,PGDatePickerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSString *dateString;

@end

@implementation SPSZ_chu_chuZhengRecordsViewController
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth,MainScreenHeight -[ProgramSize statusBarHeight]) style:UITableViewStylePlain];

        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SPSZ_chu_chuZhengRecordsTableViewCell class] forCellReuseIdentifier:@"SPSZ_chu_chuZhengRecordsTableViewCell"];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.dataArray removeAllObjects];
            self.index = 1;
            [self downloadDataWithDate:self.dateString];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self uploadDataWithDate:self.dateString];
        }];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)backToUpView
{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)configNavigation
{
    self.navigationItem.title = @"出证记录";
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"calendar_white"] forState:UIControlStateNormal];
    [rightButton setTitle:@"日期查询" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    rightButton.frame = CGRectMake(0, 0, 80, 44);
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(12, 10, 12, 57)];
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.index = 1;
    [self configNavigation];
    self.dateString = nil;
 
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backToUpView)];
    self.navigationItem.leftBarButtonItem = item;
    [self.view addSubview:self.tableView];
    
     [self uploadDataWithDate:self.dateString];
 
}


- (void)uploadDataWithDate:(NSString *)date
{
    KRWeakSelf;
    SPSZ_chuLoginModel *model = [KRAccountTool getChuUserInfo];
 
    [ChuzhengNetworkTool geChuZhengRecordsPageSize:10 pageNo:self.index userId:model.login_Id printdate:self.dateString successBlock:^(NSMutableArray *modelArray) {
        [weakSelf.tableView.mj_footer endRefreshing];

        weakSelf.index++;
        [weakSelf.dataArray addObjectsFromArray:modelArray];
        [weakSelf.tableView reloadData];
        
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];

    } failureBlock:^(NSString *failure) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

- (void)downloadDataWithDate:(NSString *)date
{
    KRWeakSelf;
    SPSZ_chuLoginModel *model = [KRAccountTool getChuUserInfo];
 
    [ChuzhengNetworkTool geChuZhengRecordsPageSize:10 pageNo:self.index userId:model.login_Id printdate:self.dateString successBlock:^(NSMutableArray *modelArray) {
         [weakSelf.tableView.mj_header endRefreshing];
        self.index++;
        [weakSelf.dataArray addObjectsFromArray:modelArray];
        
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer  setState:MJRefreshStateIdle];
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failureBlock:^(NSString *failure) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

#pragma mark ======== UITableViewDeleate, UITableViewDataSource ========

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SPSZ_chu_recordsModel *model = self.dataArray[indexPath.row];
    
    SPSZ_chu_chuZhengRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SPSZ_chu_chuZhengRecordsTableViewCell" forIndexPath:indexPath];
    
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPSZ_chu_recordsModel *model = self.dataArray[indexPath.row];
    SPSZ_chu_ChuZhengDetailViewController *vc = [[SPSZ_chu_ChuZhengDetailViewController alloc]init];
    vc.printcode = model.printcode;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)rightButtonAction:(UIButton *)button{
    
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    datePickManager.isShadeBackgroud = true;
    datePickManager.style = PGDatePickManagerStyle3;
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.delegate = self;
    datePicker.datePickerType = PGDatePickerType2;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerMode = PGDatePickerModeDate;
    [self presentViewController:datePickManager animated:false completion:nil];
}



- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSString *date = [NSString stringWithFormat:@"%ld-%02ld-%02ld",dateComponents.year,dateComponents.month,dateComponents.day];
    self.dateString = date;
    self.index = 1;
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    [self uploadDataWithDate:date];
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
