//
//  SPSZ_ChuIndexViewController.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/21.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_ChuIndexViewController.h"
#import "SPSZ_AddGoodsViewController.h"
#import "SPSZ_chu_personalCenterViewController.h"
#import "SPSZ_LoginViewController.h"
#import "SPSZ_chu_jinHuoLuRuViewController.h"

#import "SPSZ_IndexView.h"
#import "SPSZ_ChooseConnectView.h"
#import "SPSZ_ChuSelectedView.h"


#import "SPSZ_DeviceModel.h"


#import "UIButton+Gradient.h"
#import "UIButton+ImageTitleSpacing.h"


#import "PrinterSDK.h"
#import <CoreBluetooth/CoreBluetooth.h>

#import "BaseNavigationController.h"
#import "SPSZ_LoginViewController.h"

#import "SPSZ_ShowTicketView.h"
#import "SPSZ_suo_saoMaDetailModel.h"
#import "SPSZ_suo_shouDongRecordModel.h"

@interface SPSZ_ChuIndexViewController ()<ChooseConnectViewDelegate, CBCentralManagerDelegate, CBPeripheralDelegate>
//@interface SPSZ_ChuIndexViewController ()<ChooseConnectViewDelegate, BluetoothDelegate>
//{
//    NSTimer* mytimer;
//    UIActivityIndicatorView *activityView;
//}

@property (nonatomic, strong) SPSZ_IndexView *indexView;
@property (nonatomic, strong) SPSZ_ChooseConnectView *chooseConnectView;
@property (nonatomic, strong) SPSZ_ChuSelectedView *selectedView;


@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, strong) UIButton *editGoodsButton;
@property (nonatomic, strong) UIButton *personalCenterButton;

@property (nonatomic, assign) BOOL isConnect;

@property (nonatomic, strong) NSMutableArray *selectedArray;

@property (nonatomic, strong) NSMutableArray *deviceArray;

@property (nonatomic, assign) BOOL hasCreate;

// 蓝牙中心管理器
@property (nonatomic, strong) CBCentralManager *centralManager;
// 当前连接的外设
@property (nonatomic, strong) CBPeripheral *peripheral;
// 要使用的特征
@property (nonatomic, strong) CBCharacteristic *characteristic;

@end

@implementation SPSZ_ChuIndexViewController

- (NSMutableArray *)selectedArray
{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}

- (NSMutableArray *)deviceArray
{
    if (!_deviceArray) {
        _deviceArray = [NSMutableArray array];
    }
    return _deviceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configNavigation];
    
    [self configSubViews];

    [self configTabbar];
    
    
//    [self testCode];
}

- (void)testCode
{
    SPSZ_suo_shouDongRecordModel *model = [[SPSZ_suo_shouDongRecordModel alloc] init];
    model.suo_shouDongId = @"10741";
    model.address = @"detail";
    model.printcode = @"1231231221312";
    model.uploaddate = @"2018-05-28 23:27:43";
    model.cityname = @"江苏南京市玄武区";
    model.realname = @"hahah11";
    model.imgurl = @"";
    model.mobile = @"111232312";
    model.companyname = @"dadadadad";
    /**
     "id": 10741,
     "address": "detail",
     "printcode": "",
     "dishes":
     "uploaddate": "2018-05-28 23:27:43",
     "cityname": "江苏南京市玄武区",
     "realname": "hahah",
     "companyname": "gongjin",
     "imgurl": "",
     "mobile": "186"
     */
    SPSZ_suo_saoMaDetailModel *d1 = [[SPSZ_suo_saoMaDetailModel alloc] init];
    d1.amount = @"20";
    d1.addresssource = @"sfafda";
    d1.unit = @"haha";
    d1.objectName = @"water";
    d1.dishid = @"1";
    d1.cityname = @"Beijing";
    
    SPSZ_suo_saoMaDetailModel *d2 = [[SPSZ_suo_saoMaDetailModel alloc] init];
    d2.amount = @"230";
    d2.addresssource = @"s222da";
    d2.unit = @"h1h1";
    d2.objectName = @"cake";
    d2.dishid = @"2";
    d2.cityname = @"Jiangsu";
    

    model.dishes = @[d1, d2, d1, d2, d1, d2];
    
    self.view.backgroundColor = [UIColor redColor];
    
    SPSZ_ShowTicketView *showTicketView = [[SPSZ_ShowTicketView alloc] init];
    [self.view addSubview:showTicketView];
    [showTicketView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(100);
        make.left.equalTo(60);
        make.right.equalTo(-60);
        make.bottom.equalTo(-300);
    }];
    showTicketView.model = model;
    showTicketView.hasHuabian = NO;
    
}


