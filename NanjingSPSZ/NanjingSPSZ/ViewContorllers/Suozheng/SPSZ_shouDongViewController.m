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
#import "SPSZ_EditWightView.h"

#import "SPSZ_suo_orderNetTool.h"

#import "KRAccountTool.h"

#import "SPSZ_suoLoginModel.h"

#import "SPSZ_suo_saoMaDetailModel.h"



@interface SPSZ_shouDongViewController ()<UITextFieldDelegate,PGDatePickerDelegate>

@property (nonatomic, strong)UIView *mainView;

@property (nonatomic, strong)UITextField *productNameTextField;

@property (nonatomic, strong)UIButton *productLocationButton;

@property (nonatomic, strong)UITextField *detailLocationTextField;

//@property (nonatomic, strong)UITextField *numberTextField;
@property (nonatomic, strong)UIButton *numberButton;

@property (nonatomic, strong)UITextField *companyTextField;

@property (nonatomic, strong)UITextField *nameTextField;

@property (nonatomic, strong)UITextField *phoneTextField;

@property (nonatomic, strong)UIButton *timeButton;

@property (nonatomic, assign)CGFloat width;

@property (nonatomic, assign)CGFloat height;

@property (nonatomic, strong)NSMutableArray *titleArray;

@property (nonatomic, strong)CityView *cityView;
@property (nonatomic, strong)SPSZ_EditWightView *editWeightView;

@property (nonatomic, strong) UITextField *nowEditTF;

@property (nonatomic, strong)NSString *locationString;

@property (nonatomic, strong)NSString *amount;

@property (nonatomic, strong)NSString *unit;
@end

@implementation SPSZ_shouDongViewController


- (SPSZ_EditWightView *)editWeightView
{
    if (!_editWeightView) {
        _editWeightView = [[SPSZ_EditWightView alloc] init];
        KRWeakSelf;
        [_editWeightView setChooseWeightBlock:^(NSString *weight, NSString *unit) {
            weakSelf.amount = weight;
            weakSelf.unit = unit;
            [weakSelf.numberButton setTitle:[NSString stringWithFormat:@"%@%@", weight, unit] forState:UIControlStateNormal];
            [weakSelf.numberButton setTitleColor:[ProgramColor RGBColorWithRed:59 green:59 blue:59] forState:UIControlStateNormal];
        }];
    }
    return _editWeightView;
}

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
        
        KRWeakSelf
        _cityView.getSelectCityBlock = ^(NSDictionary *dic) {
             weakSelf.locationString = dic[@"name"];
             [weakSelf.productLocationButton setTitle:weakSelf.locationString forState:UIControlStateNormal];
            [weakSelf.productLocationButton setTitleColor:[ProgramColor RGBColorWithRed:59 green:59 blue:59] forState:UIControlStateNormal];

        };
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
        _productNameTextField.textColor = [ProgramColor RGBColorWithRed:59 green:59 blue:59];
        _productNameTextField.font = [UIFont systemFontOfSize:14];
        _productNameTextField.tag = 555 + 0;
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
        _detailLocationTextField.textColor = [ProgramColor RGBColorWithRed:59 green:59 blue:59];
        _detailLocationTextField.font = [UIFont systemFontOfSize:14];
        _productNameTextField.tag = 555 + 1;
    }
    return _detailLocationTextField;
}

- (UIButton *)numberButton
{
    if (!_numberButton) {
        _numberButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _numberButton.frame = CGRectMake(170, 0, _width - 180, _height);
        [_numberButton setTitle:@"请输入" forState:UIControlStateNormal];
        _numberButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _numberButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _numberButton.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
        [_numberButton addTarget:self action:@selector(editNumber:) forControlEvents:UIControlEventTouchUpInside];
        [_numberButton setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];

    }
    return _numberButton;
}
- (UITextField *)companyTextField{
    if (!_companyTextField) {
        _companyTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, _width - 110 -10, _height)];
        _companyTextField.delegate = self;
        _companyTextField.tintColor = [UIColor redColor];
        _companyTextField.textAlignment = NSTextAlignmentRight;
        _companyTextField.placeholder = @"请输入";
        _companyTextField.textColor = [ProgramColor RGBColorWithRed:59 green:59 blue:59];
        _companyTextField.font = [UIFont systemFontOfSize:14];
        _companyTextField.tag = 555 + 4;
    }
    return _companyTextField;
}

- (UITextField *)nameTextField{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(130, 0, _width - 130 -10, _height)];
        _nameTextField.delegate = self;
        _nameTextField.textAlignment = NSTextAlignmentRight;
        _nameTextField.placeholder = @"请输入";
        _nameTextField.textColor = [ProgramColor RGBColorWithRed:59 green:59 blue:59];
        _nameTextField.font = [UIFont systemFontOfSize:14];
        _nameTextField.tag = 555 + 5;
    }
    return _nameTextField;
}

