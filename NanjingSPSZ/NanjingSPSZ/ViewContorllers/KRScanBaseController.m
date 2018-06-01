//
//  KRScanBaseController.m
//  ZHSH-V1.0
//
//  Created by nansen on 16/4/27.
//  Copyright © 2016年 NansenLu. All rights reserved.
//

#import "KRScanBaseController.h"

#import "KRAudioTool.h"

// 设置扫描框的宽高
static NSInteger LUScanWidth = 260;

#define LUWidth MainScreenWidth

#define LUHeight MainScreenHeight

// 设置扫描框距离底部的距离
#define LUBottomPedding ((LUHeight - LUScanWidth)/2.0)

//遮盖的颜色
#define LUShadowColor [UIColor colorWithWhite:0.000 alpha:0.550]



@interface KRScanBaseController () <AVCaptureMetadataOutputObjectsDelegate>
{
    int _num;
    BOOL _upOrdown;
    NSTimer *_timer;
}

////一个捕捉视频流的设备  AVMediaTypeVideo视频
//@property (nonatomic, strong) AVCaptureDevice *device;

//// 识别二维码之后的输出数据
//@property (nonatomic, strong) AVCaptureMetadataOutput *output;



// 预览扫描视频的 layer
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *previewLayer;

// 设置扫描的线
@property (nonatomic, weak) UIImageView *scanLine;


@end

@implementation KRScanBaseController
- (void)backToUpView
{
    [self.navigationController popViewControllerAnimated:true];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backToUpView)];
    self.navigationItem.leftBarButtonItem = item;
    
    self.edgesForExtendedLayout =  UIRectEdgeNone;
    
    // 设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏的标题
    self.navigationItem.title = @"扫描二维码";
    
    // 设置扫码硬件
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusAuthorized) {
        [self setupDevice];
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setupDevice];
                });
            }
            else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self denyAction];
                });
            }
        }];
    }
    else {
        [self denyAction];
    }
}

- (void)setupDevice
{
    [self configCapture];
    
    // 添加子控件
    [self configSubViews];
    
    // 开始扫描
    [self setUpCamera];
}

- (void)denyAction
{
    [KRAlertTool alertString:@"请在设置中打开相机权限!"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setUpCamera];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_session stopRunning];
}

// 开始捕捉视频
- (void)setUpCamera
{
    if (_session) {
        [_session startRunning];
    }
}


#pragma mark ============ 设置扫码硬件 =============
- (void)configCapture {
    
    NSError *error = nil;
    
    // Device
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc] init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //判断有没有获得输入流,如果没有打印错误信息
    if (!input) {
        NSLog(@"%@", [error localizedFailureReason]);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备没有可用摄像头或摄像头已损坏" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }

    
    // Session 输入输出流中间处理的桥梁
    _session = [[AVCaptureSession alloc] init];
    
    //设置捕捉到的输出流的分辨率:高(1080p)
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    //桥接输入,输出流
    if ([_session canAddInput:input]){
        [_session addInput:input];
    }
    if ([_session canAddOutput:output]){
        [_session addOutput:output];
    }
    
    self.input = input;
    
    // 条码类型 AVMetadataObjectTypeQRCode(二维码,条形码)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // Preview 预览视频的layer
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    
    //layer的填充方式
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    previewLayer.frame = CGRectMake(0, 0, LUWidth, LUHeight);
    
    //将预览视频的layer插入到self.view.layer的上面.显示出来
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    self.previewLayer = previewLayer;
    
    //计算 rectOfInterest :代表我们识别二维码的区域.
    //圆角的二维码和被挡住一部分的二维码特别难以识别,缩小识别方位可以提升识别速度.
    //注意x,y交换位置
    //_output 的rectOfInterest,是以图片的形式识别二维码的,图片是横向的,而手机屏幕是竖着的,所以x和y是反向的,宽和高也是反向的.(x,y,width,height)四个值得范围都是0-1之间,按照比例进行换算.
    [output setRectOfInterest:CGRectMake((LUHeight - LUBottomPedding - LUScanWidth)/ LUHeight ,(LUWidth - LUScanWidth) / 2/ LUWidth , LUScanWidth / LUHeight , LUScanWidth / LUWidth)];
    
}


