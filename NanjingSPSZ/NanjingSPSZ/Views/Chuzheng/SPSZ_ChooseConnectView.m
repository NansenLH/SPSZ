//
//  SPSZ_ChooseConnectView.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/23.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_ChooseConnectView.h"

#import "SPSZ_DeviceModel.h"
#import "UIButton+Gradient.h"
#import "SPSZ_DeviceTableViewCell.h"

@interface SPSZ_ChooseConnectView ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SPSZ_ChooseConnectView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, [ProgramSize mainScreenWidth], [ProgramSize mainScreenHeight])]) {
        [self configSubView];
    }
    return self;
}

- (void)configSubView
{
    self.backgroundColor = [ProgramColor RGBColorWithRed:0 green:0 blue:0 alpha:0.2];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:titleButton];
    [titleButton setTitle:@"选择连接" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    titleButton.layer.cornerRadius = 8;
    titleButton.layer.masksToBounds = YES;
    [titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.height.equalTo(39);
        make.bottom.equalTo(-300-[ProgramSize bottomHeight]);
    }];
    [titleButton gradientButtonWithSize:CGSizeMake([ProgramSize mainScreenWidth], 39) colorArray:[ProgramColor blueMoreGradientColors] percentageArray:@[@(0), @(1)] gradientType:GradientFromLeftToRight];
    
    UIView *headerView = [[UIView alloc] init];
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.mas_equalTo(titleButton.mas_bottom).offset(-4);
        make.height.equalTo(34);
    }];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.font = [UIFont systemFontOfSize:14];
    leftLabel.textColor = [ProgramColor RGBColorWithRed:89 green:89 blue:89];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.text = @"名称";
    [headerView addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(0);
        make.width.equalTo([ProgramSize mainScreenWidth] * 0.4);
    }];
    
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.font = [UIFont systemFontOfSize:14];
    rightLabel.textColor = [ProgramColor RGBColorWithRed:89 green:89 blue:89];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.text = @"设备代码";
    [headerView addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(0);
        make.width.equalTo([ProgramSize mainScreenWidth] * 0.6);
    }];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(0);
        make.height.equalTo(270+[ProgramSize bottomHeight]);
    }];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIView *tableFooterView = [[UIView alloc] init];
    self.tableView.tableFooterView = tableFooterView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 44.0;
    
    [self.tableView registerClass:[SPSZ_DeviceTableViewCell class] forCellReuseIdentifier:@"SPSZ_DeviceTableViewCell"];
}


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
    CBPeripheral *peripheral = self.dataArray[indexPath.row];
    SPSZ_DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SPSZ_DeviceTableViewCell"];
    cell.device = peripheral;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseDevice:)]) {
        [self.delegate chooseDevice:self.dataArray[indexPath.row]];
    }
}


- (void)showInView:(UIView *)view
{
    if (!view) {
        return;
    }
    
    [view addSubview:self];
}

- (void)hidden
{
    if (self.superview) {
        [self removeFromSuperview];
    }
}

- (void)setDataArray:(NSMutableArray<CBPeripheral *> *)dataArray
{
    _dataArray = dataArray;
    
    [self.tableView reloadData];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //注意：_touchView应该是_referenceView的子视图
    CGPoint p = [touch locationInView:self];
    //NSLog(@"frame:%@",NSStringFromCGPoint(p));
    if(CGRectContainsPoint(self.tableView.frame, p)) {
        return NO;
    }
    return YES;
}

@end
