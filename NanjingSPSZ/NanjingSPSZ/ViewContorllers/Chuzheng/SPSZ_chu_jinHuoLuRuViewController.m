//
//  SPSZ_chu_jinHuoLuRuViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/28.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_chu_jinHuoLuRuViewController.h"

#import "CZHAddressPickerView.h"
#import "AddressPickerHeader.h"

#import "SPSZ_chu_luRuCollectionViewCell.h"

#import "UIButton+Gradient.h"

#import <Photos/Photos.h>
#import "LUNetHelp.h"
#import "UIImageView+WebCache.h"

#import "SPSZ_ChuhuoModel.h"
#import "YYModel.h"

#import "CityView.h"
#import "KRAccountTool.h"
#import "SPSZ_chuLoginModel.h"

#import "ChuzhengNetworkTool.h"
#import "SPSZ_EditWightView.h"

// TODO: 限制字符个数


@interface SPSZ_chu_jinHuoLuRuViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UITextFieldDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UIGestureRecognizerDelegate
>
@property (nonatomic, strong)UIView  *mainView;

@property (nonatomic, assign)CGFloat height;

@property (nonatomic, strong)NSMutableArray *titleArray;

@property (nonatomic, strong)UITextField *productNameLabel;

@property (nonatomic, strong)UIButton *numberButton;
//@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong)UITextField *carLabel;

@property (nonatomic, strong)UIButton *productLocationButton;

@property (nonatomic, strong)UITextField *detailLocationLabel;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)UIButton *saveButton;

@property (nonatomic, strong) NSMutableArray *imagesArray;

@property (nonatomic, strong) SPSZ_ChuhuoModel *addGoods;

@property (nonatomic, strong) CityView *cityView;

@property (nonatomic, strong) SPSZ_EditWightView *editWeightView;

@end

@implementation SPSZ_chu_jinHuoLuRuViewController

- (SPSZ_EditWightView *)editWeightView
{
    if (!_editWeightView) {
        _editWeightView = [[SPSZ_EditWightView alloc] init];
        KRWeakSelf;
        [_editWeightView setChooseWeightBlock:^(NSString *weight, NSString *unit) {
            weakSelf.addGoods.dishamount = weight;
            weakSelf.addGoods.unit = unit;
            
            [weakSelf.numberButton setTitle:[NSString stringWithFormat:@"%@%@", weight, unit] forState:UIControlStateNormal];
            [weakSelf.numberButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }];
    }
    return _editWeightView;
}

- (CityView *)cityView
{
    if (!_cityView) {
        _cityView = [[CityView alloc] initWithFrame:CGRectMake(0, 0, [ProgramSize mainScreenWidth], [ProgramSize mainScreenHeight])];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSArray *cityList = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        _cityView.cityList = cityList;
        KRWeakSelf;
        [_cityView setGetSelectCityBlock:^(NSDictionary *dic) {
            [weakSelf.productLocationButton setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
            weakSelf.addGoods.cityname = [dic objectForKey:@"name"];
            weakSelf.addGoods.cityid = [dic objectForKey:@"Id"];
        }];
    }
    return _cityView;
}


- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"货品信息",@"货品名称",@"货品数量/重量",@"运输信息/车辆牌照",@"来源产地",@"详细地址",@"拍照留证", nil];
    }
    return _titleArray;
}

