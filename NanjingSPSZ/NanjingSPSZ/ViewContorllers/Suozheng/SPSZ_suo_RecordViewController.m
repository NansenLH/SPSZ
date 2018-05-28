//
//  SPSZ_suo_RecordViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/21.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_suo_RecordViewController.h"
#import "SPSZ_suo_RecordModel.h"
#import "SPSZ_suo_RecordTableViewCell.h"
@interface SPSZ_suo_RecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataSourceArray;

@end

@implementation SPSZ_suo_RecordViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[SPSZ_suo_RecordTableViewCell class] forCellReuseIdentifier:@"RecordCell"];
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
//    SPSZ_suo_RecordModel *model = _dataSourceArray[indexPath.row];
    
    SPSZ_suo_RecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordCell" forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)setDataArray:(NSArray *)dataArray
{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
    
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
