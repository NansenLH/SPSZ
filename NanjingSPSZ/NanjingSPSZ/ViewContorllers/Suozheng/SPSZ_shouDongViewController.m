//
//  SPSZ_shouDongViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/22.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_shouDongViewController.h"

#import "CZHAddressPickerView.h"
#import "AddressPickerHeader.h"

#import "PGDatePickManager.h"

#import "CityView.h"


#import "SPSZ_addGoodsNetTool.h"

@interface SPSZ_shouDongViewController ()<UITextFieldDelegate,PGDatePickerDelegate>

@property (nonatomic, strong)UIView *mainView;

@property (nonatomic, strong)UITextField *productNameTextField;

@property (nonatomic, strong)UIButton *productLocationButton;

@property (nonatomic, strong)UITextField *detailLocationTextField;

@property (nonatomic, strong)UITextField *numberTextField;

@property (nonatomic, strong)UITextField *companyTextField;

@property (nonatomic, strong)UITextField *nameTextField;

@property (nonatomic, strong)UITextField *phoneTextField;

@property (nonatomic, strong)UIButton *timeButton;

@property (nonatomic, assign)CGFloat width;

@property (nonatomic, assign)CGFloat height;

@property (nonatomic, strong)NSMutableArray *titleArray;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, strong)CityView *cityView;


@end

@implementation SPSZ_shouDongViewController


- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"产品名称",@"产品产地",@"详细地址",@"进货数量/重量",@"供货单位",@"批发商姓名",@"联系电话",@"发货时间", nil];
    }
    return _titleArray;
}

- (CityView *)cityView{
    if (!_cityView) {
        _cityView = [[CityView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
        _cityView.cityList = [self readLocalFileWithName:@"city"];
    }
    return _cityView;
}
- (UITextField *)productNameTextField{
    if (!_productNameTextField) {
        _productNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, _width - 110 -10, _height)];
        _productNameTextField.delegate = self;
        _productNameTextField.tintColor = [UIColor redColor];
        _productNameTextField.textAlignment = NSTextAlignmentRight;
        _productNameTextField.placeholder = @"请输入";
    }
    return _productNameTextField;
}


- (UITextField *)detailLocationTextField{
    if (!_detailLocationTextField) {
        _detailLocationTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, _width - 110 -10, _height)];
        _detailLocationTextField.delegate = self;
        _detailLocationTextField.tintColor = [UIColor redColor];
        _detailLocationTextField.textAlignment = NSTextAlignmentRight;
        _detailLocationTextField.placeholder = @"请输入";
    }
    return _detailLocationTextField;
}

- (UITextField *)numberTextField{
    if (!_numberTextField) {
        _numberTextField = [[UITextField alloc]initWithFrame:CGRectMake(140, 0, _width - 140 -10, _height)];
        _numberTextField.delegate = self;
        _nameTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _numberTextField.tintColor = [UIColor redColor];
        _numberTextField.textAlignment = NSTextAlignmentRight;
        _numberTextField.placeholder = @"请输入";
    }
    return _numberTextField;
}

- (UITextField *)companyTextField{
    if (!_companyTextField) {
        _companyTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, _width - 110 -10, _height)];
        _companyTextField.delegate = self;
        _companyTextField.tintColor = [UIColor redColor];
        _companyTextField.textAlignment = NSTextAlignmentRight;
        _companyTextField.placeholder = @"请输入";
    }
    return _companyTextField;
}

- (UITextField *)nameTextField{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(130, 0, _width - 130 -10, _height)];
        _nameTextField.delegate = self;
        _nameTextField.tintColor = [UIColor redColor];
        _nameTextField.textAlignment = NSTextAlignmentRight;
        _nameTextField.placeholder = @"请输入";
    }
    return _nameTextField;
}

- (UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, _width - 110 -10, _height)];
        _phoneTextField.delegate = self;
        _phoneTextField.tintColor = [UIColor redColor];
        _nameTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.textAlignment = NSTextAlignmentRight;
        _phoneTextField.placeholder = @"请输入";
    }
    return _phoneTextField;
}

