//
//  SPSZ_saoMa_ViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/22.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_saoMa_ViewController.h"

#import "SPSZ_suo_orderNetTool.h"
#import "SPSZ_suoLoginModel.h"

#import "SPSZ_ShowTicketView.h"

#import "LUNetHelp.h"

@interface SPSZ_saoMa_ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong)UIImageView *mainImageView;

@property (nonatomic, strong)SPSZ_ShowTicketView *showView;

@end

@implementation SPSZ_saoMa_ViewController

- (UIImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"retailer_scan"]];
        _mainImageView.frame = CGRectMake(30, 0, MainScreenWidth - 60, MainScreenHeight -264);
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor   = [ UIColor clearColor];

    UIView *yy = [[UIView alloc]initWithFrame:CGRectMake(0, 30, MainScreenWidth, MainScreenHeight -236)];
    [yy addSubview:self.mainImageView];
    
    [self.view addSubview:yy];
    
    
}

- (void)loadInvoice{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)saoMa{
    
    SPSZ_ShowTicketView *showView = [[SPSZ_ShowTicketView alloc]init];
    showView.hasHuabian = NO;
    [self.mainImageView addSubview:showView];
    [showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(20);
    }];
    [SPSZ_suo_orderNetTool getDaYinDataWithPrintcode:@"10012949758109081600" successBlock:^(SPSZ_suo_shouDongRecordModel *model) {
        showView.model = model;
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        
    } failureBlock:^(NSString *failure) {
        
    }];
    
}

- (void)reSaoMa{
    _mainImageView.image = [UIImage imageNamed:@"retailer_scan"];
}



- (void)sureUpload
{
    
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
//    if (self.imageArray.count == 0) {
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//            // 处理
//            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//            if (image) {
//                [self uploadImage:image];
//            }
//            else {
//                NSLog(@"拍照出错");
//            }
//        }
//    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadImage:(UIImage *)image
{
//    [LUNetHelp uploadImage:image successBlock:^(NSString *imageURL) {
//        
//        [self.imageArray addObject:imageURL];
//        
//        self.mainImageView.image = image;
//        //        [self.collectionView reloadData];
//    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
//        [KRAlertTool alertString:errorMessage];
//    } failureBlock:^(NSString *failure) {
//        [KRAlertTool alertString:failure];
//    }];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