- (UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, _width - 110 -10, _height)];
        _phoneTextField.delegate = self;
        _phoneTextField.tintColor = [UIColor redColor];
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.textAlignment = NSTextAlignmentRight;
        _phoneTextField.placeholder = @"请输入";
        _phoneTextField.textColor = [ProgramColor RGBColorWithRed:59 green:59 blue:59];
        _phoneTextField.font = [UIFont systemFontOfSize:14];
        _phoneTextField.tag = 555 + 6;
    }
    return _phoneTextField;
}

- (UIButton *)timeButton{
    if (!_timeButton) {
        _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeButton.frame = CGRectMake(110, 0, _width - 110 -10, _height);
        _timeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_timeButton setTitle:@"请选择" forState:UIControlStateNormal];
        _timeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _timeButton.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
        [_timeButton setTitleColor:[ProgramColor RGBColorWithRed:59 green:59 blue:59] forState:UIControlStateNormal];
        [_timeButton setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];

        [_timeButton addTarget:self action:@selector(timeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeButton;
}

- (UIButton *)productLocationButton{
    if (!_productLocationButton) {
        _productLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _productLocationButton.frame = CGRectMake(110, 0, _width - 110 -10, _height);
        [_productLocationButton setTitle:@"请选择" forState:UIControlStateNormal];
        [_productLocationButton setTitleColor:[ProgramColor RGBColorWithRed:59 green:59 blue:59] forState:UIControlStateNormal];
        _productLocationButton.titleLabel.font = [UIFont systemFontOfSize:14];

        [_productLocationButton setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
        _productLocationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _productLocationButton.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
        [_productLocationButton addTarget:self action:@selector(productLocationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _productLocationButton;
}

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(30, 30, MainScreenWidth - 60, MainScreenHeight - 220 -[ProgramSize bottomHeight] - [ProgramSize statusBarAndNavigationBarHeight])];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.amount = @"0";
    self.unit = @"公斤";
    self.height = (MainScreenHeight - 220 -[ProgramSize bottomHeight] - [ProgramSize statusBarAndNavigationBarHeight])/8;
    self.width = MainScreenWidth - 60;
    
    [self.view addSubview:self.mainView];

    [self setUpView];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUpView{
    
    [self setUpViewWith:0 textfield:self.productNameTextField button:nil];
    [self setUpViewWith:1 textfield:nil button:self.productLocationButton];
    [self setUpViewWith:2 textfield:self.detailLocationTextField button:nil];
    [self setUpViewWith:3 textfield:nil button:self.numberButton];
    [self setUpViewWith:4 textfield:self.companyTextField button:nil];
    [self setUpViewWith:5 textfield:self.nameTextField button:nil];
    [self setUpViewWith:6 textfield:self.phoneTextField button:nil];
    [self setUpViewWith:7 textfield:nil button:self.timeButton];
}


- (void)setUpViewWith:(NSInteger)number textfield:(UITextField *)textfield button:(UIButton *)button{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _height*number, _width, _height)];
    CGFloat w = 100;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, w, _height)];
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:14];
    if (number == 2 || number == 7) {
       
        [label setAttributedText:[self Color:[UIColor redColor] secondColor:[ProgramColor RGBColorWithRed:59 green:59 blue:59 alpha:0.58] string:@"    " string2:self.titleArray[number]]];
       
    }else{
        if (number == 5 ) {
            w = 140;
            label.frame = CGRectMake(10, 0, w, _height);

        }
        if (number == 3 ) {
            w = 170;
            label.frame = CGRectMake(10, 0, w, _height);
        }

        [label setAttributedText:[self Color:[UIColor redColor] secondColor:[ProgramColor RGBColorWithRed:59 green:59 blue:59 alpha:0.58] string:@"*  " string2:self.titleArray[number]]];
    }
    [view addSubview:label];

    if (button) {
        [view addSubview:button];
    }else
    {
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
    [self huishoujianpan];
    [self.cityView showCityListViewInView:self.navigationController.view];
}


- (void)timeButtonAction:(UIButton *)button{
    [self huishoujianpan];
    
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
    [self.timeButton setTitleColor:[ProgramColor RGBColorWithRed:59 green:59 blue:59] forState:UIControlStateNormal];

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
    _companyTextField.text = @"";
    _nameTextField.text = @"";
    _phoneTextField.text = @"";
    [_timeButton setTitle:@"请选择" forState:UIControlStateNormal];
    [_productLocationButton setTitle:@"请选择" forState:UIControlStateNormal];
    [_numberButton setTitle:@"请输入" forState:UIControlStateNormal];
    [_numberButton setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
    [_timeButton setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
    [_productLocationButton setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];

}

- (void)sureUpload{
    
    if (!_productNameTextField.text.length) {
        [KRAlertTool alertString:@"请填写产品名称!"];
        return;
    }
    if ([_productLocationButton.titleLabel.text isEqualToString:@"请选择"]) {
        [KRAlertTool alertString:@"请选择产品产地!"];
        return;
    }
    
    if (!self.amount.length) {
        [KRAlertTool alertString:@"请输入数量/重量!"];
        return;
    }
    
    if (!_companyTextField.text.length) {
        [KRAlertTool alertString:@"请填写供货单位!"];
        return;
    }
    
    if (!_nameTextField.text.length) {
        [KRAlertTool alertString:@"请填写批发商姓名!"];
        return;
    }
    if (!_phoneTextField.text.length) {
        [KRAlertTool alertString:@"请填写联系电话"];
        return;
    }
    if ([_timeButton.titleLabel.text isEqualToString:@"请选择"]) {
        [KRAlertTool alertString:@"请选择发货时间！"];
        return;
    }
 
    SPSZ_suo_shouDongRecordModel *shouDongModel = [[SPSZ_suo_shouDongRecordModel alloc]init];
    shouDongModel.mobile = self.phoneTextField.text;
    shouDongModel.companyname = self.companyTextField.text;
    shouDongModel.realname = self.nameTextField.text;
    shouDongModel.address = self.detailLocationTextField.text;
    
    SPSZ_suo_saoMaDetailModel *detailModel = [[SPSZ_suo_saoMaDetailModel alloc]init];
    detailModel.amount = self.amount;
    detailModel.unit = self.unit;
    detailModel.addresssource = self.detailLocationTextField.text;
    detailModel.cityname = self.locationString;
    detailModel.dishid = @" ";
    detailModel.objectName = self.productNameTextField.text;
    
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:detailModel];
    shouDongModel.dishes = array;
    
    KRWeakSelf;
    [SPSZ_suo_orderNetTool shangChuanWith:@"2" model:shouDongModel successBlock:^(NSString *string) {
        UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:@"提示" message:@"上传成功!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 上传不清空  清空打开注释 
//            [weakSelf reloadNewData];
        }];
        [actionSheetController addAction:okAction];
        
        [weakSelf presentViewController:actionSheetController animated:YES completion:nil];
        
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        [KRAlertTool alertString:errorMessage];
    } failureBlock:^(NSString *failure) {
        [KRAlertTool alertString:failure];
        
    }];
}

