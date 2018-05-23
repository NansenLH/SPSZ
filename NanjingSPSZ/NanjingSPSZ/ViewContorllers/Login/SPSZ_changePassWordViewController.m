//
//  SPSZ_changePassWordViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/21.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_changePassWordViewController.h"

@interface SPSZ_changePassWordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UITextField *phoneNumberTextField;

@property (nonatomic, strong)UITextField *securityTextField;

@property (nonatomic, strong)UITextField *passwordTextField;

@property (nonatomic, strong)UIButton *securityButton;

@property (nonatomic, strong)UIButton *sureButton;


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
        _securityButton.frame = CGRectMake(MainScreenWidth*0.6, 64+80, MainScreenWidth*0.4, 60);
        _securityButton.backgroundColor = [UIColor blueColor];
        [_securityButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_securityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_securityButton addTarget:self action:@selector(securityButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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
        _passwordTextField.backgroundColor = [UIColor redColor];
        _passwordTextField.placeholder = @"请输入6-10位英文或数字的新密码";
    }
    return _passwordTextField;
}

- (UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.frame = CGRectMake(MainScreenWidth / 6, 64+80 + 80 + 85, MainScreenWidth/3*2, 60);
        _sureButton.layer.cornerRadius = 30;
        _sureButton.backgroundColor = [UIColor blueColor];
        [_sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MainScreenWidth, 60)];
    view1.backgroundColor = [UIColor redColor];
    [view1 addSubview:self.phoneNumberTextField];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0,64+80, MainScreenWidth *0.6, 60)];
    view2.backgroundColor = [UIColor redColor];
    [view2 addSubview:self.securityTextField];
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:self.securityButton];
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0,64+80 + 80, MainScreenWidth, 60)];
    view3.backgroundColor = [UIColor redColor];
    [view3 addSubview:self.passwordTextField];
    [self.view addSubview:view3];
    [self.view addSubview:self.sureButton];
}


- (void)securityButtonAction:(UIButton *)button
{
    
}

- (void)sureButtonAction:(UIButton *)button
{
    
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
