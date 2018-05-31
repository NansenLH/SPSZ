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

#import "KRScanBaseController.h"


@interface SPSZ_saoMa_ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong)UIImageView *mainImageView;

@property (nonatomic, strong)SPSZ_ShowTicketView *showView;


@property (nonatomic, strong)SPSZ_suo_shouDongRecordModel *model;

@end

@implementation SPSZ_saoMa_ViewController

- (UIImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"retailer_scan"]];
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
    self.buttonImageType = NO;
    
    UIView *yy = [[UIView alloc]initWithFrame:CGRectMake(0, 30, MainScreenWidth, MainScreenHeight -236-[ProgramSize bottomHeight])];
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
    if (!self.model) {
        KRScanBaseController *vc = [[KRScanBaseController alloc] init];
        vc.hasNavigationBar = YES;
        KRWeakSelf;
        [vc setGetQRStringBlock:^(NSString *qrString) {
            [weakSelf getQRString:qrString];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self sureUpload];
    }

    
    
}


- (void)getQRString:(NSString *)qrString
{
    KRWeakSelf;
    weakSelf.showView = [[SPSZ_ShowTicketView alloc]init];
    weakSelf.showView.hasHuabian = NO;
    [weakSelf.mainImageView addSubview:weakSelf.showView];
    [weakSelf.showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(20);
    }];
    [SPSZ_suo_orderNetTool getDaYinDataWithPrintcode:qrString successBlock:^(SPSZ_suo_shouDongRecordModel *model) {
        weakSelf.showView.model = model;
        weakSelf.model = model;
        
        [weakSelf saoMaSetType:YES];
        
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        [weakSelf reSaoMa];
        [KRAlertTool alertString:errorMessage];
    } failureBlock:^(NSString *failure) {
        [weakSelf reSaoMa];
        [KRAlertTool alertString:failure];
    }];
}



- (void)reSaoMa{
    self.buttonImageType = NO;
    [self.showView removeFromSuperview];
    _mainImageView.image = [UIImage imageNamed:@"retailer_scan"];
    
    [self saoMaSetType:NO];
}


- (void)sureUpload
{
    if (!self.model) {
        [KRAlertTool alertString:@"请先扫码!"];
        return;
    }
    KRWeakSelf;
    [SPSZ_suo_orderNetTool shangChuanWith:@"0" model:self.model successBlock:^(NSString *string) {
        UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:@"提示" message:@"上传成功!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf reSaoMa];
            weakSelf.model = nil;
            [weakSelf saoMaSetType:NO];
        }];
        [actionSheetController addAction:okAction];
        
        [weakSelf presentViewController:actionSheetController animated:YES completion:nil];
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        [KRAlertTool alertString:errorMessage];
    } failureBlock:^(NSString *failure) {
        [KRAlertTool alertString:failure];
    }];
}


- (void)saoMaSetType:(BOOL)type
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(saoMabuttonImageType:)]) {
        [self.delegate saoMabuttonImageType:type];
    }
}


@end
