//
//  SPSZ_paiZhaoViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/22.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_paiZhaoViewController.h"

#import <Photos/Photos.h>
#import "LUNetHelp.h"
#import "UIImageView+WebCache.h"

#import "SPSZ_suo_orderNetTool.h"
#import "SPSZ_suo_saoMaDetailModel.h"
#import "SPSZ_suo_shouDongRecordModel.h"

@interface SPSZ_paiZhaoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *mainImageView;

@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation SPSZ_paiZhaoViewController



- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (UIImageView *)mainImageView{
    if (!_mainImageView) {
        
        _mainImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"retailer_take_phote"]];
        _mainImageView.frame = CGRectMake(30, 0, MainScreenWidth - 60, MainScreenHeight -264-[ProgramSize bottomHeight]);
        _mainImageView.contentMode = UIViewContentModeScaleAspectFill;
        _mainImageView.clipsToBounds = YES;
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor   = [ UIColor clearColor];
    
    UIView *yy = [[UIView alloc]initWithFrame:CGRectMake(0, 30, MainScreenWidth, MainScreenHeight -236-[ProgramSize bottomHeight])];
    [yy addSubview:self.mainImageView];
    [self.view addSubview:yy];
}


// 重新录入
- (void)reEnterAction
{
    _mainImageView.image = [UIImage imageNamed:@"retailer_take_phote"];
    [self.imageArray removeAllObjects];
    [self gobackImage:NO];
}

// 拍照
- (void)takePhotoAction
{
    if (self.imageArray.count == 0) {
        // 拍照
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusAuthorized) {
            [self takePhoto];
        }
        else if (authStatus == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self alertSettingCameraAuth];
                    });
                }
            }];
        }
        else {
            [self alertSettingCameraAuth];
        }
    }else
    {
        SPSZ_suo_shouDongRecordModel *shouDongModel = [[SPSZ_suo_shouDongRecordModel alloc]init];
        shouDongModel.imgurl = self.imageArray.firstObject;
        
        KRWeakSelf;
        [SPSZ_suo_orderNetTool shangChuanWith:@"1" model:shouDongModel successBlock:^(NSString *string) {
            UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:@"提示" message:@"上传成功!" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf reEnterAction];
            }];
            [actionSheetController addAction:okAction];
            
            [weakSelf presentViewController:actionSheetController animated:YES completion:nil];
        } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
            [KRAlertTool alertString:errorMessage];
        } failureBlock:^(NSString *failure) {
            [KRAlertTool alertString:failure];
        }];
    }
   
}


- (void)takePhoto
{
    UIImagePickerController *ctrl = [[UIImagePickerController alloc] init];
    ctrl.delegate = self;
    ctrl.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:ctrl animated:YES completion:nil];
}





- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (self.imageArray.count == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            // 处理
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            if (image) {
                [self uploadImage:image];
            }
            else {
                NSLog(@"拍照出错");
            }
        }
    }
   
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadImage:(UIImage *)image
{
    KRWeakSelf;
    [LUNetHelp uploadImage:image successBlock:^(NSString *imageURL) {
        
        [weakSelf.imageArray addObject:imageURL];
        
        weakSelf.mainImageView.image = image;
        
        [weakSelf gobackImage:YES];
                
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        [KRAlertTool alertString:errorMessage];
    } failureBlock:^(NSString *failure) {
        [KRAlertTool alertString:failure];
    }];
}


- (void)gobackImage:(BOOL)type
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonImageType:)]) {
        [self.delegate buttonImageType:type];
    }
}



- (void)alertSettingCameraAuth
{
    NSDictionary *mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [mainInfoDictionary objectForKey:@"CFBundleDisplayName"];
    if (!appName) {
        appName = [mainInfoDictionary objectForKey:(NSString *)kCFBundleNameKey];
    }
    NSString * tipTitle = [NSString stringWithFormat:@"请允许\"%@\"使用您的相机", appName];
    NSString * tipMessage = [NSString stringWithFormat:@"您可点击\"去设置\"按钮后将\"相机\"权限打开!"];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:tipTitle message:tipMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:settingURL]) {
            [[UIApplication sharedApplication] openURL:settingURL options:@{} completionHandler:nil];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"稍后设置" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
