//
//  LightControlViewController.m
//  linkuslight
//
//  Created by Aba on 17/10/26.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "YCXMenu.h"
#import "LZCircularSlider.h"
#import "UIColor-Extensions.h"
#import "ClockViewController.h"
#import "WHCircularSlider.h"
#import "LightControlViewController.h"
#import "ColorLight.h"
#import "HomerRemoteCtrl.h"
#import "Uility.h"
#import "ColorCircleView.h"
#import "DeviceManager.h"
#import "DataStoreHelper.h"
#import "AlarmClockTableVC.h"

@interface LightControlViewController ()<LLCircularViewDelegate>

@property(assign, nonatomic)BOOL isRightMenuShow;

@property (weak, nonatomic) IBOutlet UIImageView *lightView;

@property(strong, nonatomic)UIView *rightbgView;

@property(strong, nonatomic)UIView *rightMenuView;

@property (weak, nonatomic) IBOutlet UIButton *alarmONButton;

@property (weak, nonatomic) IBOutlet UIButton *alarmOFFButton;
@property (weak, nonatomic) IBOutlet UILabel *alarmLabel;

@property (weak, nonatomic) IBOutlet UIButton *lightTurnClourButton;

@property (weak, nonatomic) IBOutlet UIButton *lightTurnWhiteButton;

@property (weak, nonatomic) IBOutlet UIButton *deviceOnButton;

@property (weak, nonatomic) IBOutlet UIButton *deviceOFFButton;

@property (weak, nonatomic) IBOutlet UISlider *lightenessSlider;

@property (retain, nonatomic) LLCircularView *whiteLightSlider;

//@property (retain, nonatomic) WHCircularSlider *colourLightSlider;

@property (retain, nonatomic) ColorCircleView *colorCircleSlider;

@property (weak, nonatomic) IBOutlet UILabel *brightnessLable;

@property (retain, nonatomic) ColorLight *colorLight;

//@property (nonatomic, assign) HomerRemoteCtrl *homerRemoteCtrl;
@property (weak, nonatomic) IBOutlet UILabel *changeModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end

@implementation LightControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.homerRemoteCtrl = [HomerRemoteCtrl sharedManager];
//    self.homerRemoteCtrl.delegate = self;
    _colorLight = [[ColorLight alloc] initWithDeviceInfo:_DeviceInfo];
    [self initView];
    // DEBUG:
    // [self getDeviceStatus];

    [_deviceOnButton setTitle:NSLocalizedString(@"on", nil) forState:UIControlStateNormal];
    [_deviceOFFButton setTitle:NSLocalizedString(@"off", nil) forState:UIControlStateNormal];
    [_alarmLabel setText:NSLocalizedString(@"alarm", nil)];
    [_changeModeLabel setText:NSLocalizedString(@"mode_switch", nil)];
    [_lightTurnClourButton setTitle:NSLocalizedString(@"dev_colorlight", nil) forState:UIControlStateNormal];
    [_lightTurnWhiteButton setTitle:NSLocalizedString(@"dev_whitelight", nil) forState:UIControlStateNormal];
    [_stateLabel setText:NSLocalizedString(@"state_prompt", nil)];
    [_brightnessLable setText:NSLocalizedString(@"brightness", nil)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.lightControlDeviceType == LightControlDeviceTypeSingle){
        [self.navigationController.topViewController.navigationItem setTitle:_DeviceInfo.name];
    }else if(self.lightControlDeviceType == LightControlDeviceTypeGroup){
         [self.navigationController.topViewController.navigationItem setTitle:_groupInfo.name];
    }

    //self.navigationController.navigationBar.tintColor = nil;
    //self.navigationController.navigationBar.backgroundColor = nil;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //self.navigationController.navigationBar.clipsToBounds = YES;
    //[self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [YCXMenu dismissMenu];
}

