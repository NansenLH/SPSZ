//
//  SPSZ_EnterPasswordViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/21.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_EnterPasswordViewController.h"
#import "SPSZ_changePassWordViewController.h"

#import "SPSZ_LoginNetTool.h"

@interface SPSZ_EnterPasswordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UITextField *phoneNumberTextField;

@property (nonatomic, strong)UITextField *passwordTextField;

@property (nonatomic, strong)UIButton *loginButton;

@property (nonatomic, strong)UIButton *forgotButton;
@end


@implementation SPSZ_EnterPasswordViewController

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

- (UITextField *)passwordTextField
{
    if(!_passwordTextField){
        _passwordTextField = [[UITextField alloc]init];
        _passwordTextField.frame = CGRectMake(10,0, MainScreenWidth-20, 60);
        _passwordTextField.delegate = self;
        _passwordTextField.tintColor = [UIColor redColor];
        _passwordTextField.placeholder = @"请输入密码";
    }
    return _passwordTextField;
}

- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.frame = CGRectMake(MainScreenWidth / 6, 88 +69+25, MainScreenWidth/3*2, 60);
        _loginButton.layer.cornerRadius = 30;
        _loginButton.backgroundColor = [UIColor blueColor];
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)forgotButton{
    if (!_forgotButton) {
        _forgotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgotButton.frame = CGRectMake((MainScreenWidth -150)/2, 88 +69+25 + 60 + 30, 150, 60);
        [_forgotButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgotButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_forgotButton addTarget:self action:@selector(forgotButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgotButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 60)];
    view1.backgroundColor = [ProgramColor huiseColor];
    [view1 addSubview:self.phoneNumberTextField];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0,80, MainScreenWidth, 60)];
    view2.backgroundColor = [ProgramColor huiseColor];
    [view2 addSubview:self.passwordTextField];
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.forgotButton];
}


- (void)loginButtonAction:(UIButton *)button
{
    [SPSZ_LoginNetTool pifashangLoginWithPwd:self.passwordTextField.text tel:self.phoneNumberTextField.text successBlock:^(SPSZ_chuLoginModel *model) {
        
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        
    } failureBlock:^(NSString *failure) {
        
    }];
}
- (void)forgotButtonAction:(UIButton *)button
{
    SPSZ_changePassWordViewController *changeView = [[SPSZ_changePassWordViewController alloc]init];
    self.navigationController.navigationBar.hidden = NO;
    
    [self.navigationController pushViewController:changeView animated:YES];
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
