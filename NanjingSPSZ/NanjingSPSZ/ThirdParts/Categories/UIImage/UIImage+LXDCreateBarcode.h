//
//  UIImage+LXDCreateBarcode.h

//  Copyright © 2015年 cnpayany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LXDCreateBarcode)

/**
 *  生成宽高为100的黑色的二维码图片
 */
+ (UIImage *)imageOfQRFromURL: (NSString *)networkAddress;


/**
 *  生成黑色的二维码
 *
 *  @param networkAddress 链接地址
 *  @param codeSize       二维码的宽高
 *
 *  @return 二维码图片
 */
+ (UIImage *)imageOfQRFromURL: (NSString *)networkAddress
                     codeSize: (CGFloat)codeSize;



/**
 *  生成二维码:颜色(16进制)
 *
 *  @param networkAddress 链接地址
 *  @param codeSize       二维码的宽高
 *
 *  @return 二维码图片
 */
+ (UIImage *)imageOfQRFromURL: (NSString *)networkAddress
                     codeSize: (CGFloat)codeSize
                          red: (NSUInteger)red
                        green: (NSUInteger)green
                         blue: (NSUInteger)blue;




/**
 *  生成二维码:颜色(16进制)
 *
 *  @param networkAddress 链接地址
 *  @param codeSize       二维码的宽和高
 *  @param insertImage    中间的image
 *
 *  @return 二维码图片
 */
+ (UIImage *)imageOfQRFromURL: (NSString *)networkAddress
                     codeSize: (CGFloat)codeSize
                          red: (NSUInteger)red
                        green: (NSUInteger)green
                         blue: (NSUInteger)blue
                  insertImage: (UIImage *)insertImage;



/**
 *  生成二维码:颜色(16进制)
 *
 *  @param networkAddress 链接地址
 *  @param codeSize       二维码的宽和高
 *  @param insertImage    中间插入的image
 *  @param roundRadius    image的圆角
 *
 *  @return 二维码图片
 */
+ (UIImage *)imageOfQRFromURL: (NSString *)networkAddress
                     codeSize: (CGFloat)codeSize
                          red: (NSUInteger)red
                        green: (NSUInteger)green
                         blue: (NSUInteger)blue
                  insertImage: (UIImage *)insertImage
                  roundRadius: (CGFloat)roundRadius;


@end
