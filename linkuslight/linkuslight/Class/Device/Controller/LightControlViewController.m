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
#import "LightControlViewController.h"
#import "ColorLight.h"

@interface LightControlViewController ()<LLCircularViewDelegate>

@property(assign, nonatomic)BOOL isRightMenuShow;

@property (weak, nonatomic) IBOutlet UIImageView *lightView;

@property(strong, nonatomic)UIView *rightbgView;

@property(strong, nonatomic)UIView *rightMenuView;

@property (weak, nonatomic) IBOutlet UIButton *alarmONButton;

@property (weak, nonatomic) IBOutlet UIButton *alarmOFFButton;

@property (weak, nonatomic) IBOutlet UIButton *lightTurnClourButton;

@property (weak, nonatomic) IBOutlet UIButton *lightTurnWhiteButton;

@property (weak, nonatomic) IBOutlet UIButton *deviceOnButton;

@property (weak, nonatomic) IBOutlet UIButton *deviceOFFButton;

@property (weak, nonatomic) IBOutlet UISlider *lightenessSlider;

@property (retain, nonatomic) LLCircularView *whiteLightSlider;

@property (retain, nonatomic) LLCircularView *colourLightSlider;

@property (retain, nonatomic) LZCircularSlider *lightBrightnessSlider;

@property (weak, nonatomic) IBOutlet UILabel *brightnessLable;

@property (retain, nonatomic) ColorLight *colorLight;

@end

@implementation LightControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _colorLight = [[ColorLight alloc] initWithDeviceInfo:_DeviceInfo];
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.topViewController.navigationItem setTitle:_DeviceInfo.name];
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

- (IBAction)didAlarmButtionClicked:(id)sender {
    [self showClockView];
}

- (IBAction)didAlarmONButtionClicked:(id)sender {
    [self turnAlarmOn:YES];
}

- (IBAction)didalarmOFFButtionClicked:(id)sender {
    [self turnAlarmOn:NO];
}

- (IBAction)didlightTurnColourButtonClicked:(id)sender {
    [self turnLight:YES];
}

- (IBAction)didlightTurnWhiteButtonClicked:(id)sender {
    [self turnLight:NO];
}

- (IBAction)diddeviceOnButtonClicked:(id)sender {
    [self turnDeviceOn:YES];
}

- (IBAction)diddeviceOFFButtonClicked:(id)sender {
    [self turnDeviceOn:NO];
}

- (void)sliderEndChangeValue:(id)sender {
    //亮度变化
   DebugLog(@"亮度：%f",_lightenessSlider.value);
    [_colorLight setBrightness:(uint8_t)_lightenessSlider.value];
    _brightnessLable.text = [NSString stringWithFormat:@"亮度：%d",(int)_lightenessSlider.value];
}

#pragma mark Private
- (void)initView
{
    [self transform];

    [self.view setBackgroundColor:[UIColor colorWithRed:0.3975 green:0.6503 blue:1.0 alpha:1.0]];
    
    self.rightbgView = [[UIView alloc] initWithFrame:CGRectMake(30, 30, 30, 30)];
    
    [self.view addSubview:self.rightbgView];
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
    
    if (_LightType == LULLightSliderTypeWhiteLight) {
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


- (void)transform {
    
    self.navigationItem.backBarButtonItem = nil;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_button"]
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(backUPView)];
    leftItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"更多"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(showmenu)];
    rightItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.backBarButtonItem = nil;

}

