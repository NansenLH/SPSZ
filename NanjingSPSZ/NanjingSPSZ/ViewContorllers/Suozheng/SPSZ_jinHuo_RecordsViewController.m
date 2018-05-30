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


#import "KRTagBar.h"
#import "UIImage+Gradient.h"
#import "LUNetHelp.h"

@interface SPSZ_jinHuo_RecordsViewController ()<KRTagBarDelegate,UIScrollViewDelegate>
{
    SPSZ_saoMa_OrderViewController *vc1;
    SPSZ_shouDong_OrderViewController *vc3;
    SPSZ_paiZhao_OrderViewController *vc2;
}
@property (nonatomic, strong) KRTagBar          *tagBar;

@property (nonatomic, strong) UIView          *containerView;

@property (nonatomic, strong) UIScrollView    *detailScrollView;

@property (nonatomic, strong) UIImageView     *imageView;

@property (nonatomic, copy) NSString *stall_id;
@end

@implementation SPSZ_jinHuo_RecordsViewController

- (void)configNavigation
{
    self.navigationItem.title = @"进货记录";
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"calendar_white"] forState:UIControlStateNormal];
    [rightButton setTitle:@"日期查询" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    rightButton.frame = CGRectMake(0, 0, 80, 44);
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(12, 10, 12, 57)];
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}



- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backToUpView)];
    self.navigationItem.leftBarButtonItem = item;
    
    self.stall_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"stallID"];
    [self setupTagBar];
    [self configNavigation];
    [self setupDetailScrollView];

//    [self getuploadprintinvoicedetaillist:0];
}

- (void)backToUpView
{
    [self.navigationController popViewControllerAnimated:true];
}

//设置按钮标签的scrollview
- (void)setupTagBar
{
    NSArray *itemArray = [NSArray arrayWithObjects:@"扫码订单",@"拍照订单",@"手动订单", nil];
    // 中间滑动的scrollView
    self.tagBar = [[KRTagBar alloc]init];
    self.tagBar.itemArray = itemArray;
    [self.view addSubview:self.tagBar];
    [self.tagBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
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
        make.top.equalTo(40);
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
    
    
    
    vc1 = [[SPSZ_saoMa_OrderViewController alloc]init];
    vc2 = [[SPSZ_paiZhao_OrderViewController alloc]init];
    vc3 = [[SPSZ_shouDong_OrderViewController alloc]init];
    
    NSArray *vcArray = [NSArray arrayWithObjects:vc1,vc2,vc3, nil];
    
    for (int i = 0; i < count; i ++) {
        CGFloat x = i * MainScreenWidth;
        CGFloat w = MainScreenWidth;
        BaseViewController *vc = vcArray[i];
        [self addChildViewController:vc];
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


- (void)rightButtonAction:(UIButton *)button{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)getuploadprintinvoicedetaillist:(int)tag
//{
//    __weak typeof (self) weakSelf = self;
//    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
//    NSMutableString *newPath = [NSMutableString stringWithFormat:@"%@%@", BasePath, @"getuploadprintinvoicedetaillist"];
//    [requestDic setObject:self.stall_id forKey:@"stall_id"];
//    [requestDic setObject:[NSString stringWithFormat:@"%d",tag] forKey:@"type"];
//    [requestDic setObject:@"" forKey:@"uploaddate"];
//    [LUNetHelp lu_postWithPath:newPath andParams:requestDic andProgress:nil andComplete:^(BOOL success, id result) {
//        if ([result[@"respCode"] integerValue] == 1000000) {
//            if (weakSelf.tagBar.selectedIndex == 0) {
//                vc1.dataArray = result[@"resultList"];
//            }
//        }
//    }];
//}

@end
