//
//  SPSZ_chu_personalCenterViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/24.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_chu_personalCenterViewController.h"
#import "SPSZ_chu_jinHuoRecordsViewController.h"
#import "SPSZ_chu_chuZhengRecordsViewController.h"
#import "SPSZ_LoginViewController.h"
#import "SPSZ_personalInfoViewController.h"
@interface SPSZ_chu_personalCenterViewController ()

@property (nonatomic, strong)NSMutableArray *itemArray;

@property (nonatomic, strong)NSMutableArray *numberArray;

@property (nonatomic, strong)NSMutableArray *titleArray;

@property (nonatomic, strong)NSMutableArray *titleNumArray;

@property (nonatomic, strong)UILabel        *numLabel;
@end

@implementation SPSZ_chu_personalCenterViewController

- (NSMutableArray *)itemArray
{
    if (!_itemArray) {
        _itemArray = [NSMutableArray arrayWithObjects:@"批发商",@"版本信息",@"其他信息", nil];
    }
    return _itemArray;
}

- (NSMutableArray *)numberArray
{
    if (!_numberArray) {
        _numberArray = [NSMutableArray arrayWithObjects:@"1",@"5",@"8", nil];
    }
    return _numberArray;
}

- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"个人信息",@"进货记录",@"出货记录",@"版本号",@"检查版本",@"帮助",@"注销登录", nil];
    }
    return _titleArray;
}

- (NSMutableArray *)titleNumArray
{
    if (!_titleNumArray) {
        _titleNumArray = [NSMutableArray arrayWithObjects:@"2",@"3",@"4",@"6",@"7",@"9",@"10", nil];
    }
    return _titleNumArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ProgramColor huiseColor];
    for (int i=0; i<self.itemArray.count; i++) {
        [self setUpViewWith:i];
    }
    
    for (int i=0; i<self.titleArray.count; i++) {
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
    if (num == 6) {
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
        view.tag = 20000 + num;
        [view addGestureRecognizer:tap];
    }
    
    if (num == 9 || num == 2 || num ==3) {
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
    if ([tap view].tag == 20002) {
        NSLog(@"个人信息");
        SPSZ_personalInfoViewController *vc  = [[SPSZ_personalInfoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([tap view].tag == 20003){
        SPSZ_chu_jinHuoRecordsViewController *vc =[[SPSZ_chu_jinHuoRecordsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([tap view].tag == 20004){
        SPSZ_chu_chuZhengRecordsViewController *vc = [[SPSZ_chu_chuZhengRecordsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([tap view].tag == 20007){
        NSLog(@"检查版本");
    }else if ([tap view].tag == 20009){
        NSLog(@"帮助");
    }else if ([tap view].tag == 20010){
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
