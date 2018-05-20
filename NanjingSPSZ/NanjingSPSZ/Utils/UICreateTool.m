//
//  UICreateTool.m
//  MyAlertTool
//
//  Created by nansen on 2016/12/8.
//  Copyright © 2016年 nansen. All rights reserved.
//

#import "UICreateTool.h"

@implementation UICreateTool

#pragma mark - ======== UIView ========
+ (UIView *)viewWithBgColor:(UIColor *)backgroundColor
{
    return [self viewWithBgColor:backgroundColor cornerRadius:0 borderColor:backgroundColor borderWidth:0];
}

+ (UIView *)viewWithBgColor:(UIColor *)backgroundColor
               cornerRadius:(CGFloat)cornerRadius
                borderColor:(UIColor *)borderColor
                borderWidth:(CGFloat)borderWidth
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = backgroundColor ? backgroundColor : [UIColor whiteColor];
    view.layer.cornerRadius = cornerRadius;
    view.layer.borderColor = borderColor.CGColor;
    view.layer.borderWidth = borderWidth;
    view.layer.masksToBounds = YES;
    return view;
}

#pragma mark - ======== UILabel ========
+(UILabel *)labelWithFont:(UIFont *)font
                     text:(NSString *)text
                textColor:(UIColor *)textColor
            textAlignment:(NSTextAlignment)textAlignment
{
    return [self labelWithBgColor:nil
                             font:font text:text
                        textColor:textColor
                    textAlignment:textAlignment
                    numberOfLines:1
                    lineBreakMode:NSLineBreakByWordWrapping
                   attributedText:nil
           userInteractionEnabled:YES
             highlightedTextColor:textColor];
}

+ (UILabel *)labelWithFont:(UIFont *)font
                      text:(NSString *)text
                 textColor:(UIColor *)textColor
             textAlignment:(NSTextAlignment)textAlignment
             numberOfLines:(NSInteger)numberOfLinews
{
    return [self labelWithBgColor:nil
                             font:font text:text
                        textColor:textColor
                    textAlignment:textAlignment
                    numberOfLines:numberOfLinews
                    lineBreakMode:NSLineBreakByWordWrapping
                   attributedText:nil
           userInteractionEnabled:YES
             highlightedTextColor:textColor];
}

+ (UILabel *)labelWithBgColor:(UIColor *)bgColor
                         font:(UIFont *)font
                         text:(NSString *)text
                    textColor:(UIColor *)textColor
                textAlignment:(NSTextAlignment)textAlignment
                numberOfLines:(NSInteger)numberOfLinews
                lineBreakMode:(NSLineBreakMode)lineBreaeMode
               attributedText:(NSAttributedString *)attributedText
       userInteractionEnabled:(BOOL)userInteractionEnabled
         highlightedTextColor:(UIColor *)highlightedColor
{
    UILabel *label = [[UILabel alloc] init];
    label.font = font ? font : [UIFont systemFontOfSize:16];
    label.text = text;
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLinews;
    label.backgroundColor = bgColor ? bgColor : [UIColor clearColor];
    
    label.textColor = textColor;
    
    label.highlightedTextColor = highlightedColor ? highlightedColor : [UIColor blackColor];
    
    label.lineBreakMode = lineBreaeMode;
    if (attributedText) {
        label.attributedText = attributedText;
    }
    label.userInteractionEnabled = userInteractionEnabled;
    return label;
}

#pragma mark - ======== UIButton ========
+(UIButton *)buttonWithTitle:(NSString *)title
                        font:(UIFont *)font
                  titleColor:(UIColor *)titleColor
                    imageUrl:(NSString *)imageUrl
             backgroundColor:(UIColor *)backgroundColor
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }else{
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    button.titleLabel.font = font ? font : [UIFont systemFontOfSize:16];
    
    if (imageUrl) {
        [button setImage:[UIImage imageNamed:imageUrl] forState:UIControlStateNormal];
    }
    
    button.backgroundColor = backgroundColor ;
    return button;
}

#pragma mark - ======== UIImageView ========
+ (UIImageView *)imageViewWithImageUrl:(NSString *)imageUrl
                          cornerRadius:(CGFloat)cornerRadius{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageUrl];
    if (cornerRadius != 0) {
        imageView.layer.cornerRadius = cornerRadius;
        imageView.layer.masksToBounds = YES;
    }
    
    return imageView;
}

#pragma mark - ======== UITextField ========
+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder
                             keyboardType:(UIKeyboardType)keyboardType
                          clearButtonMode:(UITextFieldViewMode)clearButtonMode
                          secureTextEntry:(BOOL)secureTextEntry
                     placeholderLabelFont:(UIFont *)placeholderLabelFont
                              borderStyle:(UITextBorderStyle)borderStyle{
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = placeholder;
    textField.keyboardType = keyboardType;
    textField.clearButtonMode = clearButtonMode;
    textField.secureTextEntry = secureTextEntry;
    [textField setValue:placeholderLabelFont forKeyPath:@"_placeholderLabel.font"];
    textField.borderStyle = borderStyle;
    return textField;
}

@end
