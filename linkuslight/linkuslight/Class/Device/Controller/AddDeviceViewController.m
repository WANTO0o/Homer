//
//  AddDeviceViewController.m
//  linkuslight
//
//  Created by Aba on 17/10/21.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "UINavigationBar+BackgroundColor.h"

#import "MBProgressHUD+Add.h"
#import "AddDeviceViewController.h"

@interface AddDeviceViewController ()
@property (weak, nonatomic) IBOutlet UITextField *ssidTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *mutButton;
@property (weak, nonatomic) IBOutlet UIImageView *addStateImg;
@property (weak, nonatomic) IBOutlet UILabel *addStateText;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end

@implementation AddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.topViewController.navigationItem setTitle:@"添加设备"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didMutButtonClicked:(id)sender {
    
    if ([_mutButton.titleLabel.text isEqualToString: @"●"]) {
        //_mutButton.titleLabel.textColor = [UIColor whiteColor];
        //_mutButton.titleLabel.text = @"〇";
        [_mutButton setTitle:@"〇" forState:(UIControlStateNormal)];
        [_mutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        //_mutButton.titleLabel.textColor = [UIColor greenColor];
        //_mutButton.titleLabel.text = @"●";
        [_mutButton setTitle:@"●" forState:(UIControlStateNormal)];
        [_mutButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
 
}

- (IBAction)didDoneButtonClicked:(id)sender {
    
    [MBProgressHUD showMsg:@"添加成功" imgName:@"addition_succeed" duration:1 toView:self.view];
    //[MBProgressHUD showMsg:@"添加失败" imgName:@"addition_be defeated" duration:1 toView:self.view];

    //[self backUPView];
}

#pragma mark Private
- (void)initView
{
    [self.view setBackgroundColor:[UIColor colorWithRed:0.3975 green:0.6503 blue:1.0 alpha:1.0]];
    UIColor *color = [UIColor whiteColor];
    _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: color}];
    
    UIView *rightVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView* xImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_addition_password_not"]];
    xImageView.highlightedImage = [UIImage imageNamed:@"icon_addition_password"];
    xImageView.frame = CGRectMake(0, 3,25,20);
    [rightVeiw addSubview:xImageView];
    _passwordTextField.rightView = rightVeiw;
    _passwordTextField.rightViewMode = UITextFieldViewModeAlways;
    xImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *xImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xImageViewClick:)];
    [xImageView addGestureRecognizer:xImageViewTap];
    
    [_doneButton.layer setCornerRadius:8.0];
    
    [self transform];

}

- (void)xImageViewClick:(UITapGestureRecognizer*)gesture
{
    if(gesture)
    {
        UIImageView *imgView = (UIImageView*)gesture.view;
        
        if (imgView.highlighted) {
            [imgView setHighlighted:NO];
            _passwordTextField.secureTextEntry = true;
        } else {
            [imgView setHighlighted:YES];
            _passwordTextField.secureTextEntry = false;
        }
    }
}

- (void)transform {

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

@end
