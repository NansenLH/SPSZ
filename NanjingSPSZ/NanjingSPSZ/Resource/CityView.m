//
//  CityView.m
//  cityDemo
//
//  Created by yyx on 2018/5/28.
//  Copyright © 2018年 liren. All rights reserved.
//

#import "CityView.h"

@interface CityView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) UIPickerView *mainPickerView;
@property (nonatomic, strong) UIView *toolView;
///省
@property (nonatomic, strong) NSArray *provice;
///市
@property (nonatomic, strong) NSArray *city;
///区
@property (nonatomic, strong) NSArray *area;

//每个轮子选中的行
@property (assign) NSInteger component1;
@property (assign) NSInteger component2;
@property (assign) NSInteger component3;
@end

@implementation CityView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgView = [[UIView alloc] initWithFrame:frame];
        self.bgView.backgroundColor = [UIColor blackColor];
        self.bgView.alpha = 0.3;
        [self addSubview:self.bgView];
        self.bgView.hidden = true;
        
        [self createMainUI:frame];
    }
    return self;
}

- (void)createMainUI:(CGRect)frame
{
    self.toolView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height, frame.size.width, 240)];
    self.toolView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.toolView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(15, 5, 60, 30);
    leftBtn.clipsToBounds = true;
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    leftBtn.layer.cornerRadius = 5;
    leftBtn.layer.borderWidth = 1;
    leftBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [self.toolView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(self.frame.size.width - 75, 5, 60, 30);
    rightBtn.clipsToBounds = true;
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    rightBtn.layer.cornerRadius = 5;
    rightBtn.layer.borderWidth = 1;
    rightBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [self.toolView addSubview:rightBtn];
    
    self.mainPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, frame.size.width, 200)];
    self.mainPickerView.backgroundColor = [UIColor whiteColor];
    self.mainPickerView.delegate = self;
    self.mainPickerView.dataSource = self;
    [self.toolView addSubview:self.mainPickerView];
}

//返回有几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

//返回指定列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0) {
        return self.provice.count;;
    }else if(component == 1){
        return self.city.count;
    }
    
    return self.area.count;
}

//返回指定列，行的高度，就是自定义行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

//返回指定列的宽度
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component==0) {
        return  self.frame.size.width/3;
    } else if(component==1){
        return  self.frame.size.width/3;
    }
    return  self.frame.size.width/3;
}

// 自定义指定列的每行的视图，即指定列的每行的视图行为一致
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (!view){
        view = [[UIView alloc]init];
    }
    
    if (component == 0){
        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/3, 40)];
        text.textAlignment = NSTextAlignmentCenter;
        text.text = self.provice[row][@"areaName"];
        text.font = [UIFont systemFontOfSize:16];
        [view addSubview:text];
    }else if (component == 1){
        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/3, 40)];
        text.textAlignment = NSTextAlignmentCenter;
        text.text = self.city[row][@"areaName"];
        text.font = [UIFont systemFontOfSize:16];
        [view addSubview:text];
    }else if (component == 2){
        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/3, 40)];
        text.textAlignment = NSTextAlignmentCenter;
        text.text = self.area[row][@"areaName"];
        text.font = [UIFont systemFontOfSize:16];
        [view addSubview:text];
    }
    
    
    //隐藏上下直线
    [self.mainPickerView.subviews objectAtIndex:1].backgroundColor = [UIColor clearColor];
    [self.mainPickerView.subviews objectAtIndex:2].backgroundColor = [UIColor clearColor];
    return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0){
        self.city = self.provice[row][@"cities"];
        self.area = self.city[0][@"counties"];
        
        [self.mainPickerView reloadComponent:1];
        [self.mainPickerView reloadComponent:2];
        [self.mainPickerView selectRow:0 inComponent:1 animated:YES];
        [self.mainPickerView selectRow:0 inComponent:2 animated:YES];
        
        self.component1 = row;
        self.component2 = 0;
        self.component3 = 0;
    }else if (component == 1){
        self.area = self.city[row][@"counties"];
        [self.mainPickerView reloadComponent:2];
        [self.mainPickerView selectRow:0 inComponent:2 animated:YES];
        
        self.component2 = row;
        self.component3 = 0;
    }else if (component == 2){
        self.component3 = row;
    }
}

//初始化页面的数据
- (void)setCityList:(NSArray *)cityList
{
    self.component1 = 0;
    self.component2 = 0;
    self.component3 = 0;
    
    self.provice = cityList;
    self.city = self.provice[0][@"cities"];    
    self.area = self.city[0][@"counties"];
    [self.mainPickerView reloadAllComponents];
}

//取消按钮
- (void)leftAction
{
    if (self.getSelectCityBlock) {
        self.getSelectCityBlock(nil);
    }
    
    //隐藏地址选择器
    [self hiddenPickerView];
}

//确定按钮
- (void)rightAction
{
    NSString *name = @"";
    NSString *nameId = @"";
    
    NSDictionary *pDic = self.provice[_component1];
    name = pDic[@"areaName"];
    nameId = pDic[@"areaId"];
    
    NSDictionary *cDic = pDic[@"cities"][_component2];
    name = [NSString stringWithFormat:@"%@ %@",name,cDic[@"areaName"]];
    nameId = [NSString stringWithFormat:@"%@ %@",nameId,cDic[@"areaId"]];
    
    NSDictionary *aDic = cDic[@"counties"][_component3];
    name = [NSString stringWithFormat:@"%@ %@",name,aDic[@"areaName"]];
    nameId = [NSString stringWithFormat:@"%@ %@",nameId,aDic[@"areaId"]];
    
    NSMutableDictionary *cityInfoDic = [NSMutableDictionary dictionary];
    [cityInfoDic setValue:name forKey:@"name"];
    [cityInfoDic setValue:nameId forKey:@"Id"];
    if (self.getSelectCityBlock) {
        self.getSelectCityBlock(cityInfoDic);
    }
    
    //隐藏地址选择器
    [self hiddenPickerView];
}

- (void)showCityListViewInView:(UIView *)view
{
    if (view) {
        [view addSubview:self];
        [UIView animateWithDuration:0.3 animations:^{
            self.toolView.frame = CGRectMake(0, self.frame.size.height - 240, self.frame.size.width, 240);
        } completion:^(BOOL finished) {
            self.bgView.hidden = false;
        }];
    }
    
}

//隐藏地址选择器
- (void)hiddenPickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.toolView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 240);
    } completion:^(BOOL finished) {
        self.bgView.hidden = true;
        [self removeFromSuperview];
    }];
}
@end
