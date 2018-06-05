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

@property (nonatomic, strong) UIView *countView;
@end

@implementation SPSZ_saoMa_OrderViewController

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(MainScreenWidth, MainScreenHeight -  100 - [ProgramSize statusBarAndNavigationBarHeight] - [ProgramSize bottomHeight]);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 20;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, MainScreenWidth, MainScreenHeight - 100 - [ProgramSize statusBarAndNavigationBarHeight] - [ProgramSize bottomHeight]) collectionViewLayout:flowLayout];
        // 设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = true;
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
 
        _leftLabel.textColor = [UIColor whiteColor];
//        [ProgramColor RGBColorWithRed:32 green:107 blue:225];
 
        [_topView addSubview:self.leftLabel];
        
        _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + (MainScreenWidth - 30)/2 +80, 0, (MainScreenWidth - 30)/2-80,60)];
        _rightLabel.font = [UIFont systemFontOfSize:25];
        _rightLabel.textColor = [UIColor whiteColor];
//        [ProgramColor RGBColorWithRed:32 green:107 blue:225];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        [_topView addSubview:self.rightLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 59, MainScreenWidth - 30, 1)];
        lineView.backgroundColor = [UIColor whiteColor];
//        [ProgramColor RGBColorWithRed:32 green:107 blue:225];
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
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-[ProgramSize bottomHeight])];
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
    
    self.todayString = [NSString stringWithFormat:@"%ld-%02ld-%02ld",currentYear,currentMonth,currentDay];

    
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
        [self.collectionView setContentOffset:CGPointMake(0, 0) animated:false];
        [self.countView removeFromSuperview];
        self.countView = nil;
        self.countView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, MainScreenWidth, 30)];
        [self.view addSubview:self.countView];
        float btnWidth = MainScreenWidth / self.dataArray.count;
        for (int i = 0; i < self.dataArray.count; i++) {
            UIButton *countBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            countBtn.frame = CGRectMake(i * btnWidth, 0, btnWidth, 30);
            [countBtn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
            [countBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            countBtn.titleLabel.font = [UIFont systemFontOfSize:20];
            countBtn.tag = 100 + i;
            [countBtn addTarget:self action:@selector(selectIndex:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                [countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            [self.countView addSubview:countBtn];
        }
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
    [self.countView removeFromSuperview];
        [self setDateLabelWith:newdate];
        self.rightLabel.text = [NSString stringWithFormat:@"%ld条",self.dataArray.count];
        [self.collectionView reloadData];
        
        [KRAlertTool alertString:errorMessage];
        
    } failureBlock:^(NSString *failure) {
        [self.countView removeFromSuperview];
        [KRAlertTool alertString:failure];
    }];
}

- (void)selectIndex:(UIButton *)sender
{
    [self.collectionView setContentOffset:CGPointMake((sender.tag - 100) * MainScreenWidth, 0) animated:true];
    
    for (int i = 0; i < self.dataArray.count; i++) {
        UIButton *btn = (UIButton *)[self.countView viewWithTag:100 + i];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        if (i == sender.tag - 100) {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
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


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _collectionView) {
        //获取滚动位置
        int pageNo= scrollView.contentOffset.x/scrollView.frame.size.width;
        for (int i = 0; i < self.dataArray.count; i++) {
            UIButton *btn = (UIButton *)[self.countView viewWithTag:100 + i];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            if (i == pageNo) {
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
    }
    
}

- (void)reloadDataWithDateWith:(NSString *)date{
    [self loadDataWith:self.timeString newDate:date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
