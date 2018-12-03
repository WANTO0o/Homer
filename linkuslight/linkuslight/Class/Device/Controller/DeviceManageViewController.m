//
//  DeviceManageViewController.m
//  linkuslight
//
//  Created by Aba on 17/10/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "DeviceInfo.h"
#import "ColorPickerController.h"
#import "MJRefresh/MJRefresh.h"
#import "ClockViewController.h"
#import "DeviceTableViewCell.h"
#import "AddDeviceViewController.h"
#import "LLSelectGroupTypeAlterView.h"
#import "LightControlViewController.h"
#import "SocketDeviceViewController.h"
#import "DeviceManageViewController.h"
#import "UINavigationBar+BackgroundColor.h"

#import "Homer.h"
#import "DeviceManager.h"
#import "HomerRemoteCtrl.h"

#import "Uility.h"

@interface DeviceManageViewController ()<UITableViewDelegate, UITableViewDataSource, HomerSearchDelegate, HomerRemoteCtrlDelegate>

@property (weak, nonatomic) IBOutlet UITableView *deviceTableView;
@property (nonatomic,retain)UIView *tipsView;
//@property (nonatomic,retain)NSMutableArray *devices;

@property (nonatomic, strong) Homer *homerCtrl;
@property (nonatomic, assign) HomerRemoteCtrl *homerRemoteCtrl;
@property (nonatomic, retain)  NSMutableArray *localDevices;
@property (nonatomic, retain)  NSMutableArray *remoteDevices;
@property (nonatomic, assign)  BOOL getLocalDevice;
@property (nonatomic, assign)  BOOL getRemoteDevice;
@end

@implementation DeviceManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.homerCtrl = [[Homer alloc]init];
    self.homerRemoteCtrl = [HomerRemoteCtrl sharedManager];
    [self.homerRemoteCtrl setDelegate:self]; // 赋值委托
    self.localDevices = [NSMutableArray array];
    self.remoteDevices = [NSMutableArray array];
    [self initView];
    //[self initData];
    [_deviceTableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self.navigationController.navigationBar setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //[self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithRed:0.2543 green:0.4697 blue:1.0 alpha:1.0]];
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.3975 green:0.6503 blue:1.0 alpha:1.0]];
    //self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.3975 green:0.6503 blue:1.0 alpha:1.0];
    //self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.3975 green:0.6503 blue:1.0 alpha:1.0];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //[self.navigationController.navigationBar setShadow]];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];

    [self.navigationController.topViewController.navigationItem setTitle:@"SMART ELF"];
    //[self.deviceTableView.mj_header beginRefreshing];
}

#pragma mark Private 
- (void)initView {
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self transform];

    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    _deviceTableView.tableFooterView = view;

    CGRect tableFrame = self.deviceTableView.frame;
    UIView *theView = [[UIView alloc] initWithFrame:tableFrame];
    theView.tag = 1001;
    //Tips
    self.tipsView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 300, 300))];

    UIImageView *tipsImg = [[UIImageView alloc] initWithFrame:(CGRectMake(kScreen_Width-192, 93, 152, 113))];
    tipsImg.image = [UIImage imageNamed:@"zhishi"];
    [_tipsView addSubview:tipsImg];
    UILabel *actionnameLable = [[UILabel alloc] initWithFrame:(CGRectMake(32, 207, 100, 20))];
    actionnameLable.textAlignment = NSTextAlignmentCenter;
    actionnameLable.textColor = [UIColor colorWithRed:0.4052 green:0.4052 blue:0.4052 alpha:1.0];
    actionnameLable.font = [UIFont systemFontOfSize:18];
    actionnameLable.text = NSLocalizedString(@"no_device", nil);
    [_tipsView addSubview:actionnameLable];
    
    UILabel *actioncommentnameLable = [[UILabel alloc] initWithFrame:(CGRectMake(42, 227, 200, 20))];
    actioncommentnameLable.textAlignment = NSTextAlignmentCenter;
    actioncommentnameLable.textColor = [UIColor colorWithRed:0.4052 green:0.4052 blue:0.4052 alpha:1.0];
    actioncommentnameLable.font = [UIFont systemFontOfSize:13];
    actioncommentnameLable.text = NSLocalizedString(@"no_device_prompt", nil);
    [_tipsView addSubview:actioncommentnameLable];
    
    if ([DeviceManager sharedManager].deviceList.count > 0) {

    } else {
        UIView *theView = _deviceTableView.backgroundView;
        [theView addSubview:_tipsView];
    }
    //Footer
