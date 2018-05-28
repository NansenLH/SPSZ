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

@interface SPSZ_chu_jinHuoLuRuViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
@property (nonatomic, strong)UIView  *mainView;

@property (nonatomic, assign)CGFloat height;

@property (nonatomic, strong)NSMutableArray *titleArray;

@property (nonatomic, strong)UITextField *productNameLabel;

@property (nonatomic, strong)UITextField *numberLabel;

@property (nonatomic, strong)UITextField *carLabel;

@property (nonatomic, strong)UIButton *productLocationButton;

@property (nonatomic, strong)UITextField *detailLocationLabel;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)UIButton *saveButton;


@end

@implementation SPSZ_chu_jinHuoLuRuViewController

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"货品信息",@"货品名称",@"货品数量/重量",@"运输信息/车辆牌照",@"来源产地",@"详细地址",@"拍照留证", nil];
    }
    return _titleArray;
}


- (UIButton *)productLocationButton{
    if (!_productLocationButton) {
        _productLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _productLocationButton.frame = CGRectMake(110, 0, MainScreenWidth - 120, _height);
        [_productLocationButton setTitle:@"请选择" forState:UIControlStateNormal];
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
        _saveButton.layer.cornerRadius = 30;
        _saveButton.layer.masksToBounds = YES;
        [_saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton gradientButtonWithSize:CGSizeMake(MainScreenWidth/3*2, 60) colorArray:@[[ProgramColor RGBColorWithRed:33 green:211 blue:255 alpha:0.94],[ProgramColor RGBColorWithRed:67 green:130 blue:255 alpha:0.94]] percentageArray:@[@(1),@(0)] gradientType:GradientFromTopToBottom];
    }
    return _saveButton;
}

- (UITextField *)productNameLabel
{
    if (!_productNameLabel) {
        _productNameLabel = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, MainScreenWidth - 120, _height)];
        _productNameLabel.placeholder = @"请输入";
        _productNameLabel.delegate = self;
        _productNameLabel.tintColor = [UIColor redColor];
        _productNameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _productNameLabel;
}

- (UITextField *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UITextField alloc]initWithFrame:CGRectMake(140, 0, MainScreenWidth - 150, _height)];
        _numberLabel.placeholder = @"请输入";
        _numberLabel.delegate = self;
        _numberLabel.tintColor = [UIColor redColor];
        _numberLabel.textAlignment = NSTextAlignmentRight;
    }
    return _numberLabel;
}


- (UITextField *)carLabel
{
    if (!_carLabel) {
        _carLabel = [[UITextField alloc]initWithFrame:CGRectMake(180, 0, MainScreenWidth - 190, _height)];
        _carLabel.placeholder = @"请输入";
        _carLabel.delegate = self;
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
        [self setUpViewWith:6 text: @"（请上传营业执照和相关证件）"];
        
        
        
//        UIView *bottom = [[UIView alloc]initWithFrame:CGRectMake(0, _height *7, MainScreenWidth, 0.6* (MainScreenWidth - 20) *4 +70)];
//        bottom.backgroundColor = [UIColor redColor];
//        [_mainView addSubview:bottom];
        
        [_mainView addSubview:self.collectionView];
        
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
        [_collectionView registerClass:[SPSZ_chu_luRuCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectionView;
}

- (void)backToUpView
{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"进货记录";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backToUpView)];
    self.navigationItem.leftBarButtonItem = item;
    
    self.height = 50;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.saveButton];
}


- (void)setUpViewWith:(NSInteger)number text:(NSString *)text{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _height*number, MainScreenWidth, _height)];
   
    CGFloat w = 100;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, _height)];
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
            [view addSubview:self.numberLabel];
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
    return noteStr;
    
}

- (void)productLocationButtonAction:(UIButton *)button
{
    [CZHAddressPickerView areaPickerViewWithProvince:self.province city:self.city area:self.area areaBlock:^(NSString *province, NSString *city, NSString *area) {
        KRWeakSelf;
        weakSelf.province = province;
        weakSelf.city = city;
        weakSelf.area = area;
        [button setTitle:[NSString stringWithFormat:@"%@%@%@",province,city,area] forState:UIControlStateNormal];
    }];
}

- (void)saveButtonAction:(UIButton *)button
{
    
}



#pragma mark --- delegate、dataSource ---
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}
#pragma mark --- 返回cell ---
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPSZ_chu_luRuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // cell.backgroundColor = [UIColor yellowColor];
    //    cell.picImageView.image = self.modelArray[indexPath.row];
//    cell.timelabel.text = [NSString stringWithFormat:@"   第%03ld个",indexPath.row + 1];
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
    // 第一个参数: 上
    // 第二个参数: 左
    // 第三个参数: 下
    // 第四个参数: 右
    return UIEdgeInsetsMake(10, 5, 10, 5);
}



#pragma mark --- item点击的方法 ---
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"第%ld 分区  第 %ld 个",indexPath.section,indexPath.row);
    //    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //    RootCollectionViewController *secondCollectionView = [[RootCollectionViewController alloc]initWithCollectionViewLayout:flowLayout];
    //    [self.navigationController pushViewController:secondCollectionView animated:YES];
    
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
