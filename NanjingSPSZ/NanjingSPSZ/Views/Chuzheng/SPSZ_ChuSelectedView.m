//
//  SPSZ_ChuSelectedView.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/27.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_ChuSelectedView.h"

#import "SPSZ_SelectedTableViewCell.h"

#import "SPSZ_GoodsModel.h"

#import "UIButton+Gradient.h"
#import "UIImage+Gradient.h"

@interface SPSZ_ChuSelectedView ()<UITableViewDelegate, UITableViewDataSource, SPSZ_SelectedTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *titleView;

// 新设计不再使用
@property (nonatomic, strong) UIButton * clearButton;

@end


@implementation SPSZ_ChuSelectedView



- (instancetype)init
{
    if (self = [super init]) {
        _selectedArray = [NSMutableArray array];
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.titleView = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.titleView setImage:[UIImage imageNamed:@"icon_right_2"] forState:UIControlStateNormal];
    [self.titleView setTitle:@"当前设备连接正常" forState:UIControlStateNormal];
    [self.titleView setTitleColor:[ProgramColor RGBColorWithRed:51 green:51 blue:51 alpha:0.66] forState:UIControlStateNormal];
    self.titleView.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleView.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [self addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(8);
        make.left.right.equalTo(0);
        make.height.equalTo(15);
    }];
    
//    [self configAddMoreBtnOld];
    [self configAddMoreBtnNew];
    
//    [self configTableViewOld];
    [self configTableViewNew];
   
}

- (void)configAddMoreBtnOld
{
    self.addMoreGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addMoreGoodsButton setTitle:@"继 续 添 加" forState:UIControlStateNormal];
    self.addMoreGoodsButton.layer.cornerRadius = 17;
    self.addMoreGoodsButton.layer.masksToBounds = YES;
    [self.addMoreGoodsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.addMoreGoodsButton gradientButtonWithSize:CGSizeMake(165, 36)
                                         colorArray:[ProgramColor blueMoreGradientColors]
                                    percentageArray:@[@(0), @(1)]
                                       gradientType:GradientFromTopToBottom];
    self.addMoreGoodsButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.addMoreGoodsButton];
    
    BOOL is480 = [ProgramSize mainScreenHeight] == 480;
    CGFloat marginBottom = is480 ? 70 : 100;
    [self.addMoreGoodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.width.equalTo(165);
        make.height.equalTo(36);
        make.bottom.equalTo(-marginBottom);
    }];
}

- (void)configAddMoreBtnNew
{
    self.addMoreGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addMoreGoodsButton setTitle:@"继续添加" forState:UIControlStateNormal];
    [self.addMoreGoodsButton setImage:[UIImage imageNamed:@"addMoreGoods"] forState:UIControlStateNormal];
    [self.addMoreGoodsButton setTitleColor:[ProgramColor RGBColorWithRed:82 green:145 blue:242] forState:UIControlStateNormal];
    self.addMoreGoodsButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.addMoreGoodsButton];
    self.addMoreGoodsButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    [self.addMoreGoodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom).offset(8);
        make.height.equalTo(50);
        make.left.right.equalTo(0);
    }];
}

- (void)configTableViewOld
{
    UIView *backShadowView = [[UIView alloc] init];
    [self addSubview:backShadowView];
    [backShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(32);
        make.left.equalTo(27);
        make.right.equalTo(-27);
        make.bottom.mas_equalTo(self.addMoreGoodsButton.mas_top).offset(-20);
    }];
    backShadowView.backgroundColor = [UIColor whiteColor];
    backShadowView.layer.cornerRadius = 4;
    backShadowView.layer.shadowColor = [ProgramColor RGBColorWithRed:0 green:0 blue:0 alpha:0.3].CGColor;
    backShadowView.layer.shadowOpacity = 1;
    backShadowView.layer.shadowOffset = CGSizeMake(0, 0);
    
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 4;
    backView.layer.masksToBounds = YES;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(32);
        make.left.equalTo(27);
        make.right.equalTo(-27);
        make.bottom.mas_equalTo(self.addMoreGoodsButton.mas_top).offset(-20);
    }];
    
    
    UIImageView *titleImageView = [[UIImageView alloc] init];
    CGFloat width = [ProgramSize mainScreenWidth] - 54;
    UIImage *titleImage = [[[UIImage alloc] init] createImageWithSize:CGSizeMake(width, 40) gradientColors:[ProgramColor blueGradientColors] percentage:@[@(0), @(1)] gradientType:GradientFromTopToBottom];
    titleImageView.userInteractionEnabled = YES;
    titleImageView.image = titleImage;
    [backView addSubview:titleImageView];
    [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(0);
        make.height.equalTo(40);
    }];
    
    UILabel *titleLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:15] text:@"出证票据" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [titleImageView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
    }];
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton setTitle:@"清空" forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:13];
    clearButton.layer.borderColor = [UIColor whiteColor].CGColor;
    clearButton.layer.borderWidth = 1;
    [titleImageView addSubview:clearButton];
    [clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.height.equalTo(17);
        make.width.equalTo(38);
        make.right.equalTo(-15);
    }];
    self.clearButton = clearButton;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [backView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(40);
    }];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIView *tableFooterView = [[UIView alloc] init];
    self.tableView.tableFooterView = tableFooterView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, -20);
    self.tableView.rowHeight = 76;
    
    [self.tableView registerClass:[SPSZ_SelectedTableViewCell class] forCellReuseIdentifier:@"SPSZ_SelectedTableViewCell"];
}

- (void)configTableViewNew
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.mas_equalTo(self.addMoreGoodsButton.mas_bottom);
    }];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIView *tableFooterView = [[UIView alloc] init];
    self.tableView.tableFooterView = tableFooterView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, -20);
    self.tableView.rowHeight = 76;
    
    [self.tableView registerClass:[SPSZ_SelectedTableViewCell class] forCellReuseIdentifier:@"SPSZ_SelectedTableViewCell"];
}



- (void)setIsConnect:(BOOL)isConnect
{
    _isConnect = isConnect;
    
    self.titleView.selected = isConnect;
}

- (void)setSelectedArray:(NSMutableArray<SPSZ_GoodsModel *> *)selectedArray
{
    _selectedArray = selectedArray;
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPSZ_GoodsModel *model = self.selectedArray[indexPath.row];
    SPSZ_SelectedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SPSZ_SelectedTableViewCell"];
    cell.delegate = self;
    cell.model = model;
    
    return cell;
}

#pragma mark - ======== SPSZ_SelectedTableViewCellDelegate ========
- (void)deleModel:(SPSZ_SelectedTableViewCell *)cell model:(SPSZ_GoodsModel *)model
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.selectedArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if (self.selectedArray.count == 0) {
        if (self.deleteLastCellBlock) {
            self.deleteLastCellBlock();
        }
//        [self.clearButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

@end
