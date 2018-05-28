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

#import "SPSZ_IndexView.h"
#import "SPSZ_ChooseConnectView.h"
#import "SPSZ_ChuSelectedView.h"


#import "SPSZ_DeviceModel.h"


#import "UIButton+Gradient.h"
#import "UIButton+ImageTitleSpacing.h"
#import "HLBLEManager.h"

#import "BaseNavigationController.h"
#import "SPSZ_LoginViewController.h"

@interface SPSZ_ChuIndexViewController ()<ChooseConnectViewDelegate>

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
    
//    self.isConnect = YES;
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

#pragma mark ---- 立即连接 ----
- (void)connectNow
{
    self.isConnect = YES;
    
    
//    if (self.hasCreate) {
//
//    }
//    else {
//        self.hasCreate = YES;
//
//        HLBLEManager *manager = [HLBLEManager sharedInstance];
//        __weak HLBLEManager *weakManager = manager;
//        manager.stateUpdateBlock = ^(CBCentralManager *central) {
//            NSString *info = nil;
//            switch (central.state) {
//                case CBCentralManagerStatePoweredOn:
//                    [self.chooseConnectView showInView:self.navigationController.view];
//                    [weakManager scanForPeripheralsWithServiceUUIDs:nil options:nil];
//                    break;
//                case CBCentralManagerStatePoweredOff:
//                    info = @"请在设置中打开蓝牙开关";
//                    break;
//                case CBCentralManagerStateUnsupported:
//                    info = @"SDK不支持";
//                    break;
//                case CBCentralManagerStateUnauthorized:
//                    info = @"程序未授权";
//                    break;
//                case CBCentralManagerStateResetting:
//                    info = @"CBCentralManagerStateResetting";
//                    break;
//                case CBCentralManagerStateUnknown:
//                    info = @"CBCentralManagerStateUnknown";
//                    break;
//            }
//        };
//
//        manager.discoverPeripheralBlcok = ^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
//            if (peripheral.name.length <= 0) {
//                return ;
//            }
//
//            if (self.deviceArray.count == 0) {
//                [self.deviceArray addObject:peripheral];
//            } else {
//                BOOL isExist = NO;
//                for (int i = 0; i < self.deviceArray.count; i++) {
//                    CBPeripheral *per = [self.deviceArray objectAtIndex:i];
//                    if ([per.identifier.UUIDString isEqualToString:peripheral.identifier.UUIDString]) {
//                        isExist = YES;
//                        [self.deviceArray replaceObjectAtIndex:i withObject:peripheral];
//                    }
//                }
//
//                if (!isExist) {
//                    [self.deviceArray addObject:peripheral];
//                }
//            }
//
//            self.chooseConnectView.dataArray = self.deviceArray;
//        };
//    }
//
    
}

#pragma mark ---- 打印票据 ----
- (void)printTicket
{
    self.isConnect = NO;
}

#pragma mark ---- 货品录入 ----
- (void)editGoodsClick
{
    // TODO: 未实现
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
#pragma mark ---- ChooseConnectViewDelegate ----
- (void)chooseDevice:(CBPeripheral *)device
{
    [self.chooseConnectView hidden];
    
    
    // TODO: 未实现
}


@end
