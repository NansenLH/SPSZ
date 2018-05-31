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

#import "ChuzhengNetworkTool.h"
#import "UIButton+Gradient.h"
#import "MJRefresh.h"


@interface SPSZ_AddGoodsViewController ()<UITableViewDelegate, UITableViewDataSource, SPSZ_AddGoodsTableViewCellDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *allSelectButton;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UIButton *confirmAddButton;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) int pageNo;

@end

@implementation SPSZ_AddGoodsViewController

- (NSMutableArray *)dataArray
{
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
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backToUpView)];
    self.navigationItem.leftBarButtonItem = item;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.pageNo = 1;
    
    [self configNavigationBar];
    
    [self configSubView];
    
    [self netRequest];
}

- (void)configNavigationBar
{
    self.navigationItem.title = @"添加货物";
    
//    UIButton *logOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [logOutButton setImage:[UIImage imageNamed:@"add_white"] forState:UIControlStateNormal];
//    [logOutButton setTitle:@"新增货品" forState:UIControlStateNormal];
//    [logOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    logOutButton.titleLabel.font = [UIFont systemFontOfSize:13];
//    logOutButton.frame = CGRectMake(0, 0, 80, 44);
//    logOutButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
//    [logOutButton addTarget:self action:@selector(addNewGoods) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logOutButton];
}

- (void)configSubView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [ProgramSize mainScreenWidth], [ProgramSize mainScreenHeight]) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(6);
        make.bottom.equalTo(-[ProgramSize bottomHeight]-44);
    }];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 67.0;
    
    [self.tableView registerClass:[SPSZ_AddGoodsTableViewCell class] forCellReuseIdentifier:@"SPSZ_AddGoodsTableViewCell"];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getMoreGoods];
    }];
    self.tableView.mj_footer.hidden = YES;
    UIView *tableFooterView = [[UIView alloc] init];
    self.tableView.tableFooterView = tableFooterView;
    
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.shadowColor = [ProgramColor RGBColorWithRed:0 green:0 blue:0 alpha:0.05].CGColor;
    bottomView.layer.shadowOpacity = 1;
    bottomView.layer.shadowOffset = CGSizeMake(0, -4);
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(44+[ProgramSize bottomHeight]);
    }];
    
    self.allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.allSelectButton setImage:[UIImage imageNamed:@"un_select"] forState:UIControlStateNormal];
    [self.allSelectButton setImage:[UIImage imageNamed:@"has_select"] forState:UIControlStateSelected];
    [self.allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
    [self.allSelectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.allSelectButton.titleLabel.font = [UIFont systemFontOfSize:12];
    self.allSelectButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [bottomView addSubview:self.allSelectButton];
    [self.allSelectButton addTarget:self action:@selector(selectAllClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(0);
        make.width.equalTo(70);
        make.height.equalTo(44);
    }];
    
    self.confirmAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmAddButton setTitle:@"确认添加" forState:UIControlStateNormal];
    [self.confirmAddButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.confirmAddButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.confirmAddButton addTarget:self action:@selector(confirmAddClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.confirmAddButton];
    [self.confirmAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(0);
        make.height.equalTo(44);
        make.width.equalTo(130);
    }];
    [self.confirmAddButton gradientButtonWithSize:CGSizeMake(130, 44) colorArray:[ProgramColor blueGradientColors] percentageArray:@[@(0), @(1)] gradientType:GradientFromTopToBottom];
    self.confirmAddButton.enabled = NO;
    
    self.totalLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:12] text:@"0" textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:self.totalLabel];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.confirmAddButton.mas_centerY);
        make.left.equalTo(self.confirmAddButton.mas_left).offset(-45);
        make.right.equalTo(-130);
    }];
    
    UILabel *label = [UICreateTool labelWithFont:[UIFont systemFontOfSize:12] text:@"合计产品个数：" textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.confirmAddButton.mas_centerY);
        make.right.equalTo(self.totalLabel.mas_left);
    }];
    
    
}

- (void)netRequest
{
    UIWindow *window              = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD* hud            = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode                      = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    
    [ChuzhengNetworkTool addGoodsFromPageNumber:self.pageNo successBlock:^(NSMutableArray *goodsArray) {
        [hud hideAnimated:YES];
        self.dataArray = goodsArray;
        [self.tableView reloadData];
        
        if (goodsArray.count == Pagesize) {
            self.tableView.mj_footer.hidden = NO;
        }
        
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        [hud hideAnimated:YES];
        [KRAlertTool alertString:errorMessage];
    } failureBlock:^(NSString *failure) {
        [hud hideAnimated:YES];
        [KRAlertTool alertString:failure];
    }];
}

