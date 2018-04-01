//
//  ScenceDeviceListViewController.m
//  linkuslight
//
//  Created by aba on 17/11/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "DeviceListViewController.h"
#import "DeviceManager.h"
#import "Uility.h"
#import "DataStoreHelper.h"
#import "HomerRemoteCtrl.h"
#import "Homer.h"
#import "UIColor-Extensions.h"

@interface DeviceListViewController ()<UITableViewDelegate, UITableViewDataSource,DeviceTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *devicesTableView;

@property (nonatomic,retain)UIView *tipsView;
@property (nonatomic,retain)NSMutableArray *devices;

@end

@implementation DeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    _devices = [NSMutableArray array];
    for (DeviceInfo *device in [DeviceManager sharedManager].deviceList) {
        if(device.deviceType == self.deviceType){
            [_devices addObject:device];
        }
    }
//    _devices = [DeviceManager sharedManager].deviceList;
//    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self.navigationController.topViewController.navigationItem setTitle:@"LINKUS LIGHT"];
}

- (IBAction)didDoneButtonClicked:(id)sender {
    if (self.funcionType == FunctionTypeCreatGroup) {
        [self createGroupAction];
    }else if(self.funcionType == FunctionTypeCreatScence){
        [self createScenceAction];
    }
   
}

/**
创建组
 */
- (void)createGroupAction{
    NSMutableArray *tempArr = [NSMutableArray array];
    for (DeviceInfo *device in self.devices) {
        if (device.IsOn) {
            [tempArr addObject:device];
        }
    }
    if (tempArr.count == 0) {
        [Uility showError:@"没有选择设备" toView:self.view];
        return;
    }
    GroupInfo *group = [[GroupInfo alloc]init];
    group.name = self.groupName;
    group.deviceType = self.deviceType;
    group.deviceArr = tempArr;
    
    [[DataStoreHelper shareInstance]addGroup:group];
    
    [self backUPView];
}

/**
 设备关联场景
 */
- (void)createScenceAction{
    [Uility showLoadingToView:self.view];
    for (DeviceInfo *device in self.devices) {
        if (device.IsOn) {
            ColorLight *colorLight = [[ColorLight alloc] initWithDeviceInfo:device];
            if (self.sceneType == ScenceTypeMorning) {
                [colorLight setColorH:39 S:100 B:6000 Success:nil failure:nil];
                [colorLight setBrightness:60 Success:^(id resp) {
                    
                } failure:^(NSError *error) {
                    ;
                }];
                
            }else  if (self.sceneType == ScenceTypeSettingSun) {
                [colorLight setColorH:28 S:100 B:5000 Success:nil failure:nil];
                [colorLight setBrightness:80 Success:nil failure:nil];
            }else  if (self.sceneType == ScenceTypeSettingMoon) {
                [colorLight setColorH:232 S:100 B:5300 Success:nil failure:nil];
                [colorLight setBrightness:30 Success:nil failure:nil];
            }else  if (self.sceneType == ScenceTypeSettingSky) {
                [colorLight setColorH:185 S:100 B:7200 Success:nil failure:nil];
                [colorLight setBrightness:90 Success:nil failure:nil];
            }else  if (self.sceneType == ScenceTypeSettingRomantic) {
                [colorLight setColorH:9 S:100 B:8300 Success:nil failure:nil];
                [colorLight setBrightness:20 Success:nil failure:nil];
            }else  if (self.sceneType == ScenceTypeSettingMovie) {
                [colorLight setColorH:40 S:100 B:5200 Success:nil failure:nil];
                [colorLight setBrightness:20 Success:nil failure:nil];
            }
       
        }
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [Uility hideLoadingView:self.view];
        [Uility showSuccess:@"设置成功" toView:self.view];
        [self backUPView];
    });
 
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
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    _devicesTableView.tableFooterView = view;
    
    CGRect tableFrame = self.devicesTableView.frame;
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
    actionnameLable.text = NSLocalizedString(@"no_dev", nil);
    [_tipsView addSubview:actionnameLable];
    
    UILabel *actioncommentnameLable = [[UILabel alloc] initWithFrame:(CGRectMake(42, 227, 200, 20))];
    actioncommentnameLable.textAlignment = NSTextAlignmentCenter;
    actioncommentnameLable.textColor = [UIColor colorWithRed:0.4052 green:0.4052 blue:0.4052 alpha:1.0];
    actioncommentnameLable.font = [UIFont systemFontOfSize:13];
    actioncommentnameLable.text = NSLocalizedString(@"no_dev_prompt", nil);
    [_tipsView addSubview:actioncommentnameLable];
    
    if (_devices.count > 0) {
        
    } else {
        UIView *theView = _devicesTableView.backgroundView;
        [theView addSubview:_tipsView];
    }
    //Footer
    /*UILabel *comnameLable = [[UILabel alloc] initWithFrame:(CGRectMake(0, tableFrame.size.height-30, kScreen_Width, 20))];
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
    [theView addSubview:comLinkLable];*/
    
    _devicesTableView.backgroundView = theView;
    [self transform];
}

