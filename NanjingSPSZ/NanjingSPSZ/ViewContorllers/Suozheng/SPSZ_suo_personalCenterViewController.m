//
//  SPSZ_suo_personalCenterViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/23.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_suo_personalCenterViewController.h"

#import "SPSZ_personalInfoViewController.h"

#import "SPSZ_LoginViewController.h"

@interface SPSZ_suo_personalCenterViewController ()

@property (nonatomic, strong)NSMutableArray *itemArray;

@property (nonatomic, strong)NSMutableArray *numberArray;

@property (nonatomic, strong)NSMutableArray *titleArray;

@property (nonatomic, strong)NSMutableArray *titleNumArray;

@property (nonatomic, strong)UILabel        *numLabel;

@end

@implementation SPSZ_suo_personalCenterViewController

- (NSMutableArray *)itemArray
{
    if (!_itemArray) {
        _itemArray = [NSMutableArray arrayWithObjects:@"零售商",@"版本信息",@"其他信息", nil];
    }
    return _itemArray;
}

- (NSMutableArray *)numberArray
{
    if (!_numberArray) {
        _numberArray = [NSMutableArray arrayWithObjects:@"1",@"3",@"6", nil];
    }
    return _numberArray;
}

- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"个人信息",@"版本号",@"检查版本",@"帮助",@"注销登录", nil];
    }
    return _titleArray;
}

- (NSMutableArray *)titleNumArray
{
    if (!_titleNumArray) {
        _titleNumArray = [NSMutableArray arrayWithObjects:@"2",@"4",@"5",@"7",@"8", nil];
    }
    return _titleNumArray;
}

- (void)configNavigation
{
    self.navigationItem.title = @"个人中心";

}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ProgramColor huiseColor];
    [self configNavigation];
    for (int i=0; i<3; i++) {
        [self setUpViewWith:i];
    }
    
    for (int i=0; i<5; i++) {
        [self setTitleViewWith:i];
    }
    
}


- (void)setUpViewWith:(NSInteger)number{
    NSInteger num = [self.numberArray[number] integerValue];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 50*(num -1), MainScreenWidth, 50)];
    view.backgroundColor = [ProgramColor huiseColor];
    UILabel *label = [self setLabelWith:number];
    [view addSubview:label];
    [self.view addSubview:view];
}

- (UILabel *)setLabelWith:(NSInteger)number{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, MainScreenWidth - 20, 20)];
    label.text = self.itemArray[number];
    label.textColor = [ProgramColor RGBColorWithRed:32 green:107 blue:225];
    return label;
}


- (void)setTitleViewWith:(NSInteger)number{
    NSInteger num = [self.titleNumArray[number] integerValue];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 50*(num -1), MainScreenWidth, 50)];
    if (num == 4) {
        self.numLabel  = [[UILabel alloc]initWithFrame:CGRectMake(MainScreenWidth -100, 15, 85, 20)];
        self.numLabel.text = @"v1.2";
        self.numLabel.textAlignment = NSTextAlignmentRight;
        [view addSubview:self.numLabel];
        
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(10, 49, MainScreenWidth - 20, 1)];
        lineView.backgroundColor = [ProgramColor huiseColor];
        [view addSubview:lineView];
    }else
    {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"goto_textgray"]];
        imageView.frame = CGRectMake(MainScreenWidth  -35, 15, 20, 20);
        [view addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        view.tag = 10000 + num;
        [view addGestureRecognizer:tap];
    }
    
    if (num == 7) {
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(10, 49, MainScreenWidth - 20, 1)];
        lineView.backgroundColor = [ProgramColor huiseColor];
        [view addSubview:lineView];
    }
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [self setTitleLabelWith:number];
    [view addSubview:label];
    [self.view addSubview:view];
}

- (UILabel *)setTitleLabelWith:(NSInteger)number{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, MainScreenWidth / 2, 20)];
    label.text = self.titleArray[number];
    label.textColor = [ProgramColor RGBColorWithRed:55 green:55 blue:55];
    return label;
}


- (void)tapAction:(UITapGestureRecognizer *)tap{
    if ([tap view].tag == 10002) {
        NSLog(@"个人信息");
        SPSZ_personalInfoViewController *vc = [[SPSZ_personalInfoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    }else if ([tap view].tag == 10005){
        NSLog(@"检查版本");
    }else if ([tap view].tag == 10007){
        NSLog(@"帮助");
    }else if ([tap view].tag == 10008){
        NSString *isLogin = @"login_out";
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:isLogin forKey:@"isLogin"];
        [user synchronize];
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[SPSZ_LoginViewController class]]) {
                self.navigationController.navigationBar.hidden = YES;
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }
}


- (void)leftButtonAction:(UIButton *)button
{
    [self.navigationController popoverPresentationController];
}

//- (UIView *)setView
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