- (void)setIsConnect:(BOOL)isConnect
{
    _isConnect = isConnect;
    
    self.indexView.isConnect = isConnect;
    self.selectedView.isConnect = isConnect;
    
    if (isConnect) {
        [self.centerButton setImage:[UIImage imageNamed:@"printer_white"] forState:UIControlStateNormal];
        [self.centerButton setTitle:@"打印票据" forState:UIControlStateNormal];
        self.indexView.hidden = NO;
        self.selectedView.hidden = YES;
    }
    else {
        [self.centerButton setImage:[UIImage imageNamed:@"quick_connect"] forState:UIControlStateNormal];
        [self.centerButton setTitle:@"立即连接" forState:UIControlStateNormal];
        self.selectedView.hidden = YES;
        self.indexView.hidden = NO;
        [self.selectedArray removeAllObjects];
    }
}


- (void)configNavigation
{
    self.navigationItem.title = @"出证打印";
    
    UIButton *logOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logOutButton setImage:[UIImage imageNamed:@"outlogin_white"] forState:UIControlStateNormal];
    [logOutButton setTitle:@"注销登录" forState:UIControlStateNormal];
    [logOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logOutButton.titleLabel.font = [UIFont systemFontOfSize:13];
    logOutButton.frame = CGRectMake(0, 0, 80, 44);
    logOutButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [logOutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logOutButton];
}

- (void)configSubViews
{
    self.indexView = [[SPSZ_IndexView alloc] init];
    [self.view addSubview:self.indexView];
    [self.indexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(0);
    }];
    [self.indexView.addGoodsButton addTarget:self action:@selector(addGoodsClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.selectedView = [[SPSZ_ChuSelectedView alloc] init];
    [self.view addSubview:self.selectedView];
    [self.selectedView.clearButton addTarget:self action:@selector(clearSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectedView.addMoreGoodsButton addTarget:self action:@selector(addGoodsClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.bottom.equalTo(-66-[ProgramSize bottomHeight]);
    }];
    self.selectedView.hidden = YES;
    
    self.chooseConnectView = [[SPSZ_ChooseConnectView alloc] init];
    self.chooseConnectView.delegate = self;
}

- (void)configTabbar
{
    // 阴影
    UIView *bottomShadowView = [[UIView alloc] init];
    bottomShadowView.backgroundColor = [UIColor whiteColor];
    bottomShadowView.layer.shadowColor = [ProgramColor RGBColorWithRed:0 green:0 blue:0 alpha:0.05].CGColor;
    bottomShadowView.layer.shadowOpacity = 1;
    bottomShadowView.layer.shadowOffset = CGSizeMake(0, -4);
    [self.view addSubview:bottomShadowView];
    
    CGFloat bottomMargin = [ProgramSize isIPhoneX] ? 34 : 0;
    [bottomShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.height.equalTo(66);
        make.bottom.equalTo(0).offset(-bottomMargin);
    }];
    
    // 中间的 button
    UIView *shadowView = [[UIView alloc] init];
    [self.view addSubview:shadowView];
    shadowView.backgroundColor = [UIColor whiteColor];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.width.height.equalTo(100);
        make.bottom.equalTo(0).offset(-bottomMargin-12);
    }];
    shadowView.layer.cornerRadius = 50;
    shadowView.layer.shadowColor = [ProgramColor RGBColorWithRed:67 green:130 blue:255 alpha:0.4].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(0, -3);
    shadowView.layer.shadowOpacity = 1;
    
    UIButton *printButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [printButton setImage:[UIImage imageNamed:@"quick_connect"] forState:UIControlStateNormal];
    [printButton setTitle:@"立即连接" forState:UIControlStateNormal];
    [printButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    printButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [printButton gradientButtonWithSize:CGSizeMake(100, 100)
                             colorArray:[ProgramColor blueGradientColors]
                        percentageArray:@[@(0), @(1)]
                           gradientType:GradientFromTopToBottom];
    printButton.layer.cornerRadius = 50;
    printButton.layer.masksToBounds = YES;
    [self.view addSubview:printButton];
    [printButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.width.height.equalTo(100);
        make.bottom.equalTo(0).offset(-bottomMargin-12);
    }];
    [printButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [printButton addTarget:self action:@selector(centerClick) forControlEvents:UIControlEventTouchUpInside];
    self.centerButton = printButton;
    
    // 货品录入
    UIButton *editGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [editGoodsButton setImage:[UIImage imageNamed:@"input_blue"] forState:UIControlStateNormal];
    [editGoodsButton setTitle:@"货品录入" forState:UIControlStateNormal];
    editGoodsButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [editGoodsButton setTitleColor:[ProgramColor RGBColorWithRed:65 green:65 blue:65] forState:UIControlStateNormal];
    [self.view addSubview:editGoodsButton];
    [editGoodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomShadowView.mas_bottom);
        make.top.equalTo(bottomShadowView.mas_top);
        make.left.equalTo(0);
        make.right.equalTo(printButton.mas_left);
    }];
    [editGoodsButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
    [editGoodsButton addTarget:self action:@selector(editGoodsClick) forControlEvents:UIControlEventTouchUpInside];
    self.editGoodsButton = editGoodsButton;
    
    // 个人中心
    UIButton *personalCenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [personalCenterButton setImage:[UIImage imageNamed:@"person_blue"] forState:UIControlStateNormal];
    [personalCenterButton setTitle:@"个人中心" forState:UIControlStateNormal];
    personalCenterButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [personalCenterButton setTitleColor:[ProgramColor RGBColorWithRed:65 green:65 blue:65] forState:UIControlStateNormal];
    [self.view addSubview:personalCenterButton];
    [personalCenterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomShadowView.mas_bottom);
        make.top.equalTo(bottomShadowView.mas_top);
        make.right.equalTo(0);
        make.left.equalTo(printButton.mas_right);
    }];
    [personalCenterButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
    [personalCenterButton addTarget:self action:@selector(personalCenterClick) forControlEvents:UIControlEventTouchUpInside];
    self.personalCenterButton = personalCenterButton;
}




