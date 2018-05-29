//
//  SPSZ_chu_jinHuoRecordsViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/28.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_chu_jinHuoRecordsViewController.h"

#import "SPSZ_chu_jinHuoRecordsTableViewCell.h"

#import "SPSZ_chu_jinHuoModel.h"

#import "ChuzhengNetworkTool.h"

@interface SPSZ_chu_jinHuoRecordsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation SPSZ_chu_jinHuoRecordsViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth,MainScreenHeight -64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SPSZ_chu_jinHuoRecordsTableViewCell class] forCellReuseIdentifier:@"SPSZ_chu_jinHuoRecordsTableViewCell"];
    }
    return _tableView;
}

- (void)backToUpView
{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"进货记录";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backToUpView)];
    self.navigationItem.leftBarButtonItem = item;
    [self.view addSubview:self.tableView];
    [self loadData];
}


- (void)loadData
{
    [ChuzhengNetworkTool geChuZhengJinHuoRecordsStall_id:@"13156" printdate:@"2018-05-17" successBlock:^(NSMutableArray *modelArray) {
        self.dataArray = modelArray;
        [self.tableView reloadData];
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        
    } failureBlock:^(NSString *failure) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ======== UITableViewDeleate, UITableViewDataSource ========

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPSZ_chu_jinHuoModel *model = self.dataArray[indexPath.row];
    
    SPSZ_chu_jinHuoRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SPSZ_chu_jinHuoRecordsTableViewCell" forIndexPath:indexPath];
    
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
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