- (NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

- (SPSZ_ChuhuoModel *)addGoods
{
    if (!_addGoods) {
        _addGoods = [[SPSZ_ChuhuoModel alloc] init];
        SPSZ_chuLoginModel *chuUser = [KRAccountTool getChuUserInfo];
        _addGoods.salerid = chuUser.login_Id;
    }
    return _addGoods;
}

- (UIButton *)productLocationButton
{
    if (!_productLocationButton) {
        _productLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _productLocationButton.frame = CGRectMake(110, 0, MainScreenWidth - 120, _height);
        [_productLocationButton setTitle:@"请选择" forState:UIControlStateNormal];
        _productLocationButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_productLocationButton setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
        _productLocationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _productLocationButton.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
        [_productLocationButton addTarget:self action:@selector(productLocationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _productLocationButton;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveButton.frame = CGRectMake(MainScreenWidth / 6, MainScreenHeight - 80 - 64, MainScreenWidth/3*2, 60);
        _saveButton.layer.cornerRadius = 15;
        _saveButton.layer.masksToBounds = YES;
        [_saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton gradientButtonWithSize:CGSizeMake(180, 30) colorArray:[ProgramColor blueGradientColors] percentageArray:@[@(0),@(1)] gradientType:GradientFromTopToBottom];
    }
    return _saveButton;
}

- (UITextField *)productNameLabel
{
    if (!_productNameLabel) {
        _productNameLabel = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, MainScreenWidth - 120, _height)];
        _productNameLabel.placeholder = @"请输入";
        _productNameLabel.delegate = self;
        _productNameLabel.font = [UIFont systemFontOfSize:14];
        _productNameLabel.tintColor = [UIColor redColor];
        _productNameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _productNameLabel;
}

- (UIButton *)numberButton
{
    if (!_numberButton) {
        _numberButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _numberButton.frame = CGRectMake(140, 0, MainScreenWidth - 150, _height);
        [_numberButton setTitle:@"请输入" forState:UIControlStateNormal];
        [_numberButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _numberButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _numberButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _numberButton.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
        [_numberButton addTarget:self action:@selector(editNumber:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _numberButton;
}


- (UITextField *)carLabel
{
    if (!_carLabel) {
        _carLabel = [[UITextField alloc]initWithFrame:CGRectMake(180, 0, MainScreenWidth - 190, _height)];
        _carLabel.placeholder = @"请输入";
        _carLabel.delegate = self;
        _carLabel.font = [UIFont systemFontOfSize:14];
        _carLabel.tintColor = [UIColor redColor];
        _carLabel.textAlignment = NSTextAlignmentRight;
    }
    return _carLabel;
}

- (UITextField *)detailLocationLabel
{
    if (!_detailLocationLabel) {
        _detailLocationLabel = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, MainScreenWidth - 120, _height)];
        _detailLocationLabel.placeholder = @"请输入";
        _detailLocationLabel.font = [UIFont systemFontOfSize:14];
        _detailLocationLabel.delegate = self;
        _detailLocationLabel.tintColor = [UIColor redColor];
        _detailLocationLabel.textAlignment = NSTextAlignmentRight;
    }
    return _detailLocationLabel;
}


- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth,  MainScreenHeight  - 64 - 80)];
        _mainView.backgroundColor = [UIColor whiteColor];
        
        [self setUpViewWith:0 text:@"（请完善信息，以便更好的使用）"];
        [self setUpViewWith:1 text:nil];
        [self setUpViewWith:2 text:nil];
        [self setUpViewWith:3 text:nil];
        [self setUpViewWith:4 text:nil];
        [self setUpViewWith:5 text:nil];
        [self setUpViewWith:6 text: @"（请上传产地证明或是货品照片）"];
        
        [_mainView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.right.equalTo(-20);
            make.top.equalTo(self.height*7);
            make.bottom.equalTo(0);
        }];
    }
    return _mainView;
}


-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, _height *7, MainScreenWidth - 40, MainScreenHeight - _height *7 - 80 - 74) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor greenColor];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[SPSZ_chu_luRuCollectionViewCell class] forCellWithReuseIdentifier:@"SPSZ_chu_luRuCollectionViewCell"];
        
    }
    return _collectionView;
}

- (void)backToUpView
{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"进货录入";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backToUpView)];
    self.navigationItem.leftBarButtonItem = item;
    
    
    self.height = 40;
    CGFloat margin = [ProgramSize mainScreenHeight] == 480 ? 5 : 15;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.bottom.equalTo(-30-margin-margin-[ProgramSize bottomHeight]);
    }];
    
    [self.view addSubview:self.saveButton];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.height.equalTo(30);
        make.width.equalTo(180);
        make.bottom.equalTo(-margin-[ProgramSize bottomHeight]);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
    
}

- (void)endEdit
{
    [self.view endEditing:YES];
}


- (void)setUpViewWith:(NSInteger)number text:(NSString *)text
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _height*number, MainScreenWidth, _height)];
   
    CGFloat w = 100;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, _height)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor redColor];
    if (number == 0 || number == 6) {
        UILabel *mainLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, MainScreenWidth - 120, _height)];
        mainLabel.textColor = [UIColor lightGrayColor];
        mainLabel.textAlignment = NSTextAlignmentLeft;
        mainLabel.frame = CGRectMake(100, 0, MainScreenWidth -160, _height);
        mainLabel.font = [UIFont systemFontOfSize:11];
        if (number == 0) {
            [label setAttributedText:[self Color:[UIColor redColor] secondColor:[ProgramColor RGBColorWithRed:54 green:136 blue:225] string:@"      " string2:self.titleArray[number]]];
        }else{
            [label setAttributedText:[self Color:[UIColor redColor] secondColor:[ProgramColor RGBColorWithRed:54 green:136 blue:225] string:@"  *  " string2:self.titleArray[number]]];
        }
        mainLabel.text = text;
        [view addSubview:mainLabel];
        [view addSubview:label];
    }else{
        if (number == 1) {
            [view addSubview:self.productNameLabel];
        }else if (number == 2){
//            [view addSubview:self.numberLabel];
            [view addSubview:self.numberButton];
            w = 140;
        }else if (number == 3){
            [view addSubview:self.carLabel];
            w = 180;
        }else if (number == 4){
            [view addSubview:self.productLocationButton];
        }else if (number == 5){
            [view addSubview:self.detailLocationLabel];
        }
        
        label.frame = CGRectMake(0, 0, w, _height);
        if (number == 3 || number == 5) {
            [label setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor blackColor] string:@"      " string2:self.titleArray[number]]];
        }else{
            [label setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor blackColor] string:@"  *  " string2:self.titleArray[number]]];
        }
        [view addSubview:label];
    }
    if (number != 6) {
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(10, _height- 1, MainScreenWidth - 20, 1)];
        lineView.backgroundColor = [ProgramColor huiseColor];
        [view addSubview:lineView];
    }
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
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:redRange];
    return noteStr;
    
}