#pragma mark - ==== 点击事件 ====
#pragma mark ---- 注销登录 ----
- (void)logoutAction
{

    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *isLogin = @"login_out";
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:isLogin forKey:@"isLogin"];
        [user synchronize];
        
        SPSZ_LoginViewController *login = [[SPSZ_LoginViewController alloc]init];
        BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:login];
        [[AppDelegate shareInstance].window setRootViewController:navi];
    }];
    
    [actionSheetController addAction:cancelAction];
    [actionSheetController addAction:okAction];
    
    [self presentViewController:actionSheetController animated:YES completion:nil];
}

#pragma mark ---- 添加货物 ----
- (void)addGoodsClick:(UIButton *)addGoodsButton
{
    // 跳转到添加货物页面
    SPSZ_AddGoodsViewController *addGoodsVC = [[SPSZ_AddGoodsViewController alloc] init];
    KRWeakSelf;
    [addGoodsVC setAddGoodsBlock:^(NSMutableArray<SPSZ_GoodsModel *> *addGoodsArray) {
        [weakSelf.selectedArray addObjectsFromArray:addGoodsArray];
        [weakSelf showSelectedView];
    }];
    
    [self.navigationController pushViewController:addGoodsVC animated:YES];
}

- (void)showSelectedView
{
    self.selectedView.selectedArray = self.selectedArray;
    self.indexView.hidden = YES;
    self.selectedView.hidden = NO;
}

- (void)centerClick
{
    if (self.isConnect) {
        [self printTicket];
    }
    else {
        [self connectNow];
    }
}