- (void)getMoreGoods
{
    self.pageNo++;
    
    [ChuzhengNetworkTool addGoodsFromPageNumber:self.pageNo successBlock:^(NSMutableArray *goodsArray) {
        [self.dataArray addObjectsFromArray:goodsArray];
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        if (goodsArray.count < Pagesize) {
            self.tableView.mj_footer.hidden = YES;
        }
        
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        [KRAlertTool alertString:errorMessage];
    } failureBlock:^(NSString *failure) {
        [KRAlertTool alertString:failure];
    }];
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
//    SPSZ_GoodsModel *model = self.dataArray[indexPath.row];
//    model.isSelected = !model.isSelected;
//    SPSZ_AddGoodsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.dishModel = model;
//
//    if (model.isSelected) {
//        [self plusSelectedModel:model];
//    }
//    else {
//        [self minusSelectedModel:model];
//    }
}


#pragma mark - ======== SPSZ_AddGoodsTableViewCellDelegate ========
- (void)editWeigthAction:(SPSZ_AddGoodsTableViewCell *)cell model:(SPSZ_GoodsModel *)model
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"货品重量" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"公斤";
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.delegate = self;
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textfield = alertController.textFields[0];
        NSInteger weight = [textfield.text integerValue];
        model.weight = [@(weight) stringValue];
        cell.dishModel = model;
    }];
    [alertController addAction:confirmAction];    
    [self presentViewController:alertController animated:NO completion:nil];
}

- (void)selectAction:(SPSZ_AddGoodsTableViewCell *)cell model:(SPSZ_GoodsModel *)model
{
    model.isSelected = !model.isSelected;
    cell.dishModel = model;
    
    if (model.isSelected) {
        [self plusSelectedModel:model];
    }
    else {
        [self minusSelectedModel:model];
    }
}


#pragma mark - ======== 点击事件 ========
- (void)minusSelectedModel:(SPSZ_GoodsModel *)model
{
    NSInteger count = 0;
    BOOL hasSelect = NO;
    for (SPSZ_GoodsModel *model in self.dataArray) {
        if (model.isSelected) {
            count += 1;
            
            if (!hasSelect) {
                hasSelect = YES;
            }
        }
    }
    self.totalLabel.text = [NSString stringWithFormat:@"%ld", count];
    
    self.confirmAddButton.enabled = hasSelect;
    self.allSelectButton.selected = NO;
}

- (void)plusSelectedModel:(SPSZ_GoodsModel *)model
{
    NSInteger count = 0;
    BOOL hasNoSelect = NO;
    for (SPSZ_GoodsModel *model in self.dataArray) {
        if (model.isSelected) {
            count += 1;
        }
        else {
            if (hasNoSelect == NO) {
                hasNoSelect = YES;
            }
        }
    }
    self.totalLabel.text = [NSString stringWithFormat:@"%ld", count];
    
    self.allSelectButton.selected = !hasNoSelect;
    self.confirmAddButton.enabled = YES;
}

- (void)selectAllClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    for (SPSZ_GoodsModel *model in self.dataArray) {
        model.isSelected = button.selected;
    }
    [self.tableView reloadData];
    
    if (button.selected) {
        NSInteger count = 0;
        for (SPSZ_GoodsModel *model in self.dataArray) {
            if (model.isSelected) {
                count += 1;
            }
        }
        self.totalLabel.text = [NSString stringWithFormat:@"%ld", count];
    }
    else {
        self.totalLabel.text = @"0";
    }
    
    self.confirmAddButton.enabled = button.selected;
}

- (void)confirmAddClick:(UIButton *)button
{
    BOOL hasNoWeight = NO;
    NSMutableArray *selectedArray = [NSMutableArray array];
    for (SPSZ_GoodsModel *model in self.dataArray) {
        if (model.isSelected) {
            [selectedArray addObject:[model copy]];
            
            if ([model.weight isEqualToString:@"0"]) {
                hasNoWeight = YES;
                break;
            }
        }
    }
    if (hasNoWeight) {
        [KRAlertTool alertString:@"请填写要添加货物的重量"];
    }
    else {
        if (self.addGoodsBlock) {
            self.addGoodsBlock(selectedArray);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *sub = [NSString stringWithFormat:@"%@%@", textField.text, string];
    if ([sub integerValue] > 9999) {
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.text = [@([textField.text integerValue]) stringValue];
}


@end