//    UILabel *comnameLable = [[UILabel alloc] initWithFrame:(CGRectMake(0, tableFrame.size.height-30, kScreen_Width, 20))];
//    comnameLable.textAlignment = NSTextAlignmentCenter;
//    comnameLable.textColor = [UIColor blackColor];
//    comnameLable.font = [UIFont systemFontOfSize:12];
//    comnameLable.text = @"凌科斯科技（深圳）有限公司";
//    [theView addSubview:comnameLable];
//
//    UILabel *comLinkLable = [[UILabel alloc] initWithFrame:(CGRectMake(0, tableFrame.size.height-13, kScreen_Width, 17))];
//    comLinkLable.textAlignment = NSTextAlignmentCenter;
//    comLinkLable.textColor = [UIColor colorWithRed:0.3686 green:0.6 blue:0.9333 alpha:1.0];
//    comLinkLable.font = [UIFont systemFontOfSize:11];
//    comLinkLable.text = @"www.linkustek.com";
//    [theView addSubview:comLinkLable];
    if ([_deviceTableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        _deviceTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _deviceTableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        _deviceTableView.scrollIndicatorInsets = _deviceTableView.contentInset;
    }

    
    _deviceTableView.backgroundView = theView;
    //默认【下拉刷新】
    _deviceTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];

}

- (void)initData {
//
//    _devices = [NSMutableArray array];//[NSMutableArray arrayWithCapacity:0];

    DeviceInfo *dev = [[DeviceInfo alloc] init];
    dev.deviceID = @"SHTBY0001";
    dev.isOn = YES;
    dev.name = @"lamp blub 001";
    dev.hasStatuFlag = YES;
    dev.hasClockFlag = YES;
    dev.linkState = LULDeviceLinkStateCloud;
    [[DeviceManager sharedManager].deviceList addObject:dev];

    DeviceInfo *dev2 = [[DeviceInfo alloc] init];
    dev2.deviceID = @"SHTBY0002";
    dev2.isOn = YES;
    dev2.name = @"lamp blub 002";
    dev2.hasStatuFlag = NO;
    dev2.hasClockFlag = YES;
    dev2.linkState = LULDeviceLinkStateWiFi;
    dev2.deviceType= LULDeviceLinkStateWhiteLight;
    [[DeviceManager sharedManager].deviceList addObject:dev2];

    DeviceInfo *dev3 = [[DeviceInfo alloc] init];
    dev3.deviceID = @"SHTBY0003";
    dev3.isOn = NO;
    dev3.name = @"lamp blub 003";
    dev3.hasStatuFlag = NO;
    dev3.hasClockFlag = YES;
    dev3.linkState = LULDeviceLinkStateWiFi;
    [[DeviceManager sharedManager].deviceList addObject:dev3];

//    for (DeviceInfo *devInfo in [DeviceManager sharedManager].deviceList) {
//        [_devices addObject:devInfo];
//    }
    
    // TODO: 正常界面的更新不应该放在initData这里，而是initData之后initView里去初始化，不知为何调整initData和initView的顺序之后没有相应效果
//    if(_devices.count <= 0) {
//        UIView *theView = _deviceTableView.backgroundView;
//        [theView addSubview:_tipsView];
//    }
}

- (void)loadData {
    
    /*if (page >= totalPage) {
        [self endRefresh];
        return;
    }*/
    
    // 由于当前的设备搜索没有在操作结束时候返回一个委托，导致无法根据知道什么时候搜索完毕，因此endRefresh的时机不好控制
    // 临时是将设备列表和界面更新到动作放在每次搜索到设备时候调用到委托内
    // 可以确保设备列表的清空和加载正常，但是无法很好的让用户根据endRefresh的效果感受到搜索过程
    
    // 每次重载数据前先清空数据
//    [_devices removeAllObjects];
    // TODO: 这种做法需要更改，每次都需要DeviceManager去清理所有数据，那么这个DeviceManager就失去意义了。关键当前没有一个合理的标志搜索结束的标记。
    [[DeviceManager sharedManager].deviceList removeAllObjects];
    [self.localDevices removeAllObjects];
    [self.remoteDevices removeAllObjects];
    [self.tipsView removeFromSuperview];
    
    self.getLocalDevice = NO;
    self.getRemoteDevice = NO;
    // 当前设备检索策略：远程和本地分别进行检索，各自用一个标记为标记是否检索结束。如果双方都检索结束，则进入endRefresh中统一整合两个列表设备并刷新加载到界面
    // 开始远程设备搜索
    [self.homerRemoteCtrl searchDevice];
    // 开始本地设备搜索
    [self.homerCtrl beginSearchDeviceWithDelegate:self];
    // 本地设备搜索由于库没有设定超时回调，这里设定为5s超时时间，超时过后即便再搜索到，不添加进设备列表中
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         self.getLocalDevice = YES;
        //if (self.getRemoteDevice) {//已获取到远程列表
            //[[DeviceManager sharedManager] integrateLocalDevices:self.localDevices remoteDevices:self.remoteDevices];
            //[self updateDeviceData];
            [self endRefresh];
        //}
    });

}

