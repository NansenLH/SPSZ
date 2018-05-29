//
//  SPSZ_paiZhao_OrderViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/23.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_paiZhao_OrderViewController.h"

#import "SPSZ_suo_paiZhaoCollectionViewCell.h"

#import "SPSZ_suo_orderNetTool.h"

#import "SPSZ_suo_paiZhaoOrderModel.h"



@interface SPSZ_paiZhao_OrderViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)NSString *timeString;

@property (nonatomic, strong)NSString *numberString;

@property (nonatomic, strong)UIView *topView;

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)UILabel *rightLabel;

@property (nonatomic, strong)UILabel *leftLabel;


@end

@implementation SPSZ_paiZhao_OrderViewController

-(UICollectionView *)collectionView
{
    if (!_collectionView) {

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, MainScreenWidth, MainScreenHeight - 60 -64) collectionViewLayout:flowLayout];
        // 设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    
        _collectionView.backgroundColor = [UIColor whiteColor];
        // 注册cell
        [_collectionView registerClass:[SPSZ_suo_paiZhaoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    }
    return _collectionView;
}
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 60)];
        _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, (MainScreenWidth - 30)/2 +80,60)];
        _leftLabel.font = [UIFont systemFontOfSize:25];
        _leftLabel.textColor = [ProgramColor RGBColorWithRed:32 green:107 blue:225];
        _leftLabel.text = [NSString stringWithFormat:@"%@进货订单",self.timeString];
        [_topView addSubview:self.leftLabel];
        
        _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + (MainScreenWidth - 30)/2 +80, 0, (MainScreenWidth - 30)/2-80,60)];
        _rightLabel.font = [UIFont systemFontOfSize:25];
        _rightLabel.textColor = [ProgramColor RGBColorWithRed:32 green:107 blue:225];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.text = [NSString stringWithFormat:@"%ld条",self.dataArray.count];
        [_topView addSubview:self.rightLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 59, MainScreenWidth - 30, 1)];
        lineView.backgroundColor = [ProgramColor RGBColorWithRed:32 green:107 blue:225];
        [_topView addSubview:lineView];
    }
    return _topView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.topView];
    
    [self.view addSubview:self.collectionView];
    
    [self loadData];

}

- (void)loadData
{
    [SPSZ_suo_orderNetTool getSuoRecordWithStall_id:@"12986" uploaddate:@"2018-05-27" type:@"1" successBlock:^(NSMutableArray *modelArray) {
        
        self.dataArray = modelArray;
        
        [self.collectionView reloadData];
        
        self.rightLabel.text = [NSString stringWithFormat:@"%ld条",self.dataArray.count];
        
        
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        
    } failureBlock:^(NSString *failure) {
        
    }];
}


#pragma mark --- delegate、dataSource ---
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
#pragma mark --- 返回cell ---
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPSZ_suo_paiZhaoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    SPSZ_suo_paiZhaoOrderModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma mark --- 返回每个item的 宽和高 ---
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((MainScreenWidth - 50)/2 , (MainScreenWidth - 50)/2 *1.5 +30);
}

#pragma mark --- 返回集合视图集体的 上 左 下 右 边距 ---
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    // 第一个参数: 上
    // 第二个参数: 左
    // 第三个参数: 下
    // 第四个参数: 右
    return UIEdgeInsetsMake(15, 15, 10, 10);
}


#pragma mark --- 控制集合视图的行边距 ---
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}
#pragma mark --- 控制集合视图的列边距 ---
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}

#pragma mark --- item点击的方法 ---
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"第%ld 分区  第 %ld 个",indexPath.section,indexPath.row);
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
//    RootCollectionViewController *secondCollectionView = [[RootCollectionViewController alloc]initWithCollectionViewLayout:flowLayout];
//    [self.navigationController pushViewController:secondCollectionView animated:YES];
    
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
