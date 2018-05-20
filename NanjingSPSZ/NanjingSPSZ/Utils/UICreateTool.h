//
//  UICreateTool.h
//  MyAlertTool
//
//  Created by nansen on 2016/12/8.
//  Copyright © 2016年 nansen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UICreateTool : NSObject


#pragma mark - ======== UIView ========
+ (UIView *)viewWithBgColor:(UIColor *)backgroundColor;

+ (UIView *)viewWithBgColor:(UIColor *)backgroundColor
               cornerRadius:(CGFloat)cornerRadius
                borderColor:(UIColor *)borderColor
                borderWidth:(CGFloat)borderWidth;

#pragma mark - ======== UILabel ========
+ (UILabel *)labelWithFont:(UIFont *)font
                      text:(NSString *)text
                 textColor:(UIColor *)textColor
             textAlignment:(NSTextAlignment)textAlignment;

+ (UILabel *)labelWithFont:(UIFont *)font
                      text:(NSString *)text
                 textColor:(UIColor *)textColor
             textAlignment:(NSTextAlignment)textAlignment
             numberOfLines:(NSInteger)numberOfLinews;

+ (UILabel *)labelWithBgColor:(UIColor *)bgColor
                         font:(UIFont *)font
                         text:(NSString *)text
                    textColor:(UIColor *)textColor
                textAlignment:(NSTextAlignment)textAlignment
                numberOfLines:(NSInteger)numberOfLinews
                lineBreakMode:(NSLineBreakMode)lineBreaeMode
               attributedText:(NSAttributedString *)attributedText
       userInteractionEnabled:(BOOL)userInteractionEnabled
         highlightedTextColor:(UIColor *)highlightedColor;

#pragma mark - ======== UIButton ========

/**
 @param title 文字
 @param font 文字字体（默认为16）
 @param titleColor 文字颜色（默认为黑色）
 @param imageUrl 图片地址
 @param backgroundColor 背景色
 @return UIButton
 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                         font:(UIFont *)font
                   titleColor:(UIColor *)titleColor
                     imageUrl:(NSString *)imageUrl
              backgroundColor:(UIColor *)backgroundColor;


#pragma mark - ======== UIImageView ========

/**
 @param imageUrl 图片地址
 @param cornerRadius 圆角（不需要的话设置为0）
 @return UIImageView
 */
+ (UIImageView *)imageViewWithImageUrl:(NSString *)imageUrl
                          cornerRadius:(CGFloat)cornerRadius;


#pragma mark - ======== UITextField ========
+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder
                             keyboardType:(UIKeyboardType)keyboardType
                          clearButtonMode:(UITextFieldViewMode)clearButtonMode
                          secureTextEntry:(BOOL)secureTextEntry
                     placeholderLabelFont:(UIFont *)placeholderLabelFont
                              borderStyle:(UITextBorderStyle)borderStyle;

@end
