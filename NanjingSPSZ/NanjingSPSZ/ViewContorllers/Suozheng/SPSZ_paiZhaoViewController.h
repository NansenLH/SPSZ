//
//  SPSZ_paiZhaoViewController.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/22.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "BaseViewController.h"


@protocol paiZhaoSuccessDelegate <NSObject>

@optional

- (void)buttonImageType:(BOOL)type;

@end

@interface SPSZ_paiZhaoViewController : BaseViewController

@property(nonatomic, weak) id<paiZhaoSuccessDelegate>delegate;

// 重新录入
- (void)reEnterAction;

// 拍照
- (void)takePhotoAction;

// 确认上传
- (void)paiZhaoUpload;

/**
 * yes 确认上传
 * no 扫码上传
 */
@property (nonatomic, assign)BOOL buttonImageType;

@end