- (void)backUPView {
    [self.navigationController.navigationBar setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showClockView {
    ClockViewController *controller = [[ClockViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:controller animated:YES];
    //[self setHidesBottomBarWhenPushed:NO];
}

- (void)showmenu {
    
    NSMutableArray *items;
    if (_isDevice) {
        items = [NSMutableArray arrayWithObjects:@"本地升级",@"恢复出厂设置",@"删除设备",@"修改设备名称", nil];
    } else {
        items = [NSMutableArray arrayWithObjects:@"本地升级",@"恢复出厂设置",@"删除分组",@"修改分组名称", nil];
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
            NSLog(@"%@",item);
        }];
    }
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


- (void)turnLight:(Boolean)isColour {
    
    if (isColour) {
        [_lightTurnClourButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_lightTurnClourButton setBackgroundColor:kLightOrangeColor];
        [_lightTurnClourButton.layer setBorderColor:kLightOrangeColor.CGColor];
        
        [_lightTurnWhiteButton setTitleColor:kBackgroundColor forState:UIControlStateNormal];
        [_lightTurnWhiteButton setBackgroundColor:[UIColor whiteColor]];
        [_lightTurnWhiteButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        
        _LightType = LULLightSliderTypeColourLight;
        _colorLight.lightType = LULLightTypeColourLight;
        [self turnSlider];
        
    } else {
        [_lightTurnClourButton setTitleColor:kBackgroundColor forState:UIControlStateNormal];
        [_lightTurnClourButton setBackgroundColor:[UIColor whiteColor]];
        [_lightTurnClourButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        
        [_lightTurnWhiteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_lightTurnWhiteButton setBackgroundColor:kLightOrangeColor];
        [_lightTurnWhiteButton.layer setBorderColor:kLightOrangeColor.CGColor];
        
        _LightType = LULLightSliderTypeWhiteLight;
        _colorLight.lightType = LULLightTypeWhiteLight;
        [self turnSlider];
    }
}

- (void)turnDeviceOn:(Boolean)isOn {
    
    if (isOn) {
        [_colorLight turnOn];
        [_deviceOnButton.layer setBackgroundColor:kBackgroundColor.CGColor];
        [_deviceOFFButton.layer setBackgroundColor:[UIColor colorWithRed:0.8128 green:0.8128 blue:0.8128 alpha:1.0].CGColor];
    } else {
        [_colorLight turnOff];
        [_deviceOnButton.layer setBackgroundColor:[UIColor colorWithRed:0.8128 green:0.8128 blue:0.8128 alpha:1.0].CGColor];
        [_deviceOFFButton.layer setBackgroundColor:kBackgroundColor.CGColor];
    }
}

- (void)turnSlider{
    
    CGRect fram = _lightView.frame;
    
    if (!self.whiteLightSlider) {
        _whiteLightSlider = [[LLCircularView alloc] initWithFrame:CGRectMake(fram.origin.x+1, fram.origin.y+2, fram.size.width, fram.size.width)];
        _whiteLightSlider.backgroundColor = [UIColor clearColor];
        _whiteLightSlider.lineWidth =30;
        _whiteLightSlider.maximumValue =7500;
        _whiteLightSlider.minimumValue =2700;
        _whiteLightSlider.currentValue =2700;
        _whiteLightSlider.LightType =  LULLightSliderTypeWhiteLight        ;
        _whiteLightSlider.delegate = self;
    }
    
    if (!self.colourLightSlider) {
        _colourLightSlider = [[LLCircularView alloc] initWithFrame:CGRectMake(fram.origin.x+1, fram.origin.y+2, fram.size.width, fram.size.width)];
        _colourLightSlider.backgroundColor = [UIColor clearColor];
        _colourLightSlider.lineWidth =30;
        _colourLightSlider.maximumValue =7500;
        _colourLightSlider.minimumValue =2700;
        _colourLightSlider.currentValue =2700;
        _colourLightSlider.LightType = LULLightSliderTypeColourLight;
        _colourLightSlider.delegate = self;
    }

    if (_LightType == LULLightSliderTypeWhiteLight) {
        [self.colourLightSlider removeFromSuperview];
        [self.view addSubview:_whiteLightSlider];
    } else {
        [self.whiteLightSlider removeFromSuperview];
        [self.view addSubview:_colourLightSlider];
    }
    
    return;
}

- (void)didCircularClicked:(UIColor*)selectedColor Value:(int)currentValue
{
    //DebugLog(@"%@",selectedColor);
    DebugLog(@"currentValue:%d",currentValue);
    self.rightbgView.backgroundColor = selectedColor;
    //获取hsv
    struct HSV hsv;
    [selectedColor getHue:&hsv.hu saturation:&hsv.sa brightness:&hsv.br alpha:&hsv.al];
    
    [_colorLight setColorH:(hsv.hu*100) S:(hsv.sa*100) B:(hsv.br*100)];
    
    DebugLog(@"HSV is :%f,%f,%f,%f",hsv.hu,hsv.sa,hsv.br,hsv.al);
}

@end
