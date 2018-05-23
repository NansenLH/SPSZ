//
//  SPSZ_suo_MainViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/22.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_suo_MainViewController.h"
#import "KRTagBar.h"
#import "SPSZ_saoMa_ViewController.h"
#import "SPSZ_shouDongViewController.h"
#import "SPSZ_paiZhaoViewController.h"

@interface SPSZ_suo_MainViewController ()<KRTagBarDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) KRTagBar          *tagBar;

@property (nonatomic, strong) UIView          *containerView;

@property (nonatomic, strong) UIScrollView    *detailScrollView;

@property (nonatomic, strong) UIView          *bottomView;

@property (nonatomic, strong) UIButton        *recordsButton;

@property (nonatomic, strong) UIButton        *centerButton;

@property (nonatomic, strong) UIButton        *personButton;


@end

@implementation SPSZ_suo_MainViewController

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,MainScreenHeight -100 , MainScreenWidth, 100)];
        [_bottomView addSubview:self.recordsButton];
    }
    return _bottomView;
}

- (UIButton *)recordsButton{
    if (!_recordsButton) {
        _recordsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _recordsButton.frame = CGRectMake(40, 20, 80, 80);
        [_recordsButton setImage:[UIImage imageNamed:@"record_gray"] forState:UIControlStateNormal];
        [_recordsButton setTitle:@"进货记录" forState:UIControlStateNormal];
        [_recordsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self setButtonContentCenter:_recordsButton];
    }
    return _recordsButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self setupTagBar];
    
    [self setupDetailScrollView];
    [self.view addSubview:self.bottomView];
    // Do any additional setup after loading the view.
}

//设置按钮标签的scrollview
- (void)setupTagBar
{
    NSArray *itemArray = [NSArray arrayWithObjects:@"扫码上传",@"手动上传",@"拍照上传", nil];
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
    
    
    
    SPSZ_saoMa_ViewController *vc1 = [[SPSZ_saoMa_ViewController alloc]init];
    SPSZ_shouDongViewController *vc2 = [[SPSZ_shouDongViewController alloc]init];
    SPSZ_paiZhaoViewController *vc3 = [[SPSZ_paiZhaoViewController alloc]init];
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
            make.height.equalTo(MainScreenHeight - 204);
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

-(void)setButtonContentCenter:(UIButton *)button
{
    CGSize imgViewSize,titleSize,btnSize;  
    UIEdgeInsets imageViewEdge,titleEdge;
    CGFloat heightSpace = 10.0f;
    
    //设置按钮内边距
    imgViewSize = button.imageView.bounds.size;
    titleSize = button.titleLabel.bounds.size;
    btnSize = button.bounds.size;
    imageViewEdge = UIEdgeInsetsMake(heightSpace,0.0, btnSize.height -imgViewSize.height - heightSpace, - titleSize.width);
    [button setImageEdgeInsets:imageViewEdge];
    titleEdge = UIEdgeInsetsMake(imgViewSize.height +heightSpace, - imgViewSize.width, 0.0, 0.0);
    [button setTitleEdgeInsets:titleEdge];
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