- (void)getDeviceStatus{
    if (self.lightControlDeviceType == LightControlDeviceTypeSingle) {
        //单个设备
        if(self.DeviceInfo.linkState == LULDeviceLinkStateCloud || self.DeviceInfo.linkState == LULDeviceLinkStateBoth){
            //远程设备需要重新获取列表
            [Uility showLoadingToView:self.view];
            [_colorLight getDeviceStatusSuccess:^(id response) {
                NSString *msg = response[@"ret"];
                if ([msg containsString:@"Device is offline"]) {
                    self.colorLight.deviceInfo.IsOn = NO;
                    [Uility hideLoadingView:self.view];
                    [Uility showError:NSLocalizedString(@"dev_offline", nil) toView:self.view];
                    return ;
                }
                //设备在线，刷新视图
                [self refreshViewWithDevice:self.colorLight];
                [Uility hideLoadingView:self.view];
            } failure:^(id response) {
                [Uility showError:NSLocalizedString(@"refresh_error", nil) toView:self.view];
            }];
        }else{
            [self refreshViewWithDevice:self.colorLight];
        }
    }else{//分组一个或多个设备
        
    }
}

#pragma mark - ButtionClickedAction
/**闹钟*/
- (IBAction)didAlarmButtionClicked:(id)sender {
    [self showClockView];
}

- (IBAction)didAlarmONButtionClicked:(id)sender {
    [self turnAlarmOn:YES];
}

- (IBAction)didalarmOFFButtionClicked:(id)sender {
    [self turnAlarmOn:NO];
}

/**切换彩灯*/
- (IBAction)didlightTurnColourButtonClicked:(id)sender {
    [self turnLight:YES];
}

/**切换白灯*/
- (IBAction)didlightTurnWhiteButtonClicked:(id)sender {
    [self turnLight:NO];
}
/**打开设备*/
- (IBAction)diddeviceOnButtonClicked:(id)sender {
    [self turnDeviceOn:YES];
}
/**关闭设备*/
- (IBAction)diddeviceOFFButtonClicked:(id)sender {
    [self turnDeviceOn:NO];
}

- (void)sliderEndChangeValue:(id)sender {
    //亮度变化
   DebugLog(@"亮度：%f",_lightenessSlider.value);
    if (self.lightControlDeviceType == LightControlDeviceTypeSingle) {
        [Uility showLoadingToView:self.view];
        [_colorLight setBrightness:(uint8_t)_lightenessSlider.value Success:^(id resp){
            [Uility hideLoadingView:self.view];
            [self analycisResp:resp];

          
        } failure:^(NSError *error) {
            [Uility showError:NSLocalizedString(@"refresh_error", nil) toView:self.view];
        }];
    }else if(self.lightControlDeviceType == LightControlDeviceTypeGroup){
        [Uility showLoadingToView:self.view];
        for (DeviceInfo *device in self.groupInfo.deviceArr) {
            ColorLight *colorLight = [[ColorLight alloc]initWithDeviceInfo:device];
            [colorLight setBrightness:(uint8_t)_lightenessSlider.value Success:^(id resp){
            } failure:^(NSError *error) {
            }];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Uility hideLoadingView:self.view];
        });
    }
    
    _brightnessLable.text = [NSString stringWithFormat:@"%@：%d",
                             NSLocalizedString(@"brightness", nil),
                             (int)_lightenessSlider.value];
}

- (void)analycisResp:(id)resp{
    if ([resp isKindOfClass:[NSDictionary class]]) {
        NSString *ret = resp[@"ret"];
        if ([ret containsString:@"Device is offline"]) {
            [Uility showError:NSLocalizedString(@"dev_offline", nil) toView:self.view];
        }else if([ret containsString:@"ok"]){
            [Uility showSuccess:NSLocalizedString(@"setting_success", nil) toView:self.view];
        }
        
    }
}

