//
//  SPSZ_EnterPasswordViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/21.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_EnterPasswordViewController.h"
#import "SPSZ_changePassWordViewController.h"

#import "BaseNavigationController.h"
#import "SPSZ_suo_MainViewController.h"
#import "SPSZ_ChuIndexViewController.h"

#import "SPSZ_LoginNetTool.h"

#import "UIButton+Gradient.h"

#import "KRAccountTool.h"


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
        _phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
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
        _passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordTextField.placeholder = @"请输入密码";
    }
    return _passwordTextField;
}

- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.frame = CGRectMake(MainScreenWidth / 6, 88 +69+25, MainScreenWidth/3*2, 45);
        _loginButton.layer.cornerRadius = 22.5;
        _loginButton.layer.masksToBounds = YES;
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton gradientButtonWithSize:CGSizeMake(MainScreenWidth/3*2, 60) colorArray:@[[ProgramColor RGBColorWithRed:33 green:211 blue:255 alpha:0.94],[ProgramColor RGBColorWithRed:67 green:130 blue:255 alpha:0.94]] percentageArray:@[@(1),@(0)] gradientType:GradientFromTopToBottom];
    }
    return _loginButton;
}

- (UIButton *)forgotButton{
    if (!_forgotButton) {
        _forgotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgotButton.frame = CGRectMake((MainScreenWidth -150)/2, 88 +69+25 + 45 + 30, 150, 60);
        [_forgotButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgotButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_forgotButton addTarget:self action:@selector(forgotButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgotButton;
}

- (void)configNavigation
{
    self.navigationItem.title = @"登录";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backToUpView)];
    self.navigationItem.leftBarButtonItem = item;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configNavigation];
    
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
    
    UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyboard)];
    tapRecognize.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapRecognize];
    

}

- (void)hiddenKeyboard
{
    [_phoneNumberTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

- (void)loginButtonAction:(UIButton *)button
{
    if (self.phoneNumberTextField.text.length == 0) {
        [MBProgressHUD showWarnMessage:@"请输入手机号码"];
        return;
    }
    // suo
    if (self.isType) {
        [SPSZ_LoginNetTool lingshoushangLoginWithPwd:self.passwordTextField.text tel:self.phoneNumberTextField.text successBlock:^(SPSZ_suoLoginModel *model) {
            NSString *isLogin = @"suo_login";
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:isLogin forKey:@"isLogin"];
//            [user setObject:model.stall_id forKey:@"stallID"];
            [user synchronize];
            
            [KRAccountTool saveSuoUserInfo:model];
            

            SPSZ_suo_MainViewController *vc = [[SPSZ_suo_MainViewController alloc]init];
            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
            [[AppDelegate shareInstance].window setRootViewController:nav];
        } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
            [MBProgressHUD showWarnMessage:@"用户名或者密码错误"];
        } failureBlock:^(NSString *failure) {
            
        }];
    }
    else{// chu
        [SPSZ_LoginNetTool pifashangLoginWithPwd:self.passwordTextField.text tel:self.phoneNumberTextField.text successBlock:^(SPSZ_chuLoginModel *model) {

            NSString *isLogin = @"chu_login";
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:isLogin forKey:@"isLogin"];
            [user setObject:model.stall_no forKey:@"stallID"];
            [user synchronize];
            
            [KRAccountTool saveChuUserInfo:model];

                    
            SPSZ_ChuIndexViewController *vc = [[SPSZ_ChuIndexViewController alloc] init];
            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
            [[AppDelegate shareInstance].window setRootViewController:nav];
        } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
            [MBProgressHUD showWarnMessage:@"用户名或者密码错误"];
        } failureBlock:^(NSString *failure) {
            
        }];
    }
   
}
- (void)forgotButtonAction:(UIButton *)button
{
    SPSZ_changePassWordViewController *changeView = [[SPSZ_changePassWordViewController alloc]init];
    changeView.isType = self.isType;
    
    [self.navigationController pushViewController:changeView animated:YES];
}


- (void)leftButtonAction:(UIButton *)button
{
    [self.navigationController popoverPresentationController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backToUpView
{
    [self.navigationController popViewControllerAnimated:true];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.passwordTextField) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}
@end
