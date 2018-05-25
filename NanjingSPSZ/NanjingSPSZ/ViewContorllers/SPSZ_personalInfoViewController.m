//
//  SPSZ_personalInfoViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/24.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_personalInfoViewController.h"

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
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, MainScreenWidth, MainScreenHeight - 64)];
                _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(MainScreenWidth, _height *9+ 0.6* (MainScreenWidth - 20) *4 +50);
        _scrollView.showsHorizontalScrollIndicator = YES;
        [_scrollView addSubview:self.mainView];

    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.height = 50;
    self.view.backgroundColor = [UIColor whiteColor];
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
        mainLabel.frame = CGRectMake(100, 0, MainScreenWidth -160, _height);
        mainLabel.font = [UIFont systemFontOfSize:11];
        if (number == 0) {
            [label setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor blueColor] string:@"      " string2:self.titleArray[number]]];
        }else{
            [label setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor blueColor] string:@"  *  " string2:self.titleArray[number]]];
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
        mainLabel.frame = CGRectMake(150, 0, MainScreenWidth -160, _height);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
