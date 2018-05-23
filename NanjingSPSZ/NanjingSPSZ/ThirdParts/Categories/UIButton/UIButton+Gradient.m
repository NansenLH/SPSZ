//
//  UIButton+Gradient.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/23.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "UIButton+Gradient.h"

@implementation UIButton (Gradient)

- (UIButton *)gradientButtonWithSize:(CGSize)btnSize colorArray:(NSArray *)clrs percentageArray:(NSArray *)percent gradientType:(GradientType)type {
    
    UIImage *backImage = [[UIImage alloc] createImageWithSize:btnSize gradientColors:clrs percentage:percent gradientType:type];
    
    [self setBackgroundImage:backImage forState:UIControlStateNormal];
    
    return self;
}

@end
