//
//  SPSZ_personalInfoViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/24.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_personalInfoViewController.h"
#import "BaseNavigationController.h"
#import "SPSZ_LoginViewController.h"
#import "SPSZ_suoLoginModel.h"
#import "SPSZ_chuLoginModel.h"
#import "UIButton+WebCache.h"
 #import "SYPhotoBrowser.h"
 #import "KRAccountTool.h"

@interface SPSZ_personalInfoViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic, strong)UIView  *mainView;

@property (nonatomic, assign)CGFloat height;

@property (nonatomic, strong)NSMutableArray *titleArray;

@property (nonatomic, strong)NSMutableArray *mainArray;

@property (nonatomic, strong)NSString *locationString;

@property (nonatomic, strong)NSString *shiChangString;

@property (nonatomic, strong)NSString *detailLocationString;

@property (nonatomic, strong)NSString *tanWeiString;

@property (nonatomic, strong)NSString *tanZhuString;

@property (nonatomic, strong)NSString *zhuYingXiangMuString;

@property (nonatomic, strong)NSString *xinYongMaString;

@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, copy) NSString *bus_img;//营业执照
@property (nonatomic, copy) NSString *img_qs;//食品经营许可证
@property (nonatomic, copy) NSString *img_entry;//入场协议
@property (nonatomic, copy) NSString *img_save;//安全承诺书
@end

@implementation SPSZ_personalInfoViewController

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"基本信息",@"所属区县",@"所属市场",@"详细地址",@"本人摊位",@"摊主姓名",@"主营项目",@"统一社会信用码",@"相关证件", nil];
    }
    return _titleArray;
}


- (NSMutableArray *)mainArray{
    if (!_mainArray) {
        _mainArray = [NSMutableArray arrayWithObjects:@"（请完善信息，以便更好的使用）",self.locationString,self.shiChangString,self.detailLocationString,self.tanWeiString,self.tanZhuString,self.zhuYingXiangMuString,self.xinYongMaString, @"（请上传营业执照和相关证件）",nil];
    }
    return _mainArray;
}

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, _height *9+ 0.6* (MainScreenWidth - 20) *4 +50)];
        _mainView.backgroundColor = [UIColor whiteColor];
        
        [self setUpViewWith:0 text:@"（请完善信息，以便更好的使用）"];
        [self setUpViewWith:1 text:self.locationString];
        [self setUpViewWith:2 text:self.shiChangString];
        [self setUpViewWith:3 text:self.detailLocationString];
        [self setUpViewWith:4 text:self.tanWeiString];
        [self setUpViewWith:5 text:self.tanZhuString];
        [self setUpViewWith:6 text:self.zhuYingXiangMuString];
        [self setUpViewWith:7 text:self.xinYongMaString];
        [self setUpViewWith:8 text: @"（请上传营业执照和相关证件）"];
        
        UIView *bottom = [[UIView alloc]initWithFrame:CGRectMake(0, _height *9, MainScreenWidth, 0.6* (MainScreenWidth - 20) *4 +70)];
        [_mainView addSubview:bottom];
        [self photoView:bottom number:0 title:@"营业执照"];
        [self photoView:bottom number:1 title:@"食品经营许可证"];
        [self photoView:bottom number:2 title:@"入场协议"];
        [self photoView:bottom number:3 title:@"安全承诺书"];


    }
    return _mainView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - 64)];
                _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(MainScreenWidth, _height *9+ 0.6* (MainScreenWidth - 20) *4 +50);
        _scrollView.showsHorizontalScrollIndicator = YES;
        [_scrollView addSubview:self.mainView];

    }
    return _scrollView;
}

- (void)backToUpView
{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.imgArray = [NSMutableArray array];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backToUpView)];
    self.navigationItem.leftBarButtonItem = item;
    
    UIButton *logOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logOutButton setImage:[UIImage imageNamed:@"outlogin_white"] forState:UIControlStateNormal];
    [logOutButton setTitle:@"注销登录" forState:UIControlStateNormal];
    [logOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logOutButton.titleLabel.font = [UIFont systemFontOfSize:13];
    logOutButton.frame = CGRectMake(0, 0, 80, 44);
    logOutButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [logOutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logOutButton];
    
    self.height = 50;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSString *loginType = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"];
    if ([loginType isEqualToString:@"suo_login"]) {
//        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        SPSZ_suoLoginModel *model = [KRAccountTool getSuoUserInfo];
        self.locationString = model.cityname;
        self.shiChangString = model.deptname;
        self.detailLocationString = model.address;
        self.tanWeiString = model.stall_no;
        self.tanZhuString = model.stall_name;
//        self.zhuYingXiangMuString =
        self.xinYongMaString = model.bus_license;
        
        [self.imgArray addObject:model.bus_img];
        [self.imgArray addObject:model.img_qs];
        [self.imgArray addObject:model.img_entry];
        [self.imgArray addObject:model.img_save];
    }else{
//        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
//        SPSZ_chuLoginModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        SPSZ_chuLoginModel *model = [KRAccountTool getChuUserInfo];
        self.locationString = model.cityname;
        self.shiChangString = model.companyname;
//        self.detailLocationString = model.address;
        self.tanWeiString = model.stall_no;
        self.tanZhuString = model.realname;
        self.xinYongMaString = model.socialcode;
        
        [self.imgArray addObject:model.bus_img];
        [self.imgArray addObject:model.img_qs];
        [self.imgArray addObject:model.img_entry];
        [self.imgArray addObject:model.img_save];
    }
    
    [self.view addSubview:self.scrollView];
}