- (void)initData {
    
    _devices = [NSMutableArray arrayWithCapacity:1];
    
    DeviceInfo *dev = [[DeviceInfo alloc] init];
    dev.deviceID = @"SHTBY0001";
    dev.isOn = NO;
    dev.name = @"lamp blub 001";
    dev.hasStatuFlag = YES;
    dev.hasClockFlag = YES;
    dev.linkState = LULDeviceLinkStateWiFi;
    dev.deviceType = _deviceType;
    [_devices addObject:dev];
    
    DeviceInfo *dev2 = [[DeviceInfo alloc] init];
    dev2.deviceID = @"SHTBY0002";
    dev2.isOn = NO;
    dev2.name = @"lamp blub 002";
    dev2.hasStatuFlag = NO;
    dev2.hasClockFlag = YES;
    dev2.linkState = LULDeviceLinkStateCloud;
    dev2.deviceType = _deviceType;
    [_devices addObject:dev2];
    
    DeviceInfo *dev3 = [[DeviceInfo alloc] init];
    dev3.deviceID = @"SHTBY0003";
    dev3.isOn = NO;
    dev3.name = @"lamp blub 003";
    dev3.hasStatuFlag = NO;
    dev3.hasClockFlag = YES;
    dev3.linkState = LULDeviceLinkStateCloud;
    dev3.deviceType = _deviceType;
    [_devices addObject:dev3];
    
    DeviceInfo *dev4 = [[DeviceInfo alloc] init];
    dev4.deviceID = @"SHTBY0004";
    dev4.isOn = NO;
    dev4.name = @"lamp blub 004";
    dev4.hasStatuFlag = NO;
    dev4.hasClockFlag = YES;
    dev4.linkState = LULDeviceLinkStateCloud;
    dev4.deviceType = _deviceType;
    [_devices addObject:dev4];
    
    /*if (_devices.count > 0) {
     [_tipsView removeFromSuperview];
     } else {
     
     UIView *theView = _scenceDevicesTableView.backgroundView;
     [theView addSubview:_tipsView];
     }*/
}

- (void) transform {
    
    self.navigationItem.backBarButtonItem = nil;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_button"]
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(backUPView)];
    leftItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
    
}

- (void)backUPView {
    [self.navigationController.navigationBar setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _devices.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DeviceListTableViewCell *cell = [DeviceListTableViewCell cellWithTableView:tableView];
    cell.index = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.Delegate = self;
    
    DeviceInfo *dev = [_devices objectAtIndex:indexPath.row];
    [cell refreshWithDeviceInfo:dev];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _devices.count) {
        NSLog(@"didSelectRowAtIndexRow:%ld",(long)indexPath.row);
        switch (indexPath.row) {
            case 0:
                break;
            case 1:
                break;
            case 2:
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

- (void)didCellClicked:(DeviceListTableViewCell*)sender IsOn:(Boolean)isOn {
    if (sender) {
        DeviceInfo *device =_devices[sender.index];
        device.isOn = isOn;
        [_devicesTableView reloadData];
    }
}

- (void)showLightView {
    LightControlViewController *controller = [[LightControlViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
    
}

@end
