//
//  SPSZ_chu_chuZhengRecordsViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/28.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_chu_chuZhengRecordsViewController.h"

#import "ChuzhengNetworkTool.h"
#import "KRAccountTool.h"
#import "MJRefresh.h"


#import "SPSZ_chu_chuZhengRecordsTableViewCell.h"

#import "SPSZ_chu_recordsModel.h"
#import "SPSZ_chuLoginModel.h"



@interface SPSZ_chu_chuZhengRecordsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger index;

@end

@implementation SPSZ_chu_chuZhengRecordsViewController
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth,MainScreenHeight -64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SPSZ_chu_chuZhengRecordsTableViewCell class] forCellReuseIdentifier:@"SPSZ_chu_chuZhengRecordsTableViewCell"];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.dataArray removeAllObjects];
            self.index = 1;
            [self downloadData];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self uploadData];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"出货记录";
    self.index = 1;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backToUpView)];
    self.navigationItem.leftBarButtonItem = item;
    [self.view addSubview:self.tableView];
    
    [self uploadData];
}


- (void)uploadData
{
    KRWeakSelf;
    SPSZ_chuLoginModel *model = [KRAccountTool getChuUserInfo];
    [ChuzhengNetworkTool geChuZhengRecordsPageSize:10 pageNo:self.index userId:model.login_Id printdate:nil successBlock:^(NSMutableArray *modelArray) {
        [weakSelf.tableView.mj_footer endRefreshing];

        if (modelArray.count >0) {
            weakSelf.index++;
            [weakSelf.dataArray addObjectsFromArray:modelArray];
        }else
        {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
       
        [weakSelf.tableView reloadData];
        
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        [weakSelf.tableView.mj_footer endRefreshing];
        if ([errorMessage isEqualToString:@"无出证记录" ]) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }

    } failureBlock:^(NSString *failure) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

- (void)downloadData
{
    KRWeakSelf;
    SPSZ_chuLoginModel *model = [KRAccountTool getChuUserInfo];
    [ChuzhengNetworkTool geChuZhengRecordsPageSize:10 pageNo:self.index userId:model.login_Id printdate:nil successBlock:^(NSMutableArray *modelArray) {
        [weakSelf.tableView.mj_header endRefreshing];
        self.index++;
        [weakSelf.dataArray addObjectsFromArray:modelArray];
        
        [weakSelf.tableView reloadData];
        
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
