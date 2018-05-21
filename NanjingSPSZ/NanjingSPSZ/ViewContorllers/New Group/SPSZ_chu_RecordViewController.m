//
//  SPSZ_chu_RecordViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/21.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_chu_RecordViewController.h"
#import "SPSZ_chu_RecordModel.h"
#import "SPSZ_chu_RecordTableViewCell.h"

@interface SPSZ_chu_RecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataSourceArray;

@end

@implementation SPSZ_chu_RecordViewController


- (UITableView *)tableView
{
    
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[SPSZ_chu_RecordTableViewCell class] forCellReuseIdentifier:@"RecordCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

#pragma mark ======== UITableViewDeleate, UITableViewDataSource ========
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return _dataSourceArray.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPSZ_chu_RecordModel *model = _dataSourceArray[indexPath.row];
    
    SPSZ_chu_RecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordCell" forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
    
    // Dispose of any resources that can be recreated.
}



@end