#pragma mark ============= 添加子控件 =============
- (void)configSubViews
{
    // 创建遮盖
    CGFloat topHeight = self.hasNavigationBar == NO ? (LUHeight - LUScanWidth - LUBottomPedding) : (LUHeight - LUScanWidth - LUBottomPedding - 64);
    CGFloat bottomY = self.hasNavigationBar == NO ? (LUHeight - LUBottomPedding) : (LUHeight - LUBottomPedding - 64);
    
    //新建一个layer,遮住左边
    [self createBackLayerWithFrame:CGRectMake(0, 0, (LUWidth - LUScanWidth) / 2, LUHeight)];
    //遮住右边
    [self createBackLayerWithFrame:CGRectMake((LUWidth - LUScanWidth) / 2 + LUScanWidth, 0, (LUWidth - LUScanWidth) / 2, LUHeight)];
    //遮住上边
    [self createBackLayerWithFrame:CGRectMake((LUWidth - LUScanWidth) / 2, 0, LUScanWidth, topHeight)];
    //遮住下边
    [self createBackLayerWithFrame:CGRectMake((LUWidth - LUScanWidth) / 2, bottomY, LUScanWidth, LUBottomPedding)];
    
    
    
    
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-(LUBottomPedding - 40));
        make.height.equalTo(40);
        make.centerX.equalTo(0);
        make.width.equalTo(120);
    }];
    label.text = @"将取景框对准二维码即可自动扫描";
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 2;
    
    
//    // 3.创建打开闪光灯按钮
//    UIButton *shanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [shanBtn setTitle:@"闪光灯" forState:UIControlStateNormal];
//    [self.view addSubview:shanBtn];
//    [shanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(-48);
//        make.left.equalTo(16);
//        make.height.equalTo(38);
//        make.width.equalTo(60);
//    }];
    
//    [shanBtn handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
//        
//        // 手电筒开关
//        AVCaptureTorchMode torch = self.input.device.torchMode;
//        switch (_input.device.torchMode) {
//            case AVCaptureTorchModeAuto:
//                break;
//            case AVCaptureTorchModeOff:
//                torch = AVCaptureTorchModeOn;
//                break;
//            case AVCaptureTorchModeOn:
//                torch = AVCaptureTorchModeOff;
//                break;
//            default:
//                break;
//        }
//        
//        //在配置摄像头的相关属性之前，必须先调用lockForConfiguration：方法执行锁定，配置完成后调用unlockForConfiguration方法解锁。
//        [_input.device lockForConfiguration:nil];
//        _input.device.torchMode = torch;
//        [_input.device unlockForConfiguration];
//    }];
    
    
//    // 4.创建获取自己二维码的按钮
//    UIButton *myQRCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [myQRCodeBtn setTitle:@"我的二维码" forState:UIControlStateNormal];
//    [self.view addSubview:myQRCodeBtn];
//    [myQRCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(-48);
//        make.right.equalTo(-16);
//        make.height.equalTo(38);
//        make.width.equalTo(60);
//    }];
//    
//    [myQRCodeBtn handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
//        
//        LUMyQRCodeController *myQRCodeVC = [[LUMyQRCodeController alloc] init];
//        
//        [self.navigationController pushViewController:myQRCodeVC animated:YES];
//        
//    }];
    
    
    
    // 5.创建扫描区域的imageview
    UIImageView *borderImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ScanBorder"]];
    [self.view addSubview:borderImage];
    [borderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.bottom.equalTo(-LUBottomPedding);
        make.size.equalTo(CGSizeMake(LUScanWidth, LUScanWidth));
    }];
    
    // 6.创建上下扫描的线
    UIImageView *scanLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_line"]];
    scanLine.contentMode = UIViewContentModeScaleAspectFill;
    scanLine.clipsToBounds = YES;
    [borderImage addSubview:scanLine];
    scanLine.frame = CGRectMake(5, 0, LUScanWidth-10, 10);
    self.scanLine = scanLine;
    
    _upOrdown = NO;
    _num = 0;
    
    //执行动画
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(animation) userInfo:nil repeats:YES];
}

//执行的动画
- (void)animation {
    if (_upOrdown == NO) {
        _num ++;
        CGPoint center = _scanLine.center;
        center.y += 2;
        _scanLine.center = center;
        if (2 * _num == LUScanWidth - 20) {
            _upOrdown = YES;
        }
    }
    else {
        _num --;
        CGPoint center = _scanLine.center;
        center.y -= 2;
        _scanLine.center = center;
        if (_num == 2) {
            _upOrdown = NO;
        }
    }
}



#pragma mark ============= 添加遮盖 =============
- (void)createBackLayerWithFrame:(CGRect)frame{
    CALayer *backLayer = [CALayer layer];
    backLayer.frame = frame;
    backLayer.backgroundColor = LUShadowColor.CGColor;
    [self.view.layer addSublayer:backLayer];
}



#pragma mark - AVCaptureMetadataOutputObjectsDelegate
// 当扫描到数据的时候,调用代理的方法,获取数据,显示在 resultLabel上
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if (metadataObjects != nil && [metadataObjects count] > 0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        [_session stopRunning];
        // 操作获得的string
        [self operationWithString:stringValue];
        
    }
    else {
        
    }
}

#pragma mark ============= 这里对获得的string进行操作 =============
- (void)operationWithString:(NSString *)string
{
    NSLog(@"base扫描到的数据是: %@", string);
    [KRAudioTool playSound:@"QRCodeSound.wav"];
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.getQRStringBlock) {
        self.getQRStringBlock(string);
    }
    
}

- (void)dealloc {
    
    [_session stopRunning];
}


//#pragma mark ---- UIAlertViewDelegate ----
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag == 333) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
