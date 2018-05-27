//
//  SPSZ_changePassWordViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/21.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_changePassWordViewController.h"
#import "SPSZ_LoginNetTool.h"
#import "SPSZ_suo_MainViewController.h"
#import "UIButton+Gradient.h"
@interface SPSZ_changePassWordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UITextField *phoneNumberTextField;

@property (nonatomic, strong)UITextField *securityTextField;

@property (nonatomic, strong)UITextField *passwordTextField;

@property (nonatomic, strong)UIButton *securityButton;

@property (nonatomic, strong)UIButton *sureButton;

@property (nonatomic, strong)NSString *saveYanZhengMa;

@end

@implementation SPSZ_changePassWordViewController

- (UITextField *)phoneNumberTextField
{
    if(!_phoneNumberTextField){
        _phoneNumberTextField = [[UITextField alloc]init];
        _phoneNumberTextField.frame = CGRectMake(10, 0, MainScreenWidth-20, 60);
        _phoneNumberTextField.delegate = self;
        _phoneNumberTextField.tintColor = [UIColor redColor];
        _phoneNumberTextField.placeholder = @"请输入手机号码";
    }
    return _phoneNumberTextField;
}

- (UITextField *)securityTextField
{
    if(!_securityTextField){
        _securityTextField = [[UITextField alloc]init];
        
        _securityTextField.frame = CGRectMake(10,0, MainScreenWidth *0.6 -20, 60);
        _securityTextField.delegate = self;
        _securityTextField.tintColor = [UIColor redColor];

        _securityTextField.placeholder = @"请输入验证码";
    }
    return _securityTextField;
}

- (UIButton *)securityButton{
    if (!_securityButton) {
        _securityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _securityButton.frame = CGRectMake(MainScreenWidth*0.6, 80, MainScreenWidth*0.4, 60);
        [_securityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_securityButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_securityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_securityButton addTarget:self action:@selector(securityButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_securityButton gradientButtonWithSize:CGSizeMake(MainScreenWidth *0.4, 60) colorArray:@[[ProgramColor RGBColorWithRed:33 green:211 blue:255 alpha:0.94],[ProgramColor RGBColorWithRed:67 green:130 blue:255 alpha:0.94]] percentageArray:@[@(1),@(0)] gradientType:GradientFromTopToBottom];

    }
    return _securityButton;
}

- (UITextField *)passwordTextField
{
    if(!_passwordTextField){
        _passwordTextField = [[UITextField alloc]init];
        _passwordTextField.frame = CGRectMake(10,0, MainScreenWidth-20, 60);
        _passwordTextField.delegate = self;
        _passwordTextField.tintColor = [UIColor redColor];
        _passwordTextField.placeholder = @"请输入6-10位英文或数字的新密码";
    }
    return _passwordTextField;
}

- (UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.frame = CGRectMake(MainScreenWidth / 6, 80 + 80 + 85, MainScreenWidth/3*2, 60);
        _sureButton.layer.cornerRadius = 30;
        _sureButton.layer.masksToBounds = YES;
        [_sureButton setTitle:@"确认修改" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sureButton gradientButtonWithSize:CGSizeMake(MainScreenWidth/3*2, 60) colorArray:@[[ProgramColor RGBColorWithRed:33 green:211 blue:255 alpha:0.94],[ProgramColor RGBColorWithRed:67 green:130 blue:255 alpha:0.94]] percentageArray:@[@(1),@(0)] gradientType:GradientFromTopToBottom];

    }
    return _sureButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 60)];
    view1.backgroundColor = [ProgramColor huiseColor];
    [view1 addSubview:self.phoneNumberTextField];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0,80, MainScreenWidth *0.6, 60)];
    view2.backgroundColor = [ProgramColor huiseColor];
    [view2 addSubview:self.securityTextField];
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:self.securityButton];
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0,80 + 80, MainScreenWidth, 60)];
    view3.backgroundColor = [ProgramColor huiseColor];
    [view3 addSubview:self.passwordTextField];
    [self.view addSubview:view3];
    [self.view addSubview:self.sureButton];
}


// 获取验证码
- (void)securityButtonAction:(UIButton *)button
{
    [SPSZ_LoginNetTool sedMessageWithTel:self.phoneNumberTextField.text successBlock:^(NSString *message) {
        self.saveYanZhengMa = message;
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        
    } failureBlock:^(NSString *failure) {
        
    }];
}

- (void)sureButtonAction:(UIButton *)button
{
    // suo zheng
    if (self.isType) {
        [SPSZ_LoginNetTool lingshoushangChangePswWithNewPwd:self.passwordTextField.text tel:self.phoneNumberTextField.text code:self.securityTextField.text successBlock:^(NSString *string) {
            SPSZ_suo_MainViewController *vc = [[SPSZ_suo_MainViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
            
        } failureBlock:^(NSString *failure) {
            
        }];
    }else{
        [SPSZ_LoginNetTool pifashangChangePswWithNewPwd:self.passwordTextField.text tel:self.phoneNumberTextField.text code:self.securityTextField.text successBlock:^(NSString *string) {
            
        } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        
        } failureBlock:^(NSString *failure) {
            
        }];
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
