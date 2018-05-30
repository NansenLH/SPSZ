//
//  SPSZ_saoMa_OrderViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/23.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_saoMa_OrderViewController.h"

#import "UIImage+Gradient.h"

#import "SPSZ_suo_orderNetTool.h"

#import "SPSZ_suo_SaoMaOrderCollectionViewCell.h"

#import "SPSZ_suoLoginModel.h"
#import "KRAccountTool.h"

@interface SPSZ_saoMa_OrderViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)NSString *numberString;

@property (nonatomic, strong)UIView *topView;

@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, strong)UILabel *leftLabel;

@property (nonatomic, strong)UILabel *rightLabel;

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)NSString *todayString;

@end

@implementation SPSZ_saoMa_OrderViewController

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(MainScreenWidth, MainScreenHeight -  60 - 64);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 20;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, MainScreenWidth, MainScreenHeight - 60 -64) collectionViewLayout:flowLayout];
        // 设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        // 注册cell
        [_collectionView registerClass:[SPSZ_suo_SaoMaOrderCollectionViewCell class] forCellWithReuseIdentifier:@"SPSZ_suo_SaoMaOrderCollectionViewCell"];
        
    }
    return _collectionView;
}
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 60)];
        _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, (MainScreenWidth - 30)/2 +80,60)];
        _leftLabel.font = [UIFont systemFontOfSize:25];
        _leftLabel.textColor = [UIColor blueColor];
        _leftLabel.text = [NSString stringWithFormat:@"%@进货订单",self.timeString];
        [_topView addSubview:self.leftLabel];
        
        _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + (MainScreenWidth - 30)/2 +80, 0, (MainScreenWidth - 30)/2-80,60)];
        _rightLabel.font = [UIFont systemFontOfSize:25];
        _rightLabel.textColor = [UIColor blueColor];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.text = [NSString stringWithFormat:@"%ld条",self.dataArray.count];
        [_topView addSubview:self.rightLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 59, MainScreenWidth - 30, 1)];
        lineView.backgroundColor = [UIColor blueColor];
        [_topView addSubview:lineView];
    }
    return _topView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *naviBackImage = [[UIImage alloc] createImageWithSize:CGSizeMake([ProgramSize mainScreenWidth], [ProgramSize mainScreenHeight])
                                                   gradientColors:[ProgramColor blueGradientColors]
                                                       percentage:@[@(1), @(0)]
                                                     gradientType:GradientFromTopToBottom];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    [self.view addSubview:self.imageView];
    [self.imageView setImage:naviBackImage];
    
    
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];
    [formatter setDateFormat:@"dd"];
    NSInteger currentDay=[[formatter stringFromDate:date] integerValue];
    
    self.todayString = [NSString stringWithFormat:@"%ld-%02ld-%ld",currentYear,currentMonth,currentDay];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.topView];
    [self loadDataWith:self.todayString newDate:nil];
}




- (void)loadDataWith:(NSString *)date newDate:(NSString *)newdate
{
    SPSZ_suoLoginModel *model = [KRAccountTool getSuoUserInfo];
    
    [SPSZ_suo_orderNetTool getSuoRecordWithStall_id:model.stall_id uploaddate:date type:@"0" successBlock:^(NSMutableArray *modelArray) {
        
        [self setDateLabelWith:newdate];

        self.dataArray = modelArray;
        self.rightLabel.text = [NSString stringWithFormat:@"%ld条",self.dataArray.count];

        [self.collectionView reloadData];
        
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
    
        [self setDateLabelWith:newdate];
        self.rightLabel.text = [NSString stringWithFormat:@"%ld条",self.dataArray.count];

        [self.collectionView reloadData];

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

#pragma mark --- delegate、dataSource ---
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
#pragma mark --- 返回cell ---
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPSZ_suo_SaoMaOrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SPSZ_suo_SaoMaOrderCollectionViewCell" forIndexPath:indexPath];
    SPSZ_suo_shouDongRecordModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark --- 控制集合视图的行边距 ---
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    // 第一个参数: 上
    // 第二个参数: 左
    // 第三个参数: 下
    // 第四个参数: 右
    return UIEdgeInsetsMake(0, 0, 0, 0);
}




- (void)reloadDataWithDateWith:(NSString *)date{
    [self loadDataWith:self.timeString newDate:date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