- (void)editNumber:(UIButton *)button
{
    [self.view endEditing:YES];
    [self.editWeightView show];
}



// 回收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self huishoujianpan];

    [self.view endEditing:YES];
}

//时时获取输入框输入的新内容   return NO：输入内容清空   return YES：输入内容不清空， string 输入内容 ，range输入的范围
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([textField isEqual:self.productNameTextField]) {
        if (textField.text.length > 6) {
            [KRAlertTool alertString:@"超出字数限制！"];
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 6)];

        }
    }
    if ([textField isEqual:self.detailLocationTextField]) {
        if (textField.text.length > 19) {
            [KRAlertTool alertString:@"超出字数限制！"];
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 19)];
            
        }
    }
    
    if ([textField isEqual:self.phoneTextField]) {
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






- (NSArray *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.nowEditTF = textField;
    return true;
}

- (void)huishoujianpan
{
    [self.productNameTextField resignFirstResponder];
    [self.detailLocationTextField resignFirstResponder];
    [self.companyTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //
    CGFloat keyTop = [ProgramSize mainScreenHeight] - kbHeight;
    
    CGFloat editBottom = (self.nowEditTF.tag - 554) * self.height + 70 + [ProgramSize statusBarAndNavigationBarHeight];
    CGFloat offset = keyTop - editBottom - 20;
    if (offset < 0) {
        // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
        double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        //将视图上移计算好的偏移
        [UIView animateWithDuration:duration animations:^{
            
            self.mainView.y += offset;
            
//            self.view.frame = CGRectMake(2 * self.view.frame.size.width, offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    
//    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
//    CGFloat offset = (self.nowEditTF.frame.origin.y+self.nowEditTF.frame.size.height+50) - (self.view.frame.size.height - kbHeight) - 20;
//
//    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
//    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//
//    NSLog(@"kbH = %0.0lf, offset = %0.0lf", kbHeight, offset);
//
//    //将视图上移计算好的偏移
//    [UIView animateWithDuration:duration animations:^{
//        self.view.frame = CGRectMake(2 * self.view.frame.size.width, offset, self.view.frame.size.width, self.view.frame.size.height);
//    }];
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    if (self.mainView.y != 30) {
        [UIView animateWithDuration:duration animations:^{
            self.mainView.y = 30;
        }];
    }
//    [UIView animateWithDuration:duration animations:^{
//
////        self.view.frame = CGRectMake(2*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
//    }];
}



@end
