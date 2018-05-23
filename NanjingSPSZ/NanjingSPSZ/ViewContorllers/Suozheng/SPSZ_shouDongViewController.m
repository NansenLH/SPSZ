//
//  SPSZ_shouDongViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/22.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_shouDongViewController.h"

@interface SPSZ_shouDongViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UIView *mainView;

@property (nonatomic, strong)UITextField *productNameTextField;

@property (nonatomic, strong)UITextField *productLocationTextField;

@property (nonatomic, strong)UITextField *detailLocationTextField;

@property (nonatomic, strong)UITextField *numberTextField;

@property (nonatomic, strong)UITextField *companyTextField;

@property (nonatomic, strong)UITextField *nameTextField;

@property (nonatomic, strong)UITextField *phoneTextField;

@property (nonatomic, strong)UITextField *timeTextField;


@end

@implementation SPSZ_shouDongViewController


- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(30, 30, MainScreenWidth - 60, MainScreenHeight -264)];
        _mainView.backgroundColor = [UIColor greenColor];
    }
    return _mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor   = [ UIColor clearColor];

    
    [self.view addSubview:self.mainView];

    [self setUpView];
}

- (void)setUpView{
    
    CGFloat height = (MainScreenHeight -264)/8;
    CGFloat width = MainScreenWidth - 60;
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, height)];
    label.textColor = [UIColor redColor];
    [label setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"*  " string2:@"产品名称"]];
    [view1 addSubview:label];
    _productNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, width - 110 -10, height)];
    _productNameTextField.delegate = self;
    _productNameTextField.tintColor = [UIColor redColor];
    _productNameTextField.textAlignment = NSTextAlignmentRight;
    _productNameTextField.placeholder = @"请输入";
    [view1 addSubview:_productNameTextField];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, height, width, height)];
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, height)];
    label2.textColor = [UIColor redColor];
    [label2 setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"*  " string2:@"产品产地"]];
    [view2 addSubview:label2];
    _productLocationTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, width - 110 -10, height)];
    _productLocationTextField.delegate = self;
    _productLocationTextField.tintColor = [UIColor redColor];
    _productLocationTextField.textAlignment = NSTextAlignmentRight;
    _productLocationTextField.placeholder = @"请输入";
    [view2 addSubview:_productLocationTextField];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, height *2, width, height)];
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, height)];
    label3.textColor = [UIColor redColor];
    [label3 setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"   " string2:@"详细地址"]];
    [view3 addSubview:label3];
    _detailLocationTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, width - 110 -10, height)];
    _detailLocationTextField.delegate = self;
    _detailLocationTextField.tintColor = [UIColor redColor];
    _detailLocationTextField.textAlignment = NSTextAlignmentRight;
    _detailLocationTextField.placeholder = @"请输入";
    [view3 addSubview:_detailLocationTextField];
    
    
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(0, height*3, width, height)];
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, height)];
    label4.textColor = [UIColor redColor];
    [label4 setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"*  " string2:@"进货数量/重量"]];
    [view4 addSubview:label4];
    _numberTextField = [[UITextField alloc]initWithFrame:CGRectMake(140, 0, width - 140 -10, height)];
    _numberTextField.delegate = self;
    _numberTextField.tintColor = [UIColor redColor];
    _numberTextField.textAlignment = NSTextAlignmentRight;
    _numberTextField.placeholder = @"请输入";
    [view4 addSubview:_numberTextField];
    
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(0, height *4, width, height)];
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, height)];
    label5.textColor = [UIColor redColor];
    [label5 setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"*  " string2:@"供货单位"]];
    [view5 addSubview:label5];
    _companyTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, width - 110 -10, height)];
    _companyTextField.delegate = self;
    _companyTextField.tintColor = [UIColor redColor];
    _companyTextField.textAlignment = NSTextAlignmentRight;
    _companyTextField.placeholder = @"请输入";
    [view5 addSubview:_companyTextField];
    
    UIView *view6 = [[UIView alloc]initWithFrame:CGRectMake(0, height *5, width, height)];
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, height)];
    label6.textColor = [UIColor redColor];
    [label6 setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"*  " string2:@"批发商姓名"]];
    [view6 addSubview:label6];
    _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(130, 0, width - 130 -10, height)];
    _nameTextField.delegate = self;
    _nameTextField.tintColor = [UIColor redColor];
    _nameTextField.textAlignment = NSTextAlignmentRight;
    _nameTextField.placeholder = @"请输入";
    [view6 addSubview:_nameTextField];
    
    UIView *view7 = [[UIView alloc]initWithFrame:CGRectMake(0, height *6, width, height)];
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, height)];
    label7.textColor = [UIColor redColor];
    [label7 setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"*  " string2:@"联系电话"]];
    [view7 addSubview:label7];
    _phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, width - 110 -10, height)];
    _phoneTextField.delegate = self;
    _phoneTextField.tintColor = [UIColor redColor];
    _phoneTextField.textAlignment = NSTextAlignmentRight;
    _phoneTextField.placeholder = @"请输入";
    [view7 addSubview:_phoneTextField];
    
    UIView *view8 = [[UIView alloc]initWithFrame:CGRectMake(0, height *7, width, height)];
    UILabel *label8 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, height)];
    label8.textColor = [UIColor redColor];
    [label8 setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"*  " string2:@"联系电话"]];
    [view8 addSubview:label8];
    _timeTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, width - 110 -10, height)];
    _timeTextField.delegate = self;
    _timeTextField.tintColor = [UIColor redColor];
    _timeTextField.textAlignment = NSTextAlignmentRight;
    _timeTextField.placeholder = @"请输入";
    [view8 addSubview:_timeTextField];
    
    [self.mainView addSubview:view1];
    [self.mainView addSubview:view2];
    [self.mainView addSubview:view3];
    [self.mainView addSubview:view4];
    [self.mainView addSubview:view5];
    [self.mainView addSubview:view6];
    [self.mainView addSubview:view7];
    [self.mainView addSubview:view8];
    
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