#pragma mark Private
- (void)initView
{
    [self transform];

    [self.view setBackgroundColor:[UIColor colorWithRed:0.3975 green:0.6503 blue:1.0 alpha:1.0]];
    
    //self.rightbgView = [[UIView alloc] initWithFrame:CGRectMake(30, 30, 30, 30)];
    
    //[self.view addSubview:self.rightbgView];
    /*UIColor *color = [UIColor whiteColor];
     _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: color}];
     
     UIView *rightVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
     UIImageView* xImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_addition_password_not"]];
     xImageView.highlightedImage = [UIImage imageNamed:@"icon_addition_password"];
     xImageView.frame = CGRectMake(0, 0,30,30);
     [rightVeiw addSubview:xImageView];
     _passwordTextField.rightView = rightVeiw;
     _passwordTextField.rightViewMode = UITextFieldViewModeAlways;
     xImageView.userInteractionEnabled = YES;
     UITapGestureRecognizer *xImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xImageViewClick:)];
     [xImageView addGestureRecognizer:xImageViewTap];
     
     [_doneButton.layer setCornerRadius:8.0];*/

    [_alarmONButton.layer setCornerRadius:10.0];
    [_alarmONButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [_alarmOFFButton.layer setCornerRadius:10.0];
    [_alarmOFFButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [_lightTurnClourButton.layer setCornerRadius:10.0];
    [_lightTurnClourButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [_lightTurnWhiteButton.layer setCornerRadius:10.0];
    [_lightTurnWhiteButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [_deviceOnButton.layer setCornerRadius:20.0];
    [_deviceOnButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [_deviceOFFButton.layer setCornerRadius:20.0];
    [_deviceOFFButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    

    if (self.DeviceInfo.deviceType == LULLightSliderTypeWhiteLight) {
        [self turnLight:NO];
    } else {
        [self turnLight:YES];
    }
    

    
    
    /*_lightBrightnessSlider = [[LZCircularSlider alloc] initWithFrame:_lightenessSlider.frame];
    _lightBrightnessSlider.backgroundColor = [UIColor clearColor];
    _lightBrightnessSlider.lineWidth =10;
    _lightBrightnessSlider.maximumValue =255;
    _lightBrightnessSlider.minimumValue =0;
    _lightBrightnessSlider.currentValue =0;
    [self.view addSubview:_lightBrightnessSlider];
    
    _lightenessSlider.enabled = NO;
    [_lightenessSlider removeFromSuperview];*/
    _lightenessSlider.minimumValue = 0;
    _lightenessSlider.maximumValue = 100;
    [_lightenessSlider.layer setCornerRadius:10];
    _lightenessSlider.maximumValueImage = [UIImage imageNamed:@"control_icon_variability_big"];
    _lightenessSlider.minimumValueImage = [UIImage imageNamed:@"control_icon_variability_small"];
    [_lightenessSlider addTarget:self action:@selector(sliderEndChangeValue:) forControlEvents:UIControlEventValueChanged];
    
    self.lightenessSlider.continuous = NO;
}


/**
 赋值视图
 */
- (void)refreshViewWithDevice:(ColorLight *)colorLight{
    //设备开关
    if (colorLight.deviceInfo.IsOn) {
        [_deviceOnButton.layer setBackgroundColor:kBackgroundColor.CGColor];
        [_deviceOFFButton.layer setBackgroundColor:[UIColor colorWithRed:0.8128 green:0.8128 blue:0.8128 alpha:1.0].CGColor];
    }else{
        [_deviceOnButton.layer setBackgroundColor:[UIColor colorWithRed:0.8128 green:0.8128 blue:0.8128 alpha:1.0].CGColor];
        [_deviceOFFButton.layer setBackgroundColor:kBackgroundColor.CGColor];
    }
    //亮度
    
     _brightnessLable.text = [NSString stringWithFormat:@"%@：%d%%",
                              NSLocalizedString(@"brightness", nil),
                              (int)colorLight.deviceInfo.Color_Brightness];
    _lightenessSlider.value = colorLight.deviceInfo.Color_Brightness;
    
    if (self.colorLight.deviceInfo.lightType == LULLightTypeWhiteLight) {
        self.LightType = LULLightSliderTypeWhiteLight;
    }else{
        self.LightType = LULLightSliderTypeColourLight;
    }
    //白彩灯
    if (self.LightType == LULLightSliderTypeWhiteLight) {
        [self turnLight:NO];
        //_whiteLightSlider.currentValue = colorLight.deviceInfo
    } else {
        [self turnLight:YES];
    }
    
}

- (void)transform {
    
    //self.navigationItem.backBarButtonItem = nil;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"back", nil)
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:nil];
    backItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.backBarButtonItem = backItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_button"]
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(backUPView)];
    leftItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
                                  initWithTitle:NSLocalizedString(@"item_more", nil)
                                  style:UIBarButtonItemStyleDone
                                  target:self
                                  action:@selector(showmenu)];
    rightItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)backUPView {
    [self.navigationController.navigationBar setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    [self.navigationController popViewControllerAnimated:YES];
    if (self.backActionBlock) {
        self.backActionBlock();
    }
}

- (void)showClockView {
    //ClockViewController *controller = [[ClockViewController alloc] init];
    AlarmClockTableVC *controller = [[AlarmClockTableVC alloc] init];
    
    [self setHidesBottomBarWhenPushed:YES];

    [self.navigationController pushViewController:controller animated:YES];
    //[self setHidesBottomBarWhenPushed:NO];
}

- (void)showmenu {
    
    NSMutableArray *items;
    
    NSString *bindCloud = NSLocalizedString(@"item_cloud_bind", nil);
    NSString *firmwareUpdate = NSLocalizedString(@"item_firmware_update", nil);
    NSString *devReset = NSLocalizedString(@"item_dev_reset", nil);
    NSString *devRename = NSLocalizedString(@"item_dev_rename", nil);
    NSString *firmwareVersion = NSLocalizedString(@"item_firmware_ver", nil);
    NSString *removeCloud = NSLocalizedString(@"item_cloud_remove", nil);
    NSString *groupRename = NSLocalizedString(@"item_group_rename", nil);
    NSString *groupDel = NSLocalizedString(@"item_group_del", nil);
    NSString *groupUpdate = NSLocalizedString(@"item_group_update", nil);
    NSString *groupReset = NSLocalizedString(@"item_group_reset", nil);
    
    if (_isDevice) {
        if(_DeviceInfo.linkState == LULDeviceLinkStateWiFi)
        {
            items = [NSMutableArray arrayWithObjects:
                     bindCloud,
                     firmwareUpdate,
                     devReset,
                     devRename,
                     firmwareVersion,
                     nil];
        } else if (_DeviceInfo.linkState == LULDeviceLinkStateCloud) {
            items = [NSMutableArray arrayWithObjects:
                     removeCloud,
                     devRename,
                     nil];
        } else {
            items = [NSMutableArray arrayWithObjects:
                     firmwareUpdate,
                     removeCloud,
                     devReset,
                     devRename,
                     firmwareVersion,
                     nil];
        }
    } else {
        items = [NSMutableArray arrayWithObjects:
                 groupUpdate,
                 groupReset,
                 groupRename,
                 groupDel,
                 nil];
    }
    
    NSMutableArray *menuitems = [NSMutableArray arrayWithCapacity:1];
    for (int i=0; i<items.count; i++) {
        YCXMenuItem *item=[YCXMenuItem menuItem:items[i]
                                          image:nil
                                            tag:100+i
                                       userInfo:@{@"title":@"Menu"}
                                      ];
        item.foreColor=[UIColor colorWithRed:0.4027 green:0.4027 blue:0.4027 alpha:1.0];
        
        [menuitems addObject:item];
    }

    [YCXMenu setTintColor:[UIColor colorWithRed:0.9547 green:0.9519 blue:1.0 alpha:1.0]];
    [YCXMenu setSelectedColor:[UIColor colorWithRed:0.1226 green:0.4705 blue:1.0 alpha:1.0]];
    if ([YCXMenu isShow]){
        [YCXMenu dismissMenu];
    } else {
        [YCXMenu showMenuInView:self.view fromRect:CGRectMake(self.view.frame.size.width - 55, 60, 50, 0) menuItems:menuitems selected:^(NSInteger index, YCXMenuItem *item) {
            if([item.title isEqualToString:firmwareUpdate]) {
                [self updateFirmware];
            } else if ([item.title isEqualToString:groupUpdate]) {
                [self updateFirmware];
            } else if ([item.title isEqualToString:devReset]) {
                [self restoreToFactory];
            } else if ([item.title isEqualToString:removeCloud]) {
                [self delDevice];
            } else if ([item.title isEqualToString:groupDel]) {
                [self delGroup];
            } else if ([item.title isEqualToString:devRename]) {
                [self updateDeviceInfo];
            } else if ([item.title isEqualToString:groupRename]) {
                [self updateGroupInfo];
            } else if ([item.title isEqualToString:bindCloud]) {
                [self bindToCloud];
            }
        }];
    }
}

// 绑定到云端
- (void)bindToCloud {
    [Uility showLoadingToView:self.view];
    [_colorLight bindToCloudSuccess:^(id resp) {
        [Uility hideLoadingView:self.view];
        [Uility showSuccess:NSLocalizedString(@"setting_success", nil) toView:self.view];
    } failure:^(NSError *error) {
        [Uility hideLoadingView:self.view];
        [Uility showError:NSLocalizedString(@"setting_fail", nil) toView:self.view];
    }];
}

// 升级固件
- (void)updateFirmware {
    
}

// 恢复出厂设置
- (void)restoreToFactory {
}

// 删除设备
- (void)delDevice {
    [Uility showLoadingToView:self.view];
    [[HomerRemoteCtrl sharedManager] delDevice:_DeviceInfo success:^(id response) {
        [Uility hideLoadingView:self.view];
        [Uility showSuccess:NSLocalizedString(@"setting_success", nil) toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.deleteDeviceBlock) {
                self.deleteDeviceBlock(self.DeviceInfo);
            };
            [self.navigationController popViewControllerAnimated:YES];
        });

    } failure:^(id response) {
        [Uility hideLoadingView:self.view];
        [Uility showError:NSLocalizedString(@"setting_fail", nil) toView:self.view];
    }];

}

// 删除分组
- (void)delGroup {
    [[DataStoreHelper shareInstance]deleteGroup:self.groupInfo];
    [Uility showSuccess:NSLocalizedString(@"setting_success", nil) toView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

// 更新设备信息
- (void)updateDeviceInfo {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"alert", nil) message:NSLocalizedString(@"setting_enter_devname", nil) preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"ok", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *nameTextField = alertController.textFields.firstObject;
        NSString *newName = nameTextField.text;
        if ([newName isEqualToString:@""]) {
            [Uility showError:NSLocalizedString(@"setting_devname_not_null", nil) toView:self.view];
            return ;
        }
        [Uility showLoadingToView:self.view];
        if (![newName isEqualToString:_DeviceInfo.name]) {
            if(_DeviceInfo.linkState != LULDeviceLinkStateWiFi) {
                [self.colorLight updateName:newName AndDesc:[self.DeviceInfo desc] Success:^(id resp) {
                    [self.navigationController.topViewController.navigationItem setTitle:newName];
                    self.DeviceInfo.name = newName;
                    self.DeviceInfo.desc = [self.DeviceInfo desc];
                    [Uility hideLoadingView:self.view];
                    [self analycisResp:resp];
                } failure:^(NSError *error) {
                    [Uility hideLoadingView:self.view];
                    [Uility showError:NSLocalizedString(@"setting_fail", nil) toView:self.view];
                }];
            } else {
                [self.navigationController.topViewController.navigationItem setTitle:newName];
                self.DeviceInfo.name = newName;
                [Uility hideLoadingView:self.view];
            }
        }
    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil) style:UIAlertActionStyleDefault handler:nil]];
    
    //定义输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = _DeviceInfo.name;
    }];
    
    [self presentViewController:alertController animated:true completion:nil];
}

