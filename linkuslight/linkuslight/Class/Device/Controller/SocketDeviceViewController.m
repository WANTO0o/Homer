//
//  SocketDeviceViewController.m
//  linkuslight
//
//  Created by Aba on 17/10/26.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "SocketDeviceViewController.h"

@interface SocketDeviceViewController ()

@property (weak, nonatomic) IBOutlet UIButton *alarmOnButton;
@property (weak, nonatomic) IBOutlet UIButton *alarmOFFButton;
@property (weak, nonatomic) IBOutlet UIButton *deviceOnButton;
@property (weak, nonatomic) IBOutlet UIButton *deviceOFFButton;

@end

@implementation SocketDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.topViewController.navigationItem setTitle:@"设置插座"];
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didAlarmOnButtonClicked:(id)sender {
    [self turnAlamOn:YES];
}

- (IBAction)didAlarmOFFButtonClicked:(id)sender {
    [self turnAlamOn:NO];
}

- (IBAction)didDeviceOnButtonClicked:(id)sender {
    [self turnDeviceOn:YES];
}

- (IBAction)didDeviceOFFButtonClicked:(id)sender {
    [self turnDeviceOn:NO];
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
- (void)initView
{
    [self transform];

    [self.view setBackgroundColor:[UIColor colorWithRed:0.3975 green:0.6503 blue:1.0 alpha:1.0]];
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
    
    [_alarmOnButton.layer setCornerRadius:20.0];
    [_alarmOnButton.layer setBorderWidth:1.0f];
    [_alarmOnButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    _alarmOnButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 70);
    _alarmOnButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
    /*[_alarmOnButton setImage:[UIImage imageNamed:@"control_icon_ alarm"] forState:UIControlStateNormal];
    _alarmOnButton.imageEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 80);
    //button标题的偏移量，这个偏移量是相对于图片的
    [_alarmOnButton setTitle:@"开" forState:UIControlStateNormal];
    [_alarmOnButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];*/

    [_alarmOFFButton.layer setCornerRadius:20.0];
    [_alarmOFFButton.layer setBorderWidth:1.0f];
    [_alarmOFFButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    _alarmOFFButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 70);
    _alarmOFFButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    //[_alarmOFFButton setTitle:@"关" forState:UIControlStateNormal];
    //[_alarmOnButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];

    [_deviceOnButton.layer setCornerRadius:20.0];
    /*[_deviceOnButton.layer setBorderWidth:1.0f];
    [_deviceOnButton.layer setBorderColor:[UIColor whiteColor].CGColor];*/
    [_deviceOFFButton.layer setCornerRadius:20.0];
    /*[_deviceOFFButton.layer setBorderWidth:1.0f];
    [_deviceOFFButton.layer setBorderColor:[UIColor whiteColor].CGColor];*/
    //[self gsad];
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
                                                                action:@selector(didMoreButtonClicked)];
    rightItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)backUPView {
    [self.navigationController.navigationBar setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didMoreButtonClicked {

}

- (void)turnAlamOn:(Boolean)isOn {

    //self.statusImg.image = [staimg rt_tintedImageWithColor:[UIColor colorWithRed:0.8681 green:0.8962 blue:0.9261 alpha:1.0]];
    if (isOn) {
        _alarmOnButton.alpha = 1.0;
        _alarmOFFButton.alpha = 0.7;

    } else {
        _alarmOnButton.alpha = 0.7;
        _alarmOFFButton.alpha = 1.0;
    }
}

- (void)turnDeviceOn:(Boolean)isOn {
    
    if (isOn) {
        [_deviceOnButton.layer setBackgroundColor:kBackgroundColor.CGColor];
        [_deviceOFFButton.layer setBackgroundColor:[UIColor colorWithRed:0.8128 green:0.8128 blue:0.8128 alpha:1.0].CGColor];
    } else {
        [_deviceOnButton.layer setBackgroundColor:[UIColor colorWithRed:0.8128 green:0.8128 blue:0.8128 alpha:1.0].CGColor];
        [_deviceOFFButton.layer setBackgroundColor:kBackgroundColor.CGColor];
    }
}


- (void)gsad {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 50);
    button.backgroundColor = [UIColor clearColor];
    //设置button正常状态下的图片
    [button setImage:[UIImage imageNamed:@"addition_icon_film-1"] forState:UIControlStateNormal];
    //设置button高亮状态下的图片
    [button setImage:[UIImage imageNamed:@"addition_icon_film-1"] forState:UIControlStateHighlighted];
    //设置button正常状态下的背景图
    [button setBackgroundImage:[UIImage imageNamed:@"addition_icon_film-1"] forState:UIControlStateNormal];
    //设置button高亮状态下的背景图
    [button setBackgroundImage:[UIImage imageNamed:@"addition_icon_film-1"] forState:UIControlStateHighlighted];
    //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
    button.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 60);
    [button setTitle:@"南瓜瓜" forState:UIControlStateNormal];
    //button标题的偏移量，这个偏移量是相对于图片的
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    //设置button正常状态下的标题颜色
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //设置button高亮状态下的标题颜色
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:button];
    
}

@end