- (UIButton *)timeButton{
    if (!_timeButton) {
        _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeButton.frame = CGRectMake(110, 0, _width - 110 -10, _height);
        [_timeButton setTitle:@"请选择" forState:UIControlStateNormal];
        [_timeButton setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
        _timeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _timeButton.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
        [_timeButton addTarget:self action:@selector(timeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeButton;
}

- (UIButton *)productLocationButton{
    if (!_productLocationButton) {
        _productLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _productLocationButton.frame = CGRectMake(110, 0, _width - 110 -10, _height);
        [_productLocationButton setTitle:@"请选择" forState:UIControlStateNormal];
        [_productLocationButton setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
        _productLocationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _productLocationButton.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
        [_productLocationButton addTarget:self action:@selector(productLocationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _productLocationButton;
}

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(30, 30, MainScreenWidth - 60, MainScreenHeight -264)];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.height = (MainScreenHeight -264)/8;
    self.width = MainScreenWidth - 60;
    
    [self.view addSubview:self.mainView];

    [self setUpView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)setUpView{
    
    [self setUpViewWith:0 textfield:self.productNameTextField button:nil];
    [self setUpViewWith:1 textfield:nil button:self.productLocationButton];
    [self setUpViewWith:2 textfield:self.detailLocationTextField button:nil];
    [self setUpViewWith:3 textfield:self.numberTextField button:nil];
    [self setUpViewWith:4 textfield:self.companyTextField button:nil];
    [self setUpViewWith:5 textfield:self.nameTextField button:nil];
    [self setUpViewWith:6 textfield:self.phoneTextField button:nil];
    [self setUpViewWith:7 textfield:nil button:self.timeButton];
}


- (void)setUpViewWith:(NSInteger)number textfield:(UITextField *)textfield button:(UIButton *)button{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _height*number, _width, _height)];
    if (number == 1 || number == 7) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, _height)];
        label.textColor = [UIColor redColor];
        [label setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"    " string2:self.titleArray[number]]];
        [view addSubview:label];
        [view addSubview:button];
    }else{
        CGFloat w = 100;
        if (number == 3 || number == 5) {
            w = 140;
        }
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, _height)];
        label.textColor = [UIColor redColor];
        [label setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"*  " string2:self.titleArray[number]]];
        [view addSubview:label];
        [view addSubview:textfield];
    }
    if (number != 7) {
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(10, _height- 1, _width - 20, 1)];
        lineView.backgroundColor = [ProgramColor huiseColor];
        [view addSubview:lineView];
    }
    [self.mainView addSubview:view];
}


- (void)productLocationButtonAction:(UIButton *)button{
    [self.cityView showCityListViewInView:self.navigationController.view];

}


- (void)timeButtonAction:(UIButton *)button{
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    datePickManager.isShadeBackgroud = true;
    datePickManager.style = PGDatePickManagerStyle3;
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.delegate = self;
    datePicker.datePickerType = PGDatePickerType2;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerMode = PGDatePickerModeDate;
    [self presentViewController:datePickManager animated:false completion:nil];
}

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    [self.timeButton setTitle:[NSString stringWithFormat:@"%ld-%ld-%ld",dateComponents.year,dateComponents.month,dateComponents.day] forState:UIControlStateNormal];
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


- (void)reloadNewData{
    _productNameTextField.text = @"";
    _detailLocationTextField.text = @"";
    _numberTextField.text = @"";
    _companyTextField.text = @"";
    _nameTextField.text = @"";
    _phoneTextField.text = @"";
    [_timeButton setTitle:@"请选择" forState:UIControlStateNormal];
    [_productLocationButton setTitle:@"请选择" forState:UIControlStateNormal];
}

- (void)sureUpload{
    
    if ([_phoneTextField.text isEqualToString:@""]) {
        [self tiShiKuangWithString:@"产品名称"];
    }else if ([_productLocationButton.titleLabel.text isEqualToString:@"请选择"]) {
        [self tiShiKuangWithString:@"产品产地"];
    }
}


// 回收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.productNameTextField resignFirstResponder];
    [self.detailLocationTextField resignFirstResponder];
    [self.numberTextField resignFirstResponder];
    [self.companyTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];

    [self.view endEditing:YES];
}

//时时获取输入框输入的新内容   return NO：输入内容清空   return YES：输入内容不清空， string 输入内容 ，range输入的范围
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField isEqual:self.numberTextField] || [textField isEqual:self.phoneTextField]) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        
        return   [self isPureInt:string];
    }
    return YES;
}

- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}



- (void)tiShiKuangWithString:(NSString *)string
{
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@不能为空!",string] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [actionSheetController addAction:okAction];
    
    [self presentViewController:actionSheetController animated:YES completion:nil];
}

- (NSArray *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
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