- (void)setUpViewWith:(NSInteger)number text:(NSString *)text{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _height*number, MainScreenWidth, _height)];
    UILabel *mainLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, MainScreenWidth - 120, _height)];
    mainLabel.textAlignment = NSTextAlignmentRight;
    mainLabel.textColor = [UIColor lightGrayColor];
    CGFloat w = 100;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, _height)];
    label.textColor = [UIColor redColor];
    if (number == 0 || number == 8) {
        mainLabel.textAlignment = NSTextAlignmentLeft;
        mainLabel.frame = CGRectMake(100, 0, MainScreenWidth -110, _height);
        mainLabel.font = [UIFont systemFontOfSize:11];
        if (number == 0) {
            [label setAttributedText:[self Color:[UIColor redColor] secondColor:[ProgramColor RGBColorWithRed:54 green:136 blue:225] string:@"      " string2:self.titleArray[number]]];
        }else{
            [label setAttributedText:[self Color:[UIColor redColor] secondColor:[ProgramColor RGBColorWithRed:54 green:136 blue:225] string:@"  *  " string2:self.titleArray[number]]];
        }

        [view addSubview:label];
    }else{
        if (number == 7) {
            w = 150;
        }
        label.frame = CGRectMake(0, 0, w, _height);
        if (number == 3) {
            [label setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor blackColor] string:@"      " string2:self.titleArray[number]]];
        }else{
            [label setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor blackColor] string:@"  *  " string2:self.titleArray[number]]];
        }
        [view addSubview:label];
        mainLabel.frame = CGRectMake(w, 0, MainScreenWidth -w -10, _height);
    }
    if (number != 8) {
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(10, _height- 1, MainScreenWidth - 20, 1)];
        lineView.backgroundColor = [ProgramColor huiseColor];
        [view addSubview:lineView];
    }
    mainLabel.text = text;
    [view addSubview:mainLabel];
    [self.mainView addSubview:view];
    
}


- (void)photoView:(UIView *)view number:(NSInteger)number title:(NSString *)title{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_takephoto"]];
    imageView.frame = CGRectMake(10, 10 *(number + 1)+ (number *0.6* (MainScreenWidth - 20)), MainScreenWidth - 20, 0.6* (MainScreenWidth - 20));
    [view addSubview:imageView];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0.6* (MainScreenWidth - 20)*0.8, MainScreenWidth - 40, 20)];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [ProgramColor huiseColor];
    [imageView addSubview:label];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBtn.frame = imageView.frame;
    photoBtn.tag = number;
    photoBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    photoBtn.clipsToBounds = true;
    [photoBtn addTarget:self action:@selector(showPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:photoBtn];
    
    NSString *imageURL = [NSString stringWithFormat:@"%@%@", BaseImagePath, self.imgArray[number]];
    [photoBtn sd_setImageWithURL:[NSURL URLWithString:imageURL] forState:UIControlStateNormal];
}


- (NSMutableAttributedString *)Color:(UIColor *)color
                         secondColor:(UIColor *)secondColor
                              string:(NSString *)string
                             string2:(NSString *)string2{
    NSString *str = [NSString stringWithFormat:@"%@%@",string,string2];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:string2].location, [[noteStr string] rangeOfString:string2].length);
    //需要设置的位置
    [noteStr addAttribute:NSForegroundColorAttributeName value:secondColor range:redRange];
    return noteStr;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logoutAction
{
    
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *isLogin = @"login_out";
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:isLogin forKey:@"isLogin"];
        [user synchronize];
        
        SPSZ_LoginViewController *login = [[SPSZ_LoginViewController alloc]init];
        BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:login];
        [[AppDelegate shareInstance].window setRootViewController:navi];
    }];
    
    [actionSheetController addAction:cancelAction];
    [actionSheetController addAction:okAction];
    
    [self presentViewController:actionSheetController animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)showPhoto:(UIButton *)sender
{
    NSString *imgPath = self.imgArray[sender.tag];
    if (imgPath) {
        if (imgPath.length != 0) {
            NSString *imageURL = [NSString stringWithFormat:@"%@%@", BaseImagePath, self.imgArray[sender.tag]];
            SYPhotoBrowser *photoBrowser = [[SYPhotoBrowser alloc] initWithImageSourceArray:@[imageURL] delegate:self];
            [self presentViewController:photoBrowser animated:YES completion:nil];
        }
    }
}
@end
