//
//  SPSZ_AddGoodsViewController.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/25.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_AddGoodsViewController.h"

#import "SPSZ_AddGoodsTableViewCell.h"

#import "SPSZ_GoodsModel.h"


@interface SPSZ_AddGoodsViewController ()<UITableViewDelegate, UITableViewDataSource, SPSZ_AddGoodsTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *allSelectButton;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UIButton *confirmAddButton;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SPSZ_AddGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self netRequest];
}

- (void)configNavigationBar
{
    self.navigationItem.title = @"添加货物";
    
    UIButton *logOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logOutButton setImage:[UIImage imageNamed:@"add_white"] forState:UIControlStateNormal];
    [logOutButton setTitle:@"新增货品" forState:UIControlStateNormal];
    [logOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logOutButton.titleLabel.font = [UIFont systemFontOfSize:13];
    logOutButton.frame = CGRectMake(0, 0, 80, 44);
    logOutButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [logOutButton addTarget:self action:@selector(addNewGoods) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logOutButton];
}

- (void)configTableView
{
    
}

- (void)netRequest
{
    
}

#pragma mark - ======== UITableViewDelegate, UITableViewDataSource ========
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPSZ_GoodsModel *model = self.dataArray[indexPath.row];
    SPSZ_AddGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SPSZ_AddGoodsTableViewCell"];
    cell.dishModel = model;
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark ---- SPSZ_AddGoodsTableViewCellDelegate ----
- (void)selectedGoods:(BOOL)selected goods:(SPSZ_GoodsModel *)dish
{
    
}




#pragma mark - ======== 点击事件 ========
- (void)addNewGoods
{
    
}



@end