- (void)productLocationButtonAction:(UIButton *)button
{
    [self.view endEditing:YES];
    [self.cityView showCityListViewInView:self.navigationController.view];
}

- (void)saveButtonAction:(UIButton *)button
{
    if (!self.productNameLabel.text) {
        [KRAlertTool alertString:@"请填写货品名称"];
        return;
    }
    self.addGoods.dishname = self.productNameLabel.text;

    if (!self.addGoods.dishamount) {
        [KRAlertTool alertString:@"请填写货品重量"];
        return;
    }

    if (!self.addGoods.cityname || !self.addGoods.cityid) {
        [KRAlertTool alertString:@"请填写来源产地"];
        return;
    }

    self.addGoods.addresssource = self.detailLocationLabel.text;
    self.addGoods.carnumber = self.carLabel.text;

    if (self.imagesArray.count == 0) {
        [KRAlertTool alertString:@"请拍照留证"];
        return;
    }
    NSMutableString *imgs = [NSMutableString string];
    for (NSString *imgUrl in self.imagesArray) {
        [imgs appendString:imgUrl];
        [imgs appendString:@","];
    }
    self.addGoods.dishimgs = [imgs substringWithRange:NSMakeRange(0, imgs.length-1)];

    [ChuzhengNetworkTool addGoods:self.addGoods successBlock:^{
        [KRAlertTool alertString:@"添加成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        [KRAlertTool alertString:errorMessage];
    } failureBlock:^(NSString *failure) {
        [KRAlertTool alertString:failure];
    }];
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint p = [touch locationInView:self.view];
    if(CGRectContainsPoint(self.collectionView.frame, p)) {
        return NO;
    }
    return YES;
}

- (void)editNumber:(UIButton *)button
{
    [self.editWeightView show];
}


#pragma mark --- delegate、dataSource ---
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (self.imagesArray.count + 1);
}
#pragma mark --- 返回cell ---
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPSZ_chu_luRuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SPSZ_chu_luRuCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row == self.imagesArray.count) {
        cell.picImageView.image = [UIImage imageNamed:@"icon_takephoto"];
    }
    else {
        NSString *imageURL = [NSString stringWithFormat:@"%@%@", BaseImagePath, self.imagesArray[indexPath.row]];
        [cell.picImageView sd_setImageWithURLString:imageURL];
    }
    return cell;
}

#pragma mark --- 返回每个item的 宽和高 ---
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((MainScreenWidth - 40 - 30  -40)/3 , (MainScreenWidth - 80 - 30)/3);
}

#pragma mark --- 返回集合视图集体的 上 左 下 右 边距 ---
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 10, 5);
}



#pragma mark --- item点击的方法 ---
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.imagesArray.count && self.imagesArray.count < 5) {
        // 拍照
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusAuthorized) {
            [self takePhoto];
        }
        else if (authStatus == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self alertSettingCameraAuth];
                    });
                }
            }];
        }
        else {
            [self alertSettingCameraAuth];
        }
    }
    else if (self.imagesArray.count == 5 && indexPath.row == self.imagesArray.count) {
        [KRAlertTool alertString:@"最多只能上传5张照片"];
    }
}

- (void)takePhoto
{
    UIImagePickerController *ctrl = [[UIImagePickerController alloc] init];
    ctrl.delegate = self;
    ctrl.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:ctrl animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // 处理
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (image) {
            [self uploadImage:image];
        }
        else {
            NSLog(@"拍照出错");
        }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadImage:(UIImage *)image
{
    [LUNetHelp uploadImage:image successBlock:^(NSString *imageURL) {
        [self.imagesArray addObject:imageURL];
        [self.collectionView reloadData];
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        [KRAlertTool alertString:errorMessage];
    } failureBlock:^(NSString *failure) {
        [KRAlertTool alertString:failure];
    }];
}




- (void)alertSettingCameraAuth
{
    NSDictionary *mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [mainInfoDictionary objectForKey:@"CFBundleDisplayName"];
    if (!appName) {
        appName = [mainInfoDictionary objectForKey:(NSString *)kCFBundleNameKey];
    }
    NSString * tipTitle = [NSString stringWithFormat:@"请允许\"%@\"使用您的相机", appName];
    NSString * tipMessage = [NSString stringWithFormat:@"您可点击\"去设置\"按钮后将\"相机\"权限打开!"];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:tipTitle message:tipMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:settingURL]) {
            [[UIApplication sharedApplication] openURL:settingURL options:@{} completionHandler:nil];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"稍后设置" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
