//
//  DeviceManageViewController.m
//  linkuslight
//
//  Created by Aba on 17/10/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "DeviceInfo.h"
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

@interface DeviceManageViewController ()<UITableViewDelegate, UITableViewDataSource, HomerSearchDelegate>

@property (weak, nonatomic) IBOutlet UITableView *deviceTableView;
@property (nonatomic,retain)UIView *tipsView;
@property (nonatomic,retain)NSMutableArray *devices;

@property (atomic, strong) Homer *_homerCtrl;

@end

@implementation DeviceManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self._homerCtrl = [[Homer alloc]init];
    
    [self initView];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

    [self.navigationController.topViewController.navigationItem setTitle:@"LINKUS LIGHT"];
    [self.deviceTableView.mj_header beginRefreshing];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
    actionnameLable.text = @"没有设备";
    [_tipsView addSubview:actionnameLable];
    
    UILabel *actioncommentnameLable = [[UILabel alloc] initWithFrame:(CGRectMake(42, 227, 200, 20))];
    actioncommentnameLable.textAlignment = NSTextAlignmentCenter;
    actioncommentnameLable.textColor = [UIColor colorWithRed:0.4052 green:0.4052 blue:0.4052 alpha:1.0];
    actioncommentnameLable.font = [UIFont systemFontOfSize:13];
    actioncommentnameLable.text = @"您可以通过添加设备来控制设备";
    [_tipsView addSubview:actioncommentnameLable];
    
    if (_devices.count > 0) {

    } else {
        UIView *theView = _deviceTableView.backgroundView;
        [theView addSubview:_tipsView];
    }
    //Footer
    UILabel *comnameLable = [[UILabel alloc] initWithFrame:(CGRectMake(0, tableFrame.size.height-30, kScreen_Width, 20))];
    comnameLable.textAlignment = NSTextAlignmentCenter;
    comnameLable.textColor = [UIColor blackColor];
    comnameLable.font = [UIFont systemFontOfSize:12];
    comnameLable.text = @"凌科斯科技（深圳）有限公司";
    [theView addSubview:comnameLable];
    
    UILabel *comLinkLable = [[UILabel alloc] initWithFrame:(CGRectMake(0, tableFrame.size.height-13, kScreen_Width, 17))];
    comLinkLable.textAlignment = NSTextAlignmentCenter;
    comLinkLable.textColor = [UIColor colorWithRed:0.3686 green:0.6 blue:0.9333 alpha:1.0];
    comLinkLable.font = [UIFont systemFontOfSize:11];
    comLinkLable.text = @"www.linkustek.com";
    [theView addSubview:comLinkLable];

    _deviceTableView.backgroundView = theView;
    //默认【下拉刷新】
    _deviceTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
}

- (void)initData {

    _devices = [NSMutableArray arrayWithCapacity:1];
    
//    DeviceInfo *dev = [[DeviceInfo alloc] init];
//    dev.deviceID = @"SHTBY0001";
//    dev.isOn = YES;
//    dev.name = @"lamp blub 001";
//    dev.hasStatuFlag = YES;
//    dev.hasClockFlag = YES;
//    dev.linkState = LULDeviceLinkStateCloud;
//    [_devices addObject:dev];
//
//    DeviceInfo *dev2 = [[DeviceInfo alloc] init];
//    dev2.deviceID = @"SHTBY0002";
//    dev2.isOn = YES;
//    dev2.name = @"lamp blub 002";
//    dev2.hasStatuFlag = NO;
//    dev2.hasClockFlag = YES;
//    dev2.linkState = LULDeviceLinkStateWiFi;
//    [_devices addObject:dev2];
//
//    DeviceInfo *dev3 = [[DeviceInfo alloc] init];
//    dev3.deviceID = @"SHTBY0003";
//    dev3.isOn = NO;
//    dev3.name = @"lamp blub 003";
//    dev3.hasStatuFlag = NO;
//    dev3.hasClockFlag = YES;
//    dev3.linkState = LULDeviceLinkStateWiFi;
//    [_devices addObject:dev3];
    
    [self._homerCtrl beginSearchDeviceWithDelegate:self];
    
    if (_devices.count > 0) {
        [_tipsView removeFromSuperview];
    } else {
        
        UIView *theView = _deviceTableView.backgroundView;
        [theView addSubview:_tipsView];
    }
}

- (void)loadData {
    
    /*if (page >= totalPage) {
        [self endRefresh];
        return;
    }*/
    
    [self._homerCtrl beginSearchDeviceWithDelegate:self];
    [self.deviceTableView reloadData];
    [self endRefresh];
}

#pragma mark - 下拉刷新
- (void)headerRefresh {
    
    [self loadData];
}

#pragma mark - 结束下拉刷新和上拉加载
- (void)endRefresh {
    
    if (_devices.count == 0) {
        [self.deviceTableView.mj_header endRefreshing];
    }
    
    [self.deviceTableView.mj_header endRefreshing];
    
}

- (void) transform {
    /*UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStyleDone
                                                                target:nil
                                                                action:nil];
    backItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.backBarButtonItem = backItem;*/
    
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
    self.navigationItem.backBarButtonItem = nil;
    

}

- (void)gotoMenuView {
    [self.sideMenuViewController presentLeftMenuViewController];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void)gotoAddViewWithDeviceType:(LULDeviceType)deviceType {

    AddDeviceViewController *addController = [[AddDeviceViewController alloc] init];
    addController.addWifiDevice = YES;
    addController.deviceType = deviceType;
    
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:addController animated:YES];
    [self setHidesBottomBarWhenPushed:NO];

}

- (void)gotoSelectGroupTypeView {
    
    LLSelectGroupTypeAlterView *lsll=[[LLSelectGroupTypeAlterView alloc] initWithTitle:@"设备类型" SureTitle:@"确定" CancelBtClcik:^{
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
    return _devices.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DeviceTableViewCell *cell = [DeviceTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    DeviceInfo *dev = [_devices objectAtIndex:indexPath.row];
    [cell refreshWithDeviceInfo:dev];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _devices.count) {
        NSLog(@"didSelectRowAtIndexRow:%ld",(long)indexPath.row);
        switch (indexPath.row) {
                case 0:
                [self showLightViewWithDeviceType:LULDeviceLinkStateColourLight];
                break;
                case 1:
                [self showLightViewWithDeviceType:LULDeviceLinkStateWhiteLight];
                break;
                case 2:
                [self showSocketView];
                break;
            default:
                break;
        }
    };
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0f;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DebugLog(@"changanle");
    return NO;
}

- (void)showLightViewWithDeviceType:(LULDeviceType)deviceType {
    
    LightControlViewController *controller = [[LightControlViewController alloc] init];
    controller.isDevice = YES;
    if (deviceType == LULDeviceLinkStateWhiteLight) {
        controller.LightType = LULLightSliderTypeWhiteLight;
    } else {
        controller.LightType = LULLightSliderTypeColourLight;
    }
    
    [self setHidesBottomBarWhenPushed:YES];

    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];

}

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

-(void) onDeviceSearch:(Device *)result {
    NSLog(@"Devicd %@ is found", [result getIp]);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //[self showAlertWithResult:result];
        DeviceInfo *devFind = [[DeviceInfo alloc] init];
        devFind.deviceID = [result getId];
        devFind.isOn = YES;
        devFind.name = [result getId];
        devFind.ip = [result getIp];
        devFind.hasStatuFlag = NO;
        devFind.hasClockFlag = YES;
        devFind.linkState = LULDeviceLinkStateWiFi;
        [_devices addObject:devFind];
    });
}

@end