- (void)updateDeviceData {
//    for (DeviceInfo *devInfo in [DeviceManager sharedManager].deviceList) {
//        [_devices addObject:devInfo];
//    }
    
    if([DeviceManager sharedManager].deviceList.count <= 0) {
        UIView *theView = _deviceTableView.backgroundView;
        [theView addSubview:_tipsView];
    } else {
        [_tipsView removeFromSuperview];
    }
    
    [self.deviceTableView reloadData];
}

#pragma mark - 下拉刷新
- (void)headerRefresh {
    DebugLog(@"headerRefresh");
    
    [self loadData];
}

#pragma mark - 结束下拉刷新和上拉加载
- (void)endRefresh {
    DebugLog(@"endRefresh");
    
    //if (_devices.count == 0) {
    //    [self.deviceTableView.mj_header endRefreshing];
    //}
    if(self.getRemoteDevice && self.getLocalDevice) {
        [[DeviceManager sharedManager] integrateLocalDevices:self.localDevices remoteDevices:self.remoteDevices];
        [self updateDeviceData];
        
        [self.deviceTableView.mj_header endRefreshing];
    }
}

- (void) transform {
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"back", nil)
//                                                                 style:UIBarButtonItemStyleDone
//                                                                target:self
//                                                                action:nil];
//    backItem.tintColor = [UIColor whiteColor];
//
//    self.navigationItem.backBarButtonItem = backItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_leftbar"]
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(gotoMenuView)];
    leftItem.tintColor = [UIColor whiteColor];

    self.navigationItem.leftBarButtonItem = leftItem;

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_addition"]
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(gotoSelectGroupTypeView)];
    rightItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    //self.navigationItem.backBarButtonItem = nil;
    

}

- (void)gotoMenuView {
    [self.sideMenuViewController presentLeftMenuViewController];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void)gotoAddViewWithDeviceType:(LULDeviceType)deviceType {

    AddDeviceViewController *addController = [[AddDeviceViewController alloc] init];
    addController.addWifiDevice = YES;
    addController.deviceType = deviceType;
    addController.addBolck = ^(DeviceInfo *addDevice) {
        [[DeviceManager sharedManager]add:addDevice];
        [self.deviceTableView reloadData];
    };
    
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:addController animated:YES];
    [self setHidesBottomBarWhenPushed:NO];

}

- (void)gotoSelectGroupTypeView {
    
    LLSelectGroupTypeAlterView *lsll=[[LLSelectGroupTypeAlterView alloc] initWithTitle:NSLocalizedString(@"info_devType", nil) SureTitle:NSLocalizedString(@"ok", nil) CancelBtClcik:^{
        //取消按钮点击事件
        NSLog(@"取消");
    } SureBtClcik:^(NSInteger selectDeviceTag) {
        //确定按钮点击事件
        NSLog(@"确定");
        switch (selectDeviceTag) {
            case 111:
                NSLog(@"选择彩灯");
                [self gotoAddViewWithDeviceType:LULDeviceLinkStateColourLight];
                break;
            case 112:
                NSLog(@"选择白灯");
                [self gotoAddViewWithDeviceType:LULDeviceLinkStateWhiteLight];
                break;
            case 113:
                NSLog(@"选择开关");
                [self gotoAddViewWithDeviceType:LULDeviceLinkStateSocket];
                break;
            default:
                break;
        }
        
        //[_deviceTableView reloadData];
    }];
    
    [lsll showLLAlertView:self.view];
}

#pragma TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DeviceManager sharedManager].deviceList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DeviceTableViewCell *cell = [DeviceTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    DeviceInfo *dev = [[DeviceManager sharedManager].deviceList objectAtIndex:indexPath.row];
    [cell refreshWithDeviceInfo:dev];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < [DeviceManager sharedManager].deviceList.count) {
        NSLog(@"didSelectRowAtIndexRow:%ld",(long)indexPath.row);
        [self showLightViewWithDeviceInfo:[DeviceManager sharedManager].deviceList[indexPath.row]];
    };
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0f;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DebugLog(@"changanle");
    return NO;
}

