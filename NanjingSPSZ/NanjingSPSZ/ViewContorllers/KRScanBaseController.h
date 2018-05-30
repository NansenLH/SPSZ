//
//  KRScanBaseController.h
//  ZHSH-V1.0
//
//  Created by nansen on 16/4/27.
//  Copyright © 2016年 NansenLu. All rights reserved.
//

#import <UIKit/UIKit.h>

//需要基础的多媒体支持
#import <AVFoundation/AVFoundation.h>


@interface KRScanBaseController : UIViewController

// 从硬件摄像头输入数据
@property (nonatomic, weak) AVCaptureDeviceInput *input;

// Session 输入输出流中间处理的桥梁
@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, assign) BOOL hasNavigationBar;

@property (nonatomic, copy) void(^getQRStringBlock)(NSString *qrString);
/**
 *  重写该方法,完成对扫描结果 string 的操作
 */
- (void)operationWithString:(NSString *)string;




@end
