//
//  SPSZ_saoMa_ViewController.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/22.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "BaseViewController.h"

@protocol saoMaSuccessDelegate <NSObject>

@optional

- (void)saoMabuttonImageType:(BOOL)type;

@end

@interface SPSZ_saoMa_ViewController : BaseViewController

@property(nonatomic, weak) id<saoMaSuccessDelegate>delegate;


- (void)reSaoMa;

- (void)saoMa;

/**
  * yes 确认上传
  * no 扫码上传
 */
@property (nonatomic, assign)BOOL buttonImageType;

@end
