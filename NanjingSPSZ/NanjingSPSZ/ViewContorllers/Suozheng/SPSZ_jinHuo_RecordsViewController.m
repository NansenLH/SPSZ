//
//  SPSZ_jinHuo_RecordsViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/23.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_jinHuo_RecordsViewController.h"
#import "SPSZ_saoMa_OrderViewController.h"
#import "SPSZ_paiZhao_OrderViewController.h"
#import "SPSZ_shouDong_OrderViewController.h"

#import "SPSZ_suo_RecordViewController.h"

#import "KRTagBar.h"

@interface SPSZ_jinHuo_RecordsViewController ()<KRTagBarDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) KRTagBar          *tagBar;

@property (nonatomic, strong) UIView          *containerView;

@property (nonatomic, strong) UIScrollView    *detailScrollView;

@end

@implementation SPSZ_jinHuo_RecordsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTagBar];
    
    [self setupDetailScrollView];
    // Do any additional setup after loading the view.
}

//设置按钮标签的scrollview
- (void)setupTagBar
{
    NSArray *itemArray = [NSArray arrayWithObjects:@"扫码订单",@"手动订单",@"拍照订单", nil];
    // 中间滑动的scrollView
    self.tagBar = [[KRTagBar alloc]init];
    self.tagBar.itemArray = itemArray;
    [self.view addSubview:self.tagBar];
    [self.tagBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(64);
        make.left.right.equalTo(0);
        make.height.equalTo(40);
    }];
    self.tagBar.tagBarDelegate = self;
}



-(void)setupDetailScrollView
{
    NSInteger count = 3;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(104);
        make.left.right.bottom.equalTo(0);
    }];
    
    CGFloat wid = count * MainScreenWidth;
    
    self.containerView = [[UIView alloc] init];
    [scrollView addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.height.equalTo(scrollView);
        make.width.equalTo(wid);
    }];
    
    
    
//    SPSZ_saoMa_OrderViewController *vc1 = [[SPSZ_saoMa_OrderViewController alloc]init];
    SPSZ_suo_RecordViewController *vc1 = [[SPSZ_suo_RecordViewController alloc]init];
    SPSZ_shouDong_OrderViewController *vc2 = [[SPSZ_shouDong_OrderViewController alloc]init];
    SPSZ_paiZhao_OrderViewController *vc3 = [[SPSZ_paiZhao_OrderViewController alloc]init];
    NSArray *vcArray = [NSArray arrayWithObjects:vc1,vc2,vc3, nil];
    
    for (int i = 0; i < count; i ++) {
        CGFloat x = i * MainScreenWidth;
        CGFloat w = MainScreenWidth;
        BaseViewController *vc = vcArray[i];
        [self.containerView addSubview:vc.view];
        [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(x);
            make.width.equalTo(w);
            make.top.equalTo(0);
            make.height.equalTo(MainScreenHeight - 104);
        }];
    }
    
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    self.detailScrollView = scrollView;
    [self.tagBar selectIndex:0];
}


#pragma mark ---- 点击了滑动的标签 ---- KRTagBarDelegate
-(void)tagBarDidClickBtn:(UIButton *)btn atIndex:(NSInteger)index
{
    self.detailScrollView.contentOffset = CGPointMake(index * MainScreenWidth, 0);
}

#pragma mark - ========== Delegate ==========
#pragma mark ---- UIScrollViewDelegate ----
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if ([scrollView isEqual:self.detailScrollView]) {
        CGFloat pedding = scrollView.contentOffset.x;
        int index = (pedding / MainScreenWidth);
        if (index != self.tagBar.selectedIndex)
        {
            [self.tagBar selectIndex:index];
        }
        else
        {
            [self.tagBar updateContentOffSet:scrollView.contentOffset];
        }
        
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if ([scrollView isEqual:self.detailScrollView]) {
        [self.tagBar updateContentOffSet:scrollView.contentOffset];
    }
    
}

#pragma mark ---- action -----
- (void)recordButtonAction:(UIButton *)button{

}

- (void)personButtonAction:(UIButton *)button{
    
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