- (void)showColorPickerController {
    ColorPickerController *controller = [[ColorPickerController alloc] init];
    
    //UIImage * imng = [UIImage imageNamed:@"addition_bg_sh"];
    //[controller createARGBBitmapContextFromImage:imng.CGImage];
    [self setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}


- (void)showLightViewWithDeviceInfo:(DeviceInfo*)devInfo {
    LightControlViewController *controller = [[LightControlViewController alloc] init];
    controller.isDevice = YES;
    controller.DeviceInfo = devInfo;
    controller.lightControlDeviceType = LightControlDeviceTypeSingle;
    if (devInfo.deviceType == LULDeviceLinkStateWhiteLight) {
        controller.LightType = LULLightSliderTypeWhiteLight;
    } else {
        controller.LightType = LULLightSliderTypeColourLight;
    }
    controller.deleteDeviceBlock = ^(DeviceInfo *device) {
        [[DeviceManager sharedManager]del:device];
        [self.deviceTableView reloadData];
        [Uility showSuccess:NSLocalizedString(@"del_dev_success", nil) toView:self.view];
    };
    controller.backActionBlock = ^{
        //修改，重新刷新视图
        [self.deviceTableView reloadData];
    };
    [self setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

//- (void)showLightViewWithDeviceType:(LULDeviceType)deviceType{
//
//    LightControlViewController *controller = [[LightControlViewController alloc] init];
//    controller.isDevice = YES;
////    if (deviceType == LULDeviceLinkStateWhiteLight) {
////        controller.LightType = LULLightSliderTypeWhiteLight;
////    } else {
////        controller.LightType = LULLightSliderTypeColourLight;
////    }
//
//    [self setHidesBottomBarWhenPushed:YES];
//
//    [self.navigationController pushViewController:controller animated:YES];
//    [self setHidesBottomBarWhenPushed:NO];
//
//}

- (void)showSocketView {
    SocketDeviceViewController *controller = [[SocketDeviceViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];

    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];

}

- (void)showClockView {
    ClockViewController *controller = [[ClockViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];

    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}


#pragma mark - homeSearchDelegate
-(void) onDeviceSearch:(Device *)result {
    DebugLog(@"Device %@ is found", [result getIp]);
    dispatch_async(dispatch_get_main_queue(), ^{
//        if ( [DeviceManager sharedManager].deviceList.count > 0) {
//            DebugLog(@"搜索异常，没有提前获取列表");
//            return ;
//        }
//        for (DeviceInfo *device in [DeviceManager sharedManager].deviceList){
//            //云端列表已有
//            if (device.deviceID == [result getId]) {
//                device.linkState = LULDeviceLinkStateWiFi;
//                device.name = [result getId];
//                device.ip = [result getIp];
//                devFind.hasStatuFlag = NO;
//                devFind.hasClockFlag = YES;
//                [self.deviceTableView reloadData];
//                break;
//            }
//        }
        //云端列表暂有
        //[self showAlertWithResult:result];
        
        
        
        DeviceInfo *devFind = [[DeviceInfo alloc] init];
        devFind.deviceID = [result getId];
        devFind.isOn = YES;
        int hexNum = [devFind.deviceID intValue];
        devFind.name = [NSString stringWithFormat:@"LIGHT%08X", hexNum];
        //devFind.name = [NSString stringWithFormat:@"LIGHT%@", devFind.deviceID];
        devFind.ip = [result getIp];
        devFind.hasStatuFlag = NO;
        devFind.hasClockFlag = NO;
        devFind.linkState = LULDeviceLinkStateWiFi;
//        devFind.device = result;

//        [_devices addObject:devFind];
        // TODO: 是否需要判断_tipsView当前是否存在于Superview中，再做remove的动作
        //if(_devices.count > 0) {
//        if (_tipsView.superview) {
//            [_tipsView removeFromSuperview];
//        }
        //}
//        [[DeviceManager sharedManager] add:devFind];
        if (!self.getLocalDevice) {//5秒内添加，超时不添加
            [self.localDevices addObject:devFind];
        }

//        [self.deviceTableView reloadData];
        
   
        
    });
}

#pragma mark -HomerRemoteCtrl delegate
-(void) remoteSearchDevice:(NSMutableArray *)devList {
    for (ColorLight *light in devList) {
        [self.remoteDevices addObject:[light deviceInfo]];
//        [[DeviceManager sharedManager] add:[light deviceInfo]];
    }
    self.getRemoteDevice = YES;
    //if (self.getLocalDevice) {//搜索本地已结束
        dispatch_async(dispatch_get_main_queue(), ^{
            //[[DeviceManager sharedManager] integrateLocalDevices:self.localDevices remoteDevices:self.remoteDevices];
            //[self updateDeviceData];
            [self endRefresh];
        });
    //}else{
        //继续等待
    //}
  
}

-(void)transferSuccess {
    DebugLog(@"getDeviceSuccess");
}

-(void)transferFailWithMsg:(NSError *)failMsg {
    DebugLog(@"getDeviceFailed");
    self.getRemoteDevice = YES;
    
    //[self endRefresh];
    [Uility showError:NSLocalizedString(@"refresh_error", nil) toView:self.view];
    //self.getLocalDevice = YES;
}

@end
