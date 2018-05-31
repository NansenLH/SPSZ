//
//  SPSZ_EditWightView.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/30.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_EditWightView.h"

@interface SPSZ_EditWightView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) NSMutableArray<UIButton *> *buttonArray;

@end


@implementation SPSZ_EditWightView

- (NSMutableArray<UIButton *> *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self configSubviews];
    }
    return self;
}


- (void)configSubviews
{
    CGFloat height = 0;
    
    _unit = @"公斤";
    self.weight = @"0";
    
    self.backgroundColor = [ProgramColor RGBColorWithRed:0 green:0 blue:0 alpha:0.2];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-300);
        make.left.equalTo(30);
        make.right.equalTo(-30);
        make.height.equalTo(150);
    }];
    
    self.textField = [[UITextField alloc] init];
    [bgView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.height.equalTo(30);
    }];
    self.textField.placeholder = @"输入重量/数量";
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.layer.borderColor = [UIColor grayColor].CGColor;
    self.textField.layer.borderWidth = 1;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.delegate = self;
    
    height = 50;
    
    CGFloat btnW = 40;
    CGFloat btnH = 30;
    // 水平个数
    NSInteger horNumber = floor((MainScreenWidth - 80) / btnW);
    NSInteger count = [ProgramConfig unitArray].count;
    // 行数
    NSInteger liens = ceil(count * 1.0 / horNumber);
    CGFloat marginX = (MainScreenWidth - 80 - horNumber*btnW) * 1.0 / (horNumber - 1);
    
    for (int i = 0; i < liens; i++) {
        CGFloat y = 60 + (10 + btnH) * i;
        
        NSInteger jMax = i < (liens-1) ? horNumber : count-(horNumber*i);
        
        for (int j = 0; j < jMax; j++) {
            NSDictionary *dic = [[ProgramConfig unitArray] objectAtIndex:(i*horNumber+j)];
            NSString *title = [dic objectForKey:@"unit"];
            CGFloat x = 10 + (btnW + marginX)*j;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.tag = 235 + (i*horNumber+j);
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:button];
            button.frame = CGRectMake(x, y, btnW, btnH);
            
            [self.buttonArray addObject:button];
            
            if ([title isEqualToString:self.unit]) {
                button.backgroundColor = [ProgramColor RGBColorWithRed:67 green:130 blue:255];
            }
        }
    }
    
    height = 50 + (10 + btnH) *liens + 10;
    UIButton *confrimButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confrimButton setTitle:@"确定" forState:UIControlStateNormal];
    [confrimButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confrimButton.titleLabel.font = [UIFont systemFontOfSize:16];
    confrimButton.backgroundColor = [ProgramColor RGBColorWithRed:67 green:130 blue:255];
    [confrimButton addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    confrimButton.layer.cornerRadius = 4;
    confrimButton.layer.masksToBounds = YES;
    [bgView addSubview:confrimButton];
    [confrimButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(25);
        make.right.equalTo(-25);
        make.top.equalTo(height);
        make.height.equalTo(30);
    }];
    
    height += 45;
    
    [bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(height);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self addGestureRecognizer:tap];
    
}

- (void)setUnit:(NSString *)unit
{
    _unit = unit;
    
    
    for (UIButton *button in self.buttonArray) {
        if ([button.titleLabel.text isEqualToString:unit]) {
            button.backgroundColor = [ProgramColor RGBColorWithRed:67 green:130 blue:255];
        }
        else {
            button.backgroundColor = [UIColor whiteColor];
        }
    }
}

- (void)setWeight:(NSString *)weight
{
    _weight = weight;
    
    if ([weight isEqualToString:@"0"]) {
        self.textField.text = nil;
    }
    else {
        self.textField.text = weight;
    }
    
}


- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(0);
    }];
    [self.textField becomeFirstResponder];
}


- (void)hide
{
    if (self.superview) {
        [self removeFromSuperview];
    }
}

- (void)btnClick:(UIButton *)button
{
    NSDictionary *dic = [[ProgramConfig unitArray] objectAtIndex:(button.tag - 235)];
    self.unit = [dic objectForKey:@"unit"];
}

- (void)confirmClick:(UIButton *)button
{
    NSInteger weight = [self.textField.text integerValue];
    self.weight = [@(weight) stringValue];
    
    if (self.chooseWeightBlock) {
        self.chooseWeightBlock(self.weight, self.unit);
    }
    [self hide];
}




- (void)tapClick:(UITapGestureRecognizer *)tap
{
    if (self.chooseWeightBlock) {
        self.chooseWeightBlock(self.weight, self.unit);
    }
    [self hide];
}


/**
 清空当前的 unit 和 weight
 */
- (void)clear
{
    self.unit = @"公斤";
    self.weight = @"0";
    self.textField.text = nil;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *sub = [NSString stringWithFormat:@"%@%@", textField.text, string];
    if ([sub integerValue] > 9999) {
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.textField.text = [@([textField.text integerValue]) stringValue];
}


@end