// 更新分组信息
- (void)updateGroupInfo {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:NSLocalizedString(@"alert", nil)
                                          message:NSLocalizedString(@"setting_enter_groupname", nil)
                                          preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"ok", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *nameTextField = alertController.textFields.firstObject;
        NSString *newName = nameTextField.text;
        if ([newName isEqualToString:@""]) {
            [Uility showError:NSLocalizedString(@"setting_groupname_not_null", nil) toView:self.view];
            return ;
        }
        _groupInfo.name = newName;
        [[DataStoreHelper shareInstance]updateGroup:_groupInfo];
        [self.navigationController.topViewController.navigationItem setTitle:_groupInfo.name];
        [Uility showSuccess:NSLocalizedString(@"setting_success", nil) toView:self.view];
        
    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil) style:UIAlertActionStyleDefault handler:nil]];
    
    //定义输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = _groupInfo.name;
    }];
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)turnAlarmOn:(Boolean)isOn {
    if (isOn) {
        [_alarmONButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_alarmONButton setBackgroundColor:kLightOrangeColor];
        [_alarmONButton.layer setBorderColor:kLightOrangeColor.CGColor];
        
        [_alarmOFFButton setTitleColor:kBackgroundColor forState:UIControlStateNormal];
        [_alarmOFFButton setBackgroundColor:[UIColor whiteColor]];
        [_alarmOFFButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        
    } else {
        [_alarmONButton setTitleColor:kBackgroundColor forState:UIControlStateNormal];
        [_alarmONButton setBackgroundColor:[UIColor whiteColor]];
        [_alarmONButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        
        [_alarmOFFButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_alarmOFFButton setBackgroundColor:kLightOrangeColor];
        [_alarmOFFButton.layer setBorderColor:kLightOrangeColor.CGColor];
        
    }
}


/**
 白彩灯切换
 */
- (void)turnLight:(Boolean)isColour {
    DebugLog(@"turnlight");
    if (isColour) {
        [_lightTurnClourButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_lightTurnClourButton setBackgroundColor:kLightOrangeColor];
        [_lightTurnClourButton.layer setBorderColor:kLightOrangeColor.CGColor];
        
        [_lightTurnWhiteButton setTitleColor:kBackgroundColor forState:UIControlStateNormal];
        [_lightTurnWhiteButton setBackgroundColor:[UIColor whiteColor]];
        [_lightTurnWhiteButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        
        _LightType = LULLightSliderTypeColourLight;
        _colorLight.deviceInfo.lightType = LULLightTypeColourLight;
        [self turnSlider];
        
    } else {
        [_lightTurnClourButton setTitleColor:kBackgroundColor forState:UIControlStateNormal];
        [_lightTurnClourButton setBackgroundColor:[UIColor whiteColor]];
        [_lightTurnClourButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        
        [_lightTurnWhiteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_lightTurnWhiteButton setBackgroundColor:kLightOrangeColor];
        [_lightTurnWhiteButton.layer setBorderColor:kLightOrangeColor.CGColor];
        
        _LightType = LULLightSliderTypeWhiteLight;
        _colorLight.deviceInfo.lightType = LULLightTypeWhiteLight;
        [self turnSlider];
    }
}


- (void)turnDeviceOn:(Boolean)isOn {
    if (isOn) {
        if (self.lightControlDeviceType == LightControlDeviceTypeSingle) {
            [Uility showLoadingToView:self.view];
            [_colorLight turnOnSuccess:^(id resp){
                [Uility hideLoadingView:self.view];
                [self analycisResp:resp];

            } failure:^(NSError *error) {
                [Uility showError:NSLocalizedString(@"setting_fail", nil) toView:self.view];
            }];
        }else if (self.lightControlDeviceType == LightControlDeviceTypeGroup){
            [Uility showLoadingToView:self.view];
            for (DeviceInfo *deviceInfo in self.groupInfo.deviceArr) {//分组
                 ColorLight *color =[[ ColorLight alloc]initWithDeviceInfo:deviceInfo];
                [color turnOnSuccess:^(id resp){
                } failure:^(NSError *error) {
                }];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [Uility hideLoadingView:self.view];
            });
        }

        [_deviceOnButton.layer setBackgroundColor:kBackgroundColor.CGColor];
        [_deviceOFFButton.layer setBackgroundColor:[UIColor colorWithRed:0.8128 green:0.8128 blue:0.8128 alpha:1.0].CGColor];
    } else {
        if (self.lightControlDeviceType == LightControlDeviceTypeSingle) {
            [Uility showLoadingToView:self.view];
            [_colorLight turnOffSuccess:^(id resp){
                [Uility hideLoadingView:self.view];
                [self analycisResp:resp];
            } failure:^(NSError *error) {
                [Uility showError:NSLocalizedString(@"setting_fail", nil) toView:self.view];
            }];
        }else if (self.lightControlDeviceType == LightControlDeviceTypeGroup){
            [Uility showLoadingToView:self.view];
            for (DeviceInfo *deviceInfo in self.groupInfo.deviceArr) {//分组
                ColorLight *color =[[ ColorLight alloc]initWithDeviceInfo:deviceInfo];
                [color turnOffSuccess:^(id resp){
                } failure:^(NSError *error) {
                }];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [Uility hideLoadingView:self.view];
            });
        }
  
        [_deviceOnButton.layer setBackgroundColor:[UIColor colorWithRed:0.8128 green:0.8128 blue:0.8128 alpha:1.0].CGColor];
        [_deviceOFFButton.layer setBackgroundColor:kBackgroundColor.CGColor];
    }
 
}

/**切换白彩灯背景*/
- (void)turnSlider{
    
    CGRect fram = _lightView.frame;
    CGRect fram1 = _lightView.bounds;

    if (!self.whiteLightSlider) {
        _whiteLightSlider = [[LLCircularView alloc] initWithFrame:CGRectMake(kScreen_Width/2-fram.size.width/2, fram.origin.y+2, fram.size.width, fram.size.width)];
        _whiteLightSlider.backgroundColor = [UIColor clearColor];
        _whiteLightSlider.lineWidth =30;
        _whiteLightSlider.maximumValue =2700;
        _whiteLightSlider.minimumValue =7000;
        _whiteLightSlider.currentValue =2700;
        _whiteLightSlider.LightType =  LULLightSliderTypeWhiteLight;
        _whiteLightSlider.delegate = self;
        
        NSLog(@"white light turn");
    }
    
    if (!self.colorCircleSlider) {
        /*_colourLightSlider = [[LLCircularView alloc] initWithFrame:CGRectMake(fram.origin.x+1, fram.origin.y+2, fram.size.width, fram.size.width)];
        _colourLightSlider.backgroundColor = [UIColor clearColor];
        _colourLightSlider.lineWidth =30;
        _colourLightSlider.maximumValue =7500;
        _colourLightSlider.minimumValue =2700;
        _colourLightSlider.currentValue =2700;
        _colourLightSlider.LightType = LULLightSliderTypeColourLight;
        _colourLightSlider.delegate = self;*/
//        self.colourLightSlider = [WHCircularSlider new];
//        
//        _colourLightSlider.frame = CGRectMake(kScreen_Width/2-fram.size.width/2, fram.origin.y+2, fram.size.width, fram.size.width);
//        _colourLightSlider.backgroundColor = [UIColor clearColor];
//        [self.view addSubview:_colourLightSlider];
        _colorCircleSlider = [[ColorCircleView alloc]init];
        _colorCircleSlider.frame = CGRectMake(kScreen_Width/2-fram.size.width/2, fram.origin.y+2, fram.size.width, fram.size.width);
        /*UIView *v = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
        v.layer.cornerRadius = 25;
        v.layer.masksToBounds = YES;
        [self.view addSubview:v];*/
        
        __weak typeof(self) weakSelf = self;
        
        _colorCircleSlider.colorBlock = ^(UIColor *col){
            
            struct HSV hsv;
            
            [col getHue:&hsv.hu saturation:&hsv.sa brightness:&hsv.br alpha:&hsv.al];
            if (self.lightControlDeviceType == LightControlDeviceTypeSingle) {
                [Uility showLoadingToView:self.view];
                [weakSelf.colorLight setColorH:(hsv.hu*360) S:(hsv.sa*100) B:(hsv.br*100)Success:^(id resp){
                    [Uility hideLoadingView:self.view];
                    [self analycisResp:resp];
                    
                } failure:^(NSError *error) {
                    ;
                }];
            }else if(self.lightControlDeviceType == LightControlDeviceTypeGroup){
                [Uility showLoadingToView:self.view];
                for (DeviceInfo *device in self.groupInfo.deviceArr) {
                    ColorLight *color =[[ ColorLight alloc]initWithDeviceInfo:device];
                    [color setColorH:(hsv.hu*360) S:(hsv.sa*100) B:(hsv.br*100)Success:^(id resp){
                    } failure:^(NSError *error) {
                        ;
                    }];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [Uility hideLoadingView:self.view];
                });
            }
            DebugLog(@"HSV is :%f,%f,%f,%f",hsv.hu,hsv.sa,hsv.br,hsv.al);
        };
        
    }

    if (self.LightType == LULLightSliderTypeWhiteLight) {
        [self.colorCircleSlider removeFromSuperview];
        [self.view addSubview:_whiteLightSlider];
    } else {
        [self.whiteLightSlider removeFromSuperview];
        [self.view addSubview:_colorCircleSlider];
    }
    
    return;
}

- (void)didCircularClicked:(UIColor*)selectedColor Value:(int)currentValue
{
    //DebugLog(@"%@",selectedColor);
    //DebugLog(@"currentValue:%d",currentValue);
    //self.rightbgView.backgroundColor = selectedColor;
    //获取hsv
    //struct HSV hsv;
    //[selectedColor getHue:&hsv.hu saturation:&hsv.sa brightness:&hsv.br alpha:&hsv.al];
    
    //[_colorLight setColorH:(hsv.hu*360) S:(hsv.sa*100) B:(hsv.br*100)];
    DebugLog(@"Current Value %d", currentValue);
    [Uility showLoadingToView:self.view];
    [_colorLight setColorTemp:currentValue Success:^(id resp){
        [Uility hideLoadingView:self.view];
        [self analycisResp:resp];
    } failure:^(NSError *error) {
        ;
    }];
    //DebugLog(@"HSV2 is :%f,%f,%f,%f",hsv.hu,hsv.sa,hsv.br,hsv.al);
}
//#pragma mark - HomerRemoteCtrlDelegate
//-(void) remoteSearchDevice:(NSMutableArray *)devList {
//
//    for (ColorLight *light in devList) {
//        if ([[light deviceInfo].deviceID isEqualToString:self.DeviceInfo.deviceID]) {
//            LULDeviceLinkState linkState = self.DeviceInfo.linkState;
//            self.DeviceInfo = [light deviceInfo];
//            self.DeviceInfo.linkState = linkState;
//            self.colorLight = light;
//            if (self.DeviceInfo.deviceType == LULDeviceLinkStateWhiteLight) {
//                self.LightType = LULLightSliderTypeWhiteLight;
//            } else {
//                self.LightType = LULLightSliderTypeColourLight;
//            }
//            [[DeviceManager sharedManager] replace:self.DeviceInfo];
//            [self refreshViewWithDevice:self.colorLight];
//            //当前操作的设备
//            break;
//        }
//
//    }
//    [Uility hideLoadingView:self.view];
//}

//-(void) transferSuccess{
//    [Uility hideLoadingView:self.view];
//    DebugLog(@"请求成功");
//}
//
//-(void) transferFailWithMsg:(NSError *)failMsg{
//    [Uility hideLoadingView:self.view];
//    [Uility showError:@"请求失败，请稍后尝试" toView:self.view];
//     DebugLog(@"请求失败，%@",failMsg);
//}

@end
