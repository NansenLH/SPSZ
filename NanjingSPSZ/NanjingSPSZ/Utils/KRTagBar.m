//
//  KRTagBar.m
//  smartlife
//
//  Created by Chensai on 2016/12/30.
//  Copyright © 2016年 jingxi. All rights reserved.
//

#import "KRTagBar.h"

static const CGFloat buttonH = 40;

@interface KRTagBar ()<UIScrollViewDelegate>

@property (strong,nonatomic)UIButton *selectedBtn;

@property (nonatomic, strong) NSMutableArray  *buttonArray;
// 标签栏下面的移动块
@property (nonatomic, weak  ) UIView          *lineView;

@property (nonatomic, weak  ) UIView          *btnScrlBeforeView;

@property (nonatomic, weak  ) CALayer         *maskLayer;

@property (nonatomic, assign) CGFloat buttonW;
//区分滑动和点击
@property (nonatomic,assign) BOOL isClick;

@end

@implementation KRTagBar
-(NSMutableArray *)buttonArray
{
    if (!_buttonArray)
    {
        _buttonArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _buttonArray;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.buttonW = MainScreenWidth / 3;
        self.backgroundColor = [UIColor whiteColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        UIView *lineView = [[UIView alloc] init];
        [self addSubview:lineView];
        lineView.width = 60;
        lineView.height = 3;
        lineView.y = buttonH - 3;
        lineView.backgroundColor = [ProgramColor RGBColorWithRed:15 green:96 blue:255];
        self.lineView = lineView;
    }
    return self;
}

-(UIView *)setLabelsWithColor:(UIColor *)color
{
    UIView *view = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:view];
    NSInteger count = self.itemArray.count;
    for (int i = 0; i < count; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.text = self.itemArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = color;
        label.font = [UIFont systemFontOfSize:14];
        label.tag = 500 + i;
        [view addSubview:label];
        label.frame = CGRectMake(i*_buttonW, 0, _buttonW, buttonH);
    }
    return view;
}

-(void)setBeforeViewMask
{
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, _buttonW, buttonH);
    layer.backgroundColor = [UIColor grayColor].CGColor;
    self.btnScrlBeforeView.layer.mask = layer;
    self.maskLayer = layer;
}

-(void)setItemArray:(NSArray *)itemArray
{
    _itemArray = itemArray;
    self.contentSize = CGSizeMake(_buttonW *itemArray.count, buttonH);
    [self setLabelsWithColor:[UIColor darkTextColor]];
    self.btnScrlBeforeView = [self setLabelsWithColor:[ProgramColor RGBColorWithRed:63 green:141 blue:254]];
    [self setBeforeViewMask];
    for (int i = 0; i < itemArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = 500 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button.frame = CGRectMake(i*_buttonW, 0, _buttonW, buttonH);
        [self.buttonArray addObject:button];
    }
}

-(void)buttonClick:(UIButton *)btn
{
    self.isClick = YES;
    [self selectBtn:btn];
    self.isClick = NO;
}

-(void)selectIndex:(NSInteger)index
{
    self.isClick = NO;
    [self selectBtn:self.buttonArray[index]];
}

-(void)selectBtn:(UIButton *)btn
{
    NSInteger index = [self.buttonArray indexOfObject:btn];
    if ([self.tagBarDelegate respondsToSelector:@selector(tagBarDidClickBtn:atIndex:)])
    {
        [self.tagBarDelegate tagBarDidClickBtn:btn atIndex:index];
    }
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    _selectedIndex = index;
    [self buttonScrollViewChangeWithButton:btn];

}

- (void)buttonScrollViewChangeWithButton:(UIButton *)button
{
    if (button)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.lineView.centerx = button.centerx;
            CGRect frame = self.maskLayer.frame;
            frame.origin.x = self.lineView.x;
            self.maskLayer.frame = frame;
        }];
    }

    CGFloat pedding = (button.tag - 500) * button.width - (MainScreenWidth-button.width)/2.0;
    [self configOffSetWithPedding:pedding];
}

-(void)updateContentOffSet:(CGPoint)offSet
{
    if (self.isClick)return;
    CGFloat lineX = offSet.x/(MainScreenWidth/_buttonW)+10;
    self.lineView.x = lineX;
    CGRect frame = self.maskLayer.frame;
    frame.origin.x = self.lineView.x;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.maskLayer.frame = frame;
    [CATransaction commit];
    CGFloat pedding = self.lineView.x-10 - (MainScreenWidth-_buttonW)/2.0;
    [self configOffSetWithPedding:pedding];
}

-(void)configOffSetWithPedding:(CGFloat)pedding
{
    CGFloat a = self.lineView.x-10;
    CGFloat b = (MainScreenWidth-_buttonW)/2.0;
    CGFloat c = self.buttonArray.count * _buttonW-MainScreenWidth;
    CGFloat offSetX = 0;
    if ((a > b) && (pedding < c))
    {
        offSetX = pedding;
    } else if (a < b) {
        offSetX = 0;
    } else if (pedding > c && c>0) {
        offSetX = c;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.contentOffset = CGPointMake(offSetX, 0);
    }];
    
}

@end