#pragma mark ---- 货品录入 ----
- (void)editGoodsClick
{
    SPSZ_chu_jinHuoLuRuViewController *vc = [[SPSZ_chu_jinHuoLuRuViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ---- 个人中心 ----
- (void)personalCenterClick
{
    SPSZ_chu_personalCenterViewController *vc = [[SPSZ_chu_personalCenterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clearSelected:(UIButton *)button
{
    [self.selectedArray removeAllObjects];
    self.selectedView.hidden = YES;
    self.indexView.hidden = NO;
}



#pragma mark - ======== Delegate ========


#pragma mark ---- 立即连接 ----
//- (void)connectNow
//{
//    [PrinterWraper SetBlutoothDelegate:self];
//    [PrinterWraper StartScanTimeout:10];
//
//    mytimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(timeout) userInfo:nil repeats:NO];
//    activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//
//    activityView.center=self.view.center;
//
//    [activityView startAnimating];
//
//    [self.view addSubview:activityView];
//}

//- (void)timeout
//{
//    [self stopScan];
//    if (self.deviceArray.count == 0)
//    {
//        UIAlertView*alert=[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"没有扫描到打印机",@"") delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", @"") otherButtonTitles:nil, nil];
//        [alert show];
//    }
//}

//-(void)stopScan
//{
//    [PrinterWraper StopScan];
//    [activityView stopAnimating];
//    [mytimer invalidate];
//    mytimer=nil;
//}

- (void)connectNow
{
    if (self.centralManager) {
        self.centralManager = nil;
    }
    
    NSDictionary *options = @{CBCentralManagerOptionShowPowerAlertKey:@(YES)};
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue() options:options];
}


#pragma mark ---- 打印票据 ----
- (void)printTicket
{
    if (self.selectedArray.count == 0) {
        return;
    }
    
    [self startPrint];
}

//- (void)startPrint
//{
//    //设置格式 大字体 行间距28 局中
//    [PrinterWraper setPrintFormat:3 LineSpace:28 alinment:1 rotation:0];// 3 大字体  ，28默认行间距,1局中对齐
//    //打印标题
//    [PrinterWraper addPrintText:@"南京市农产品销售流通凭证\n\n"];//打印文字
//
//    // 打印时间戳
//    NSString *timeString = [NSString stringWithFormat:@"%@\n\n", [self getTime]];
//    [PrinterWraper setPrintFormat:2 LineSpace:28 alinment:1 rotation:0];
//    [PrinterWraper addPrintText:timeString];
//
//    // 打印分类
//    NSArray *titleValueArray = @[@"产品名称", @"产品产地", @"进货数量/重量"];
//    NSArray *titleArray = @[titleValueArray];
//    [PrinterWraper addItemLines:titleArray];
//
//    // 打印---
//    [PrinterWraper startPrint:nil];
//}

- (void)startPrint
{
    
}



//#pragma mark bluetooth delegate
//-(void)BlueToothOpen:(BOOL)isopen
//{
//    if (!isopen) {
//        [self stopScan];
//        [self.deviceArray removeAllObjects];
//    }
//}
//
//- (void)updateBluetoothDevice:(NSMutableArray*)devices;
//{
//    self.deviceArray = devices;
//
//    self.chooseConnectView.dataArray = devices;
//    if (!self.isConnect) {
//        [self.chooseConnectView showInView:self.navigationController.view];
//    }
//}
//
//- (void)didConnected:(NSString*)deviceUid Result:(BOOL)success
//{
//    if (success) {
//        self.isConnect = YES;
//    }
//    else {
//        NSLog(@"连接失败!");
//    }
//}
//
//- (void)finishPrint
//{
//    NSLog(@"打印完成!");
//}
//

#pragma mark ---- ChooseConnectViewDelegate ----
//- (void)chooseDevice:(CBPeripheral *)device
//{
//    [PrinterWraper connectPrinter:device.identifier.UUIDString shouldreset:YES];
//    [self.chooseConnectView hidden];
//}
- (void)chooseDevice:(CBPeripheral *)device
{
    [self.centralManager connectPeripheral:device options:@{CBConnectPeripheralOptionNotifyOnDisconnectionKey:@(YES)}];
    [self.chooseConnectView hidden];
}



#pragma mark - ======== CBCentralManagerDelegate ========
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    // 蓝牙可用，开始扫描外设
    if (central.state == CBManagerStatePoweredOn) {
        if (!self.isConnect) {
            [self.chooseConnectView showInView:self.navigationController.view];
            [self.centralManager scanForPeripheralsWithServices:nil options:nil];
        }
    }
    if(central.state==CBManagerStateUnsupported) {
        [[LUAlertTool defaultTool] Lu_alertInViewController:self title:@"提示" message:@"该设备不支持蓝牙" cancelButtonTitle:@"确认"];
    }
    if (central.state==CBManagerStatePoweredOff) {
        NSLog(@"设置中未打开蓝牙");
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI
{

    if (self.deviceArray.count == 0) {
        [self.deviceArray addObject:peripheral];
    }
    else {
        BOOL isExist = NO;
        for (int i = 0; i < self.deviceArray.count; i++) {
            CBPeripheral *per = [self.deviceArray objectAtIndex:i];
            if ([per.identifier.UUIDString isEqualToString:peripheral.identifier.UUIDString]) {
                isExist = YES;
                [self.deviceArray replaceObjectAtIndex:i withObject:peripheral];
            }
        }

        if (!isExist) {
            [self.deviceArray addObject:peripheral];
        }
    }

    self.chooseConnectView.dataArray = self.deviceArray;

}


/** 连接成功 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    // 可以停止扫描
    [self.centralManager stopScan];
    // 设置代理
    peripheral.delegate = self;
    self.peripheral = peripheral;

    self.isConnect = YES;
    NSLog(@"连接成功");

    [self.peripheral discoverServices:nil];
}

/** 连接失败的回调 */
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    [KRAlertTool alertString:@"连接蓝牙设备失败,请重试"];
}

/** 断开连接 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    self.isConnect = NO;
}


#pragma mark - ======== CBPeripheralDelegate ========
/** 发现服务 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    // 遍历出外设中所有的服务
    for (CBService *service in peripheral.services) {
        NSLog(@"\n\n%@\n\n", service);
    }
    
    [peripheral discoverCharacteristics:nil forService:peripheral.services.firstObject];
}

/** 发现特征回调 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    // 遍历出所需要的特征
    for (CBCharacteristic *characteristic in service.characteristics) {
        if (characteristic.properties & CBCharacteristicPropertyWrite) {
            NSLog(@"\n\nperipheral : %@\ncharacteristic：%@\nservice: %@\n\n", peripheral, characteristic, service);
            self.peripheral = peripheral;
            self.characteristic = characteristic;
        }
    }
}


/** 写入数据回调 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    if (error) {
        NSLog(@"写入失败:%@",error);
    }
    else {
        NSLog(@"写入成功");
    }
}









- (NSString *)getTime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    return DateTime;
}


    //        switch (characteristic.properties) {
    //            case CBCharacteristicPropertyBroadcast:
    //            {
    //                NSLog(@"CBCharacteristicPropertyBroadcast");
    //                break;
    //            }
    //            case CBCharacteristicPropertyRead:
    //            {
    //                NSLog(@"CBCharacteristicPropertyRead");
    //                break;
    //            }
    //            case CBCharacteristicPropertyWriteWithoutResponse:
    //            {
    //                NSLog(@"CBCharacteristicPropertyWriteWithoutResponse");
    //                break;
    //            }
    //            case CBCharacteristicPropertyWrite:
    //            {
    //                NSLog(@"CBCharacteristicPropertyWrite");
    //                break;
    //            }
    //            case CBCharacteristicPropertyNotify:
    //            {
    //                NSLog(@"CBCharacteristicPropertyNotify");
    //                break;
    //            }
    //            case CBCharacteristicPropertyIndicate:
    //            {
    //                NSLog(@"CBCharacteristicPropertyIndicate");
    //                break;
    //            }
    //            case CBCharacteristicPropertyAuthenticatedSignedWrites:
    //            {
    //                NSLog(@"CBCharacteristicPropertyAuthenticatedSignedWrites");
    //                break;
    //            }
    //            case CBCharacteristicPropertyExtendedProperties:
    //            {
    //                NSLog(@"CBCharacteristicPropertyExtendedProperties");
    //                break;
    //            }
    //            case CBCharacteristicPropertyNotifyEncryptionRequired:
    //            {
    //                NSLog(@"CBCharacteristicPropertyNotifyEncryptionRequired");
    //                break;
    //            }
    //            case CBCharacteristicPropertyIndicateEncryptionRequired:
    //            {
    //                NSLog(@"CBCharacteristicPropertyIndicateEncryptionRequired");
    //                break;
    //            }
    //            default:
    //                break;
    //        }



@end
